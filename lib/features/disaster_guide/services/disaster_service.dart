import '../data/disaster_data.dart';
import '../models/disaster_model.dart';

class DisasterService {
  // Singleton
  DisasterService._();

  static final DisasterService instance = DisasterService._();

  /// Get all disasters
  List<DisasterModel> getAllDisasters() {
    return List.unmodifiable(DisasterData.disasters);
  }

  /// Find disaster by ID
  DisasterModel? getDisasterById(String id) {
    try {
      return DisasterData.disasters.firstWhere(
        (disaster) => disaster.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  /// Search disasters
  List<DisasterModel> searchDisasters(String query) {
    if (query.trim().isEmpty) {
      return getAllDisasters();
    }

    final keyword = query.toLowerCase();

    return DisasterData.disasters.where((disaster) {
      return disaster.title.toLowerCase().contains(keyword) ||
          disaster.description.toLowerCase().contains(keyword);
    }).toList();
  }

  /// Total number of disasters
  int get totalDisasters => DisasterData.disasters.length;
}