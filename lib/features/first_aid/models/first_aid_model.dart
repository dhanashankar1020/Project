class FirstAidModel {
  final String id;
  final String title;
  final String description;
  final List<String> steps;
  final String warning;
  final String emergencyNumber;
  final String image;

  const FirstAidModel({
    required this.id,
    required this.title,
    required this.description,
    required this.steps,
    required this.warning,
    required this.emergencyNumber,
    required this.image,
  });

  FirstAidModel copyWith({
    String? id,
    String? title,
    String? description,
    List<String>? steps,
    String? warning,
    String? emergencyNumber,
    String? image,
  }) {
    return FirstAidModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      steps: steps ?? this.steps,
      warning: warning ?? this.warning,
      emergencyNumber: emergencyNumber ?? this.emergencyNumber,
      image: image ?? this.image,
    );
  }
}