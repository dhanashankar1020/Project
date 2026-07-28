import '../data/safe_places_data.dart';
import '../models/safe_place_model.dart';
import '../../../services/location_service.dart';
import '../../../services/network_safe_places_service.dart';

class SafePlacesService {
  SafePlacesService._();

  static final SafePlacesService instance = SafePlacesService._();

  /// Get all safe places
  List<SafePlaceModel> getAllPlaces() {
    return List.unmodifiable(SafePlacesData.allPlaces);
  }

  /// Total places
  int get totalPlaces => SafePlacesData.allPlaces.length;

  /// Search places
  List<SafePlaceModel> searchPlaces(String query) {
    if (query.trim().isEmpty) {
      return getAllPlaces();
    }

    final keyword = query.toLowerCase();

    return SafePlacesData.allPlaces.where((place) {
      return place.name.toLowerCase().contains(keyword) ||
          place.category.toLowerCase().contains(keyword) ||
          place.description.toLowerCase().contains(keyword) ||
          place.address.toLowerCase().contains(keyword);
    }).toList();
  }

  /// Get places by category
  List<SafePlaceModel> getPlacesByCategory(String category) {
    if (category.trim().isEmpty || category.toLowerCase() == 'all') {
      return getAllPlaces();
    }

    final normalizedCategory = category.toLowerCase().trim();

    return SafePlacesData.allPlaces.where((place) {
      final placeCategory = place.category.toLowerCase();
      return placeCategory == normalizedCategory ||
          (normalizedCategory == 'police' && placeCategory.contains('police')) ||
          (normalizedCategory == 'fire' && placeCategory.contains('fire')) ||
          (normalizedCategory == 'fire station' && placeCategory.contains('fire')) ||
          (normalizedCategory == 'shelter' && placeCategory.contains('shelter')) ||
          (normalizedCategory == 'hospital' && placeCategory.contains('hospital')) ||
          (normalizedCategory == 'relief' && placeCategory.contains('relief')) ||
          (normalizedCategory == 'relief center' && placeCategory.contains('relief'));
    }).toList();
  }

  /// Get government places
  List<SafePlaceModel> getGovernmentPlaces() {
    return SafePlacesData.allPlaces.where((place) {
      return place.isGovernment;
    }).toList();
  }

  /// Get 24-hour places
  List<SafePlaceModel> get24HourPlaces() {
    return SafePlacesData.allPlaces.where((place) {
      return place.isOpen24Hours;
    }).toList();
  }

  /// Find place by ID
  SafePlaceModel? getPlaceById(String id) {
    try {
      return SafePlacesData.allPlaces.firstWhere(
        (place) => place.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  /// Check if place exists
  bool placeExists(String id) {
    return SafePlacesData.allPlaces.any(
      (place) => place.id == id,
    );
  }

  /// Get all categories
  List<String> getCategories() {
    return SafePlacesData.categories;
  }

  /// Get total government places
  int getGovernmentPlaceCount() {
    return getGovernmentPlaces().length;
  }

  /// Get total 24-hour places
  int get24HourPlaceCount() {
    return get24HourPlaces().length;
  }
  /// AI Recommendation
List<SafePlaceModel> getRecommendedPlaces(String prompt) {
  final text = prompt.toLowerCase();

  if (text.contains("hospital") ||
      text.contains("medical") ||
      text.contains("injury")) {
    return getPlacesByCategory("Hospital");
  }

  if (text.contains("shelter") ||
      text.contains("cyclone") ||
      text.contains("flood")) {
    return getPlacesByCategory("Shelter");
  }

  if (text.contains("police") ||
      text.contains("crime")) {
    return getPlacesByCategory("Police");
  }

  if (text.contains("fire")) {
    return getPlacesByCategory("Fire Station");
  }

  if (text.contains("relief")) {
    return getPlacesByCategory("Relief Center");
  }

  return getAllPlaces();
}

  /// Fetches real-time safe places from OpenStreetMap Overpass API near [lat] and [lng].
  /// Automatically sorts places by distance and falls back to local data if offline or unavailable.
  Future<List<SafePlaceModel>> fetchRealTimeNearbyPlaces({
    required double lat,
    required double lng,
    String category = 'All',
  }) async {
    final networkPlaces = await NetworkSafePlacesService.instance.fetchNearbySafePlaces(
      lat: lat,
      lng: lng,
      category: category,
    );

    if (networkPlaces.isNotEmpty) {
      networkPlaces.sort((a, b) {
        final distA = LocationService.calculateDistanceKm(lat, lng, a.latitude, a.longitude);
        final distB = LocationService.calculateDistanceKm(lat, lng, b.latitude, b.longitude);
        return distA.compareTo(distB);
      });
      return networkPlaces;
    }

    // Fallback to local dataset sorted by distance
    final localPlaces = getPlacesByCategory(category);
    localPlaces.sort((a, b) {
      final distA = LocationService.calculateDistanceKm(lat, lng, a.latitude, a.longitude);
      final distB = LocationService.calculateDistanceKm(lat, lng, b.latitude, b.longitude);
      return distA.compareTo(distB);
    });

    return localPlaces;
  }
}