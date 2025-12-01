// Food Models
class FoodItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final double discount;
  final String imageUrl;
  final String categoryId;
  final bool isAvailable;
  final bool isVegetarian;
  final bool isSpicy;
  final bool isFeatured;
  final double rating;
  final int reviewCount;
  final int orderCount;
  final List<String> tags;
  final List<String> ingredients;
  final int preparationTime;
  bool isFavorite;

  FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.discount = 0,
    required this.imageUrl,
    required this.categoryId,
    this.isAvailable = true,
    this.isVegetarian = false,
    this.isSpicy = false,
    this.isFeatured = false,
    this.rating = 0,
    this.reviewCount = 0,
    this.orderCount = 0,
    this.tags = const [],
    this.ingredients = const [],
    this.preparationTime = 15,
    this.isFavorite = false,
  });

  double get finalPrice => discount > 0 ? price - (price * discount / 100) : price;
  bool get hasDiscount => discount > 0;

  FoodItem copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    double? discount,
    String? imageUrl,
    String? categoryId,
    bool? isAvailable,
    bool? isVegetarian,
    bool? isSpicy,
    bool? isFeatured,
    double? rating,
    int? reviewCount,
    int? orderCount,
    List<String>? tags,
    List<String>? ingredients,
    int? preparationTime,
    bool? isFavorite,
  }) {
    return FoodItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      imageUrl: imageUrl ?? this.imageUrl,
      categoryId: categoryId ?? this.categoryId,
      isAvailable: isAvailable ?? this.isAvailable,
      isVegetarian: isVegetarian ?? this.isVegetarian,
      isSpicy: isSpicy ?? this.isSpicy,
      isFeatured: isFeatured ?? this.isFeatured,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      orderCount: orderCount ?? this.orderCount,
      tags: tags ?? this.tags,
      ingredients: ingredients ?? this.ingredients,
      preparationTime: preparationTime ?? this.preparationTime,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class MenuCategory {
  final String id;
  final String name;
  final String description;
  final List<FoodItem> items;
  final String imageUrl;
  final int displayOrder;

  MenuCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.items,
    required this.imageUrl,
    this.displayOrder = 0,
  });
}

// Food Repository
class FoodRepository {
  final List<MenuCategory> _categories = [];
  final List<FoodItem> _featuredItems = [];

  FoodRepository() {
    _initializeData();
  }

  void _initializeData() {
    // Mock data initialization
    _categories.addAll([
      MenuCategory(
        id: '1',
        name: 'Appetizers',
        description: 'Start your meal right',
        imageUrl: 'assets/images/appetizers.jpg',
        items: [
          FoodItem(
            id: '1',
            name: 'Spring Rolls',
            description: 'Crispy vegetable spring rolls with sweet chili sauce',
            price: 6.99,
            imageUrl: 'assets/images/spring_rolls.jpg',
            categoryId: '1',
            isVegetarian: true,
            tags: const ['popular', 'crispy'],
            rating: 4.5,
            reviewCount: 128,
          ),
          FoodItem(
            id: '2',
            name: 'Chicken Satay',
            description: 'Grilled chicken skewers with peanut sauce',
            price: 8.99,
            imageUrl: 'assets/images/chicken_satay.jpg',
            categoryId: '1',
            tags: const ['grilled', 'popular'],
            rating: 4.7,
            reviewCount: 95,
          ),
        ],
      ),
      MenuCategory(
        id: '2',
        name: 'Main Courses',
        description: 'Hearty and delicious main dishes',
        imageUrl: 'assets/images/main_courses.jpg',
        items: [
          FoodItem(
            id: '3',
            name: 'Kung Pao Chicken',
            description: 'Spicy stir-fried chicken with peanuts and vegetables',
            price: 14.99,
            imageUrl: 'assets/images/kung_pao_chicken.jpg',
            categoryId: '2',
            isSpicy: true,
            isFeatured: true,
            tags: const ['spicy', 'popular'],
            rating: 4.6,
            reviewCount: 210,
          ),
          FoodItem(
            id: '4',
            name: 'Sweet and Sour Pork',
            description: 'Crispy pork with tangy sweet and sour sauce',
            price: 13.99,
            discount: 10,
            imageUrl: 'assets/images/sweet_sour_pork.jpg',
            categoryId: '2',
            tags: const ['sweet', 'crispy'],
            rating: 4.4,
            reviewCount: 156,
          ),
        ],
      ),
    ]);

    _featuredItems.addAll([
      FoodItem(
        id: '3',
        name: 'Kung Pao Chicken',
        description: 'Spicy stir-fried chicken with peanuts and vegetables',
        price: 14.99,
        imageUrl: 'assets/images/kung_pao_chicken.jpg',
        categoryId: '2',
        isSpicy: true,
        isFeatured: true,
        tags: const ['spicy', 'popular'],
        rating: 4.6,
        reviewCount: 210,
      ),
      FoodItem(
        id: '5',
        name: 'Beef with Broccoli',
        description: 'Tender beef stir-fried with fresh broccoli',
        price: 15.99,
        imageUrl: 'assets/images/beef_broccoli.jpg',
        categoryId: '2',
        isFeatured: true,
        tags: const ['healthy', 'popular'],
        rating: 4.8,
        reviewCount: 189,
      ),
    ]);
  }

  // Get all menu categories
  Future<List<MenuCategory>> getMenuCategories() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _categories;
  }

  // Get featured items
  Future<List<FoodItem>> getFeaturedItems() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _featuredItems;
  }

  // Search food items
  Future<List<FoodItem>> searchFoodItems(String query) async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    if (query.isEmpty) return [];

    final searchLower = query.toLowerCase();
    final results = _categories.expand((category) => category.items).where((item) {
      return item.name.toLowerCase().contains(searchLower) ||
             item.description.toLowerCase().contains(searchLower) ||
             item.tags.any((tag) => tag.toLowerCase().contains(searchLower));
    }).toList();

    return results;
  }

  // Get food items by category
  Future<List<FoodItem>> getFoodItemsByCategory(String categoryId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    final category = _categories.firstWhere(
      (cat) => cat.id == categoryId,
      orElse: () => MenuCategory(
        id: '',
        name: '',
        description: '',
        items: const [],
        imageUrl: '',
      ),
    );
    
    return category.items;
  }

  // Get food item by ID
  Future<FoodItem?> getFoodItemById(String itemId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    
    for (final category in _categories) {
      final item = category.items.firstWhere(
        (item) => item.id == itemId,
        orElse: () => FoodItem(
          id: '',
          name: '',
          description: '',
          price: 0,
          imageUrl: '',
          categoryId: '',
        ),
      );
      if (item.id.isNotEmpty) return item;
    }
    
    return null;
  }

  // Get popular items
  Future<List<FoodItem>> getPopularItems({int limit = 10}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final allItems = _categories.expand((category) => category.items).toList();
    allItems.sort((a, b) => b.orderCount.compareTo(a.orderCount));
    
    return allItems.take(limit).toList();
  }

  // Get discounted items
  Future<List<FoodItem>> getDiscountedItems({int limit = 10}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final discountedItems = _categories
        .expand((category) => category.items)
        .where((item) => item.discount > 0)
        .toList();

    discountedItems.sort((a, b) => b.discount.compareTo(a.discount));
    
    return discountedItems.take(limit).toList();
  }

  // Filter food items
  Future<List<FoodItem>> filterFoodItems({
    List<String>? categories,
    double? minPrice,
    double? maxPrice,
    double? minRating,
    bool? isVegetarian,
    bool? isSpicy,
    bool? hasDiscount,
    List<String>? tags,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    var allItems = _categories.expand((category) => category.items).toList();

    if (categories != null && categories.isNotEmpty) {
      allItems = allItems.where((item) => categories.contains(item.categoryId)).toList();
    }

    if (minPrice != null) {
      allItems = allItems.where((item) => item.price >= minPrice).toList();
    }

    if (maxPrice != null) {
      allItems = allItems.where((item) => item.price <= maxPrice).toList();
    }

    if (minRating != null) {
      allItems = allItems.where((item) => item.rating >= minRating).toList();
    }

    if (isVegetarian != null) {
      allItems = allItems.where((item) => item.isVegetarian == isVegetarian).toList();
    }

    if (isSpicy != null) {
      allItems = allItems.where((item) => item.isSpicy == isSpicy).toList();
    }

    if (hasDiscount != null) {
      allItems = allItems.where((item) => (item.discount > 0) == hasDiscount).toList();
    }

    if (tags != null && tags.isNotEmpty) {
      allItems = allItems.where((item) => 
        item.tags.any((tag) => tags.contains(tag))
      ).toList();
    }

    return allItems;
  }

  // Toggle favorite status
  Future<void> toggleFavoriteStatus(String itemId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    for (final category in _categories) {
      final itemIndex = category.items.indexWhere((item) => item.id == itemId);
      if (itemIndex != -1) {
        final currentItem = category.items[itemIndex];
        category.items[itemIndex] = currentItem.copyWith(
          isFavorite: !currentItem.isFavorite,
        );
        break;
      }
    }

    final featuredIndex = _featuredItems.indexWhere((item) => item.id == itemId);
    if (featuredIndex != -1) {
      final currentItem = _featuredItems[featuredIndex];
      _featuredItems[featuredIndex] = currentItem.copyWith(
        isFavorite: !currentItem.isFavorite,
      );
    }
  }

  // Get favorite items
  Future<List<FoodItem>> getFavoriteItems() async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    final favoriteItems = _categories
        .expand((category) => category.items)
        .where((item) => item.isFavorite)
        .toList();

    return favoriteItems;
  }

  // Refresh menu data
  Future<void> refreshMenuData() async {
    await Future.delayed(const Duration(seconds: 1));
    _initializeData();
  }
}
