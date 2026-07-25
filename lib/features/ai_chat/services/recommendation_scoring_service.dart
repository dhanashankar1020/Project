import 'dart:math';

import '../../safe_places/models/safe_place_model.dart';
import '../../safe_places/services/safe_places_service.dart';

/// A scored safe place with its relevance score.
class ScoredPlace {
  final SafePlaceModel place;

  /// 0.0 (irrelevant) — 1.0 (perfect match)
  final double score;

  const ScoredPlace({required this.place, required this.score});
}

/// Recommendation Scoring Engine.
///
/// Given a user intent and optional GPS coordinates, retrieves and ranks
/// safe places using a weighted multi-factor score:
///
///   score = (distanceScore × 0.50) + (availabilityScore × 0.30) + (govBonus × 0.20)
///
/// Falls back gracefully when GPS is unavailable (distance factor set to 0.5).
class RecommendationScoringService {
  RecommendationScoringService._();

  static final RecommendationScoringService instance =
      RecommendationScoringService._();

  // ── Public API ─────────────────────────────────────────────────────────────
  // Note: Max scoring radius is 10.0 km (used in the Haversine path below).

  /// Returns up to [limit] places for [category], sorted by relevance score.
  ///
  /// [userLat] / [userLng] are optional. When null, distance scoring is
  /// replaced by a neutral 0.5 factor so other signals still rank results.
  List<SafePlaceModel> getScoredPlaces({
    required String category,
    double? userLat,
    double? userLng,
    int limit = 5,
  }) {
    final raw = SafePlacesService.instance.getPlacesByCategory(category);

    final scored = raw.map((place) {
      final score = _calculateScore(place, userLat, userLng);
      return ScoredPlace(place: place, score: score);
    }).toList()
      ..sort((a, b) => b.score.compareTo(a.score));

    return scored.take(limit).map((s) => s.place).toList();
  }

  /// Returns all categories with scored results, useful for "show everything"
  /// queries where no specific category is detected.
  List<SafePlaceModel> getTopAcrossAllCategories({
    double? userLat,
    double? userLng,
    int perCategory = 2,
  }) {
    final categories = SafePlacesService.instance.getCategories()
      ..remove('All');

    final results = <SafePlaceModel>[];
    for (final cat in categories) {
      results.addAll(
        getScoredPlaces(
          category: cat,
          userLat: userLat,
          userLng: userLng,
          limit: perCategory,
        ),
      );
    }
    return results;
  }

  // ── Scoring Logic ──────────────────────────────────────────────────────────

  double _calculateScore(
    SafePlaceModel place,
    double? userLat,
    double? userLng,
  ) {
    // 1. Distance Score [0.0 – 1.0]
    //    Computed only when the model has lat/lng AND user location is known.
    final double distScore = _distanceScore(place, userLat, userLng);

    // 2. Availability Score [0.7 – 1.0]
    final double availScore = place.isOpen24Hours ? 1.0 : 0.7;

    // 3. Government trust bonus [0.0 – 0.1]
    final double govBonus = place.isGovernment ? 0.1 : 0.0;

    // Weighted combination
    return (distScore * 0.50) + (availScore * 0.30) + govBonus;
  }

  double _distanceScore(
    SafePlaceModel place,
    double? userLat,
    double? userLng,
  ) {
    // The model doesn't currently carry lat/lng fields — return neutral score.
    // When you add latitude/longitude to SafePlaceModel (Phase 2), replace
    // this with the Haversine calculation below.
    if (userLat == null || userLng == null) return 0.5;

    // ---- Haversine placeholder (activate after adding lat/lng to model) ----
    // final distKm = _haversine(userLat, userLng, place.latitude, place.longitude);
    // return max(0.0, 1.0 - (distKm / 10.0)); // 10.0 km max radius
    return 0.5;
  }

  /// Haversine formula — computes great-circle distance in kilometres.
  // ignore: unused_element
  double _haversine(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadiusKm = 6371;
    final double dLat = _rad(lat2 - lat1);
    final double dLon = _rad(lon2 - lon1);
    final double a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(_rad(lat1)) * cos(_rad(lat2)) * sin(dLon / 2) * sin(dLon / 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadiusKm * c;
  }

  double _rad(double deg) => deg * pi / 180;
}
