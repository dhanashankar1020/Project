import '../models/emergency_item_model.dart';

import 'baby_pet_data.dart';
import 'basic_supplies_data.dart';
import 'documents_data.dart';
import 'food_water_data.dart';
import 'medical_supplies_data.dart';
import 'tools_equipment_data.dart';

class EmergencyKitData {
  EmergencyKitData._();

  /// Complete emergency kit list
  static final List<EmergencyItemModel> allItems = [
    ...BasicSuppliesData.data,
    ...MedicalSuppliesData.data,
    ...FoodWaterData.data,
    ...ToolsEquipmentData.data,
    ...DocumentsData.data,
    ...BabyPetData.data,
  ];

  /// Total items
  static int get totalItems => allItems.length;

  /// Search items by name or description
  static List<EmergencyItemModel> search(String query) {
    if (query.trim().isEmpty) {
      return allItems;
    }

    final keyword = query.toLowerCase();

    return allItems.where((item) {
      return item.name.toLowerCase().contains(keyword) ||
          item.description.toLowerCase().contains(keyword) ||
          item.category.toLowerCase().contains(keyword);
    }).toList();
  }

  /// Get all items in a category
  static List<EmergencyItemModel> getByCategory(String category) {
    return allItems.where((item) {
      return item.category == category;
    }).toList();
  }

  /// Find an item by ID
  static EmergencyItemModel? getById(String id) {
    try {
      return allItems.firstWhere((item) => item.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Essential items only
  static List<EmergencyItemModel> get essentialItems {
    return allItems.where((item) => item.isEssential).toList();
  }
}