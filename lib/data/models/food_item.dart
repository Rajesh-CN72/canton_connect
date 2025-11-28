class FoodItem {
  final String id;
  final String nameEn;
  final String nameZh;
  final String descriptionEn;
  final String descriptionZh;
  final double price;
  final List<String> images;
  final double rating;
  final int reviewCount;
  final int cookingTime; // in minutes
  final bool isSpicy;
  final bool isVegetarian;
  final bool isVegan;
  final List<String> ingredients;
  final List<String> allergens;
  final NutritionInfo nutritionInfo;
  final List<AddOn> addOns;
  final String category;
  final String subCategory;
  
  // Add missing properties used in FoodDetailPage
  final bool isPopular;
  final bool isNew;
  final int serves;
  
  // ADDED: isFeatured property for menu page
  final bool isFeatured;

  // NEW: Properties for subscription and family packages
  final bool availableInSubscription;
  final bool availableInFamilyPackage;
  final List<String> dietaryTags; // For filtering in subscriptions
  final int maxOrderPerWeek; // For subscription limits

  // NEW: Properties for subscription meal selection
  final List<String> tags; // ['lunch', 'dinner', 'vegetarian', 'vegan', 'low_carb', 'chinese', 'western', 'spicy', 'healthy']
  final List<String> availableMealTypes; // ['lunch', 'dinner', 'both']
  final List<String> compatiblePlans; // Plan IDs that this meal is available for
  final bool isSeasonal; // Seasonal items might not be available year-round
  final DateTime? availableFrom; // Start date for seasonal items
  final DateTime? availableUntil; // End date for seasonal items
  final int preparationLeadTime; // Hours needed to prepare this meal

  FoodItem({
    required this.id,
    required this.nameEn,
    required this.nameZh,
    required this.descriptionEn,
    required this.descriptionZh,
    required this.price,
    required this.images,
    required this.rating,
    required this.reviewCount,
    required this.cookingTime,
    required this.isSpicy,
    required this.isVegetarian,
    required this.isVegan,
    required this.ingredients,
    required this.allergens,
    required this.nutritionInfo,
    required this.addOns,
    required this.category,
    required this.subCategory,
    // Initialize new properties with default values
    this.isPopular = false,
    this.isNew = false,
    this.serves = 1,
    // ADDED: Initialize isFeatured with default value
    this.isFeatured = false,
    // NEW: Initialize subscription and family package properties
    this.availableInSubscription = false,
    this.availableInFamilyPackage = false,
    this.dietaryTags = const [],
    this.maxOrderPerWeek = 0, // 0 means no limit
    // NEW: Initialize subscription meal selection properties
    this.tags = const [],
    this.availableMealTypes = const ['lunch', 'dinner'],
    this.compatiblePlans = const [],
    this.isSeasonal = false,
    this.availableFrom,
    this.availableUntil,
    this.preparationLeadTime = 24, // Default 24 hours
  });

  String getName(String language) => language == 'zh' ? nameZh : nameEn;
  String getDescription(String language) => language == 'zh' ? descriptionZh : descriptionEn;

  // Add getter for preparationTime to match FoodDetailPage expectation
  int get preparationTime => cookingTime;
  
  // Getter for available add-ons
  List<AddOn> get availableAddOns => addOns.where((addOn) => addOn.isAvailable).toList();

  // Add missing methods for action bar
  double getAddOnsTotalPrice(List<AddOn> selectedAddOns) {
    return selectedAddOns.fold(0.0, (sum, addOn) => sum + addOn.price);
  }

  bool get isOutOfStock => false; // Modify based on your inventory logic

  // NEW: Helper methods for subscription and family packages
  bool get canBeInSubscription => availableInSubscription && !isOutOfStock;
  bool get canBeInFamilyPackage => availableInFamilyPackage && !isOutOfStock;
  
  // Check if this item matches dietary requirements
  bool matchesDietaryRequirements(List<String> requiredTags) {
    if (requiredTags.isEmpty) return true;
    return requiredTags.any((tag) => dietaryTags.contains(tag) || tags.contains(tag));
  }

  // NEW: Check if meal is available for a specific subscription plan
  bool isAvailableForPlan(String planId) {
    return compatiblePlans.isEmpty || compatiblePlans.contains(planId);
  }

  // NEW: Check if meal is available for specific meal type (lunch/dinner)
  bool isAvailableForMealType(String mealType) {
    return availableMealTypes.contains(mealType) || availableMealTypes.contains('both');
  }

  // NEW: Check if meal is currently available (considering seasonal availability)
  bool get isCurrentlyAvailable {
    if (!isSeasonal) return true;
    
    final now = DateTime.now();
    if (availableFrom != null && now.isBefore(availableFrom!)) return false;
    if (availableUntil != null && now.isAfter(availableUntil!)) return false;
    
    return true;
  }

  // NEW: Check if meal can be ordered for a specific date (considering lead time)
  bool canBeOrderedForDate(DateTime deliveryDate) {
    final now = DateTime.now();
    final cutoffTime = deliveryDate.subtract(Duration(hours: preparationLeadTime));
    return now.isBefore(cutoffTime) && isCurrentlyAvailable;
  }

  // Get display tags including dietary and other tags
  List<String> get displayTags {
    final List<String> allTags = [];
    if (isSpicy) allTags.add('spicy');
    if (isVegetarian) allTags.add('vegetarian');
    if (isVegan) allTags.add('vegan');
    if (isSeasonal) allTags.add('seasonal');
    if (isNew) allTags.add('new');
    if (isPopular) allTags.add('popular');
    
    // Add dietary tags and general tags
    allTags.addAll(dietaryTags);
    allTags.addAll(tags);
    
    return allTags.toSet().toList(); // Remove duplicates
  }

  // NEW: Get dietary-specific tags for filtering
  List<String> get dietaryDisplayTags {
    final dietaryTags = [
      if (isVegetarian) 'vegetarian',
      if (isVegan) 'vegan',
      if (isSpicy) 'spicy',
    ];
    
    // Add other dietary tags from the tags list
    final dietaryKeywords = ['low_carb', 'gluten_free', 'keto', 'dairy_free', 'nut_free', 'high_protein'];
    dietaryTags.addAll(tags.where(dietaryKeywords.contains));
    
    return dietaryTags;
  }

  // NEW: Get meal type tags
  List<String> get mealTypeTags {
    return availableMealTypes;
  }

  // NEW: Get cuisine type tags
  List<String> get cuisineTags {
    final cuisineKeywords = ['chinese', 'western', 'cantonese', 'sichuan', 'guangzhou', 'asian', 'fusion'];
    return tags.where((tag) => cuisineKeywords.contains(tag)).toList();
  }

  // Clone with updated properties (useful for cart modifications)
  FoodItem copyWith({
    String? id,
    String? nameEn,
    String? nameZh,
    String? descriptionEn,
    String? descriptionZh,
    double? price,
    List<String>? images,
    double? rating,
    int? reviewCount,
    int? cookingTime,
    bool? isSpicy,
    bool? isVegetarian,
    bool? isVegan,
    List<String>? ingredients,
    List<String>? allergens,
    NutritionInfo? nutritionInfo,
    List<AddOn>? addOns,
    String? category,
    String? subCategory,
    bool? isPopular,
    bool? isNew,
    int? serves,
    bool? isFeatured,
    bool? availableInSubscription,
    bool? availableInFamilyPackage,
    List<String>? dietaryTags,
    int? maxOrderPerWeek,
    // NEW: Subscription meal selection properties
    List<String>? tags,
    List<String>? availableMealTypes,
    List<String>? compatiblePlans,
    bool? isSeasonal,
    DateTime? availableFrom,
    DateTime? availableUntil,
    int? preparationLeadTime,
  }) {
    return FoodItem(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      nameZh: nameZh ?? this.nameZh,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      descriptionZh: descriptionZh ?? this.descriptionZh,
      price: price ?? this.price,
      images: images ?? this.images,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      cookingTime: cookingTime ?? this.cookingTime,
      isSpicy: isSpicy ?? this.isSpicy,
      isVegetarian: isVegetarian ?? this.isVegetarian,
      isVegan: isVegan ?? this.isVegan,
      ingredients: ingredients ?? this.ingredients,
      allergens: allergens ?? this.allergens,
      nutritionInfo: nutritionInfo ?? this.nutritionInfo,
      addOns: addOns ?? this.addOns,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      isPopular: isPopular ?? this.isPopular,
      isNew: isNew ?? this.isNew,
      serves: serves ?? this.serves,
      isFeatured: isFeatured ?? this.isFeatured,
      availableInSubscription: availableInSubscription ?? this.availableInSubscription,
      availableInFamilyPackage: availableInFamilyPackage ?? this.availableInFamilyPackage,
      dietaryTags: dietaryTags ?? this.dietaryTags,
      maxOrderPerWeek: maxOrderPerWeek ?? this.maxOrderPerWeek,
      // NEW: Subscription meal selection properties
      tags: tags ?? this.tags,
      availableMealTypes: availableMealTypes ?? this.availableMealTypes,
      compatiblePlans: compatiblePlans ?? this.compatiblePlans,
      isSeasonal: isSeasonal ?? this.isSeasonal,
      availableFrom: availableFrom ?? this.availableFrom,
      availableUntil: availableUntil ?? this.availableUntil,
      preparationLeadTime: preparationLeadTime ?? this.preparationLeadTime,
    );
  }

  // Convert to map for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameEn': nameEn,
      'nameZh': nameZh,
      'descriptionEn': descriptionEn,
      'descriptionZh': descriptionZh,
      'price': price,
      'images': images,
      'rating': rating,
      'reviewCount': reviewCount,
      'cookingTime': cookingTime,
      'isSpicy': isSpicy,
      'isVegetarian': isVegetarian,
      'isVegan': isVegan,
      'ingredients': ingredients,
      'allergens': allergens,
      'nutritionInfo': nutritionInfo.toJson(),
      'addOns': addOns.map((addOn) => addOn.toJson()).toList(),
      'category': category,
      'subCategory': subCategory,
      'isPopular': isPopular,
      'isNew': isNew,
      'serves': serves,
      'isFeatured': isFeatured,
      'availableInSubscription': availableInSubscription,
      'availableInFamilyPackage': availableInFamilyPackage,
      'dietaryTags': dietaryTags,
      'maxOrderPerWeek': maxOrderPerWeek,
      // NEW: Subscription meal selection properties
      'tags': tags,
      'availableMealTypes': availableMealTypes,
      'compatiblePlans': compatiblePlans,
      'isSeasonal': isSeasonal,
      'availableFrom': availableFrom?.toIso8601String(),
      'availableUntil': availableUntil?.toIso8601String(),
      'preparationLeadTime': preparationLeadTime,
    };
  }

  // NEW: Factory method to create from JSON
  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'],
      nameEn: json['nameEn'],
      nameZh: json['nameZh'],
      descriptionEn: json['descriptionEn'],
      descriptionZh: json['descriptionZh'],
      price: json['price']?.toDouble() ?? 0.0,
      images: List<String>.from(json['images'] ?? []),
      rating: json['rating']?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] ?? 0,
      cookingTime: json['cookingTime'] ?? 0,
      isSpicy: json['isSpicy'] ?? false,
      isVegetarian: json['isVegetarian'] ?? false,
      isVegan: json['isVegan'] ?? false,
      ingredients: List<String>.from(json['ingredients'] ?? []),
      allergens: List<String>.from(json['allergens'] ?? []),
      nutritionInfo: NutritionInfo.fromJson(json['nutritionInfo'] ?? {}),
      addOns: (json['addOns'] as List? ?? []).map((addOnJson) => AddOn.fromJson(addOnJson)).toList(),
      category: json['category'] ?? '',
      subCategory: json['subCategory'] ?? '',
      isPopular: json['isPopular'] ?? false,
      isNew: json['isNew'] ?? false,
      serves: json['serves'] ?? 1,
      isFeatured: json['isFeatured'] ?? false,
      availableInSubscription: json['availableInSubscription'] ?? false,
      availableInFamilyPackage: json['availableInFamilyPackage'] ?? false,
      dietaryTags: List<String>.from(json['dietaryTags'] ?? []),
      maxOrderPerWeek: json['maxOrderPerWeek'] ?? 0,
      tags: List<String>.from(json['tags'] ?? []),
      availableMealTypes: List<String>.from(json['availableMealTypes'] ?? ['lunch', 'dinner']),
      compatiblePlans: List<String>.from(json['compatiblePlans'] ?? []),
      isSeasonal: json['isSeasonal'] ?? false,
      availableFrom: json['availableFrom'] != null ? DateTime.parse(json['availableFrom']) : null,
      availableUntil: json['availableUntil'] != null ? DateTime.parse(json['availableUntil']) : null,
      preparationLeadTime: json['preparationLeadTime'] ?? 24,
    );
  }
}

class AddOn {
  final String id;
  final String nameEn;
  final String nameZh;
  final String descriptionEn;
  final String descriptionZh;
  final double price;
  final bool isAvailable;

  // NEW: For subscription compatibility
  final bool availableInSubscription;
  final bool isPremium; // Premium add-ons might cost extra in subscriptions
  final List<String> compatiblePlans; // Which subscription plans this add-on is available for

  AddOn({
    required this.id,
    required this.nameEn,
    required this.nameZh,
    required this.descriptionEn,
    required this.descriptionZh,
    required this.price,
    required this.isAvailable,
    this.availableInSubscription = true,
    this.isPremium = false,
    this.compatiblePlans = const [], // Empty means available for all plans
  });

  // THESE METHODS MUST BE PRESENT - they are used in food_model.dart
  String getName(String language) => language == 'zh' ? nameZh : nameEn;
  String getDescription(String language) => language == 'zh' ? descriptionZh : descriptionEn;

  // NEW: Check if add-on is available for a specific subscription plan
  bool isAvailableForPlan(String planId) {
    return compatiblePlans.isEmpty || compatiblePlans.contains(planId);
  }

  // NEW: JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameEn': nameEn,
      'nameZh': nameZh,
      'descriptionEn': descriptionEn,
      'descriptionZh': descriptionZh,
      'price': price,
      'isAvailable': isAvailable,
      'availableInSubscription': availableInSubscription,
      'isPremium': isPremium,
      'compatiblePlans': compatiblePlans,
    };
  }

  // NEW: Factory method to create from JSON
  factory AddOn.fromJson(Map<String, dynamic> json) {
    return AddOn(
      id: json['id'],
      nameEn: json['nameEn'],
      nameZh: json['nameZh'],
      descriptionEn: json['descriptionEn'],
      descriptionZh: json['descriptionZh'],
      price: json['price']?.toDouble() ?? 0.0,
      isAvailable: json['isAvailable'] ?? true,
      availableInSubscription: json['availableInSubscription'] ?? true,
      isPremium: json['isPremium'] ?? false,
      compatiblePlans: List<String>.from(json['compatiblePlans'] ?? []),
    );
  }
}

class NutritionInfo {
  final int calories;
  final double protein; // in grams
  final double carbs; // in grams
  final double fat; // in grams
  final double fiber; // in grams
  final double sugar; // in grams
  final double sodium; // in mg

  // NEW: Additional nutrition information for health-focused plans
  final double? saturatedFat;
  final double? transFat;
  final double? cholesterol;
  final double? potassium;
  final double? vitaminA;
  final double? vitaminC;
  final double? calcium;
  final double? iron;

  NutritionInfo({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.fiber,
    required this.sugar,
    required this.sodium,
    this.saturatedFat,
    this.transFat,
    this.cholesterol,
    this.potassium,
    this.vitaminA,
    this.vitaminC,
    this.calcium,
    this.iron,
  });

  // NEW: JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'fiber': fiber,
      'sugar': sugar,
      'sodium': sodium,
      'saturatedFat': saturatedFat,
      'transFat': transFat,
      'cholesterol': cholesterol,
      'potassium': potassium,
      'vitaminA': vitaminA,
      'vitaminC': vitaminC,
      'calcium': calcium,
      'iron': iron,
    };
  }

  // NEW: Factory method to create from JSON
  factory NutritionInfo.fromJson(Map<String, dynamic> json) {
    return NutritionInfo(
      calories: json['calories'] ?? 0,
      protein: json['protein']?.toDouble() ?? 0.0,
      carbs: json['carbs']?.toDouble() ?? 0.0,
      fat: json['fat']?.toDouble() ?? 0.0,
      fiber: json['fiber']?.toDouble() ?? 0.0,
      sugar: json['sugar']?.toDouble() ?? 0.0,
      sodium: json['sodium']?.toDouble() ?? 0.0,
      saturatedFat: json['saturatedFat']?.toDouble(),
      transFat: json['transFat']?.toDouble(),
      cholesterol: json['cholesterol']?.toDouble(),
      potassium: json['potassium']?.toDouble(),
      vitaminA: json['vitaminA']?.toDouble(),
      vitaminC: json['vitaminC']?.toDouble(),
      calcium: json['calcium']?.toDouble(),
      iron: json['iron']?.toDouble(),
    );
  }
}

class FoodOrder {
  final FoodItem foodItem;
  final int quantity;
  final List<AddOn> selectedAddOns;
  final String specialInstructions;

  // NEW: For subscription orders
  final bool isSubscriptionOrder;
  final String? subscriptionPlanId;
  final DateTime? deliveryDate; // Specific delivery date for subscription
  final String? deliveryTimeSlot; // Specific time slot for subscription

  FoodOrder({
    required this.foodItem,
    required this.quantity,
    required this.selectedAddOns,
    required this.specialInstructions,
    this.isSubscriptionOrder = false,
    this.subscriptionPlanId,
    this.deliveryDate,
    this.deliveryTimeSlot,
  });

  double get totalPrice {
    // FIXED: Use 0.0 instead of 0 for double fold operation
    double addOnsPrice = selectedAddOns.fold(0.0, (sum, addOn) => sum + addOn.price);
    return (foodItem.price + addOnsPrice) * quantity;
  }

  // NEW: Get base price without add-ons (useful for subscription calculations)
  double get basePrice => foodItem.price * quantity;

  // NEW: Get add-ons total
  double get addOnsPrice {
    return selectedAddOns.fold(0.0, (sum, addOn) => sum + addOn.price) * quantity;
  }

  // NEW: Check if this order is valid for subscription (within limits, available, etc.)
  bool get isValidForSubscription {
    if (!isSubscriptionOrder) return true;
    
    // Check if food item is available for subscription
    if (!foodItem.availableInSubscription) return false;
    
    // Check if within weekly limit
    if (foodItem.maxOrderPerWeek > 0 && quantity > foodItem.maxOrderPerWeek) return false;
    
    // Check if all add-ons are available for subscription
    if (selectedAddOns.any((addOn) => !addOn.availableInSubscription)) return false;
    
    return true;
  }

  // NEW: JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'foodItem': foodItem.toJson(),
      'quantity': quantity,
      'selectedAddOns': selectedAddOns.map((addOn) => addOn.toJson()).toList(),
      'specialInstructions': specialInstructions,
      'isSubscriptionOrder': isSubscriptionOrder,
      'subscriptionPlanId': subscriptionPlanId,
      'deliveryDate': deliveryDate?.toIso8601String(),
      'deliveryTimeSlot': deliveryTimeSlot,
      'totalPrice': totalPrice,
    };
  }

  // NEW: Factory method to create from JSON
  factory FoodOrder.fromJson(Map<String, dynamic> json) {
    return FoodOrder(
      foodItem: FoodItem.fromJson(json['foodItem']),
      quantity: json['quantity'],
      selectedAddOns: (json['selectedAddOns'] as List? ?? [])
          .map((addOnJson) => AddOn.fromJson(addOnJson))
          .toList(),
      specialInstructions: json['specialInstructions'] ?? '',
      isSubscriptionOrder: json['isSubscriptionOrder'] ?? false,
      subscriptionPlanId: json['subscriptionPlanId'],
      deliveryDate: json['deliveryDate'] != null ? DateTime.parse(json['deliveryDate']) : null,
      deliveryTimeSlot: json['deliveryTimeSlot'],
    );
  }
}
