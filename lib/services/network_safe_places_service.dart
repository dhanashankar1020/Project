import 'dart:convert';
import 'package:http/http.dart' as http;
import '../features/safe_places/models/safe_place_model.dart';

/// Service that fetches real-time safe places nearby user GPS coordinates
/// using OpenStreetMap Overpass API.
class NetworkSafePlacesService {
  NetworkSafePlacesService._();
  static final NetworkSafePlacesService instance = NetworkSafePlacesService._();

  static const String _overpassUrl = 'https://overpass-api.de/api/interpreter';

  /// Fetches nearby real-time safe places around [lat] and [lng] within [radiusMeters].
  Future<List<SafePlaceModel>> fetchNearbySafePlaces({
    required double lat,
    required double lng,
    String category = 'All',
    int radiusMeters = 5000,
  }) async {
    final queryTagPattern = _getCategoryAmenityFilter(category);
    final overpassQuery = '''
[out:json][timeout:15];
(
  node["amenity"~"$queryTagPattern"](around:$radiusMeters,$lat,$lng);
  node["building"="shelter"](around:$radiusMeters,$lat,$lng);
);
out body 30;
''';

    try {
      final response = await http.post(
        Uri.parse(_overpassUrl),
        body: {'data': overpassQuery},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) {
        return [];
      }

      final data = json.decode(response.body);
      final List elements = data['elements'] ?? [];

      final List<SafePlaceModel> results = [];
      for (final item in elements) {
        final double? itemLat = (item['lat'] as num?)?.toDouble();
        final double? itemLng = (item['lon'] as num?)?.toDouble();

        if (itemLat == null || itemLng == null) continue;

        final tags = item['tags'] as Map<String, dynamic>? ?? {};
        final String rawAmenity = tags['amenity'] ?? tags['building'] ?? 'safe_place';
        final String placeCategory = _mapAmenityToCategory(rawAmenity);

        final String name = tags['name'] ??
            tags['name:en'] ??
            tags['official_name'] ??
            '$placeCategory (Nearby)';

        final String street = tags['addr:street'] ?? tags['addr:full'] ?? tags['addr:city'] ?? 'Local Area';
        final String phone = tags['phone'] ?? tags['contact:phone'] ?? '108';
        final String openingHours = tags['opening_hours'] ?? '';

        results.add(
          SafePlaceModel(
            id: 'OSM_${item['id']}',
            name: name,
            category: placeCategory,
            description: 'Live OpenStreetMap location • $rawAmenity',
            address: street,
            contactNumber: phone,
            isOpen24Hours: openingHours.contains('24/7') || placeCategory == 'Hospital' || placeCategory == 'Police',
            isGovernment: tags['operator:type'] == 'government' || placeCategory == 'Police' || placeCategory == 'Fire Station',
            image: _getCategoryImage(placeCategory),
            latitude: itemLat,
            longitude: itemLng,
          ),
        );
      }

      return results;
    } catch (_) {
      return [];
    }
  }

  String _getCategoryAmenityFilter(String category) {
    switch (category.toLowerCase()) {
      case 'hospital':
        return 'hospital|clinic|doctors';
      case 'police':
        return 'police';
      case 'fire station':
        return 'fire_station';
      case 'shelter':
        return 'shelter';
      case 'relief center':
        return 'social_facility|community_centre';
      default:
        return 'hospital|clinic|police|fire_station|shelter|social_facility';
    }
  }

  String _mapAmenityToCategory(String amenity) {
    switch (amenity.toLowerCase()) {
      case 'hospital':
      case 'clinic':
      case 'doctors':
        return 'Hospital';
      case 'police':
        return 'Police';
      case 'fire_station':
        return 'Fire Station';
      case 'shelter':
        return 'Shelter';
      case 'social_facility':
      case 'community_centre':
        return 'Relief Center';
      default:
        return 'Shelter';
    }
  }

  String _getCategoryImage(String category) {
    switch (category) {
      case 'Hospital':
        return 'assets/images/safe_places/government_hospital.png';
      case 'Police':
        return 'assets/images/safe_places/police_station.png';
      case 'Fire Station':
        return 'assets/images/safe_places/fire_station.png';
      case 'Shelter':
        return 'assets/images/safe_places/storm_shelter.png';
      case 'Relief Center':
        return 'assets/images/safe_places/relief_camp.png';
      default:
        return 'assets/images/safe_places/government_hospital.png';
    }
  }
}
