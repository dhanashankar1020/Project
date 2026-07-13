import '../models/safe_place_model.dart';

class ReliefCentersData {
  static const List<SafePlaceModel> data = [
    SafePlaceModel(
      id: "REL001",
      name: "District Disaster Relief Center",
      category: "Relief Center",
      description:
          "Provides emergency food, drinking water, medicines, and temporary accommodation.",
      address: "District Collector Office",
      contactNumber: "1070",
      isOpen24Hours: true,
      isGovernment: true,
      image: "assets/images/safe_places/district_relief.png",
    ),

    SafePlaceModel(
      id: "REL002",
      name: "State Emergency Relief Center",
      category: "Relief Center",
      description:
          "Coordinates statewide disaster response and rehabilitation.",
      address: "State Secretariat",
      contactNumber: "1070",
      isOpen24Hours: true,
      isGovernment: true,
      image: "assets/images/safe_places/state_relief.png",
    ),

    SafePlaceModel(
      id: "REL003",
      name: "Red Cross Relief Center",
      category: "Relief Center",
      description:
          "Provides emergency medical aid, food, and humanitarian assistance.",
      address: "Red Cross Campus",
      contactNumber: "1800-200-111",
      isOpen24Hours: true,
      isGovernment: false,
      image: "assets/images/safe_places/redcross_relief.png",
    ),

    SafePlaceModel(
      id: "REL004",
      name: "Community Relief Center",
      category: "Relief Center",
      description:
          "Offers food distribution, clean water, and temporary shelter.",
      address: "Community Hall",
      contactNumber: "1070",
      isOpen24Hours: true,
      isGovernment: true,
      image: "assets/images/safe_places/community_relief.png",
    ),

    SafePlaceModel(
      id: "REL005",
      name: "NGO Relief Camp",
      category: "Relief Center",
      description:
          "Volunteer-operated relief center providing emergency supplies.",
      address: "Relief Camp Area",
      contactNumber: "1800-200-222",
      isOpen24Hours: true,
      isGovernment: false,
      image: "assets/images/safe_places/ngo_relief.png",
    ),

    SafePlaceModel(
      id: "REL006",
      name: "Medical Relief Center",
      category: "Relief Center",
      description:
          "Provides emergency medicines and first aid treatment.",
      address: "Medical Camp",
      contactNumber: "108",
      isOpen24Hours: true,
      isGovernment: true,
      image: "assets/images/safe_places/medical_relief.png",
    ),

    SafePlaceModel(
      id: "REL007",
      name: "Food Distribution Center",
      category: "Relief Center",
      description:
          "Supplies cooked meals, groceries, and drinking water.",
      address: "Food Supply Depot",
      contactNumber: "1070",
      isOpen24Hours: true,
      isGovernment: true,
      image: "assets/images/safe_places/food_relief.png",
    ),

    SafePlaceModel(
      id: "REL008",
      name: "Women's Relief Center",
      category: "Relief Center",
      description:
          "Emergency support and protection services for women and children.",
      address: "Women's Welfare Office",
      contactNumber: "181",
      isOpen24Hours: true,
      isGovernment: true,
      image: "assets/images/safe_places/women_relief.png",
    ),

    SafePlaceModel(
      id: "REL009",
      name: "Child Protection Relief Center",
      category: "Relief Center",
      description:
          "Temporary care and protection for children during disasters.",
      address: "Child Welfare Center",
      contactNumber: "1098",
      isOpen24Hours: true,
      isGovernment: true,
      image: "assets/images/safe_places/child_relief.png",
    ),

    SafePlaceModel(
      id: "REL010",
      name: "Disaster Rehabilitation Center",
      category: "Relief Center",
      description:
          "Provides long-term rehabilitation and recovery support after disasters.",
      address: "Rehabilitation Complex",
      contactNumber: "1070",
      isOpen24Hours: true,
      isGovernment: true,
      image: "assets/images/safe_places/rehabilitation_center.png",
    ),
  ];
}