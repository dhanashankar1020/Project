import 'package:flutter/foundation.dart';

import '../models/safe_place_model.dart';
import '../services/safe_places_service.dart';
import '../../../core/database/dao/cached_places_dao.dart';
import '../../../core/database/local_database.dart';
import '../../../core/network/fallback_orchestrator.dart';
import '../../../services/location_service.dart';
import '../../../services/network_safe_places_service.dart';
import '../../ai_chat/services/recommendation_scoring_service.dart';

/// Result-data for a repository query, carrying metadata about which
/// tier satisfied the request.
class PlacesResult {
  final List<SafePlaceModel> places;
  final DataSource source;
  final String? error;

  const PlacesResult({
    required this.places,
    required this.source,
    this.error,
  });

  bool get isEmpty => places.isEmpty;
  bool get isNotEmpty => places.isNotEmpty;
  int get length => places.length;

  /// Sorts the result's places by distance from the given coordinate.
  /// Uses Haversine (via `LocationService.calculateDistanceKm`) for
  /// consistency with the existing codebase.
  PlacesResult sortedByDistance(double lat, double lng) {
    final sorted = List<SafePlaceModel>.from(places)
      ..sort((a, b) {
        final distA =
            LocationService.calculateDistanceKm(lat, lng, a.latitude, a.longitude);
        final distB =
            LocationService.calculateDistanceKm(lat, lng, b.latitude, b.longitude);
        return distA.compareTo(distB);
      });
    return PlacesResult(places: sorted, source: source, error: error);
  }
}

/// Repository that resolves safe-place queries through a 3-tier fallback
/// chain using [FallbackOrchestrator].
///
/// ## Tier order
///
/// 1. **SQLite cache** — fresh entries from `cached_places` table
/// 2. **Network API** — live Overpass API (skipped when offline)
/// 3. **Static baseline** — hardcoded data bundled with the app (always succeeds)
///
/// This is an **offline-first** strategy optimised for a disaster context:
/// the SQLite cache (which may have been refreshed recently by the background
/// sync engine) is tried first for speed and reliability.
class SafePlacesRepository {
  SafePlacesRepository._();

  static final SafePlacesRepository instance = SafePlacesRepository._();

  // ── Dependencies ──────────────────────────────────────────────────────────

  CachedPlacesDao get _cache => LocalDatabase.instance.cachedPlacesDao;
  NetworkSafePlacesService get _network => NetworkSafePlacesService.instance;
  SafePlacesService get _static => SafePlacesService.instance;

  // ── Query methods ─────────────────────────────────────────────────────────

  /// Returns nearby places for the given GPS coordinate, using the 3-tier
  /// fallback chain.
  ///
  /// When [forceRefresh] is `true`, the network tier is attempted first
  /// (the cache is still used as tier 2).
  Future<PlacesResult> getNearbyPlaces({
    required double lat,
    required double lng,
    String category = 'All',
    bool forceRefresh = false,
  }) async {
    final tierOrder = forceRefresh
        ? [_networkTier(lat, lng, category), _cacheTier(lat, lng, category)]
        : [_cacheTier(lat, lng, category), _networkTier(lat, lng, category)];

    // Static tier is always last (guaranteed to succeed).
    tierOrder.add(_staticTier(lat, lng, category));

    final result = await FallbackOrchestrator.resolve(
      tiers: tierOrder,
      networkTimeout: const Duration(seconds: 10),
    );

    // If the network tier succeeded, asynchronously cache the results
    // (fire-and-forget — don't block the UI).
    if (result.source == DataSource.liveApi) {
      _cacheNetworkResults(result.data);
    }

    return PlacesResult(
      places: result.data,
      source: result.source,
      error: result.error,
    );
  }

  /// Returns all fresh places from the cache, or falls back to static.
  Future<PlacesResult> getAll() async {
    final result = await FallbackOrchestrator.resolve<List<SafePlaceModel>>(
      tiers: [
        Tier.cached(
          () async => _cache.getAllFresh(),
          label: 'cache-all',
        ),
        Tier.static(
          () async => _static.getAllPlaces(),
          label: 'static-all',
        ),
      ],
    );

    return PlacesResult(
      places: result.data,
      source: result.source,
    );
  }

  /// Returns places by category from cache, or from static data.
  Future<PlacesResult> getByCategory(String category) async {
    final result = await FallbackOrchestrator.resolve<List<SafePlaceModel>>(
      tiers: [
        Tier.cached(
          () async => _cache.getByCategory(category),
          label: 'cache-cat-$category',
        ),
        Tier.static(
          () async => _static.getPlacesByCategory(category),
          label: 'static-cat-$category',
        ),
      ],
    );

    return PlacesResult(
      places: result.data,
      source: result.source,
    );
  }

  /// Returns a single place by ID.
  Future<SafePlaceModel?> getById(String id) async {
    final result = await FallbackOrchestrator.resolve<SafePlaceModel?>(
      tiers: [
        Tier.cached(
          () async => _cache.getById(id),
          label: 'cache-id',
        ),
        Tier.static(
          () async => _static.getPlaceById(id),
          label: 'static-id',
        ),
      ],
    );
    return result.data;
  }

  /// Returns scored / ranked places using [RecommendationScoringService].
  ///
  /// Delegates to the existing scoring engine which ranks by distance,
  /// 24-hour availability, and government trust bonus.
  List<SafePlaceModel> getScoredPlaces({
    required String category,
    double? userLat,
    double? userLng,
    int limit = 5,
  }) {
    return RecommendationScoringService.instance.getScoredPlaces(
      category: category,
      userLat: userLat,
      userLng: userLng,
      limit: limit,
    );
  }

  // ── Tier builders ─────────────────────────────────────────────────────────

  Tier<List<SafePlaceModel>> _cacheTier(double lat, double lng, String category) {
    return Tier.cached(
      () async => _cache.getNearbyPlaces(
        lat: lat,
        lng: lng,
        category: category == 'All' ? null : category,
        limit: 30,
      ),
      label: 'cache-geo',
    );
  }

  Tier<List<SafePlaceModel>> _networkTier(double lat, double lng, String category) {
    return Tier.online(
      () async {
        final places = await _network.fetchNearbySafePlaces(
          lat: lat,
          lng: lng,
          category: category,
        );
        if (places.isEmpty) {
          throw FallbackSkippedException('Overpass returned empty result');
        }
        return places;
      },
      label: 'overpass',
    );
  }

  Tier<List<SafePlaceModel>> _staticTier(double lat, double lng, String category) {
    return Tier.static(
      () async {
        final places = _static.getPlacesByCategory(category);
        // Sort by distance to match the other tiers' output.
        final sorted = List<SafePlaceModel>.from(places)
          ..sort((a, b) {
            final distA = LocationService.calculateDistanceKm(
                lat, lng, a.latitude, a.longitude);
            final distB = LocationService.calculateDistanceKm(
                lat, lng, b.latitude, b.longitude);
            return distA.compareTo(distB);
          });
        return sorted;
      },
      label: 'static-geo',
    );
  }

  // ── Background cache update ───────────────────────────────────────────────

  Future<void> _cacheNetworkResults(List<SafePlaceModel> places) async {
    try {
      await _cache.upsertPlaces(
        places,
        source: 'overpass',
        ttlSeconds: 604800, // 7 days
      );
    } catch (e) {
      debugPrint('[SafePlacesRepository] Failed to cache network results: $e');
    }
  }
}

/// Exception used to signal that a fallback tier should be skipped
/// (e.g. because the API returned an empty but valid response, which
/// isn't really a failure but should still fall through to cache).
class FallbackSkippedException implements Exception {
  final String message;
  const FallbackSkippedException(this.message);

  @override
  String toString() => 'FallbackSkippedException: $message';
}
