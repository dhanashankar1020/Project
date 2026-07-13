import '../models/safe_place_model.dart';

import 'fire_stations_data.dart';
import 'hospitals_data.dart';
import 'police_stations_data.dart';
import 'relief_centers_data.dart';
import 'shelters_data.dart';

class SafePlacesData {
  SafePlacesData._();

  /// Complete list of safe places
  static final List<SafePlaceModel> allPlaces = [
    ...HospitalsData.data,
    ...PoliceStationsData.data,
    ...FireStationsData.data,
    ...SheltersData.data,
    ...ReliefCentersData.data,
  ];

  /// Total safe places
  static int get totalPlaces => allPlaces.length;

  /// Search by name, category or description
  static List<SafePlaceModel> search(String query) {
    if (query.trim().isEmpty) {
      return allPlaces;
    }

    final keyword = query.toLowerCase();

    return allPlaces.where((place) {
      return place.name.toLowerCase().contains(keyword) ||
          place.category.toLowerCase().contains(keyword) ||
          place.description.toLowerCase().contains(keyword) ||
          place.address.toLowerCase().contains(keyword);
    }).toList();
  }

  /// Filter by category
  static List<SafePlaceModel> getByCategory(String category) {
    return allPlaces.where((place) {
      return place.category == category;
    }).toList();
  }

  /// Find by ID
  static SafePlaceModel? getById(String id) {
    try {
      return allPlaces.firstWhere((place) => place.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Government places only
  static List<SafePlaceModel> get governmentPlaces {
    return allPlaces.where((place) => place.isGovernment).toList();
  }

  /// 24-hour places only
  static List<SafePlaceModel> get open24HoursPlaces {
    return allPlaces.where((place) => place.isOpen24Hours).toList();
  }

  /// All categories
  static List<String> get categories {
    return allPlaces
        .map((place) => place.category)
        .toSet()
        .toList()
      ..sort();
  }
}