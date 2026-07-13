import '../models/emergency_item_model.dart';

class BasicSuppliesData {
  static const List<EmergencyItemModel> data = [
    EmergencyItemModel(
      id: "KIT001",
      name: "Flashlight",
      category: "Basic Supplies",
      description:
          "A flashlight helps you navigate safely during power outages or at night.",
      quantity: 1,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/flashlight.png",
    ),

    EmergencyItemModel(
      id: "KIT002",
      name: "Extra Batteries",
      category: "Basic Supplies",
      description:
          "Keep spare batteries for flashlights, radios, and other devices.",
      quantity: 4,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/batteries.png",
    ),

    EmergencyItemModel(
      id: "KIT003",
      name: "Whistle",
      category: "Basic Supplies",
      description:
          "Use a whistle to signal for help if trapped or lost.",
      quantity: 1,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/whistle.png",
    ),

    EmergencyItemModel(
      id: "KIT004",
      name: "Emergency Blanket",
      category: "Basic Supplies",
      description:
          "Helps retain body heat during cold weather or emergencies.",
      quantity: 1,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/emergency_blanket.png",
    ),

    EmergencyItemModel(
      id: "KIT005",
      name: "Raincoat",
      category: "Basic Supplies",
      description:
          "Protects you from rain and helps prevent hypothermia.",
      quantity: 1,
      isEssential: false,
      isPacked: false,
      image: "assets/images/emergency_kit/raincoat.png",
    ),

    EmergencyItemModel(
      id: "KIT006",
      name: "Dust Mask",
      category: "Basic Supplies",
      description:
          "Protects against dust, smoke, and airborne particles.",
      quantity: 5,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/dust_mask.png",
    ),

    EmergencyItemModel(
      id: "KIT007",
      name: "Work Gloves",
      category: "Basic Supplies",
      description:
          "Protect your hands while clearing debris or handling sharp objects.",
      quantity: 1,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/gloves.png",
    ),

    EmergencyItemModel(
      id: "KIT008",
      name: "Waterproof Matches",
      category: "Basic Supplies",
      description:
          "Useful for starting a fire in wet conditions.",
      quantity: 1,
      isEssential: false,
      isPacked: false,
      image: "assets/images/emergency_kit/matches.png",
    ),

    EmergencyItemModel(
      id: "KIT009",
      name: "Emergency Poncho",
      category: "Basic Supplies",
      description:
          "Lightweight protection from rain and wind.",
      quantity: 1,
      isEssential: false,
      isPacked: false,
      image: "assets/images/emergency_kit/poncho.png",
    ),

    EmergencyItemModel(
      id: "KIT010",
      name: "Notebook & Pen",
      category: "Basic Supplies",
      description:
          "Useful for writing emergency information, phone numbers, or notes.",
      quantity: 1,
      isEssential: false,
      isPacked: false,
      image: "assets/images/emergency_kit/notebook.png",
    ),

    EmergencyItemModel(
      id: "KIT011",
      name: "Plastic Zip Bags",
      category: "Basic Supplies",
      description:
          "Keep important items dry and organized.",
      quantity: 10,
      isEssential: false,
      isPacked: false,
      image: "assets/images/emergency_kit/zip_bags.png",
    ),

    EmergencyItemModel(
      id: "KIT012",
      name: "Garbage Bags",
      category: "Basic Supplies",
      description:
          "Can be used for waste disposal, waterproofing, or shelter.",
      quantity: 5,
      isEssential: false,
      isPacked: false,
      image: "assets/images/emergency_kit/garbage_bags.png",
    ),
  ];
}