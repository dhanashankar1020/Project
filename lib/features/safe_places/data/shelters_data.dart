import '../models/safe_place_model.dart';

class SheltersData {
  static const List<SafePlaceModel> data = [
    SafePlaceModel(
      id: "SHEL001",
      name: "Community Relief Shelter",
      category: "Shelter",
      description:
          "Temporary shelter with food, water, and emergency medical support.",
      address: "Community Hall, City Center",
      contactNumber: "1077",
      isOpen24Hours: true,
      isGovernment: true,
      image: "assets/images/safe_places/community_shelter.png",
      latitude: 28.6150,
      longitude: 77.2080,
    ),

    SafePlaceModel(
      id: "SHEL002",
      name: "Government High School Shelter",
      category: "Shelter",
      description:
          "School building designated as an emergency evacuation center.",
      address: "North Zone",
      contactNumber: "1077",
      isOpen24Hours: true,
      isGovernment: true,
      image: "assets/images/safe_places/school_shelter.png",
      latitude: 28.6350,
      longitude: 77.1950,
    ),

    SafePlaceModel(
      id: "SHEL003",
      name: "Cyclone Relief Shelter",
      category: "Shelter",
      description:
          "Multi-storey shelter designed for cyclone and storm emergencies.",
      address: "Coastal Area",
      contactNumber: "1077",
      isOpen24Hours: true,
      isGovernment: true,
      image: "assets/images/safe_places/cyclone_shelter.png",
      latitude: 28.6000,
      longitude: 77.2300,
    ),

    SafePlaceModel(
      id: "SHEL004",
      name: "Flood Relief Camp",
      category: "Shelter",
      description:
          "Safe accommodation for families affected by floods.",
      address: "River Side",
      contactNumber: "1077",
      isOpen24Hours: true,
      isGovernment: true,
      image: "assets/images/safe_places/flood_camp.png",
      latitude: 28.5800,
      longitude: 77.2400,
    ),

    SafePlaceModel(
      id: "SHEL005",
      name: "Sports Complex Shelter",
      category: "Shelter",
      description:
          "Large indoor shelter for disaster evacuation.",
      address: "Sports Complex",
      contactNumber: "1077",
      isOpen24Hours: true,
      isGovernment: false,
      image: "assets/images/safe_places/sports_shelter.png",
      latitude: 28.6280,
      longitude: 77.2120,
    ),

    SafePlaceModel(
      id: "SHEL006",
      name: "Temple Relief Center",
      category: "Shelter",
      description:
          "Religious institution providing emergency accommodation.",
      address: "Temple Road",
      contactNumber: "1077",
      isOpen24Hours: true,
      isGovernment: false,
      image: "assets/images/safe_places/temple_shelter.png",
      latitude: 28.6050,
      longitude: 77.1850,
    ),

    SafePlaceModel(
      id: "SHEL007",
      name: "Church Community Shelter",
      category: "Shelter",
      description:
          "Community shelter offering temporary accommodation.",
      address: "Church Street",
      contactNumber: "1077",
      isOpen24Hours: true,
      isGovernment: false,
      image: "assets/images/safe_places/church_shelter.png",
      latitude: 28.6220,
      longitude: 77.2050,
    ),

    SafePlaceModel(
      id: "SHEL008",
      name: "College Evacuation Center",
      category: "Shelter",
      description:
          "College campus converted into an emergency shelter.",
      address: "University Campus",
      contactNumber: "1077",
      isOpen24Hours: true,
      isGovernment: true,
      image: "assets/images/safe_places/college_shelter.png",
      latitude: 28.6080,
      longitude: 77.2180,
    ),

    SafePlaceModel(
      id: "SHEL009",
      name: "Town Hall Shelter",
      category: "Shelter",
      description:
          "Municipal shelter with emergency supplies.",
      address: "Town Hall",
      contactNumber: "1077",
      isOpen24Hours: true,
      isGovernment: true,
      image: "assets/images/safe_places/townhall_shelter.png",
      latitude: 28.6180,
      longitude: 77.2030,
    ),

    SafePlaceModel(
      id: "SHEL010",
      name: "Disaster Relief Camp",
      category: "Shelter",
      description:
          "Temporary camp established during major disasters.",
      address: "Emergency Relief Ground",
      contactNumber: "1077",
      isOpen24Hours: true,
      isGovernment: true,
      image: "assets/images/safe_places/disaster_camp.png",
      latitude: 28.5700,
      longitude: 77.2500,
    ),
  ];
}