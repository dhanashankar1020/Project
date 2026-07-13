import '../models/first_aid_model.dart';

class BurnData {
  static const List<FirstAidModel> data = [
    FirstAidModel(
      id: "FA013",
      title: "Minor Burns",
      description:
          "A minor burn affects only the outer layer of the skin and usually causes redness and pain.",
      steps: [
        "Cool the burn under running cool water for at least 20 minutes.",
        "Remove rings or tight clothing before swelling starts.",
        "Cover with a sterile non-stick dressing.",
        "Keep the area clean and dry.",
      ],
      warning:
          "Do not apply ice, butter, toothpaste, or oil to the burn.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/minor_burn.png",
    ),

    FirstAidModel(
      id: "FA014",
      title: "Major Burns",
      description:
          "Major burns affect deep layers of the skin and require immediate medical attention.",
      steps: [
        "Call emergency services immediately.",
        "Do not remove burnt clothing stuck to the skin.",
        "Cover the burn with a clean sterile cloth.",
        "Monitor breathing until medical help arrives.",
      ],
      warning:
          "Never burst burn blisters or apply home remedies.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/major_burn.png",
    ),

    FirstAidModel(
      id: "FA015",
      title: "Electrical Burns",
      description:
          "Electrical burns can cause serious internal injuries even if the skin damage appears minor.",
      steps: [
        "Turn off the power source before touching the person.",
        "Call emergency services immediately.",
        "Check for breathing and pulse.",
        "Start CPR if required and trained.",
      ],
      warning:
          "Never touch the victim until the electricity source is disconnected.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/electrical_burn.png",
    ),

    FirstAidModel(
      id: "FA016",
      title: "Heat Stroke",
      description:
          "Heat stroke is a life-threatening condition caused by the body overheating.",
      steps: [
        "Move the person to a cool place.",
        "Remove excess clothing.",
        "Cool the body using wet towels or cool water.",
        "Call emergency services immediately.",
      ],
      warning:
          "Do not delay medical treatment for heat stroke.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/heat_stroke.png",
    ),

    FirstAidModel(
      id: "FA017",
      title: "Heat Exhaustion",
      description:
          "Heat exhaustion occurs after prolonged exposure to high temperatures.",
      steps: [
        "Move to a shaded or cool area.",
        "Drink cool water slowly.",
        "Loosen tight clothing.",
        "Rest until symptoms improve.",
      ],
      warning:
          "If symptoms worsen or last longer than an hour, seek medical care.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/heat_exhaustion.png",
    ),

    FirstAidModel(
      id: "FA018",
      title: "Hypothermia",
      description:
          "Hypothermia occurs when body temperature drops dangerously low.",
      steps: [
        "Move the person to a warm, dry place.",
        "Remove wet clothing.",
        "Cover with blankets.",
        "Give warm drinks if the person is fully conscious.",
      ],
      warning:
          "Do not use direct heat like hot water or heating pads.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/hypothermia.png",
    ),

    FirstAidModel(
      id: "FA019",
      title: "Frostbite",
      description:
          "Frostbite is damage to skin and tissues caused by freezing temperatures.",
      steps: [
        "Move to a warm place.",
        "Warm the affected area gradually using warm water.",
        "Protect the area with sterile dressings.",
        "Seek medical attention.",
      ],
      warning:
          "Do not rub the affected area or use direct heat.",
      emergencyNumber: "108",
      image: "assets/images/first_aid/frostbite.png",
    ),
  ];
}