import '../models/user_intent.dart';

/// Service that detects user intent from natural language prompts.
/// Uses keyword matching to classify queries into safe place, first aid,
/// or emergency categories.
class AIPromptService {
  AIPromptService._();
  static final AIPromptService instance = AIPromptService._();

  /// Detects the user's intent from the given [query] string.
  UserIntent detectIntent(String query) {
    final lowerQuery = query.toLowerCase().trim();

    // Check for safe place intents
    final safePlaceResult = _detectSafePlaceIntent(lowerQuery);
    if (safePlaceResult != null) return safePlaceResult;

    // Check for first aid intents
    final firstAidResult = _detectFirstAidIntent(lowerQuery);
    if (firstAidResult != null) return firstAidResult;

    // Check for emergency/disaster intents
    final emergencyResult = _detectEmergencyIntent(lowerQuery);
    if (emergencyResult != null) return emergencyResult;

    // General chat fallback
    return UserIntent(
      rawQuery: query,
      isGeneralChat: true,
    );
  }

  UserIntent? _detectSafePlaceIntent(String query) {
    // Hospital detection
    if (_containsAny(query, [
      'hospital', 'clinic', 'medical center', 'doctor', 'emergency room',
      'er', 'healthcare', 'medic', 'treatment center',
    ])) {
      return UserIntent(
        rawQuery: query,
        safePlaceType: SafePlaceType.hospital,
        isSafePlace: true,
      );
    }

    // Shelter detection
    if (_containsAny(query, [
      'shelter', 'storm shelter', 'evacuation center', 'safe house',
      'refuge', 'emergency shelter', 'relief camp', 'camp',
    ])) {
      return UserIntent(
        rawQuery: query,
        safePlaceType: SafePlaceType.shelter,
        isSafePlace: true,
      );
    }

    // Police station detection
    if (_containsAny(query, [
      'police', 'police station', 'police department', 'sheriff',
      'law enforcement', 'cop',
    ])) {
      return UserIntent(
        rawQuery: query,
        safePlaceType: SafePlaceType.policeStation,
        isSafePlace: true,
      );
    }

    // Fire station detection
    if (_containsAny(query, [
      'fire station', 'fire department', 'firefighter', 'fire brigade',
      'fire house',
    ])) {
      return UserIntent(
        rawQuery: query,
        safePlaceType: SafePlaceType.fireStation,
        isSafePlace: true,
      );
    }

    // Pharmacy detection
    if (_containsAny(query, [
      'pharmacy', 'drug store', 'chemist', 'medicine store',
      'medical store', 'apothecary',
    ])) {
      return UserIntent(
        rawQuery: query,
        safePlaceType: SafePlaceType.pharmacy,
        isSafePlace: true,
      );
    }

    // Generic safe place detection
    if (_containsAny(query, [
      'safe place', 'safe area', 'nearby', 'find place', 'where can i go',
      'emergency location', 'help near me', 'nearest',
    ])) {
      return UserIntent(
        rawQuery: query,
        safePlaceType: SafePlaceType.unknown,
        isSafePlace: true,
      );
    }

    return null;
  }

  UserIntent? _detectFirstAidIntent(String query) {
    // CPR / Cardiac
    if (_containsAny(query, [
      'cpr', 'cardiac', 'heart attack', 'cardiopulmonary', 'resuscitation',
      'chest compression', 'heart stopped',
    ])) {
      return UserIntent(
        rawQuery: query,
        firstAidType: FirstAidType.cardiacCPR,
        isFirstAid: true,
      );
    }

    // Burn
    if (_containsAny(query, [
      'burn', 'burned', 'scald', 'scalding', 'fire injury',
      'minor burn', 'chemical burn',
    ])) {
      return UserIntent(
        rawQuery: query,
        firstAidType: FirstAidType.burn,
        isFirstAid: true,
      );
    }

    // Bleeding
    if (_containsAny(query, [
      'bleeding', 'wound', 'cut', 'hemorrhage', 'blood', 'injury',
      'gash', 'laceration',
    ])) {
      return UserIntent(
        rawQuery: query,
        firstAidType: FirstAidType.bleeding,
        isFirstAid: true,
      );
    }

    // Fracture
    if (_containsAny(query, [
      'fracture', 'broken bone', 'bone', 'sprain', 'dislocation',
      'fractured', 'cracked bone',
    ])) {
      return UserIntent(
        rawQuery: query,
        firstAidType: FirstAidType.fracture,
        isFirstAid: true,
      );
    }

    // Choking
    if (_containsAny(query, [
      'choking', 'choke', 'heimlich', 'can\'t breathe',
      'blocked airway', 'airway obstruction',
    ])) {
      return UserIntent(
        rawQuery: query,
        firstAidType: FirstAidType.choking,
        isFirstAid: true,
      );
    }

    // Poisoning
    if (_containsAny(query, [
      'poisoning', 'poison', 'overdose', 'toxic', 'ingested poison',
      'poison control', 'swallowed poison',
    ])) {
      return UserIntent(
        rawQuery: query,
        firstAidType: FirstAidType.poisoning,
        isFirstAid: true,
      );
    }

    // Drowning
    if (_containsAny(query, [
      'drowning', 'drown', 'near drowning', 'water rescue',
      'underwater', 'submerged',
    ])) {
      return UserIntent(
        rawQuery: query,
        firstAidType: FirstAidType.drowning,
        isFirstAid: true,
      );
    }

    // Shock
    if (_containsAny(query, [
      'shock', 'anaphylactic', 'anaphylaxis',
      'severe allergic reaction', 'going into shock',
    ])) {
      return UserIntent(
        rawQuery: query,
        firstAidType: FirstAidType.shock,
        isFirstAid: true,
      );
    }

    // Seizure
    if (_containsAny(query, [
      'seizure', 'convulsion', 'fitting', 'epileptic', 'epilepsy',
    ])) {
      return UserIntent(
        rawQuery: query,
        firstAidType: FirstAidType.seizure,
        isFirstAid: true,
      );
    }

    return null;
  }

  UserIntent? _detectEmergencyIntent(String query) {
    // Earthquake
    if (_containsAny(query, [
      'earthquake', 'quake', 'seismic', 'tremor', 'temblor',
      'ground shaking', 'seismic activity',
    ])) {
      return UserIntent(
        rawQuery: query,
        emergencyType: EmergencyType.earthquake,
        isEmergency: true,
      );
    }

    // Flood
    if (_containsAny(query, [
      'flood', 'flooding', 'flash flood', 'flooded', 'rising water',
      'overflow', 'inundation',
    ])) {
      return UserIntent(
        rawQuery: query,
        emergencyType: EmergencyType.flood,
        isEmergency: true,
      );
    }

    // Hurricane / Cyclone
    if (_containsAny(query, [
      'hurricane', 'cyclone', 'typhoon', 'tropical storm',
    ])) {
      return UserIntent(
        rawQuery: query,
        emergencyType: EmergencyType.hurricane,
        isEmergency: true,
      );
    }

    // Tornado
    if (_containsAny(query, [
      'tornado', 'twister', 'funnel cloud', 'cyclone',
    ])) {
      return UserIntent(
        rawQuery: query,
        emergencyType: EmergencyType.tornado,
        isEmergency: true,
      );
    }

    // Tsunami
    if (_containsAny(query, [
      'tsunami', 'tidal wave', 'seismic wave',
    ])) {
      return UserIntent(
        rawQuery: query,
        emergencyType: EmergencyType.tsunami,
        isEmergency: true,
      );
    }

    // Wildfire
    if (_containsAny(query, [
      'wildfire', 'forest fire', 'bushfire', 'wild fire',
      'brush fire', 'inferno',
    ])) {
      return UserIntent(
        rawQuery: query,
        emergencyType: EmergencyType.wildfire,
        isEmergency: true,
      );
    }

    // Landslide
    if (_containsAny(query, [
      'landslide', 'mudslide', 'rockslide', 'land slip',
    ])) {
      return UserIntent(
        rawQuery: query,
        emergencyType: EmergencyType.landslide,
        isEmergency: true,
      );
    }

    // Blizzard / Snowstorm
    if (_containsAny(query, [
      'blizzard', 'snowstorm', 'heavy snow', 'ice storm',
      'snow emergency', 'winter storm',
    ])) {
      return UserIntent(
        rawQuery: query,
        emergencyType: EmergencyType.blizzard,
        isEmergency: true,
      );
    }

    // Heatwave
    if (_containsAny(query, [
      'heatwave', 'heat wave', 'extreme heat', 'heat stroke',
      'high temperature',
    ])) {
      return UserIntent(
        rawQuery: query,
        emergencyType: EmergencyType.heatwave,
        isEmergency: true,
      );
    }

    // Pandemic
    if (_containsAny(query, [
      'pandemic', 'epidemic', 'outbreak', 'virus', 'quarantine',
      'infection spread', 'disease outbreak',
    ])) {
      return UserIntent(
        rawQuery: query,
        emergencyType: EmergencyType.pandemic,
        isEmergency: true,
      );
    }

    return null;
  }

  bool _containsAny(String query, List<String> keywords) {
    return keywords.any((keyword) => RegExp(r'\b' + RegExp.escape(keyword) + r'\b').hasMatch(query));
  }
}
