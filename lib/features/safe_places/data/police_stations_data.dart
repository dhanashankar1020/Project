import '../models/safe_place_model.dart';

class PoliceStationsData {
  static const List<SafePlaceModel> data = [
    SafePlaceModel(
      id: "POL001",
      name: "Central Police Station",
      category: "Police Station",
      description:
          "Main police station providing emergency law enforcement services.",
      address: "City Center",
      contactNumber: "100",
      isOpen24Hours: true,
      isGovernment: true,
      image: "assets/images/safe_places/central_police.png",
    ),

    SafePlaceModel(
      id: "POL002",
      name: "North Police Station",
      category: "Police Station",
      description:
          "Handles emergency response, public safety, and crime reporting.",
      address: "North Zone",
      contactNumber: "100",
      isOpen24Hours: true,
      isGovernment: true,
      image: "assets/images/safe_places/north_police.png",
    ),

    SafePlaceModel(
      id: "POL003",
      name: "South Police Station",
      category: "Police Station",
      description:
          "Provides emergency assistance and disaster support.",
      address: "South Zone",
      contactNumber: "100",
      isOpen24Hours: true,
      isGovernment: true,
      image: "assets/images/safe_places/south_police.png",
    ),

    SafePlaceModel(
      id: "POL004",
      name: "East Police Station",
      category: "Police Station",
      description:
          "Offers 24-hour emergency police assistance.",
      address: "East Zone",
      contactNumber: "100",
      isOpen24Hours: true,
      isGovernment: true,
      image: "assets/images/safe_places/east_police.png",
    ),

    SafePlaceModel(
      id: "POL005",
      name: "West Police Station",
      category: "Police Station",
      description:
          "Emergency response and community safety services.",
      address: "West Zone",
      contactNumber: "100",
      isOpen24Hours: true,
      isGovernment: true,
      image: "assets/images/safe_places/west_police.png",
    ),

    SafePlaceModel(
      id: "POL006",
      name: "Highway Patrol Station",
      category: "Police Station",
      description:
          "Responds to highway accidents and road emergencies.",
      address: "National Highway",
      contactNumber: "103",
      isOpen24Hours: true,
      isGovernment: true,
      image: "assets/images/safe_places/highway_police.png",
    ),

    SafePlaceModel(
      id: "POL007",
      name: "Women's Police Station",
      category: "Police Station",
      description:
          "Specialized support for women and children in emergencies.",
      address: "Civil Lines",
      contactNumber: "1091",
      isOpen24Hours: true,
      isGovernment: true,
      image: "assets/images/safe_places/women_police.png",
    ),

    SafePlaceModel(
      id: "POL008",
      name: "Railway Police Station",
      category: "Police Station",
      description:
          "Emergency security and assistance at railway stations.",
      address: "Railway Junction",
      contactNumber: "1512",
      isOpen24Hours: true,
      isGovernment: true,
      image: "assets/images/safe_places/railway_police.png",
    ),

    SafePlaceModel(
      id: "POL009",
      name: "Tourist Police Station",
      category: "Police Station",
      description:
          "Provides safety assistance and information for visitors.",
      address: "Tourist Area",
      contactNumber: "100",
      isOpen24Hours: true,
      isGovernment: true,
      image: "assets/images/safe_places/tourist_police.png",
    ),

    SafePlaceModel(
      id: "POL010",
      name: "Cyber Crime Police Cell",
      category: "Police Station",
      description:
          "Handles cybercrime complaints and digital fraud cases.",
      address: "IT Park",
      contactNumber: "1930",
      isOpen24Hours: false,
      isGovernment: true,
      image: "assets/images/safe_places/cyber_police.png",
    ),
  ];
}