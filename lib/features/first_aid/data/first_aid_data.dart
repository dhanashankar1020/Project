import '../models/first_aid_model.dart';

import 'burn_data.dart';
import 'cardiac_data.dart';
import 'child_care_data.dart';
import 'disaster_first_aid_data.dart';
import 'drowning_data.dart';
import 'injury_data.dart';
import 'poisoning_data.dart';

class FirstAidData {
  FirstAidData._();

  /// Complete offline first aid library
  static final List<FirstAidModel> allFirstAid = [
    ...CardiacData.data,
    ...InjuryData.data,
    ...BurnData.data,
    ...PoisoningData.data,
    ...DrowningData.data,
    ...ChildCareData.data,
    ...DisasterFirstAidData.data,
  ];

  /// Total topics
  static int get totalTopics => allFirstAid.length;

  /// Search topics
  static List<FirstAidModel> search(String query) {
    if (query.trim().isEmpty) {
      return allFirstAid;
    }

    final keyword = query.toLowerCase();

    return allFirstAid.where((item) {
      return item.title.toLowerCase().contains(keyword) ||
          item.description.toLowerCase().contains(keyword);
    }).toList();
  }

  /// Find by ID
  static FirstAidModel? getById(String id) {
    try {
      return allFirstAid.firstWhere((item) => item.id == id);
    } catch (_) {
      return null;
    }
  }
}