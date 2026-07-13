import '../models/first_aid_model.dart';

class ChildCareData {
  static const List<FirstAidModel> data = [
    FirstAidModel(
      id: "FA033",
      title: "Infant CPR",
      description:
          "Infant CPR is performed on babies under one year old when they stop breathing or have no pulse.",
      steps: [
        "Check if the infant is responsive.",
        "Call emergency services or ask someone nearby to call.",
        "Place two fingers in the center of the chest.",
        "Give 30 chest compressions.",
        "Provide 2 gentle rescue breaths.",
        "Continue until emergency help arrives.",
      ],
      warning:
          "Use only two fingers for chest compressions. Do not press too hard.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/infant_cpr.png",
    ),

    FirstAidModel(
      id: "FA034",
      title: "Infant Choking",
      description:
          "A blocked airway in an infant can quickly become life-threatening.",
      steps: [
        "Support the infant's head and neck.",
        "Give 5 back blows between the shoulder blades.",
        "Turn the infant over carefully.",
        "Give 5 chest thrusts.",
        "Repeat until the object is removed or help arrives.",
      ],
      warning:
          "Do not perform abdominal thrusts on infants under one year.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/infant_choking.png",
    ),

    FirstAidModel(
      id: "FA035",
      title: "Child Fever",
      description:
          "A fever is a common response to infection but requires monitoring.",
      steps: [
        "Measure the child's temperature.",
        "Keep the child hydrated.",
        "Dress the child in light clothing.",
        "Follow medical advice regarding fever-reducing medicine.",
        "Seek medical care if the fever is very high or persistent.",
      ],
      warning:
          "Seek immediate medical attention if the child has difficulty breathing or becomes unresponsive.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/child_fever.png",
    ),

    FirstAidModel(
      id: "FA036",
      title: "Child Seizure",
      description:
          "A seizure may involve uncontrolled body movements and loss of awareness.",
      steps: [
        "Move dangerous objects away.",
        "Place something soft under the child's head.",
        "Turn the child onto one side after the seizure stops.",
        "Time the seizure.",
        "Call emergency services if it lasts longer than 5 minutes.",
      ],
      warning:
          "Do not hold the child down or place anything in their mouth.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/child_seizure.png",
    ),

    FirstAidModel(
      id: "FA037",
      title: "Dehydration",
      description:
          "Children can become dehydrated quickly due to vomiting, diarrhea, or heat.",
      steps: [
        "Offer small amounts of clean water frequently.",
        "Use oral rehydration solution (ORS) if available.",
        "Avoid sugary or caffeinated drinks.",
        "Seek medical care if symptoms worsen.",
      ],
      warning:
          "Sunken eyes, extreme sleepiness, or inability to drink require urgent medical care.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/dehydration.png",
    ),

    FirstAidModel(
      id: "FA038",
      title: "Vomiting",
      description:
          "Vomiting can lead to dehydration, especially in children.",
      steps: [
        "Allow the child to rest.",
        "Offer small sips of water or ORS.",
        "Avoid solid food until vomiting decreases.",
        "Monitor for signs of dehydration.",
      ],
      warning:
          "Seek medical care if vomiting contains blood or continues for many hours.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/vomiting.png",
    ),

    FirstAidModel(
      id: "FA039",
      title: "Diarrhea",
      description:
          "Diarrhea causes loss of fluids and electrolytes.",
      steps: [
        "Give plenty of fluids.",
        "Use ORS after each loose stool if appropriate.",
        "Continue light meals unless advised otherwise.",
        "Watch for signs of dehydration.",
      ],
      warning:
          "Blood in stool or severe dehydration requires immediate medical attention.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/diarrhea.png",
    ),

    FirstAidModel(
      id: "FA040",
      title: "Ear Bleeding",
      description:
          "Ear bleeding may result from injury, infection, or a ruptured eardrum.",
      steps: [
        "Keep the person still.",
        "Cover the outer ear lightly with sterile gauze.",
        "Do not insert anything into the ear canal.",
        "Seek immediate medical evaluation.",
      ],
      warning:
          "Do not attempt to clean deep inside the ear.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/ear_bleeding.png",
    ),
  ];
}