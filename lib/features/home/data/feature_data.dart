import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../models/feature_model.dart';

class FeatureData {
  FeatureData._();

  static const List<FeatureModel> features = [
    FeatureModel(
      id: "1",
      title: "SOS",
      subtitle: "Emergency help",
      icon: Icons.sos,
      color: AppColors.sos,
      route: "/sos",
    ),
    FeatureModel(
      id: "2",
      title: "First Aid",
      subtitle: "Emergency treatments",
      icon: Icons.medical_services,
      color: AppColors.firstAid,
      route: "/first_aid",
    ),
    FeatureModel(
      id: "3",
      title: "Contacts",
      subtitle: "Emergency contacts",
      icon: Icons.contacts,
      color: AppColors.contacts,
      route: "/contacts",
    ),
    FeatureModel(
      id: "4",
      title: "Disaster Guide",
      subtitle: "Safety instructions",
      icon: Icons.menu_book,
      color: AppColors.disasterGuide,
      route: "/disaster_guide",
    ),
    FeatureModel(
      id: "5",
      title: "Emergency Kit",
      subtitle: "Essential supplies",
      icon: Icons.backpack,
      color: AppColors.emergencyKit,
      route: "/emergency_kit",
    ),
    FeatureModel(
      id: "6",
      title: "Safe Places",
      subtitle: "Nearby shelters",
      icon: Icons.location_on,
      color: AppColors.safePlaces,
      route: "/safe_places",
    ),
  ];
}