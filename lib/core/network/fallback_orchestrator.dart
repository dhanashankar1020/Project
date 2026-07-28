import 'package:flutter/foundation.dart';

import '../../features/ai_chat/services/connectivity_service.dart';

/// Identifies which data-source tier a result came from.
///
/// Ordered by preference — each tier is tried before falling to the next.
enum DataSource {
  /// Fresh data from a live network API.
  liveApi,

  /// Data previously fetched from an API and stored locally.
  cached,

  /// Hardcoded baseline data that is bundled with the app.
  staticBaseline,
}

/// Outcome of a fallback-resolve call.
class FallbackResult<T> {
  final T data;
  final DataSource source;
  final String? error;

  const FallbackResult({
    required this.data,
    required this.source,
    this.error,
  });

  bool get isLive => source == DataSource.liveApi;
  bool get isCached => source == DataSource.cached;
  bool get isStatic => source == DataSource.staticBaseline;
}

/// Generic orchestrator that resolves data through a configurable
/// multi-tier fallback chain.
///
/// ## Typical usage
///
/// ```dart
/// final result = await FallbackOrchestrator.resolve(
///   tiers: [
///     Tier.online(() => api.fetchData()),
///     Tier.cached(() => db.getCachedData()),
///     Tier.static(() => hardcodedFallback()),
///   ],
///   networkTimeout: Duration(seconds: 8),
/// );
/// ```
class FallbackOrchestrator {
  FallbackOrchestrator._();

  /// Runs through [tiers] in order, returning the first successful result.
  ///
  /// Every tier is guarded by a try/catch so a failure in an earlier tier
  /// silently falls through to the next tier.
  ///
  /// The [networkTimeout] only applies to tiers marked with `checkConnectivity:
  /// true` (typically the online tier).  Other tiers run with the default
  /// Dart timeout.
  static Future<FallbackResult<T>> resolve<T>({
    required List<Tier<T>> tiers,
    Duration networkTimeout = const Duration(seconds: 8),
  }) async {
    for (final tier in tiers) {
      try {
        // Optional connectivity guard.
        if (tier.checkConnectivity &&
            !ConnectivityService.instance.isConnected) {
          debugPrint('[Fallback] Skipping tier "${tier.label}" — offline');
          continue;
        }

        final T data = tier.checkConnectivity
            ? await tier.call().timeout(networkTimeout)
            : await tier.call();

        return FallbackResult(data: data, source: tier.source);
      } catch (e) {
        debugPrint('[Fallback] Tier "${tier.label}" failed: $e');
        // Fall through to the next tier.
      }
    }

    // Every tier failed — this should never happen if the last tier is a
    // guaranteed static fallback (see [Tier.static]).
    throw StateError(
      'FallbackOrchestrator: all tiers exhausted for type $T',
    );
  }
}

/// A single tier in a fallback chain.
///
/// Create instances via the named constructors:
///
/// - [Tier.online] — live network API (auto-skipped when offline)
/// - [Tier.cached] — local cache (SQLite, SharedPreferences, etc.)
/// - [Tier.static] — hardcoded baseline (guaranteed to work)
abstract class Tier<T> {
  /// Identifies the source for reporting.
  final DataSource source;

  /// Human-readable label used in debug logs.
  final String label;

  /// The async function to execute for this tier.
  final Future<T> Function() call;

  /// When `true`, the orchestrator will skip this tier if the device is
  /// offline and will apply [FallbackOrchestrator.resolve]'s `networkTimeout`.
  final bool checkConnectivity;

  const Tier._({
    required this.source,
    required this.label,
    required this.call,
    this.checkConnectivity = false,
  });

  // ── Named constructors ────────────────────────────────────────────────────

  /// Tier 1: Live network API.
  ///
  /// Automatically skipped when the device is offline.  Apply a timeout
  /// via `FallbackOrchestrator.resolve(networkTimeout: ...)`.
  const factory Tier.online(Future<T> Function() call, {String? label}) =
      _OnlineTier;

  /// Tier 2: Local cache (SQLite, SharedPreferences, etc.).
  const factory Tier.cached(Future<T> Function() call, {String? label}) =
      _CachedTier;

  /// Tier 3: Static / hardcoded baseline (guaranteed to work).
  ///
  /// Because the function signature is `Future<T>`, wrap a synchronous call
  /// with `() async => mySyncFn()`.
  const factory Tier.static(Future<T> Function() call, {String? label}) =
      _StaticTier;
}

// ── Concrete subclasses ─────────────────────────────────────────────────────

class _OnlineTier<T> extends Tier<T> {
  const _OnlineTier(
    Future<T> Function() call, {
    String? label,
  }) : super._(
          source: DataSource.liveApi,
          label: label ?? 'online',
          call: call,
          checkConnectivity: true,
        );
}

class _CachedTier<T> extends Tier<T> {
  const _CachedTier(
    Future<T> Function() call, {
    String? label,
  }) : super._(
          source: DataSource.cached,
          label: label ?? 'cache',
          call: call,
        );
}

class _StaticTier<T> extends Tier<T> {
  const _StaticTier(
    Future<T> Function() call, {
    String? label,
  }) : super._(
          source: DataSource.staticBaseline,
          label: label ?? 'static',
          call: call,
        );
}
