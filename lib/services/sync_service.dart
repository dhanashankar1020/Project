import 'dart:async';

import 'package:flutter/foundation.dart';

import '../core/database/local_database.dart';
import '../core/database/dao/sync_metadata_dao.dart';
import '../core/network/fallback_orchestrator.dart';
import '../features/ai_chat/services/connectivity_service.dart';
import '../features/safe_places/repository/safe_places_repository.dart';
import 'location_service.dart';

// ── Status models ───────────────────────────────────────────────────────────

/// Aggregated sync status for all tracked sources.
class SyncStatus {
  /// Per-source sync metadata (may be a subset if some haven't synced yet).
  final List<SyncMetadata> sources;

  /// `true` while any source is being synchronised.
  final bool isRunning;

  /// Human-readable summary (e.g. "Synced 6h ago" / "Sync failed" / "Syncing…").
  final String summary;

  const SyncStatus({
    required this.sources,
    required this.isRunning,
    required this.summary,
  });
}

// ── Sync Service ────────────────────────────────────────────────────────────

/// Background sync engine that periodically refreshes cached data from
/// network sources and updates the `sync_metadata` table with TTL-based
/// scheduling.
///
/// ## Lifecycle
///
/// 1. Call [start] during app startup (after `LocalDatabase` is ready).
/// 2. The engine runs a `Timer.periodic` that checks which sources are due.
/// 3. For each due source, it fetches fresh data and updates the cache.
/// 4. UI can observe [onStatusChanged] to show an indicator.
/// 5. Call [stop] on app shutdown.
class SyncService {
  SyncService._();

  static final SyncService instance = SyncService._();

  // ── Dependencies ──────────────────────────────────────────────────────────

  SyncMetadataDao get _dao => LocalDatabase.instance.syncMetadataDao;
  SafePlacesRepository get _repo => SafePlacesRepository.instance;
  ConnectivityService get _connectivity => ConnectivityService.instance;

  // ── Internal state ────────────────────────────────────────────────────────

  Timer? _syncTimer;
  bool _isRunning = false;
  bool _isSyncing = false; // guards against concurrent sync cycles

  final StreamController<SyncStatus> _statusController =
      StreamController<SyncStatus>.broadcast();

  /// Stream that emits a new [SyncStatus] whenever sync state changes.
  Stream<SyncStatus> get onStatusChanged => _statusController.stream;

  /// The latest known status.
  SyncStatus _currentStatus = const SyncStatus(
    sources: [],
    isRunning: false,
    summary: 'Not started',
  );

  SyncStatus get currentStatus => _currentStatus;

  // ── Public API ────────────────────────────────────────────────────────────

  /// Starts the periodic sync engine.
  ///
  /// Runs an immediate sync on first call, then repeats every [interval].
  /// Safe to call multiple times — subsequent calls are no-ops.
  void start({Duration interval = const Duration(hours: 6)}) {
    if (_isRunning) return;
    _isRunning = true;

    debugPrint('[SyncService] Starting (interval: $interval)');

    // Immediate first check.
    _runSyncCycle();

    // Periodic checks.
    _syncTimer = Timer.periodic(interval, (_) => _runSyncCycle());
  }

  /// Forces an immediate sync cycle (called by UI on "Refresh" button).
  Future<void> refreshNow() async {
    debugPrint('[SyncService] Manual refresh triggered');
    await _runSyncCycle();
  }

  /// Stops the periodic timer.  Call during app disposal.
  void stop() {
    _syncTimer?.cancel();
    _syncTimer = null;
    _isRunning = false;
    _emitStatus(isRunning: false);
    debugPrint('[SyncService] Stopped');
  }

  /// Tears down the status stream.  No further [onStatusChanged] events.
  void dispose() {
    stop();
    _statusController.close();
  }

  // ── Sync cycle ────────────────────────────────────────────────────────────

  /// One complete sync cycle:
  /// 1. Check connectivity
  /// 2. Read due sources from `sync_metadata`
  /// 3. For each due source, fetch + cache + record
  Future<void> _runSyncCycle() async {
    // Prevent concurrent sync cycles (e.g. timer tick + manual refresh).
    if (_isSyncing) {
      debugPrint('[SyncService] Already syncing — skipping cycle');
      return;
    }
    _isSyncing = true;
    _emitStatus(isRunning: true);

    try {
      // 1. Connectivity
      final online = await _connectivity.checkNow();
      if (!online) {
        debugPrint('[SyncService] Offline — skipping cycle');
        _emitStatus(isRunning: false, note: 'Offline — waiting');
        return;
      }

      // 2. Find due sources.
      final due = await _dao.getDueSources();
      if (due.isEmpty) {
        debugPrint('[SyncService] No sources due');
        await _emitCurrentStatus();
        return;
      }

      // 3. Sync each due source.
      for (final meta in due) {
        await _syncSource(meta.source);
      }

      await _emitCurrentStatus();
    } catch (e) {
      debugPrint('[SyncService] Cycle error: $e');
      _emitStatus(isRunning: false, note: 'Error: $e');
    } finally {
      _isSyncing = false;
    }
  }

  /// Synchronises a single named source.
  Future<void> _syncSource(String source) async {
    debugPrint('[SyncService] Syncing source: $source');

    await _dao.markSyncing(source);
    await _emitCurrentStatus();

    try {
      switch (source) {
        case 'overpass':
          await _syncOverpass();
          break;
        default:
          debugPrint('[SyncService] Unknown source: $source — skipping');
      }
    } catch (e) {
      debugPrint('[SyncService] Sync failed for $source: $e');
      await _dao.recordSyncFailure(source, error: e.toString());
    }
  }

  /// Fetches nearby safe places from the Overpass API via the repository
  /// and caches them in SQLite.
  Future<void> _syncOverpass() async {
    // Need GPS coordinates for the spatial query.
    final position = await LocationService.getCurrentLocation();

    double lat;
    double lng;

    if (position != null) {
      lat = position.latitude;
      lng = position.longitude;
    } else {
      // Fallback coordinates if GPS unavailable — use a reasonable
      // default center (New Delhi) so seed data nearby is refreshed.
      debugPrint('[SyncService] GPS unavailable — using default coordinates');
      lat = 28.6139;
      lng = 77.2090;
    }

    // Use the repository with forceRefresh=true to hit the network.
    final result = await _repo.getNearbyPlaces(
      lat: lat,
      lng: lng,
      category: 'All',
      forceRefresh: true,
    );

    if (result.source == DataSource.liveApi) {
      final count = result.places.length;
      await _dao.recordSync('overpass', itemsCount: count);
      debugPrint('[SyncService] Overpass synced: $count places');
    } else {
      // Network tier was skipped or empty — record as a failure.
      await _dao.recordSyncFailure(
        'overpass',
        error: 'Network unavailable or returned empty',
      );
    }
  }

  // ── Status helpers ────────────────────────────────────────────────────────

  Future<void> _emitCurrentStatus() async {
    final sources = await _dao.getAll();
    _emitStatusFromSources(sources);
  }

  void _emitStatus({
    required bool isRunning,
    String? note,
  }) {
    _currentStatus = SyncStatus(
      sources: _currentStatus.sources,
      isRunning: isRunning,
      summary: note ?? _buildSummary(_currentStatus.sources),
    );
    if (!_statusController.isClosed) {
      _statusController.add(_currentStatus);
    }
  }

  void _emitStatusFromSources(List<SyncMetadata> sources) {
    _currentStatus = SyncStatus(
      sources: sources,
      isRunning: false,
      summary: _buildSummary(sources),
    );
    if (!_statusController.isClosed) {
      _statusController.add(_currentStatus);
    }
  }

  String _buildSummary(List<SyncMetadata> sources) {
    if (sources.isEmpty) return 'Never synced';

    final overpass = sources.where((s) => s.source == 'overpass').firstOrNull;
    if (overpass == null) return 'Never synced';

    if (overpass.isFailed) {
      return 'Sync failed — ${overpass.errorMessage ?? "unknown error"}';
    }

    final ago = DateTime.now().difference(overpass.lastSyncAt);
    if (ago.inMinutes < 1) return 'Synced just now';
    if (ago.inMinutes < 60) return 'Synced ${ago.inMinutes}m ago';
    if (ago.inHours < 24) return 'Synced ${ago.inHours}h ago';
    return 'Synced ${ago.inDays}d ago';
  }
}
