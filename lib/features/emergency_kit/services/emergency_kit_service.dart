import '../data/emergency_kit_data.dart';
import '../models/emergency_item_model.dart';

class EmergencyKitService {
  EmergencyKitService._();

  static final EmergencyKitService instance = EmergencyKitService._();

  /// Get all emergency kit items
  List<EmergencyItemModel> getAllItems() {
    return List.unmodifiable(EmergencyKitData.allItems);
  }

  /// Total number of items
  int get totalItems => EmergencyKitData.allItems.length;

  /// Search items
  List<EmergencyItemModel> searchItems(String query) {
    if (query.trim().isEmpty) {
      return getAllItems();
    }

    final keyword = query.toLowerCase();

    return EmergencyKitData.allItems.where((item) {
      return item.name.toLowerCase().contains(keyword) ||
          item.description.toLowerCase().contains(keyword) ||
          item.category.toLowerCase().contains(keyword);
    }).toList();
  }

  /// Get items by category
  List<EmergencyItemModel> getItemsByCategory(String category) {
    return EmergencyKitData.allItems.where((item) {
      return item.category == category;
    }).toList();
  }

  /// Get essential items only
  List<EmergencyItemModel> getEssentialItems() {
    return EmergencyKitData.allItems.where((item) {
      return item.isEssential;
    }).toList();
  }

  /// Get item by ID
  EmergencyItemModel? getItemById(String id) {
    try {
      return EmergencyKitData.allItems.firstWhere(
        (item) => item.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  /// Check if item exists
  bool itemExists(String id) {
    return EmergencyKitData.allItems.any(
      (item) => item.id == id,
    );
  }

  /// Get all categories
  List<String> getCategories() {
    return EmergencyKitData.allItems
        .map((item) => item.category)
        .toSet()
        .toList()
      ..sort();
  }

  /// Get packed items
  List<EmergencyItemModel> getPackedItems() {
    return EmergencyKitData.allItems.where((item) {
      return item.isPacked;
    }).toList();
  }

  /// Get unpacked items
  List<EmergencyItemModel> getUnpackedItems() {
    return EmergencyKitData.allItems.where((item) {
      return !item.isPacked;
    }).toList();
  }

  /// Progress percentage (used in Phase 2.2)
  double getPackingProgress() {
    if (EmergencyKitData.allItems.isEmpty) return 0;

    final packed = getPackedItems().length;

    return packed / EmergencyKitData.allItems.length;
  }
}