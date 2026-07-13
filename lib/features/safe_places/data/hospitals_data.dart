import '../models/safe_place_model.dart';

class HospitalsData {
  static const List<SafePlaceModel> data = [
    SafePlaceModel(
      id: "HOSP001",
      name: "Government General Hospital",
      category: "Hospital",
      description:
          "24/7 government hospital providing emergency medical services.",
      address: "City Center",
      contactNumber: "108",
      isOpen24Hours: true,
      isGovernment: true,
      image: "assets/images/safe_places/government_hospital.png",
    ),

    SafePlaceModel(
      id: "HOSP002",
      name: "District Hospital",
      category: "Hospital",
      description:
          "Government district hospital with trauma and emergency care.",
      address: "District Headquarters",
      contactNumber: "108",
      isOpen24Hours: true,
      isGovernment: true,
      image: "assets/images/safe_places/district_hospital.png",
    ),

    SafePlaceModel(
      id: "HOSP003",
      name: "Primary Health Centre",
      category: "Hospital",
      description:
          "Provides primary healthcare and emergency first aid.",
      address: "Rural Area",
      contactNumber: "104",
      isOpen24Hours: false,
      isGovernment: true,
      image: "assets/images/safe_places/phc.png",
    ),

    SafePlaceModel(
      id: "HOSP004",
      name: "Community Health Centre",
      category: "Hospital",
      description:
          "Community healthcare facility with emergency treatment.",
      address: "Community Zone",
      contactNumber: "104",
      isOpen24Hours: true,
      isGovernment: true,
      image: "assets/images/safe_places/chc.png",
    ),

    SafePlaceModel(
      id: "HOSP005",
      name: "Private Multi-Speciality Hospital",
      category: "Hospital",
      description:
          "Private hospital offering emergency and specialist services.",
      address: "Main Road",
      contactNumber: "1800-000-111",
      isOpen24Hours: true,
      isGovernment: false,
      image: "assets/images/safe_places/private_hospital.png",
    ),

    SafePlaceModel(
      id: "HOSP006",
      name: "Children's Hospital",
      category: "Hospital",
      description:
          "Specialized emergency care for infants and children.",
      address: "Medical Campus",
      contactNumber: "1800-000-112",
      isOpen24Hours: true,
      isGovernment: false,
      image: "assets/images/safe_places/children_hospital.png",
    ),

    SafePlaceModel(
      id: "HOSP007",
      name: "Women's Hospital",
      category: "Hospital",
      description:
          "Emergency healthcare for women and maternity services.",
      address: "Health Complex",
      contactNumber: "1800-000-113",
      isOpen24Hours: true,
      isGovernment: false,
      image: "assets/images/safe_places/women_hospital.png",
    ),

    SafePlaceModel(
      id: "HOSP008",
      name: "Medical College Hospital",
      category: "Hospital",
      description:
          "Teaching hospital with advanced emergency care facilities.",
      address: "University Campus",
      contactNumber: "1800-000-114",
      isOpen24Hours: true,
      isGovernment: true,
      image: "assets/images/safe_places/medical_college.png",
    ),

    SafePlaceModel(
      id: "HOSP009",
      name: "Emergency Trauma Center",
      category: "Hospital",
      description:
          "Specialized trauma center for accident and disaster victims.",
      address: "Highway Junction",
      contactNumber: "108",
      isOpen24Hours: true,
      isGovernment: true,
      image: "assets/images/safe_places/trauma_center.png",
    ),

    SafePlaceModel(
      id: "HOSP010",
      name: "Red Cross Hospital",
      category: "Hospital",
      description:
          "Emergency medical assistance during disasters.",
      address: "Relief Zone",
      contactNumber: "1800-000-115",
      isOpen24Hours: true,
      isGovernment: false,
      image: "assets/images/safe_places/red_cross_hospital.png",
    ),
  ];
}