import '../models/emergency_item_model.dart';

class DocumentsData {
  static const List<EmergencyItemModel> data = [
    EmergencyItemModel(
      id: "DOC001",
      name: "Government ID",
      category: "Important Documents",
      description:
          "Carry copies of Aadhaar Card, Passport, Driving License, or other government-issued ID.",
      quantity: 1,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/government_id.png",
    ),

    EmergencyItemModel(
      id: "DOC002",
      name: "Passport",
      category: "Important Documents",
      description:
          "Keep your passport in a waterproof folder for emergencies.",
      quantity: 1,
      isEssential: false,
      isPacked: false,
      image: "assets/images/emergency_kit/passport.png",
    ),

    EmergencyItemModel(
      id: "DOC003",
      name: "Medical Records",
      category: "Important Documents",
      description:
          "Carry prescriptions, blood group information, allergies, and medical history.",
      quantity: 1,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/medical_records.png",
    ),

    EmergencyItemModel(
      id: "DOC004",
      name: "Health Insurance Card",
      category: "Important Documents",
      description:
          "Useful for receiving medical treatment during emergencies.",
      quantity: 1,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/insurance_card.png",
    ),

    EmergencyItemModel(
      id: "DOC005",
      name: "Emergency Contact List",
      category: "Important Documents",
      description:
          "Printed list of emergency phone numbers for family and authorities.",
      quantity: 1,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/contact_list.png",
    ),

    EmergencyItemModel(
      id: "DOC006",
      name: "Emergency Cash",
      category: "Important Documents",
      description:
          "Carry small denomination cash in case ATMs or digital payments are unavailable.",
      quantity: 1,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/emergency_cash.png",
    ),

    EmergencyItemModel(
      id: "DOC007",
      name: "Bank Account Details",
      category: "Important Documents",
      description:
          "Keep important bank account information in a secure place.",
      quantity: 1,
      isEssential: false,
      isPacked: false,
      image: "assets/images/emergency_kit/bank_details.png",
    ),

    EmergencyItemModel(
      id: "DOC008",
      name: "Property Documents",
      category: "Important Documents",
      description:
          "Copies of house ownership or rental agreements.",
      quantity: 1,
      isEssential: false,
      isPacked: false,
      image: "assets/images/emergency_kit/property_documents.png",
    ),

    EmergencyItemModel(
      id: "DOC009",
      name: "Vehicle Documents",
      category: "Important Documents",
      description:
          "Vehicle registration, insurance, and driving license copies.",
      quantity: 1,
      isEssential: false,
      isPacked: false,
      image: "assets/images/emergency_kit/vehicle_documents.png",
    ),

    EmergencyItemModel(
      id: "DOC010",
      name: "House Keys",
      category: "Important Documents",
      description:
          "Carry an extra set of house keys in your emergency kit.",
      quantity: 1,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/house_keys.png",
    ),

    EmergencyItemModel(
      id: "DOC011",
      name: "USB Drive",
      category: "Important Documents",
      description:
          "Store scanned copies of important documents securely.",
      quantity: 1,
      isEssential: false,
      isPacked: false,
      image: "assets/images/emergency_kit/usb_drive.png",
    ),

    EmergencyItemModel(
      id: "DOC012",
      name: "Family Photograph",
      category: "Important Documents",
      description:
          "Helpful for identification if family members become separated.",
      quantity: 1,
      isEssential: false,
      isPacked: false,
      image: "assets/images/emergency_kit/family_photo.png",
    ),
  ];
}