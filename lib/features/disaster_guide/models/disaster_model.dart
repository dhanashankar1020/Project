class DisasterModel {
  final String id;
  final String title;
  final String description;
  final String safetyTips;
  final String emergencyNumber;
  final String image;

  const DisasterModel({
    required this.id,
    required this.title,
    required this.description,
    required this.safetyTips,
    required this.emergencyNumber,
    required this.image,
  });

  DisasterModel copyWith({
    String? id,
    String? title,
    String? description,
    String? safetyTips,
    String? emergencyNumber,
    String? image,
  }) {
    return DisasterModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      safetyTips: safetyTips ?? this.safetyTips,
      emergencyNumber: emergencyNumber ?? this.emergencyNumber,
      image: image ?? this.image,
    );
  }
}