import '../models/first_aid_model.dart';

class CardiacData {
  static const List<FirstAidModel> data = [

    FirstAidModel(
      id: "FA001",
      title: "Heart Attack",
      description:
          "A heart attack occurs when blood flow to part of the heart is blocked.",
      steps: [
        "Call emergency services (108/112) immediately.",
        "Keep the person calm and seated.",
        "Loosen any tight clothing.",
        "If prescribed, help them take their heart medication.",
        "Monitor breathing until help arrives."
      ],
      warning:
          "Never ignore chest pain. Immediate medical care can save a life.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/heart_attack.png",
    ),

    FirstAidModel(
      id: "FA002",
      title: "Cardiac Arrest",
      description:
          "The heart suddenly stops beating, causing loss of consciousness.",
      steps: [
        "Call emergency services immediately.",
        "Check if the person is breathing.",
        "Start CPR immediately.",
        "Use an AED if available.",
        "Continue CPR until medical help arrives."
      ],
      warning:
          "Every second matters. Begin CPR as soon as possible.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/cardiac_arrest.png",
    ),

    FirstAidModel(
      id: "FA003",
      title: "Adult CPR",
      description:
          "CPR helps maintain blood circulation until emergency help arrives.",
      steps: [
        "Place the person on a firm surface.",
        "Place both hands at the center of the chest.",
        "Push hard and fast (100–120 compressions per minute).",
        "Allow the chest to fully recoil.",
        "Continue until emergency responders arrive."
      ],
      warning:
          "Incorrect CPR technique may reduce effectiveness.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/adult_cpr.png",
    ),

    FirstAidModel(
      id: "FA004",
      title: "Stroke",
      description:
          "A stroke occurs when blood flow to the brain is interrupted.",
      steps: [
        "Remember the FAST test (Face, Arm, Speech, Time).",
        "Call emergency services immediately.",
        "Keep the person comfortable.",
        "Do not give food or water.",
        "Monitor breathing until help arrives."
      ],
      warning:
          "Stroke treatment is most effective within the first few hours.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/stroke.png",
    ),

    FirstAidModel(
      id: "FA005",
      title: "Choking (Adult)",
      description:
          "Occurs when an object blocks the airway.",
      steps: [
        "Ask if the person can speak or cough.",
        "Give five firm back blows.",
        "Perform five abdominal thrusts if needed.",
        "Repeat until the object is removed.",
        "Call emergency services if unsuccessful."
      ],
      warning:
          "Do not perform abdominal thrusts on infants.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/choking.png",
    ),

  ];
}