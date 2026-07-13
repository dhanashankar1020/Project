import '../models/emergency_item_model.dart';

class FoodWaterData {
  static const List<EmergencyItemModel> data = [
    EmergencyItemModel(
      id: "FOOD001",
      name: "Drinking Water",
      category: "Food & Water",
      description: "Store at least 3 liters of drinking water per person per day.",
      quantity: 9,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/drinking_water.png",
    ),

    EmergencyItemModel(
      id: "FOOD002",
      name: "Bottled Water",
      category: "Food & Water",
      description: "Sealed bottles of clean drinking water.",
      quantity: 6,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/bottled_water.png",
    ),

    EmergencyItemModel(
      id: "FOOD003",
      name: "Canned Food",
      category: "Food & Water",
      description: "Long-lasting food that requires little preparation.",
      quantity: 10,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/canned_food.png",
    ),

    EmergencyItemModel(
      id: "FOOD004",
      name: "Ready-to-Eat Meals",
      category: "Food & Water",
      description: "Meals that can be eaten without cooking.",
      quantity: 6,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/ready_meals.png",
    ),

    EmergencyItemModel(
      id: "FOOD005",
      name: "Energy Bars",
      category: "Food & Water",
      description: "High-energy snacks for emergency situations.",
      quantity: 12,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/energy_bar.png",
    ),

    EmergencyItemModel(
      id: "FOOD006",
      name: "Dry Fruits",
      category: "Food & Water",
      description: "Healthy snacks with a long shelf life.",
      quantity: 5,
      isEssential: false,
      isPacked: false,
      image: "assets/images/emergency_kit/dry_fruits.png",
    ),

    EmergencyItemModel(
      id: "FOOD007",
      name: "Powdered Milk",
      category: "Food & Water",
      description: "Useful when fresh milk is unavailable.",
      quantity: 2,
      isEssential: false,
      isPacked: false,
      image: "assets/images/emergency_kit/powdered_milk.png",
    ),

    EmergencyItemModel(
      id: "FOOD008",
      name: "Honey",
      category: "Food & Water",
      description: "Natural energy source with a long shelf life.",
      quantity: 1,
      isEssential: false,
      isPacked: false,
      image: "assets/images/emergency_kit/honey.png",
    ),

    EmergencyItemModel(
      id: "FOOD009",
      name: "Water Purification Tablets",
      category: "Food & Water",
      description: "Purifies water when clean drinking water isn't available.",
      quantity: 20,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/water_tablets.png",
    ),

    EmergencyItemModel(
      id: "FOOD010",
      name: "Reusable Water Bottle",
      category: "Food & Water",
      description: "Reusable bottle for carrying clean drinking water.",
      quantity: 2,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/water_bottle.png",
    ),

    EmergencyItemModel(
      id: "FOOD011",
      name: "Manual Can Opener",
      category: "Food & Water",
      description: "Required to open canned food during power outages.",
      quantity: 1,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/can_opener.png",
    ),

    EmergencyItemModel(
      id: "FOOD012",
      name: "Disposable Plates & Cups",
      category: "Food & Water",
      description: "Useful when washing utensils isn't possible.",
      quantity: 20,
      isEssential: false,
      isPacked: false,
      image: "assets/images/emergency_kit/disposable_plates.png",
    ),

    EmergencyItemModel(
      id: "FOOD013",
      name: "Instant Coffee / Tea",
      category: "Food & Water",
      description: "Comfort beverage during emergencies.",
      quantity: 10,
      isEssential: false,
      isPacked: false,
      image: "assets/images/emergency_kit/coffee.png",
    ),

    EmergencyItemModel(
      id: "FOOD014",
      name: "Electrolyte Drink Mix",
      category: "Food & Water",
      description: "Helps maintain hydration after heavy sweating.",
      quantity: 5,
      isEssential: false,
      isPacked: false,
      image: "assets/images/emergency_kit/electrolyte.png",
    ),

    EmergencyItemModel(
      id: "FOOD015",
      name: "Emergency Food Rations",
      category: "Food & Water",
      description: "Compact emergency food with a very long shelf life.",
      quantity: 2,
      isEssential: true,
      isPacked: false,
      image: "assets/images/emergency_kit/emergency_ration.png",
    ),
  ];
}