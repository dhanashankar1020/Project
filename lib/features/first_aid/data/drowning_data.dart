import '../models/first_aid_model.dart';

class DrowningData {
  static const List<FirstAidModel> data = [
    FirstAidModel(
      id: "FA027",
      title: "Drowning",
      description:
          "Drowning occurs when breathing is impaired due to submersion in water.",
      steps: [
        "Ensure the area is safe before attempting a rescue.",
        "Call emergency services immediately.",
        "Remove the person from the water if it is safe.",
        "Check for breathing and pulse.",
        "Begin CPR if the person is not breathing.",
        "Keep the person warm until help arrives."
      ],
      warning:
          "Do not put yourself in danger while attempting a rescue.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/drowning.png",
    ),

    FirstAidModel(
      id: "FA028",
      title: "Near Drowning",
      description:
          "A person rescued from water may still develop serious breathing problems.",
      steps: [
        "Call emergency services.",
        "Keep the person lying down.",
        "Monitor breathing continuously.",
        "Provide CPR if breathing stops.",
        "Seek hospital care even if the person appears well."
      ],
      warning:
          "Complications can occur several hours after the incident.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/near_drowning.png",
    ),

    FirstAidModel(
      id: "FA029",
      title: "Breathing Difficulty",
      description:
          "Difficulty breathing can result from illness, injury, or airway blockage.",
      steps: [
        "Help the person sit upright.",
        "Loosen tight clothing.",
        "Keep them calm.",
        "Call emergency services if breathing worsens.",
      ],
      warning:
          "Blue lips or unconsciousness require immediate emergency care.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/breathing_difficulty.png",
    ),

    FirstAidModel(
      id: "FA030",
      title: "Asthma Attack",
      description:
          "An asthma attack causes narrowing of the airways, making breathing difficult.",
      steps: [
        "Help the person sit comfortably.",
        "Assist them in using their prescribed inhaler.",
        "Encourage slow, steady breathing.",
        "Call emergency services if symptoms do not improve."
      ],
      warning:
          "Do not delay seeking help if the inhaler is ineffective.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/asthma_attack.png",
    ),

    FirstAidModel(
      id: "FA031",
      title: "Smoke Inhalation",
      description:
          "Breathing smoke can damage the lungs and reduce oxygen supply.",
      steps: [
        "Move the person to fresh air immediately.",
        "Loosen tight clothing.",
        "Monitor breathing.",
        "Call emergency services.",
      ],
      warning:
          "Even if symptoms appear mild, smoke inhalation can become serious.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/smoke_inhalation.png",
    ),

    FirstAidModel(
      id: "FA032",
      title: "Suffocation",
      description:
          "Suffocation occurs when the body does not receive enough oxygen.",
      steps: [
        "Remove the cause of suffocation if it is safe.",
        "Call emergency services.",
        "Check breathing.",
        "Begin CPR if necessary.",
      ],
      warning:
          "Loss of oxygen can quickly become life-threatening.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/suffocation.png",
    ),
  ];
}