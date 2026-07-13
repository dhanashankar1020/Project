import '../models/disaster_model.dart';

class DisasterData {
  static const List<DisasterModel> disasters = [
    DisasterModel(
      id: "1",
      title: "Earthquake",
      description:
          "A sudden shaking of the Earth's surface caused by movement of tectonic plates.",
      safetyTips:
          "• Drop, Cover and Hold.\n"
          "• Stay away from windows.\n"
          "• Do not use elevators.\n"
          "• Move to an open area after shaking stops.",
      emergencyNumber: "1070",
      image: "assets/images/earthquake.png",
    ),

    DisasterModel(
      id: "2",
      title: "Flood",
      description:
          "Overflow of water that covers land normally kept dry.",
      safetyTips:
          "• Move to higher ground.\n"
          "• Avoid walking through flood water.\n"
          "• Switch off electricity.\n"
          "• Listen to official alerts.",
      emergencyNumber: "1070",
      image: "assets/images/flood.png",
    ),

    DisasterModel(
      id: "3",
      title: "Fire",
      description:
          "An uncontrolled fire that spreads quickly and causes damage.",
      safetyTips:
          "• Stay low to avoid smoke.\n"
          "• Use stairs instead of elevators.\n"
          "• Call the fire service.\n"
          "• Leave the building immediately.",
      emergencyNumber: "101",
      image: "assets/images/fire.png",
    ),

    DisasterModel(
      id: "4",
      title: "Cyclone",
      description:
          "A powerful storm with strong winds and heavy rainfall.",
      safetyTips:
          "• Stay indoors.\n"
          "• Keep emergency supplies ready.\n"
          "• Avoid coastal areas.\n"
          "• Follow government instructions.",
      emergencyNumber: "1070",
      image: "assets/images/cyclone.png",
    ),

    DisasterModel(
      id: "5",
      title: "Tsunami",
      description:
          "Large ocean waves usually caused by underwater earthquakes.",
      safetyTips:
          "• Move immediately to higher ground.\n"
          "• Stay away from beaches.\n"
          "• Listen for official warnings.\n"
          "• Do not return until declared safe.",
      emergencyNumber: "1070",
      image: "assets/images/tsunami.png",
    ),

    DisasterModel(
      id: "6",
      title: "Heatwave",
      description:
          "A prolonged period of extremely hot weather.",
      safetyTips:
          "• Drink plenty of water.\n"
          "• Stay indoors during peak heat.\n"
          "• Wear light clothing.\n"
          "• Check on elderly people.",
      emergencyNumber: "108",
      image: "assets/images/heatwave.png",
    ),
  ];
}