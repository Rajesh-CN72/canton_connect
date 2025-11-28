import 'package:flutter/foundation.dart';

// Menu Models
class MenuCategory {
  final String id;
  final String name;
  final String description;
  final List<MenuItem> items;
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

class MenuItem {
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

  MenuItem({
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

  double get finalPrice {
    return discount > 0 ? price - (price * discount / 100) : price;
  }

  bool get hasDiscount => discount > 0;

  MenuItem copyWith({
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
    return MenuItem(
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

// Mock Menu Service
class MenuService {
  Future<Map<String, dynamic>> getMenuData() async {
    await Future.delayed(const Duration(seconds: 2));
    
    return {
      'categories': [
        {
          'id': '1',
          'name': 'Appetizers',
          'description': 'Start your meal right',
          'imageUrl': 'assets/images/appetizers.jpg',
          'items': [
            {
              'id': '1',
              'name': 'Spring Rolls',
              'description': 'Crispy vegetable spring rolls with sweet chili sauce',
              'price': 6.99,
              'imageUrl': 'assets/images/spring_rolls.jpg',
              'categoryId': '1',
              'isVegetarian': true,
              'tags': ['popular', 'crispy'],
            },
          ],
        },
      ],
      'featuredItems': [
        {
          'id': '2',
          'name': 'Kung Pao Chicken',
          'description': 'Spicy stir-fried chicken with peanuts and vegetables',
          'price': 14.99,
          'imageUrl': 'assets/images/kung_pao_chicken.jpg',
          'categoryId': '2',
          'isSpicy': true,
          'isFeatured': true,
          'rating': 4.5,
          'tags': ['spicy', 'popular'],
        },
      ],
    };
  }

  Future<void> updateFavoriteStatus(String itemId) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}

// Main Menu Provider
class MenuProvider with ChangeNotifier {
  final MenuService _menuService;

  MenuProvider() : _menuService = MenuService();

  List<MenuCategory> _categories = [];
  List<MenuItem> _featuredItems = [];
  List<MenuItem> _searchResults = [];
  MenuItem? _selectedItem;
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';

  List<MenuCategory> get categories => _categories;
  List<MenuItem> get featuredItems => _featuredItems;
  List<MenuItem> get searchResults => _searchResults;
  MenuItem? get selectedItem => _selectedItem;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;

  bool get hasData => _categories.isNotEmpty;
  bool get hasFeaturedItems => _featuredItems.isNotEmpty;
  bool get hasSearchResults => _searchResults.isNotEmpty;

  Future<void> loadMenuData() async {
    _setLoading(true);
    _error = null;

    try {
      final menuData = await _menuService.getMenuData();
      
      // Convert map data to model objects
      _categories = (menuData['categories'] as List).map((categoryData) {
        return MenuCategory(
          id: categoryData['id'] ?? '',
          name: categoryData['name'] ?? '',
          description: categoryData['description'] ?? '',
          imageUrl: categoryData['imageUrl'] ?? '',
          items: (categoryData['items'] as List).map((itemData) {
            return MenuItem(
              id: itemData['id'] ?? '',
              name: itemData['name'] ?? '',
              description: itemData['description'] ?? '',
              price: (itemData['price'] ?? 0.0).toDouble(),
              imageUrl: itemData['imageUrl'] ?? '',
              categoryId: itemData['categoryId'] ?? '',
              isVegetarian: itemData['isVegetarian'] ?? false,
              tags: List<String>.from(itemData['tags'] ?? []),
            );
          }).toList(),
        );
      }).toList();

      _featuredItems = (menuData['featuredItems'] as List).map((itemData) {
        return MenuItem(
          id: itemData['id'] ?? '',
          name: itemData['name'] ?? '',
          description: itemData['description'] ?? '',
          price: (itemData['price'] ?? 0.0).toDouble(),
          imageUrl: itemData['imageUrl'] ?? '',
          categoryId: itemData['categoryId'] ?? '',
          isSpicy: itemData['isSpicy'] ?? false,
          isFeatured: itemData['isFeatured'] ?? false,
          rating: (itemData['rating'] ?? 0.0).toDouble(),
          tags: List<String>.from(itemData['tags'] ?? []),
        );
      }).toList();

      notifyListeners();
    } catch (e) {
      _error = 'Failed to load menu data: ${e.toString()}';
      if (kDebugMode) {
        print('MenuProvider Error: $_error');
      }
    } finally {
      _setLoading(false);
    }
  }

  List<MenuItem> getItemsByCategory(String categoryId) {
    try {
      final category = _categories.firstWhere(
        (cat) => cat.id == categoryId,
      );
      return category.items;
    } catch (e) {
      return [];
    }
  }

  Future<void> searchItems(String query) async {
    _searchQuery = query.trim();
    
    if (_searchQuery.isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }

    _setLoading(true);

    try {
      await Future.delayed(const Duration(milliseconds: 300));

      final results = _categories.expand((category) => category.items).where((item) {
        final itemName = item.name.toLowerCase();
        final itemDescription = item.description.toLowerCase();
        final searchLower = _searchQuery.toLowerCase();
        
        return itemName.contains(searchLower) || 
               itemDescription.contains(searchLower) ||
               item.tags.any((tag) => tag.toLowerCase().contains(searchLower));
      }).toList();

      _searchResults = results;
      _error = null;
    } catch (e) {
      _error = 'Search failed: ${e.toString()}';
      _searchResults = [];
    } finally {
      _setLoading(false);
    }
  }

  void clearSearch() {
    _searchQuery = '';
    _searchResults = [];
    _error = null;
    notifyListeners();
  }

  void selectItem(MenuItem item) {
    _selectedItem = item;
    notifyListeners();
  }

  void clearSelectedItem() {
    _selectedItem = null;
    notifyListeners();
  }

  List<MenuItem> getFeaturedByCategory(String categoryId, {int limit = 4}) {
    final items = getItemsByCategory(categoryId)
        .where((item) => item.isFeatured)
        .take(limit)
        .toList();
    return items;
  }

  List<MenuItem> getPopularItems({int limit = 6}) {
    final allItems = _categories.expand((category) => category.items).toList();
    
    allItems.sort((a, b) {
      final orderCountComparison = b.orderCount.compareTo(a.orderCount);
      if (orderCountComparison != 0) return orderCountComparison;
      return b.rating.compareTo(a.rating);
    });

    return allItems.take(limit).toList();
  }

  List<MenuItem> getDiscountedItems({int limit = 8}) {
    final discountedItems = _categories
        .expand((category) => category.items)
        .where((item) => item.discount > 0)
        .toList();

    discountedItems.sort((a, b) => b.discount.compareTo(a.discount));
    
    return discountedItems.take(limit).toList();
  }

  Future<void> toggleFavorite(String itemId) async {
    try {
      for (final category in _categories) {
        final itemIndex = category.items.indexWhere((item) => item.id == itemId);
        if (itemIndex != -1) {
          final updatedItem = category.items[itemIndex].copyWith(
            isFavorite: !category.items[itemIndex].isFavorite,
          );
          
          final newItems = List<MenuItem>.from(category.items);
          newItems[itemIndex] = updatedItem;
          
          final categoryIndex = _categories.indexWhere((cat) => cat.id == category.id);
          if (categoryIndex != -1) {
            _categories[categoryIndex] = MenuCategory(
              id: category.id,
              name: category.name,
              description: category.description,
              items: newItems,
              imageUrl: category.imageUrl,
              displayOrder: category.displayOrder,
            );
          }
          
          final featuredIndex = _featuredItems.indexWhere((item) => item.id == itemId);
          if (featuredIndex != -1) {
            _featuredItems[featuredIndex] = updatedItem;
          }
          
          final searchIndex = _searchResults.indexWhere((item) => item.id == itemId);
          if (searchIndex != -1) {
            _searchResults[searchIndex] = updatedItem;
          }
          
          if (_selectedItem?.id == itemId) {
            _selectedItem = updatedItem;
          }
          
          break;
        }
      }
      
      notifyListeners();
      await _menuService.updateFavoriteStatus(itemId);
      
    } catch (e) {
      _error = 'Failed to update favorite: ${e.toString()}';
      notifyListeners();
    }
  }

  List<MenuItem> filterItems({
    List<String>? categories,
    double? minPrice,
    double? maxPrice,
    double? minRating,
    bool? isVegetarian,
    bool? isSpicy,
    bool? hasDiscount,
    List<String>? tags,
  }) {
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

  Future<void> refresh() async {
    await loadMenuData();
  }

  void clear() {
    _categories = [];
    _featuredItems = [];
    _searchResults = [];
    _selectedItem = null;
    _error = null;
    _searchQuery = '';
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
