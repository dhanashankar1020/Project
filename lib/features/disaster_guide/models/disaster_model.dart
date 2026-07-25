class DisasterModel {
  final String id;
  final String title;
  final String description;
  final List<String> before;
  final List<String> during;
  final List<String> after;
  final String emergencyNumber;
  final String image;
  final String emergencyTip;
  

  const DisasterModel({
    required this.id,
    required this.title,
    required this.description,
    required this.before,
    required this.during,
    required this.after,
    required this.emergencyNumber,
    required this.image,
    required this.emergencyTip,
    
  });

  DisasterModel copyWith({
    String? id,
    String? title,
    String? description,
    List<String>? before,
    List<String>? during,
    List<String>? after,
    String? emergencyNumber,
    String? image,
    String? emergencyTip,
    
  }) {
    return DisasterModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      before: before ?? this.before,
      during: during ?? this.during,
      after: after ?? this.after,
      emergencyNumber: emergencyNumber ?? this.emergencyNumber,
      image: image ?? this.image,
      emergencyTip: emergencyTip ?? this.emergencyTip,
      
    );
  }
}