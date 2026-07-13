import '../data/feature_data.dart';
import '../models/feature_model.dart';

class HomeService {
  HomeService._();

  static final HomeService instance = HomeService._();

  /// Get all dashboard features
  List<FeatureModel> getAllFeatures() {
    return FeatureData.features;
  }

  /// Find a feature by ID
  FeatureModel? getFeatureById(String id) {
    try {
      return FeatureData.features.firstWhere(
        (feature) => feature.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  /// Search dashboard features
  List<FeatureModel> searchFeatures(String query) {
    if (query.trim().isEmpty) {
      return FeatureData.features;
    }

    final search = query.toLowerCase();

    return FeatureData.features.where((feature) {
      return feature.title.toLowerCase().contains(search) ||
          feature.subtitle.toLowerCase().contains(search);
    }).toList();
  }
}