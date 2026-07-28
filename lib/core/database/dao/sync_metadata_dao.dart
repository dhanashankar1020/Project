import 'package:sqflite/sqflite.dart';

import '../tables/sync_metadata_table.dart';

/// Represents the sync state of a single data source.
class SyncMetadata {
  final String source;
  final DateTime lastSyncAt;
  final DateTime nextSyncAt;
  final String syncStatus;
  final String? errorMessage;
  final int itemsCount;

  const SyncMetadata({
    required this.source,
    required this.lastSyncAt,
    required this.nextSyncAt,
    required this.syncStatus,
    this.errorMessage,
    required this.itemsCount,
  });

  bool get isIdle => syncStatus == SyncMetadataTable.statusIdle;
  bool get isSyncing => syncStatus == SyncMetadataTable.statusSyncing;
  bool get isFailed => syncStatus == SyncMetadataTable.statusFailed;
  bool get isDue => nextSyncAt.isBefore(DateTime.now());

  Map<String, dynamic> toMap() => {
        SyncMetadataTable.columnSource: source,
        SyncMetadataTable.columnLastSyncAt: lastSyncAt.toIso8601String(),
        SyncMetadataTable.columnNextSyncAt: nextSyncAt.toIso8601String(),
        SyncMetadataTable.columnSyncStatus: syncStatus,
        SyncMetadataTable.columnErrorMessage: errorMessage,
        SyncMetadataTable.columnItemsCount: itemsCount,
      };

  factory SyncMetadata.fromMap(Map<String, dynamic> map) => SyncMetadata(
        source: map[SyncMetadataTable.columnSource] as String,
        lastSyncAt:
            DateTime.parse(map[SyncMetadataTable.columnLastSyncAt] as String),
        nextSyncAt:
            DateTime.parse(map[SyncMetadataTable.columnNextSyncAt] as String),
        syncStatus: map[SyncMetadataTable.columnSyncStatus] as String,
        errorMessage: map[SyncMetadataTable.columnErrorMessage] as String?,
        itemsCount: map[SyncMetadataTable.columnItemsCount] as int,
      );
}

/// Data-access object for the `sync_metadata` table.
///
/// Tracks per-source sync state so the periodic sync engine knows
/// when a source is due for a refresh and whether the last attempt
/// succeeded or failed.
class SyncMetadataDao {
  SyncMetadataDao(this._db);

  final Database? _db;

  // ── Read ─────────────────────────────────────────────────────────────────

  /// Returns metadata for a given [source], or `null` if never synced.
  Future<SyncMetadata?> get(String source) async {
    if (_db == null) return null;

    final rows = await _db.query(
      SyncMetadataTable.tableName,
      where: '${SyncMetadataTable.columnSource} = ?',
      whereArgs: [source],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return SyncMetadata.fromMap(rows.first);
  }

  /// Returns all tracked sources.
  Future<List<SyncMetadata>> getAll() async {
    if (_db == null) return [];

    final rows = await _db.query(SyncMetadataTable.tableName);
    return rows.map(SyncMetadata.fromMap).toList();
  }

  /// Returns sources that are due for a sync (next_sync_at < now).
  Future<List<SyncMetadata>> getDueSources() async {
    if (_db == null) return [];

    final rows = await _db.query(
      SyncMetadataTable.tableName,
      where:
          "${SyncMetadataTable.columnNextSyncAt} < strftime('%Y-%m-%dT%H:%M:%S','now')",
    );
    return rows.map(SyncMetadata.fromMap).toList();
  }

  // ── Write ─────────────────────────────────────────────────────────────────

  /// Inserts or replaces sync metadata for a source.
  Future<void> upsert(SyncMetadata metadata) async {
    if (_db == null) return;

    await _db.insert(
      SyncMetadataTable.tableName,
      metadata.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Convenience: marks a sync as successful for the given [source].
  ///
  /// Resets status to 'idle' and updates [lastSyncAt] to now.
  /// [nextSyncAt] is pushed forward by [intervalSeconds].
  Future<void> recordSync(
    String source, {
    int itemsCount = 0,
    int intervalSeconds = 21600, // 6 hours default
  }) async {
    final now = DateTime.now();
    await upsert(SyncMetadata(
      source: source,
      lastSyncAt: now,
      nextSyncAt: now.add(Duration(seconds: intervalSeconds)),
      syncStatus: SyncMetadataTable.statusIdle,
      errorMessage: null,
      itemsCount: itemsCount,
    ));
  }

  /// Convenience: marks a sync as failed, preserving the error description.
  Future<void> recordSyncFailure(
    String source, {
    required String error,
    int retryAfterSeconds = 300, // 5 minutes retry
  }) async {
    final existing = await get(source);
    final now = DateTime.now();
    await upsert(SyncMetadata(
      source: source,
      lastSyncAt: existing?.lastSyncAt ?? now,
      nextSyncAt: now.add(Duration(seconds: retryAfterSeconds)),
      syncStatus: SyncMetadataTable.statusFailed,
      errorMessage: error,
      itemsCount: existing?.itemsCount ?? 0,
    ));
  }

  /// Sets status to 'syncing' — used before the sync engine starts work.
  Future<void> markSyncing(String source) async {
    final existing = await get(source);
    if (existing == null) return;
    await upsert(existing.copyWith(
      syncStatus: SyncMetadataTable.statusSyncing,
    ));
  }

  /// Removes a source row (rarely used).
  Future<void> delete(String source) async {
    if (_db == null) return;

    await _db.delete(
      SyncMetadataTable.tableName,
      where: '${SyncMetadataTable.columnSource} = ?',
      whereArgs: [source],
    );
  }
}

/// Private copy-with helper to avoid cluttering the public model.
extension _SyncMetadataCopyWith on SyncMetadata {
  SyncMetadata copyWith({
    String? source,
    DateTime? lastSyncAt,
    DateTime? nextSyncAt,
    String? syncStatus,
    String? errorMessage,
    int? itemsCount,
  }) =>
      SyncMetadata(
        source: source ?? this.source,
        lastSyncAt: lastSyncAt ?? this.lastSyncAt,
        nextSyncAt: nextSyncAt ?? this.nextSyncAt,
        syncStatus: syncStatus ?? this.syncStatus,
        errorMessage: errorMessage ?? this.errorMessage,
        itemsCount: itemsCount ?? this.itemsCount,
      );
}
