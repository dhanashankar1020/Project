class SafePlaceModel {
  final String id;
  final String name;
  final String category;
  final String description;
  final String address;
  final String contactNumber;
  final bool isOpen24Hours;
  final bool isGovernment;
  final String image;
  final double latitude;
  final double longitude;

  const SafePlaceModel({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.address,
    required this.contactNumber,
    required this.isOpen24Hours,
    required this.isGovernment,
    required this.image,
    required this.latitude,
    required this.longitude,
  });

  SafePlaceModel copyWith({
    String? id,
    String? name,
    String? category,
    String? description,
    String? address,
    String? contactNumber,
    bool? isOpen24Hours,
    bool? isGovernment,
    String? image,
    double? latitude,
    double? longitude,
  }) {
    return SafePlaceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      address: address ?? this.address,
      contactNumber: contactNumber ?? this.contactNumber,
      isOpen24Hours: isOpen24Hours ?? this.isOpen24Hours,
      isGovernment: isGovernment ?? this.isGovernment,
      image: image ?? this.image,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}

