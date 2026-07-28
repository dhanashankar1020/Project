/// Represents a safe location like a hospital, shelter, police station, etc.
class SafePlace {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final SafePlaceCategory category;
  final String phoneNumber;
  final String description;
  final bool isOpen24Hours;
  final double rating;
  final int distanceMeters;
  final String distanceText;
  final List<String> services;
  final String? website;

  const SafePlace({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.category,
    this.phoneNumber = '',
    this.description = '',
    this.isOpen24Hours = true,
    this.rating = 0.0,
    this.distanceMeters = 0,
    this.distanceText = '',
    this.services = const [],
    this.website,
  });

  /// Returns a Google Maps navigation URL for this location
  String get googleMapsUrl {
    return 'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude&travelmode=driving';
  }

  /// Returns the category display name
  String get categoryName {
    switch (category) {
      case SafePlaceCategory.hospital:
        return 'Hospital';
      case SafePlaceCategory.shelter:
        return 'Shelter';
      case SafePlaceCategory.policeStation:
        return 'Police Station';
      case SafePlaceCategory.fireStation:
        return 'Fire Station';
      case SafePlaceCategory.pharmacy:
        return 'Pharmacy';
      case SafePlaceCategory.reliefCamp:
        return 'Relief Camp';
      case SafePlaceCategory.clinic:
        return 'Clinic';
      case SafePlaceCategory.communityCenter:
        return 'Community Center';
    }
  }

  /// Returns the icon for the category
  String get categoryIcon {
    switch (category) {
      case SafePlaceCategory.hospital:
        return '🏥';
      case SafePlaceCategory.shelter:
        return '🏠';
      case SafePlaceCategory.policeStation:
        return '👮';
      case SafePlaceCategory.fireStation:
        return '🚒';
      case SafePlaceCategory.pharmacy:
        return '💊';
      case SafePlaceCategory.reliefCamp:
        return '⛑️';
      case SafePlaceCategory.clinic:
        return '🏥';
      case SafePlaceCategory.communityCenter:
        return '🏛️';
    }
  }
}

/// Categories of safe places
enum SafePlaceCategory {
  hospital,
  shelter,
  policeStation,
  fireStation,
  pharmacy,
  reliefCamp,
  clinic,
  communityCenter,
}
