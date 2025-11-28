// D:\FlutterProjects\Home_Cook\canton_connect\lib\data\services\api_service.dart

import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  late SharedPreferences _prefs;
  bool _isInitialized = false;

  // Initialize the service
  Future<void> initialize() async {
    if (_isInitialized) return;
    
    _prefs = await SharedPreferences.getInstance();
    await _initializeDefaultData();
    _isInitialized = true;
  }

  // Initialize with Chinese market default data
  Future<void> _initializeDefaultData() async {
    // Check if this is first run
    final isFirstRun = _prefs.getBool('first_run') ?? true;
    
    if (isFirstRun) {
      // Set up default Chinese user
      final defaultUser = {
        'id': '1',
        'email': 'demo@cantonconnect.cn',
        'name': '演示用户', // Demo User
        'phone': '+86 13800138000',
        'avatar_url': 'assets/images/default_avatar.png',
        'language': 'zh',
        'currency': 'CNY',
        'addresses': [
          {
            'id': '1',
            'type': 'home',
            'name': '家庭地址',
            'street': '广州市天河区珠江新城',
            'city': '广州',
            'province': '广东',
            'postal_code': '510000',
            'is_default': true,
          }
        ],
        'created_at': DateTime.now().toIso8601String(),
      };
      
      await _prefs.setString('current_user', json.encode(defaultUser));
      await _prefs.setBool('first_run', false);
      await _prefs.setBool('is_logged_in', true);
      
      // Initialize with Chinese food items
      await _initializeChineseFoodItems();
      await _initializeMenuCategories();
    }
  }

  // Chinese food items data
  Future<void> _initializeChineseFoodItems() async {
    final List<Map<String, dynamic>> chineseFoodItems = [
      {
        'id': '1',
        'name': '宫保鸡丁',
        'name_en': 'Kung Pao Chicken',
        'description': '经典川菜，鸡肉鲜嫩，花生香脆',
        'description_en': 'Classic Sichuan dish with tender chicken and crispy peanuts',
        'price': 38.0,
        'original_price': 45.0,
        'category_id': '2',
        'subcategory_id': '1',
        'image_url': 'assets/images/menu/kung_pao_chicken.jpg',
        'is_available': true,
        'is_spicy': true,
        'is_vegetarian': false,
        'is_popular': true,
        'cooking_time': 15,
        'spice_level': 2,
        'rating': 4.8,
        'review_count': 128,
        'sort_order': 1,
      },
      {
        'id': '2',
        'name': '春卷',
        'name_en': 'Spring Rolls',
        'description': '酥脆春卷，蔬菜馅料',
        'description_en': 'Crispy spring rolls with vegetable filling',
        'price': 22.0,
        'category_id': '1',
        'subcategory_id': '2',
        'image_url': 'assets/images/menu/spring_rolls.jpg',
        'is_available': true,
        'is_spicy': false,
        'is_vegetarian': true,
        'is_popular': true,
        'cooking_time': 8,
        'spice_level': 0,
        'rating': 4.5,
        'review_count': 89,
        'sort_order': 1,
      },
      {
        'id': '3',
        'name': '芒果布丁',
        'name_en': 'Mango Pudding',
        'description': '新鲜芒果制作，口感细腻',
        'description_en': 'Made with fresh mango, smooth texture',
        'price': 18.0,
        'category_id': '3',
        'subcategory_id': '3',
        'image_url': 'assets/images/menu/mango_pudding.jpg',
        'is_available': true,
        'is_spicy': false,
        'is_vegetarian': true,
        'is_popular': false,
        'cooking_time': 5,
        'spice_level': 0,
        'rating': 4.6,
        'review_count': 67,
        'sort_order': 1,
      },
      {
        'id': '4',
        'name': '珍珠奶茶',
        'name_en': 'Bubble Tea',
        'description': '经典台湾珍珠奶茶',
        'description_en': 'Classic Taiwanese bubble tea',
        'price': 15.0,
        'category_id': '4',
        'subcategory_id': '4',
        'image_url': 'assets/images/menu/bubble_tea.jpg',
        'is_available': true,
        'is_spicy': false,
        'is_vegetarian': true,
        'is_popular': true,
        'cooking_time': 3,
        'spice_level': 0,
        'rating': 4.7,
        'review_count': 203,
        'sort_order': 1,
      },
      {
        'id': '5',
        'name': '麻婆豆腐',
        'name_en': 'Mapo Tofu',
        'description': '四川特色，麻辣鲜香',
        'description_en': 'Sichuan specialty, spicy and flavorful',
        'price': 32.0,
        'category_id': '2',
        'subcategory_id': '5',
        'image_url': 'assets/images/menu/mapo_tofu.jpg',
        'is_available': true,
        'is_spicy': true,
        'is_vegetarian': true,
        'is_popular': true,
        'cooking_time': 12,
        'spice_level': 3,
        'rating': 4.9,
        'review_count': 156,
        'sort_order': 2,
      },
      {
        'id': '6',
        'name': '北京烤鸭',
        'name_en': 'Peking Duck',
        'description': '传统北京烤鸭，皮脆肉嫩',
        'description_en': 'Traditional Peking duck, crispy skin and tender meat',
        'price': 88.0,
        'original_price': 108.0,
        'category_id': '2',
        'subcategory_id': '6',
        'image_url': 'assets/images/menu/peking_duck.jpg',
        'is_available': true,
        'is_spicy': false,
        'is_vegetarian': false,
        'is_popular': true,
        'cooking_time': 25,
        'spice_level': 0,
        'rating': 4.9,
        'review_count': 234,
        'sort_order': 3,
      }
    ];

    await _prefs.setString('food_items', json.encode(chineseFoodItems));
  }

  // Initialize Chinese menu categories
  Future<void> _initializeMenuCategories() async {
    final List<Map<String, dynamic>> chineseCategories = [
      {
        'id': '1',
        'name': '开胃菜',
        'name_en': 'Appetizers',
        'description': '餐前小吃',
        'description_en': 'Start your meal right',
        'sort_order': 1,
      },
      {
        'id': '2',
        'name': '主菜',
        'name_en': 'Main Course',
        'description': '丰盛主菜',
        'description_en': 'Hearty main dishes',
        'sort_order': 2,
      },
      {
        'id': '3',
        'name': '甜品',
        'name_en': 'Desserts',
        'description': '甜蜜结尾',
        'description_en': 'Sweet endings',
        'sort_order': 3,
      },
      {
        'id': '4',
        'name': '饮品',
        'name_en': 'Drinks',
        'description': '各式饮品',
        'description_en': 'Refreshing drinks',
        'sort_order': 4,
      },
    ];

    await _prefs.setString('menu_categories', json.encode(chineseCategories));
  }

  // ============ USER MANAGEMENT ============
  Map<String, dynamic> get currentUser {
    final userJson = _prefs.getString('current_user');
    if (userJson != null) {
      return Map<String, dynamic>.from(json.decode(userJson));
    }
    return {};
  }

  set currentUser(Map<String, dynamic> user) {
    _prefs.setString('current_user', json.encode(user));
  }

  bool get isLoggedIn => _prefs.getBool('is_logged_in') ?? false;

  // ============ AUTH METHODS ============
  Future<Map<String, dynamic>> signIn(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    
    // Simple demo authentication - accept any non-empty credentials
    if (email.isEmpty || password.isEmpty) {
      return {'user': null, 'error': '请输入邮箱和密码'};
    }

    final user = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'email': email,
      'name': email.contains('@') ? email.split('@').first : '用户',
      'phone': '+86 13800138000',
      'avatar_url': 'assets/images/default_avatar.png',
      'language': 'zh',
      'currency': 'CNY',
      'addresses': currentUser['addresses'] ?? [],
      'created_at': DateTime.now().toIso8601String(),
    };
    
    currentUser = user;
    _prefs.setBool('is_logged_in', true);
    
    return {'user': user, 'error': null};
  }

  Future<Map<String, dynamic>> signUp(String email, String password, Map<String, dynamic> profile) async {
    await Future.delayed(const Duration(seconds: 1));
    
    if (email.isEmpty || password.isEmpty) {
      return {'user': null, 'error': '请输入邮箱和密码'};
    }

    final user = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'email': email,
      ...profile,
      'language': 'zh',
      'currency': 'CNY',
      'addresses': [],
      'created_at': DateTime.now().toIso8601String(),
    };
    
    currentUser = user;
    _prefs.setBool('is_logged_in', true);
    
    return {'user': user, 'error': null};
  }

  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _prefs.setBool('is_logged_in', false);
    // Don't remove user data to keep preferences
  }

  // ============ PROFILES ============
  Future<Map<String, dynamic>> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return currentUser;
  }

  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> profile) async {
    await Future.delayed(const Duration(seconds: 1));
    final current = currentUser;
    current.addAll(profile);
    currentUser = current;
    return currentUser;
  }

  // ============ MENU CATEGORIES ============
  Future<List<dynamic>> getMenuCategories() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final categoriesJson = _prefs.getString('menu_categories');
    if (categoriesJson != null) {
      final List<dynamic> categoriesList = json.decode(categoriesJson);
      return categoriesList.map((category) => Map<String, dynamic>.from(category)).toList();
    }
    return [];
  }

  // ============ MENU SUBCATEGORIES ============
  Future<List<dynamic>> getMenuSubcategories(String categoryId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Return mock subcategories
    final subcategories = {
      '1': ['vegetarian', 'meat', 'seafood'], // Appetizers
      '2': ['chicken', 'beef', 'pork', 'seafood', 'tofu', 'duck'], // Main Course
      '3': ['pudding', 'cake', 'ice_cream'], // Desserts
      '4': ['tea', 'juice', 'soda', 'alcoholic'], // Drinks
    };
    
    final subs = subcategories[categoryId] ?? ['general'];
    return subs.asMap().entries.map((entry) {
      return {
        'id': '${categoryId}_${entry.key + 1}',
        'name': entry.value,
        'category_id': categoryId,
        'sort_order': entry.key + 1,
      };
    }).toList();
  }

  // ============ MENU ITEMS ============
  Future<List<dynamic>> getMenuItems({String? subcategoryId, String? categoryId}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    final List<Map<String, dynamic>> allItems = getFoodItems();
    List<Map<String, dynamic>> filteredItems = List.from(allItems);
    
    if (subcategoryId != null) {
      filteredItems = filteredItems.where((item) => item['subcategory_id'] == subcategoryId).toList();
    } else if (categoryId != null) {
      filteredItems = filteredItems.where((item) => item['category_id'] == categoryId).toList();
    }
    
    // Add mock related data
    return filteredItems.map((item) {
      return {
        ...item,
        'menu_subcategories': {'name': item['name_en'] ?? 'Subcategory'},
        'menu_categories': {'name': 'Category'},
      };
    }).toList();
  }

  List<Map<String, dynamic>> getFoodItems() {
    final foodJson = _prefs.getString('food_items');
    if (foodJson != null) {
      final List<dynamic> foodList = json.decode(foodJson);
      return foodList.map((item) => Map<String, dynamic>.from(item)).toList();
    }
    return [];
  }

  Future<dynamic> getMenuItem(String itemId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final items = getFoodItems();
    final item = items.firstWhere((item) => item['id'] == itemId, orElse: () => items[0]);
    return {
      ...item,
      'menu_subcategories': {'name': item['name_en'] ?? 'Subcategory', 'description': item['description_en'] ?? 'Description'},
      'menu_categories': {'name': 'Category'},
    };
  }

  // ============ ORDERS ============
  List<Map<String, dynamic>> getOrders() {
    final ordersJson = _prefs.getString('orders');
    if (ordersJson != null) {
      final List<dynamic> ordersList = json.decode(ordersJson);
      return ordersList.map((order) => Map<String, dynamic>.from(order)).toList();
    }
    return [];
  }

  Future<List<dynamic>> getOrdersAsync() async {
    await Future.delayed(const Duration(seconds: 1));
    final orders = getOrders();
    return orders.map((order) {
      return {
        ...order,
        'order_items': order['order_items'] ?? [
          {
            'quantity': 2,
            'price': 38.0,
            'menu_items': {
              'name': '宫保鸡丁',
              'name_en': 'Kung Pao Chicken',
              'description': '经典川菜，鸡肉鲜嫩，花生香脆',
              'image_url': 'assets/images/menu/kung_pao_chicken.jpg',
            }
          }
        ]
      };
    }).toList();
  }

  Future<dynamic> getOrder(String orderId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final orders = getOrders();
    final order = orders.firstWhere((order) => order['id'] == orderId, orElse: () => _createMockOrder());
    return {
      ...order,
      'order_items': order['order_items'] ?? [
        {
          'quantity': 2,
          'price': 38.0,
          'menu_items': {
            'name': '宫保鸡丁',
            'name_en': 'Kung Pao Chicken',
            'description': '经典川菜，鸡肉鲜嫩，花生香脆',
            'image_url': 'assets/images/menu/kung_pao_chicken.jpg',
          }
        }
      ]
    };
  }

  Future<dynamic> createOrder(Map<String, dynamic> orderData) async {
    await Future.delayed(const Duration(seconds: 2));
    final orders = getOrders();
    final newOrder = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      ...orderData,
      'created_at': DateTime.now().toIso8601String(),
      'status': 'pending',
      'order_number': 'ORD${DateTime.now().millisecondsSinceEpoch}',
    };
    
    orders.add(newOrder);
    await _prefs.setString('orders', json.encode(orders));
    
    return newOrder;
  }

  Future<dynamic> updateOrderStatus(String orderId, String status) async {
    await Future.delayed(const Duration(seconds: 1));
    final orders = getOrders();
    final orderIndex = orders.indexWhere((order) => order['id'] == orderId);
    
    if (orderIndex != -1) {
      orders[orderIndex]['status'] = status;
      orders[orderIndex]['updated_at'] = DateTime.now().toIso8601String();
      await _prefs.setString('orders', json.encode(orders));
      return orders[orderIndex];
    }
    return _createMockOrder();
  }

  // ============ SUBSCRIPTION PLANS ============
  Future<List<dynamic>> getSubscriptionPlans() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      {
        'id': '1',
        'name': '基础套餐',
        'name_en': 'Basic Plan',
        'description': '适合个人用户',
        'description_en': 'Perfect for individuals',
        'price': 299.0,
        'original_price': 399.0,
        'duration_days': 30,
        'meals_per_week': 5,
        'features': ['5餐/周', '免费配送', '基础客服'],
      },
      {
        'id': '2',
        'name': '高级套餐',
        'name_en': 'Premium Plan',
        'description': '适合家庭用户',
        'description_en': 'Great for families',
        'price': 499.0,
        'original_price': 599.0,
        'duration_days': 30,
        'meals_per_week': 10,
        'features': ['10餐/周', '免费配送', '优先客服', '专属菜品'],
      },
      {
        'id': '3',
        'name': '豪华套餐',
        'name_en': 'Deluxe Plan',
        'description': '适合企业用户',
        'description_en': 'Ideal for corporate users',
        'price': 899.0,
        'original_price': 999.0,
        'duration_days': 30,
        'meals_per_week': 20,
        'features': ['20餐/周', '免费配送', 'VIP客服', '专属菜品', '定制菜单'],
      },
    ];
  }

  Future<dynamic> getSubscriptionPlan(String planId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final plans = await getSubscriptionPlans();
    return plans.firstWhere((plan) => plan['id'] == planId, orElse: () => plans[0]);
  }

  // ============ USER SUBSCRIPTION ============
  Future<dynamic> getUserSubscription() async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Return null to simulate no active subscription
    return null;
  }

  Future<dynamic> createUserSubscription(Map<String, dynamic> subscriptionData) async {
    await Future.delayed(const Duration(seconds: 2));
    return {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      ...subscriptionData,
      'status': 'active',
      'start_date': DateTime.now().toIso8601String(),
      'end_date': DateTime.now().add(const Duration(days: 30)).toIso8601String(),
      'subscription_plans': await getSubscriptionPlan(subscriptionData['plan_id']),
    };
  }

  Future<dynamic> updateUserSubscription(Map<String, dynamic> subscriptionData) async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      ...subscriptionData,
      'subscription_plans': await getSubscriptionPlan(subscriptionData['plan_id']),
    };
  }

  Future<void> cancelUserSubscription() async {
    await Future.delayed(const Duration(seconds: 1));
    // Mock cancellation
  }

  // ============ ADDRESSES ============
  Future<List<dynamic>> getAddresses() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final user = currentUser;
    final addresses = user['addresses'] ?? [];
    return List<Map<String, dynamic>>.from(addresses);
  }

  Future<dynamic> createAddress(Map<String, dynamic> addressData) async {
    await Future.delayed(const Duration(seconds: 1));
    final user = currentUser;
    final addresses = await getAddresses();
    
    final newAddress = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      ...addressData,
      'created_at': DateTime.now().toIso8601String(),
    };
    
    addresses.add(newAddress);
    user['addresses'] = addresses;
    currentUser = user;
    
    return newAddress;
  }

  Future<dynamic> updateAddress(String addressId, Map<String, dynamic> addressData) async {
    await Future.delayed(const Duration(seconds: 1));
    final user = currentUser;
    final addresses = await getAddresses();
    final addressIndex = addresses.indexWhere((address) => address['id'] == addressId);
    
    if (addressIndex != -1) {
      addresses[addressIndex].addAll(addressData);
      user['addresses'] = addresses;
      currentUser = user;
      return addresses[addressIndex];
    }
    return createAddress(addressData);
  }

  Future<void> deleteAddress(String addressId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final user = currentUser;
    final addresses = await getAddresses();
    addresses.removeWhere((address) => address['id'] == addressId);
    user['addresses'] = addresses;
    currentUser = user;
  }

  // ============ REAL-TIME SUBSCRIPTIONS (MOCK) ============
  
  // Mock streams for real-time updates
  Stream<List<Map<String, dynamic>>> getOrdersStream() {
    return Stream.periodic(const Duration(seconds: 10), (_) => getOrders());
  }

  Stream<List<Map<String, dynamic>>> getMenuItemsStream() {
    return Stream.periodic(const Duration(seconds: 30), (_) => getFoodItems());
  }

  Stream<List<Map<String, dynamic>>> getUserSubscriptionStream() {
    return Stream.periodic(const Duration(seconds: 10), (_) => []);
  }

  Stream<Map<String, dynamic>> getOrderStatusStream(String orderId) {
    return Stream.periodic(const Duration(seconds: 5), (_) {
      final orders = getOrders();
      return orders.firstWhere(
        (order) => order['id'] == orderId,
        orElse: () => _createMockOrder(),
      );
    });
  }

  // ============ UTILITY METHODS ============
  Future<void> updatePassword(String newPassword) async {
    await Future.delayed(const Duration(seconds: 1));
    // Mock password update
  }

  Future<void> resetPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));
    // Mock password reset
  }

  // ============ HELPER METHODS ============
  Map<String, dynamic> _createMockOrder() {
    return {
      'id': 'mock_order_1',
      'user_id': currentUser['id'],
      'status': 'pending',
      'total_amount': 76.0,
      'created_at': DateTime.now().toIso8601String(),
      'order_items': [
        {
          'quantity': 2,
          'price': 38.0,
          'menu_items': {
            'name': '宫保鸡丁',
            'name_en': 'Kung Pao Chicken',
            'description': '经典川菜，鸡肉鲜嫩，花生香脆',
            'image_url': 'assets/images/menu/kung_pao_chicken.jpg',
          }
        }
      ]
    };
  }

  // Demo data reset for testing
  Future<void> resetDemoData() async {
    await _prefs.clear();
    await _initializeDefaultData();
  }

  // Add food item (for admin)
  Future<void> addFoodItem(Map<String, dynamic> foodItem) async {
    final items = getFoodItems();
    items.add({
      ...foodItem,
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
    });
    await _prefs.setString('food_items', json.encode(items));
  }
}
