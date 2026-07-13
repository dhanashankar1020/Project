import '../models/emergency_item_model.dart';

class BabyPetData {
  static const List<EmergencyItemModel> data = [
    EmergencyItemModel(
      id: "BP001",
      name: "Diapers",
      category: "Baby & Pet Supplies",
      description:
          "Keep enough diapers for at least 3 days for each baby.",
      quantity: 20,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/diapers.png",
    ),

    EmergencyItemModel(
      id: "BP002",
      name: "Baby Formula",
      category: "Baby & Pet Supplies",
      description:
          "Store baby formula or baby food for emergency situations.",
      quantity: 2,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/baby_formula.png",
    ),

    EmergencyItemModel(
      id: "BP003",
      name: "Baby Feeding Bottle",
      category: "Baby & Pet Supplies",
      description:
          "Clean feeding bottle for infants.",
      quantity: 2,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/baby_bottle.png",
    ),

    EmergencyItemModel(
      id: "BP004",
      name: "Baby Wipes",
      category: "Baby & Pet Supplies",
      description:
          "Useful for cleaning babies when water is limited.",
      quantity: 2,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/baby_wipes.png",
    ),

    EmergencyItemModel(
      id: "BP005",
      name: "Baby Blanket",
      category: "Baby & Pet Supplies",
      description:
          "Keeps babies warm during cold weather or emergencies.",
      quantity: 1,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/baby_blanket.png",
    ),

    EmergencyItemModel(
      id: "BP006",
      name: "Baby Clothes",
      category: "Baby & Pet Supplies",
      description:
          "Pack extra clothes suitable for the weather.",
      quantity: 3,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/baby_clothes.png",
    ),

    EmergencyItemModel(
      id: "BP007",
      name: "Pet Food",
      category: "Baby & Pet Supplies",
      description:
          "Carry enough food for your pet for several days.",
      quantity: 5,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/pet_food.png",
    ),

    EmergencyItemModel(
      id: "BP008",
      name: "Pet Water Bowl",
      category: "Baby & Pet Supplies",
      description:
          "Portable bowl for feeding water to pets.",
      quantity: 1,
      isEssential: false,
      isPacked: false,
      image: "assets/images/emergency_kit/pet_bowl.png",
    ),

    EmergencyItemModel(
      id: "BP009",
      name: "Pet Leash",
      category: "Baby & Pet Supplies",
      description:
          "Helps keep your pet safe during evacuation.",
      quantity: 1,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/pet_leash.png",
    ),

    EmergencyItemModel(
      id: "BP010",
      name: "Pet Carrier",
      category: "Baby & Pet Supplies",
      description:
          "Safe transport for small pets during emergencies.",
      quantity: 1,
      isEssential: false,
      isPacked: false,
      image: "assets/images/emergency_kit/pet_carrier.png",
    ),

    EmergencyItemModel(
      id: "BP011",
      name: "Pet Medicines",
      category: "Baby & Pet Supplies",
      description:
          "Essential medicines prescribed for your pet.",
      quantity: 1,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/pet_medicine.png",
    ),

    EmergencyItemModel(
      id: "BP012",
      name: "Pet Vaccination Records",
      category: "Baby & Pet Supplies",
      description:
          "Copies of vaccination and medical records for pets.",
      quantity: 1,
      isEssential: false,
      isPacked: false,
      image: "assets/images/emergency_kit/pet_records.png",
    ),
  ];
}