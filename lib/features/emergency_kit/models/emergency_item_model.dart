class EmergencyItemModel {
  final String id;
  final String name;
  final String category;
  final String description;
  final int quantity;
  final bool isEssential;
  final bool isPacked;
  final String image;

  const EmergencyItemModel({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.quantity,
    required this.isEssential,
    required this.isPacked,
    required this.image,
  });

  EmergencyItemModel copyWith({
    String? id,
    String? name,
    String? category,
    String? description,
    int? quantity,
    bool? isEssential,
    bool? isPacked,
    String? image,
  }) {
    return EmergencyItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      isEssential: isEssential ?? this.isEssential,
      isPacked: isPacked ?? this.isPacked,
      image: image ?? this.image,
    );
  }
}