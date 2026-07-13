import '../models/emergency_item_model.dart';

class MedicalSuppliesData {
  static const List<EmergencyItemModel> data = [
    EmergencyItemModel(
      id: "MED001",
      name: "First Aid Kit",
      category: "Medical Supplies",
      description: "A complete first aid kit containing essential medical supplies.",
      quantity: 1,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/first_aid_kit.png",
    ),

    EmergencyItemModel(
      id: "MED002",
      name: "Adhesive Bandages",
      category: "Medical Supplies",
      description: "Used to cover and protect small cuts and wounds.",
      quantity: 20,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/bandages.png",
    ),

    EmergencyItemModel(
      id: "MED003",
      name: "Sterile Gauze Pads",
      category: "Medical Supplies",
      description: "For dressing larger wounds and controlling bleeding.",
      quantity: 10,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/gauze.png",
    ),

    EmergencyItemModel(
      id: "MED004",
      name: "Medical Tape",
      category: "Medical Supplies",
      description: "Secures gauze pads and bandages in place.",
      quantity: 2,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/medical_tape.png",
    ),

    EmergencyItemModel(
      id: "MED005",
      name: "Antiseptic Solution",
      category: "Medical Supplies",
      description: "Cleans wounds to reduce the risk of infection.",
      quantity: 1,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/antiseptic.png",
    ),

    EmergencyItemModel(
      id: "MED006",
      name: "Pain Relief Tablets",
      category: "Medical Supplies",
      description: "Helps relieve pain and reduce fever.",
      quantity: 20,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/painkiller.png",
    ),

    EmergencyItemModel(
      id: "MED007",
      name: "Prescription Medicines",
      category: "Medical Supplies",
      description: "Essential personal medications for family members.",
      quantity: 1,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/prescription.png",
    ),

    EmergencyItemModel(
      id: "MED008",
      name: "Disposable Gloves",
      category: "Medical Supplies",
      description: "Protects against contamination while giving first aid.",
      quantity: 10,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/gloves_medical.png",
    ),

    EmergencyItemModel(
      id: "MED009",
      name: "Face Masks",
      category: "Medical Supplies",
      description: "Protects against airborne dust and germs.",
      quantity: 5,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/face_mask.png",
    ),

    EmergencyItemModel(
      id: "MED010",
      name: "Thermometer",
      category: "Medical Supplies",
      description: "Used to monitor body temperature.",
      quantity: 1,
      isEssential: false,
      isPacked: false,
      image: "assets/images/emergency_kit/thermometer.png",
    ),

    EmergencyItemModel(
      id: "MED011",
      name: "Oral Rehydration Salts (ORS)",
      category: "Medical Supplies",
      description: "Prevents dehydration caused by diarrhea or heat.",
      quantity: 5,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/ors.png",
    ),

    EmergencyItemModel(
      id: "MED012",
      name: "Medical Scissors",
      category: "Medical Supplies",
      description: "Cuts bandages, clothing, or medical tape safely.",
      quantity: 1,
      isEssential: false,
      isPacked: false,
      image: "assets/images/emergency_kit/scissors.png",
    ),

    EmergencyItemModel(
      id: "MED013",
      name: "Tweezers",
      category: "Medical Supplies",
      description: "Removes splinters, glass fragments, or debris.",
      quantity: 1,
      isEssential: false,
      isPacked: false,
      image: "assets/images/emergency_kit/tweezers.png",
    ),

    EmergencyItemModel(
      id: "MED014",
      name: "Safety Pins",
      category: "Medical Supplies",
      description: "Useful for securing bandages or repairing clothing.",
      quantity: 10,
      isEssential: false,
      isPacked: false,
      image: "assets/images/emergency_kit/safety_pins.png",
    ),

    EmergencyItemModel(
      id: "MED015",
      name: "Burn Cream",
      category: "Medical Supplies",
      description: "Provides temporary relief for minor burns.",
      quantity: 1,
      isEssential: false,
      isPacked: false,
      image: "assets/images/emergency_kit/burn_cream.png",
    ),
  ];
}