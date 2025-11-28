// models/menu_models.dart
class MenuCategory {
  final String id;
  final String name;
  final String imagePath;
  final String description;
  final List<MenuSubcategory> subcategories;
  final bool availableInSubscription;
  final bool availableInFamilyPackage;

  MenuCategory({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.description,
    required this.subcategories,
    this.availableInSubscription = false,
    this.availableInFamilyPackage = false,
  });
}

class MenuSubcategory {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imagePath;
  final bool isPopular;
  final List<String> dietaryTags; // ['vegetarian', 'spicy', 'gluten-free']

  MenuSubcategory({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    this.isPopular = false,
    this.dietaryTags = const [],
  });
}

class SubscriptionPlan {
  final String id;
  final String name;
  final String description;
  final double price;
  final String billingPeriod; // 'weekly', 'monthly'
  final List<String> includedCategoryIds;
  final int maxMeals;
  final List<String> benefits;
  final String imagePath;

  SubscriptionPlan({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.billingPeriod,
    required this.includedCategoryIds,
    required this.maxMeals,
    required this.benefits,
    required this.imagePath,
  });
}

class FamilyPackage {
  final String id;
  final String name;
  final String description;
  final double price;
  final int servesPeople;
  final List<PackageItem> items;
  final String imagePath;
  final List<String> dietaryOptions;

  FamilyPackage({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.servesPeople,
    required this.items,
    required this.imagePath,
    this.dietaryOptions = const [],
  });
}

class PackageItem {
  final String subcategoryId;
  final int quantity;
  final String notes;

  PackageItem({
    required this.subcategoryId,
    required this.quantity,
    this.notes = '',
  });
}
