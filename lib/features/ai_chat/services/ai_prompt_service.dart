enum EmergencyType {
  earthquake,
  flood,
  fire,
  cyclone,
  tsunami,
  heatwave,
  landslide,
  lightning,
  thunderstorm,
  volcanicEruption,
  chemicalLeak,
  pandemic,
  coldWave,
  snowstorm,
  tornado,
  roadAccident,
  none,
}

enum FirstAidType {
  cardiacCPR,
  injury,
  burn,
  poisoning,
  drowning,
  childCare,
  choking,
  none,
}

enum SafePlaceType {
  hospital,
  shelter,
  police,
  fireStation,
  reliefCenter,
  none,
}

class DetectedIntent {
  final EmergencyType emergencyType;
  final FirstAidType firstAidType;
  final SafePlaceType safePlaceType;

  DetectedIntent({
    this.emergencyType = EmergencyType.none,
    this.firstAidType = FirstAidType.none,
    this.safePlaceType = SafePlaceType.none,
  });

  bool get isEmergency => emergencyType != EmergencyType.none;
  bool get isFirstAid => firstAidType != FirstAidType.none;
  bool get isSafePlace => safePlaceType != SafePlaceType.none;
  bool get hasAnyIntent => isEmergency || isFirstAid || isSafePlace;
}

class AIPromptService {
  AIPromptService._();

  static final AIPromptService instance = AIPromptService._();

  /// Analyze user input to determine the emergency type, first aid type, or safe place type.
  DetectedIntent detectIntent(String query) {
    final text = query.toLowerCase();

    // 1. Detect Safe Place Intent
    SafePlaceType safePlaceType = SafePlaceType.none;
    if (_matches(text, [
      'hospital',
      'medical',
      'doctor',
      'clinic',
      'first aid room',
      'treatment center',
    ])) {
      safePlaceType = SafePlaceType.hospital;
    } else if (_matches(text, [
      'shelter',
      'refuge',
      'stay safe',
      'evacuate to',
      'temporary stay',
      'camp ground',
    ])) {
      safePlaceType = SafePlaceType.shelter;
    } else if (_matches(text, [
      'police',
      'cop',
      'security',
      'law enforcement',
      'station house',
    ])) {
      safePlaceType = SafePlaceType.police;
    } else if (_matches(text, [
      'fire station',
      'firefighter',
      'fire department',
      'fire engine',
      'fire truck',
    ])) {
      safePlaceType = SafePlaceType.fireStation;
    } else if (_matches(text, [
      'relief',
      'ration',
      'distribution center',
      'food supply',
      'aid center',
    ])) {
      safePlaceType = SafePlaceType.reliefCenter;
    }

    // 2. Detect First Aid Intent
    FirstAidType firstAidType = FirstAidType.none;
    if (_matches(text, [
      'cpr',
      'cardiac',
      'heart attack',
      'chest pain',
      'cardiopulmonary',
    ])) {
      firstAidType = FirstAidType.cardiacCPR;
    } else if (_matches(text, [
      'burn',
      'scalding',
      'fire burn',
      'chemical burn',
    ])) {
      firstAidType = FirstAidType.burn;
    } else if (_matches(text, [
      'poison',
      'toxic',
      'swallowed',
      'chemical ingestion',
    ])) {
      firstAidType = FirstAidType.poisoning;
    } else if (_matches(text, [
      'drown',
      'water rescue',
      'drowned',
      'submerged',
    ])) {
      firstAidType = FirstAidType.drowning;
    } else if (_matches(text, ['child', 'baby', 'infant', 'pediatric'])) {
      firstAidType = FirstAidType.childCare;
    } else if (_matches(text, [
      'chok',
      'blocked airway',
      'heimlich',
      'swallowed object',
    ])) {
      firstAidType = FirstAidType.choking;
    } else if (_matches(text, [
      'injury',
      'bleeding',
      'cut',
      'wound',
      'fracture',
      'broken bone',
      'snake bite',
      'electric shock',
      'sprain',
      'bandage',
    ])) {
      firstAidType = FirstAidType.injury;
    }

    // 3. Detect Emergency Type Intent
    EmergencyType emergencyType = EmergencyType.none;
    if (_matches(text, [
      'earthquake',
      'quake',
      'shaking',
      'tremor',
      'aftershock',
    ])) {
      emergencyType = EmergencyType.earthquake;
    } else if (_matches(text, [
      'flood',
      'inundation',
      'water rise',
      'overflowing',
    ])) {
      emergencyType = EmergencyType.flood;
    } else if (_matches(text, ['fire', 'flame', 'blaze', 'conflagration']) &&
        firstAidType != FirstAidType.burn) {
      emergencyType = EmergencyType.fire;
    } else if (_matches(text, ['cyclone', 'hurricane', 'typhoon', 'gale'])) {
      emergencyType = EmergencyType.cyclone;
    } else if (_matches(text, ['tsunami', 'tidal wave', 'harbor wave'])) {
      emergencyType = EmergencyType.tsunami;
    } else if (_matches(text, [
      'heatwave',
      'extreme heat',
      'sunstroke',
      'hot weather',
    ])) {
      emergencyType = EmergencyType.heatwave;
    } else if (_matches(text, [
      'landslide',
      'mudslide',
      'rockfall',
      'avalanche',
    ])) {
      emergencyType = EmergencyType.landslide;
    } else if (_matches(text, ['lightning', 'thunderbolt'])) {
      emergencyType = EmergencyType.lightning;
    } else if (_matches(text, ['thunderstorm', 'thunder', 'storm', 'hail'])) {
      emergencyType = EmergencyType.thunderstorm;
    } else if (_matches(text, ['volcan', 'eruption', 'lava', 'ashfall'])) {
      emergencyType = EmergencyType.volcanicEruption;
    } else if (_matches(text, [
      'chemical',
      'gas leak',
      'leakage',
      'toxic leak',
    ])) {
      emergencyType = EmergencyType.chemicalLeak;
    } else if (_matches(text, [
      'pandemic',
      'outbreak',
      'virus',
      'quarantine',
      'epidemic',
    ])) {
      emergencyType = EmergencyType.pandemic;
    } else if (_matches(text, [
      'cold wave',
      'extreme cold',
      'frost',
      'freeze',
    ])) {
      emergencyType = EmergencyType.coldWave;
    } else if (_matches(text, [
      'blizzard',
      'snowstorm',
      'heavy snow',
      'snow drift',
    ])) {
      emergencyType = EmergencyType.snowstorm;
    } else if (_matches(text, ['tornado', 'twister', 'funnel cloud'])) {
      emergencyType = EmergencyType.tornado;
    } else if (_matches(text, [
      'accident',
      'car crash',
      'road accident',
      'collision',
      'vehicular',
    ])) {
      emergencyType = EmergencyType.roadAccident;
    }

    return DetectedIntent(
      emergencyType: emergencyType,
      firstAidType: firstAidType,
      safePlaceType: safePlaceType,
    );
  }

  bool _matches(String text, List<String> keywords) {
    for (final kw in keywords) {
      if (text.contains(kw)) {
        return true;
      }
    }
    return false;
  }
}
