import '../models/first_aid_model.dart';

class PoisoningData {
  static const List<FirstAidModel> data = [

    FirstAidModel(
      id: "FA020",
      title: "Food Poisoning",
      description:
          "Food poisoning is caused by eating contaminated food or drinking contaminated water.",
      steps: [
        "Drink plenty of clean fluids to stay hydrated.",
        "Rest and avoid heavy meals.",
        "Eat light foods such as rice or bananas.",
        "Seek medical attention if symptoms are severe."
      ],
      warning:
          "Seek immediate medical care if there is blood in vomit, severe dehydration, or persistent vomiting.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/food_poisoning.png",
    ),

    FirstAidModel(
      id: "FA021",
      title: "Chemical Poisoning",
      description:
          "Chemical poisoning can occur by swallowing, breathing, or skin contact with hazardous substances.",
      steps: [
        "Move away from the chemical source.",
        "Remove contaminated clothing.",
        "Wash affected skin with clean water.",
        "Call Poison Control or emergency services immediately."
      ],
      warning:
          "Do not induce vomiting unless instructed by medical professionals.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/chemical_poisoning.png",
    ),

    FirstAidModel(
      id: "FA022",
      title: "Medicine Overdose",
      description:
          "Taking too much medicine can seriously affect breathing, heart rate, and consciousness.",
      steps: [
        "Call emergency services immediately.",
        "Keep the medicine container with you.",
        "Monitor breathing and consciousness.",
        "Place the person in the recovery position if unconscious but breathing."
      ],
      warning:
          "Never force the person to vomit unless instructed by a healthcare professional.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/medicine_overdose.png",
    ),

    FirstAidModel(
      id: "FA023",
      title: "Snake Bite",
      description:
          "Snake bites can be life-threatening depending on the species.",
      steps: [
        "Keep the victim calm.",
        "Keep the bitten limb below heart level.",
        "Remove rings or tight clothing.",
        "Take the person to the nearest hospital immediately."
      ],
      warning:
          "Do not cut the wound, suck out venom, or apply a tourniquet.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/snake_bite.png",
    ),

    FirstAidModel(
      id: "FA024",
      title: "Spider Bite",
      description:
          "Most spider bites are harmless, but some require urgent medical attention.",
      steps: [
        "Wash the bite with soap and water.",
        "Apply a cold pack wrapped in cloth.",
        "Keep the affected area elevated if possible.",
        "Seek medical attention if symptoms worsen."
      ],
      warning:
          "Seek emergency care if breathing difficulty or severe swelling develops.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/spider_bite.png",
    ),

    FirstAidModel(
      id: "FA025",
      title: "Bee or Wasp Sting",
      description:
          "Bee and wasp stings may cause pain, swelling, or severe allergic reactions.",
      steps: [
        "Remove the stinger carefully if visible.",
        "Wash the area with soap and water.",
        "Apply a cold pack.",
        "Observe for signs of an allergic reaction."
      ],
      warning:
          "Call emergency services immediately if the person has difficulty breathing or facial swelling.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/bee_sting.png",
    ),

    FirstAidModel(
      id: "FA026",
      title: "Animal Bite",
      description:
          "Animal bites can cause serious infections including rabies.",
      steps: [
        "Wash the wound with soap and running water for at least 10 minutes.",
        "Control bleeding with a clean cloth.",
        "Cover with a sterile dressing.",
        "Visit a hospital immediately for evaluation."
      ],
      warning:
          "Rabies can be fatal if untreated. Never ignore an animal bite.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/animal_bite.png",
    ),

  ];
}