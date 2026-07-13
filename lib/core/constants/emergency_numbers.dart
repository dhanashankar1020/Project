class EmergencyNumbers {
  EmergencyNumbers._();

  // National Emergency
  static const String emergency = "112";

  // Police
  static const String police = "100";

  // Fire
  static const String fire = "101";

  // Ambulance
  static const String ambulance = "108";

  // Disaster Management
  static const String disasterManagementNational = "1070";
  static const String disasterManagementDistrict = "1077";

  // Women Helpline
  static const String womenHelpline = "181";
  static const String womenPolice = "1091";

  // Child Helpline
  static const String childHelpline = "1098";

  // Cyber Crime
  static const String cyberCrime = "1930";

  // Senior Citizen Helpline
  static const String seniorCitizen = "14567";

  // Mental Health Helpline
  static const String mentalHealth = "14416";

  // Railway
  static const String railwayHelpline = "139";
  static const String railwayPolice = "1512";

  // Road Accident
  static const String highwayEmergency = "1033";

  // Coast Guard
  static const String coastGuard = "1554";

  // Electricity Emergency
  static const String electricity = "1912";

  // Gas Leakage
  static const String gasEmergency = "1906";

  // Animal Rescue
  static const String animalRescue = "1962";

  // Poison Information
  static const String poisonHelpline = "1800116117";

  // Blood Bank
  static const String bloodBank = "104";

  /// List used in the Contacts and SOS screens
  static const List<Map<String, String>> emergencyList = [
    {
      "title": "National Emergency",
      "number": emergency,
      "icon": "🚨",
    },
    {
      "title": "Police",
      "number": police,
      "icon": "👮",
    },
    {
      "title": "Fire Service",
      "number": fire,
      "icon": "🚒",
    },
    {
      "title": "Ambulance",
      "number": ambulance,
      "icon": "🚑",
    },
    {
      "title": "Disaster Management",
      "number": disasterManagementNational,
      "icon": "🌪️",
    },
    {
      "title": "Women Helpline",
      "number": womenHelpline,
      "icon": "👩",
    },
    {
      "title": "Child Helpline",
      "number": childHelpline,
      "icon": "👶",
    },
    {
      "title": "Cyber Crime",
      "number": cyberCrime,
      "icon": "💻",
    },
    {
      "title": "Railway Helpline",
      "number": railwayHelpline,
      "icon": "🚆",
    },
    {
      "title": "Highway Emergency",
      "number": highwayEmergency,
      "icon": "🛣️",
    },
    {
      "title": "Gas Leakage",
      "number": gasEmergency,
      "icon": "🔥",
    },
    {
      "title": "Poison Helpline",
      "number": poisonHelpline,
      "icon": "☠️",
    },
  ];
}