import '../data/first_aid_data.dart';
import '../models/first_aid_model.dart';

class FirstAidService {
  // Singleton Pattern
  FirstAidService._();

  static final FirstAidService instance = FirstAidService._();

  /// Get all first aid topics
  List<FirstAidModel> getAllTopics() {
    return List.unmodifiable(FirstAidData.allFirstAid);
  }

  /// Total topics
  int get totalTopics => FirstAidData.allFirstAid.length;

  /// Search by title or description
  List<FirstAidModel> searchTopics(String query) {
    if (query.trim().isEmpty) {
      return getAllTopics();
    }

    final keyword = query.toLowerCase();

    return FirstAidData.allFirstAid.where((topic) {
      return topic.title.toLowerCase().contains(keyword) ||
          topic.description.toLowerCase().contains(keyword);
    }).toList();
  }

  /// Get topic by ID
  FirstAidModel? getTopicById(String id) {
    try {
      return FirstAidData.allFirstAid.firstWhere(
        (topic) => topic.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  /// Get topics containing a keyword
  List<FirstAidModel> getTopicsByKeyword(String keyword) {
    final search = keyword.toLowerCase();

    return FirstAidData.allFirstAid.where((topic) {
      return topic.title.toLowerCase().contains(search) ||
          topic.description.toLowerCase().contains(search) ||
          topic.warning.toLowerCase().contains(search);
    }).toList();
  }

  /// Get emergency numbers
  List<String> getEmergencyNumbers() {
    return FirstAidData.allFirstAid
        .map((topic) => topic.emergencyNumber)
        .toSet()
        .toList();
  }

  /// Get random topic (for future "Tip of the Day")
  FirstAidModel getRandomTopic() {
    FirstAidData.allFirstAid.shuffle();
    return FirstAidData.allFirstAid.first;
  }

  /// Check if a topic exists
  bool topicExists(String id) {
    return FirstAidData.allFirstAid.any(
      (topic) => topic.id == id,
    );
  }
}