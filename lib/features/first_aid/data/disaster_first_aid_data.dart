import '../models/first_aid_model.dart';

class DisasterFirstAidData {
  static const List<FirstAidModel> data = [
    FirstAidModel(
      id: "FA041",
      title: "Earthquake Injury",
      description:
          "Injuries caused by falling objects, collapsed buildings, or ground shaking.",
      steps: [
        "Move to a safe open area if possible.",
        "Check yourself and others for injuries.",
        "Control bleeding using clean cloths.",
        "Do not move seriously injured people unless necessary.",
        "Call emergency services.",
      ],
      warning:
          "Watch for aftershocks and avoid damaged buildings.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/earthquake.png",
    ),

    FirstAidModel(
      id: "FA042",
      title: "Flood Rescue",
      description:
          "Flood water can contain dangerous debris, electricity, and contaminated water.",
      steps: [
        "Move to higher ground immediately.",
        "Avoid walking or driving through floodwater.",
        "Turn off electricity if it is safe.",
        "Drink only clean or bottled water.",
      ],
      warning:
          "Floodwater may hide deep holes and live electrical wires.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/flood.png",
    ),

    FirstAidModel(
      id: "FA043",
      title: "Fire Evacuation",
      description:
          "Quick evacuation reduces the risk of burns and smoke inhalation.",
      steps: [
        "Stay low to avoid smoke.",
        "Use stairs instead of elevators.",
        "Close doors behind you if possible.",
        "Move to the designated safe assembly point.",
      ],
      warning:
          "Never re-enter a burning building.",
      emergencyNumber: "101",
      image: "assets/images/first_aid/fire.png",
    ),

    FirstAidModel(
      id: "FA044",
      title: "Cyclone Safety",
      description:
          "Cyclones bring powerful winds, heavy rain, and flying debris.",
      steps: [
        "Stay indoors in a strong building.",
        "Keep away from windows.",
        "Store drinking water and emergency supplies.",
        "Follow official evacuation orders.",
      ],
      warning:
          "Do not go outside until authorities declare it safe.",
      emergencyNumber: "1070",
      image: "assets/images/first_aid/cyclone.png",
    ),

    FirstAidModel(
      id: "FA045",
      title: "Lightning Strike",
      description:
          "Lightning can cause cardiac arrest, burns, and serious injuries.",
      steps: [
        "Call emergency services immediately.",
        "Move the person to a safe place.",
        "Check breathing and pulse.",
        "Start CPR if needed.",
      ],
      warning:
          "Lightning victims do not carry an electrical charge and are safe to touch.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/lightning.png",
    ),

    FirstAidModel(
      id: "FA046",
      title: "Building Collapse",
      description:
          "Collapsed structures can cause crush injuries and fractures.",
      steps: [
        "Call emergency services.",
        "Do not move trapped victims unless necessary.",
        "Control severe bleeding.",
        "Keep the victim calm until rescuers arrive.",
      ],
      warning:
          "Watch for additional structural collapse.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/building_collapse.png",
    ),

    FirstAidModel(
      id: "FA047",
      title: "Landslide",
      description:
          "Landslides can trap people under mud, rocks, and debris.",
      steps: [
        "Move away from the landslide area.",
        "Help injured people if it is safe.",
        "Watch for additional slides.",
        "Call emergency services.",
      ],
      warning:
          "Do not enter unstable areas after a landslide.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/landslide.png",
    ),

    FirstAidModel(
      id: "FA048",
      title: "Tsunami",
      description:
          "A tsunami consists of powerful sea waves caused by underwater disturbances.",
      steps: [
        "Move immediately to higher ground.",
        "Stay away from beaches and rivers.",
        "Follow evacuation routes.",
        "Return only after official permission.",
      ],
      warning:
          "Multiple tsunami waves may occur. The first wave is not always the largest.",
      emergencyNumber: "1070",
      image: "assets/images/first_aid/tsunami.png",
    ),
  ];
}