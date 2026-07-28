/// Types of safe places that can be detected from user queries
enum SafePlaceType {
  hospital,
  shelter,
  policeStation,
  fireStation,
  pharmacy,
  reliefCamp,
  unknown,
}

/// Types of first aid queries
enum FirstAidType {
  cardiacCPR,
  burn,
  bleeding,
  fracture,
  choking,
  poisoning,
  drowning,
  shock,
  heatStroke,
  hypothermia,
  allergicReaction,
  seizure,
  snakeBite,
  insectSting,
  unknown,
}

/// Types of emergency/disaster situations
enum EmergencyType {
  earthquake,
  flood,
  hurricane,
  tornado,
  tsunami,
  wildfire,
  landslide,
  volcanicEruption,
  thunderstorm,
  blizzard,
  heatwave,
  drought,
  pandemic,
  nuclearAccident,
  chemicalSpill,
  terroristAttack,
  unknown,
}

/// Detected intent from a user prompt
class UserIntent {
  final String rawQuery;
  final SafePlaceType safePlaceType;
  final bool isSafePlace;
  final FirstAidType firstAidType;
  final bool isFirstAid;
  final EmergencyType emergencyType;
  final bool isEmergency;
  final bool isGeneralChat;

  const UserIntent({
    this.rawQuery = '',
    this.safePlaceType = SafePlaceType.unknown,
    this.isSafePlace = false,
    this.firstAidType = FirstAidType.unknown,
    this.isFirstAid = false,
    this.emergencyType = EmergencyType.unknown,
    this.isEmergency = false,
    this.isGeneralChat = false,
  });
}

/// Response model for AI interactions
class AIResponse {
  final String text;
  final UserIntent intent;

  const AIResponse({
    required this.text,
    required this.intent,
  });
}
