import '../../disaster_guide/services/disaster_service.dart';
import '../../first_aid/services/first_aid_service.dart';
import '../../safe_places/models/safe_place_model.dart';
import '../../safe_places/services/safe_places_service.dart';
import 'ai_prompt_service.dart';

class OfflineAIResponse {
  final String text;
  final List<SafePlaceModel>? recommendedPlaces;

  OfflineAIResponse({required this.text, this.recommendedPlaces});
}

class OfflineAIService {
  OfflineAIService._();

  static final OfflineAIService instance = OfflineAIService._();

  /// Generate an offline response based on detected user intent.
  OfflineAIResponse generateResponse(String query, DetectedIntent intent) {
    // 1. Handle Safe Place Intent
    if (intent.isSafePlace) {
      final category = _getCategoryString(intent.safePlaceType);
      final places = SafePlacesService.instance.getPlacesByCategory(category);

      String replyText =
          "📍 **Offline Safe Places: $category**\n\n"
          "I have found ${places.length} matching safe places in our offline database for **$category**.\n\n"
          "You can view their details and navigate to them directly using the cards below.";

      if (places.isEmpty) {
        replyText =
            "📍 **Offline Safe Places: $category**\n\n"
            "Sorry, I couldn't find any safe places categorized as **$category** in the offline database.";
      }

      return OfflineAIResponse(text: replyText, recommendedPlaces: places);
    }

    // 2. Handle First Aid Intent
    if (intent.isFirstAid) {
      final searchKeyword = _getFirstAidSearchKeyword(intent.firstAidType);
      final topics = FirstAidService.instance.searchTopics(searchKeyword);

      if (topics.isNotEmpty) {
        final topic = topics.first;
        final buffer = StringBuffer();
        buffer.writeln("🩹 **Offline First Aid Guide: ${topic.title}**\n");
        buffer.writeln("${topic.description}\n");

        if (topic.warning.trim().isNotEmpty) {
          buffer.writeln("⚠️ **IMPORTANT WARNING:**");
          buffer.writeln("> ${topic.warning}\n");
        }

        buffer.writeln("👉 **STEPS TO TAKE:**");
        for (int i = 0; i < topic.steps.length; i++) {
          buffer.writeln("${i + 1}. ${topic.steps[i]}");
        }

        if (topic.emergencyNumber.trim().isNotEmpty) {
          buffer.writeln(
            "\n📞 **Emergency Number:** **${topic.emergencyNumber}**",
          );
        }

        return OfflineAIResponse(text: buffer.toString());
      }
    }

    // 3. Handle Emergency/Disaster Guide Intent
    if (intent.isEmergency) {
      final title = _getDisasterTitle(intent.emergencyType);
      final disasters = DisasterService.instance.searchDisasters(title);

      if (disasters.isNotEmpty) {
        final disaster = disasters.first;
        final buffer = StringBuffer();
        buffer.writeln("🚨 **Offline Disaster Guide: ${disaster.title}**\n");
        buffer.writeln("${disaster.description}\n");

        if (disaster.emergencyTip.trim().isNotEmpty) {
          buffer.writeln("💡 **QUICK TIP:**");
          buffer.writeln("> ${disaster.emergencyTip}\n");
        }

        if (disaster.before.isNotEmpty) {
          buffer.writeln("🟢 **BEFORE (Preparation):**");
          for (final step in disaster.before) {
            buffer.writeln("• $step");
          }
          buffer.writeln();
        }

        if (disaster.during.isNotEmpty) {
          buffer.writeln("🟡 **DURING (Response):**");
          for (final step in disaster.during) {
            buffer.writeln("• $step");
          }
          buffer.writeln();
        }

        if (disaster.after.isNotEmpty) {
          buffer.writeln("🔴 **AFTER (Recovery):**");
          for (final step in disaster.after) {
            buffer.writeln("• $step");
          }
          buffer.writeln();
        }

        if (disaster.emergencyNumber.trim().isNotEmpty) {
          buffer.writeln(
            "📞 **Emergency Number:** **${disaster.emergencyNumber}**",
          );
        }

        return OfflineAIResponse(text: buffer.toString());
      }
    }

    // 4. Default Fallback
    final fallback =
        "👋 **Hello! I am SafePlace AI, your offline emergency assistant.**\n\n"
        "Since we are currently **offline**, my natural language capabilities are limited, but I have full access to our local emergency guides and safe places!\n\n"
        "Try asking me things like:\n"
        "• 🏠 *\"Find nearby shelters\"* or *\"Show hospitals\"*\n"
        "• 🩹 *\"How to perform CPR?\"* or *\"First aid for burns\"*\n"
        "• 🚨 *\"Safety tips for an earthquake\"* or *\"Flood advice\"*\n\n"
        "Please specify your emergency or request clearly so I can retrieve the correct local information!";

    return OfflineAIResponse(text: fallback);
  }

  String _getCategoryString(SafePlaceType type) {
    switch (type) {
      case SafePlaceType.hospital:
        return "Hospital";
      case SafePlaceType.shelter:
        return "Shelter";
      case SafePlaceType.police:
        return "Police";
      case SafePlaceType.fireStation:
        return "Fire Station";
      case SafePlaceType.reliefCenter:
        return "Relief Center";
      default:
        return "";
    }
  }

  String _getFirstAidSearchKeyword(FirstAidType type) {
    switch (type) {
      case FirstAidType.cardiacCPR:
        return "CPR";
      case FirstAidType.burn:
        return "Burn";
      case FirstAidType.poisoning:
        return "Poisoning";
      case FirstAidType.drowning:
        return "Drowning";
      case FirstAidType.childCare:
        return "Child Care";
      case FirstAidType.choking:
        return "Choking";
      case FirstAidType.injury:
        return "Injury";
      default:
        return "";
    }
  }

  String _getDisasterTitle(EmergencyType type) {
    switch (type) {
      case EmergencyType.earthquake:
        return "Earthquake";
      case EmergencyType.flood:
        return "Flood";
      case EmergencyType.fire:
        return "Fire";
      case EmergencyType.cyclone:
        return "Cyclone";
      case EmergencyType.tsunami:
        return "Tsunami";
      case EmergencyType.heatwave:
        return "Heatwave";
      case EmergencyType.landslide:
        return "Landslide";
      case EmergencyType.lightning:
        return "Lightning";
      case EmergencyType.thunderstorm:
        return "Thunderstorm";
      case EmergencyType.volcanicEruption:
        return "Volcanic Eruption";
      case EmergencyType.chemicalLeak:
        return "Chemical Leak";
      case EmergencyType.pandemic:
        return "Pandemic";
      case EmergencyType.coldWave:
        return "Cold Wave";
      case EmergencyType.snowstorm:
        return "Snowstorm";
      case EmergencyType.tornado:
        return "Tornado";
      case EmergencyType.roadAccident:
        return "Road Accident";
      default:
        return "";
    }
  }
}
