import '../models/first_aid_model.dart';

class InjuryData {
  static const List<FirstAidModel> data = [
    FirstAidModel(
      id: "FA006",
      title: "Severe Bleeding",
      description:
          "Heavy bleeding can quickly become life-threatening if not controlled.",
      steps: [
        "Wear gloves if available.",
        "Apply firm pressure using a clean cloth or bandage.",
        "Keep pressure on the wound.",
        "Raise the injured limb if there is no fracture.",
        "Call emergency services immediately.",
      ],
      warning:
          "Do not remove objects stuck inside the wound. Apply pressure around them.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/severe_bleeding.png",
    ),

    FirstAidModel(
      id: "FA007",
      title: "Minor Cuts & Wounds",
      description:
          "Small cuts should be cleaned properly to prevent infection.",
      steps: [
        "Wash your hands.",
        "Clean the wound with clean water.",
        "Apply antiseptic solution.",
        "Cover with a sterile bandage.",
        "Replace the dressing daily.",
      ],
      warning:
          "Seek medical help if bleeding continues or signs of infection appear.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/cuts.png",
    ),

    FirstAidModel(
      id: "FA008",
      title: "Bone Fracture",
      description:
          "A fracture is a broken bone caused by trauma or injury.",
      steps: [
        "Keep the injured area still.",
        "Support the limb with a splint if trained.",
        "Apply an ice pack wrapped in cloth.",
        "Avoid moving the person unnecessarily.",
        "Seek emergency medical care.",
      ],
      warning:
          "Never attempt to straighten a broken bone.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/fracture.png",
    ),

    FirstAidModel(
      id: "FA009",
      title: "Head Injury",
      description:
          "Head injuries can range from mild to life-threatening.",
      steps: [
        "Keep the person still.",
        "Apply a cold pack for minor swelling.",
        "Watch for vomiting or unconsciousness.",
        "Call emergency services if symptoms worsen.",
      ],
      warning:
          "Do not move the person if a neck or spine injury is suspected.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/head_injury.png",
    ),

    FirstAidModel(
      id: "FA010",
      title: "Dislocated Joint",
      description:
          "A joint is forced out of its normal position.",
      steps: [
        "Immobilize the injured joint.",
        "Apply an ice pack.",
        "Support with a sling if needed.",
        "Seek immediate medical attention.",
      ],
      warning:
          "Never try to push the joint back into place yourself.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/dislocation.png",
    ),

    FirstAidModel(
      id: "FA011",
      title: "Sprain",
      description:
          "A sprain is an injury to ligaments around a joint.",
      steps: [
        "Rest the injured area.",
        "Apply ice for 20 minutes.",
        "Use a compression bandage.",
        "Keep the limb elevated.",
      ],
      warning:
          "If severe pain or inability to move occurs, seek medical care.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/sprain.png",
    ),

    FirstAidModel(
      id: "FA012",
      title: "Eye Injury",
      description:
          "Eye injuries require careful handling to prevent permanent damage.",
      steps: [
        "Do not rub the eye.",
        "Flush with clean water if a chemical enters the eye.",
        "Cover the eye with a clean dressing.",
        "Visit a hospital immediately.",
      ],
      warning:
          "Never remove objects embedded in the eye.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/eye_injury.png",
    ),
  ];
}