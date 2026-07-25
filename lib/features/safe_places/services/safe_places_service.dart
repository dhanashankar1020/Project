import '../data/safe_places_data.dart';
import '../models/safe_place_model.dart';

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
  if (category == "All") {
    return getAllPlaces();
  }

  return SafePlacesData.allPlaces.where((place) {
    return place.category.toLowerCase() ==
        category.toLowerCase();
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
}