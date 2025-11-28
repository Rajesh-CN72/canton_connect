import 'package:flutter/foundation.dart';
import 'package:canton_connect/data/models/food_item.dart';


class CartProvider with ChangeNotifier {
  List<FoodOrder> _cartItems = [];
  String _deliveryAddress = '';
  String _specialInstructions = '';
  double _deliveryFee = 2.99;
  double _taxRate = 0.08; // 8% tax

  // Getters
  List<FoodOrder> get cartItems => List.unmodifiable(_cartItems);
  
  int get totalItems {
    return _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }
  
  double get subtotal {
    return _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
  }
  
  double get taxAmount {
    return subtotal * _taxRate;
  }
  
  double get totalAmount {
    return subtotal + taxAmount + _deliveryFee;
  }
  
  double get deliveryFee => _deliveryFee;
  String get deliveryAddress => _deliveryAddress;
  String get specialInstructions => _specialInstructions;
  bool get isCartEmpty => _cartItems.isEmpty;

  // Cart Operations
  void addToCart(FoodOrder order) {
    // Check if same item with same add-ons already exists in cart
    final existingIndex = _findExistingOrderIndex(order);
    
    if (existingIndex != -1) {
      // Update quantity if same item exists
      _cartItems[existingIndex] = FoodOrder(
        foodItem: order.foodItem,
        quantity: _cartItems[existingIndex].quantity + order.quantity,
        selectedAddOns: order.selectedAddOns,
        specialInstructions: order.specialInstructions,
      );
    } else {
      // Add new item to cart
      _cartItems.add(order);
    }
    
    notifyListeners();
  }

  void removeFromCart(String foodItemId, List<String> addOnIds) {
    _cartItems.removeWhere((order) => 
      order.foodItem.id == foodItemId && 
      _areAddOnsEqual(order.selectedAddOns.map((a) => a.id).toList(), addOnIds)
    );
    notifyListeners();
  }

  void updateQuantity(String foodItemId, List<String> addOnIds, int newQuantity) {
    if (newQuantity <= 0) {
      removeFromCart(foodItemId, addOnIds);
      return;
    }

    final index = _findOrderIndex(foodItemId, addOnIds);
    if (index != -1) {
      _cartItems[index] = FoodOrder(
        foodItem: _cartItems[index].foodItem,
        quantity: newQuantity,
        selectedAddOns: _cartItems[index].selectedAddOns,
        specialInstructions: _cartItems[index].specialInstructions,
      );
      notifyListeners();
    }
  }

  void incrementQuantity(String foodItemId, List<String> addOnIds) {
    final index = _findOrderIndex(foodItemId, addOnIds);
    if (index != -1) {
      updateQuantity(foodItemId, addOnIds, _cartItems[index].quantity + 1);
    }
  }

  void decrementQuantity(String foodItemId, List<String> addOnIds) {
    final index = _findOrderIndex(foodItemId, addOnIds);
    if (index != -1) {
      updateQuantity(foodItemId, addOnIds, _cartItems[index].quantity - 1);
    }
  }

  void updateSpecialInstructions(String foodItemId, List<String> addOnIds, String instructions) {
    final index = _findOrderIndex(foodItemId, addOnIds);
    if (index != -1) {
      _cartItems[index] = FoodOrder(
        foodItem: _cartItems[index].foodItem,
        quantity: _cartItems[index].quantity,
        selectedAddOns: _cartItems[index].selectedAddOns,
        specialInstructions: instructions,
      );
      notifyListeners();
    }
  }

  void updateDeliveryAddress(String address) {
    _deliveryAddress = address;
    notifyListeners();
  }

  void updateGlobalSpecialInstructions(String instructions) {
    _specialInstructions = instructions;
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  // Helper Methods
  int _findExistingOrderIndex(FoodOrder order) {
    return _cartItems.indexWhere((existingOrder) => 
      existingOrder.foodItem.id == order.foodItem.id &&
      _areAddOnsEqual(
        existingOrder.selectedAddOns.map((a) => a.id).toList(),
        order.selectedAddOns.map((a) => a.id).toList()
      ) &&
      existingOrder.specialInstructions == order.specialInstructions
    );
  }

  int _findOrderIndex(String foodItemId, List<String> addOnIds) {
    return _cartItems.indexWhere((order) => 
      order.foodItem.id == foodItemId &&
      _areAddOnsEqual(order.selectedAddOns.map((a) => a.id).toList(), addOnIds)
    );
  }

  bool _areAddOnsEqual(List<String> list1, List<String> list2) {
    if (list1.length != list2.length) return false;
    
    final sorted1 = List<String>.from(list1)..sort();
    final sorted2 = List<String>.from(list2)..sort();
    
    return listEquals(sorted1, sorted2);
  }

  // Check if a specific food item is in cart
  bool isItemInCart(String foodItemId) {
    return _cartItems.any((order) => order.foodItem.id == foodItemId);
  }

  // Get quantity of a specific item in cart
  int getItemQuantity(String foodItemId, List<String> addOnIds) {
    final index = _findOrderIndex(foodItemId, addOnIds);
    return index != -1 ? _cartItems[index].quantity : 0;
  }

  // Get cart summary for quick display
  Map<String, dynamic> getCartSummary() {
    return {
      'totalItems': totalItems,
      'subtotal': subtotal,
      'taxAmount': taxAmount,
      'deliveryFee': _deliveryFee,
      'totalAmount': totalAmount,
      'itemCount': _cartItems.length,
    };
  }

  // Apply promo code (placeholder for future implementation)
  void applyPromoCode(String code) {
    // TODO: Implement promo code logic
    print('Applying promo code: $code');
    notifyListeners();
  }

  // Set delivery time (placeholder for future implementation)
  void setDeliveryTime(DateTime deliveryTime) {
    // TODO: Implement delivery time logic
    print('Setting delivery time: $deliveryTime');
    notifyListeners();
  }

  // Check if cart meets minimum order amount
  bool get meetsMinimumOrder {
    const double minimumOrder = 15.00;
    return subtotal >= minimumOrder;
  }

  double get minimumOrderRemaining {
    const double minimumOrder = 15.00;
    final remaining = minimumOrder - subtotal;
    return remaining > 0 ? remaining : 0;
  }

  // Get items grouped by category for order summary
  Map<String, List<FoodOrder>> getItemsGroupedByCategory() {
    final Map<String, List<FoodOrder>> grouped = {};
    
    for (final order in _cartItems) {
      final category = order.foodItem.category;
      if (!grouped.containsKey(category)) {
        grouped[category] = [];
      }
      grouped[category]!.add(order);
    }
    
    return grouped;
  }

  // Calculate estimated preparation time
  int get estimatedPreparationTime {
    if (_cartItems.isEmpty) return 0;
    
    // Base preparation time + additional time per item
    int maxCookingTime = _cartItems.fold(0, (max, order) => 
      order.foodItem.cookingTime > max ? order.foodItem.cookingTime : max
    );
    
    // Add buffer time for multiple items
    int bufferTime = (_cartItems.length - 1) * 5;
    
    return maxCookingTime + bufferTime + 10; // +10 minutes for packaging
  }

  // Validate cart before checkout
  Map<String, dynamic> validateCart() {
    final errors = <String>[];
    final warnings = <String>[];

    // Check minimum order
    if (!meetsMinimumOrder) {
      errors.add('Minimum order amount is \$15.00');
    }

    // Check if any items are out of stock (placeholder)
    for (final order in _cartItems) {
      // TODO: Check stock availability
      if (order.quantity > 10) { // Example check
        warnings.add('${order.foodItem.nameEn} has limited availability');
      }
    }

    // Check delivery address
    if (_deliveryAddress.isEmpty) {
      warnings.add('Delivery address not set');
    }

    return {
      'isValid': errors.isEmpty,
      'errors': errors,
      'warnings': warnings,
    };
  }

  // Export cart data for persistence
  Map<String, dynamic> toJson() {
    return {
      'cartItems': _cartItems.map(_orderToJson).toList(),
      'deliveryAddress': _deliveryAddress,
      'specialInstructions': _specialInstructions,
      'deliveryFee': _deliveryFee,
      'taxRate': _taxRate,
    };
  }

  // Import cart data from persistence - FIXED VERSION
  void fromJson(Map<String, dynamic> json) {
    _cartItems = (json['cartItems'] as List<dynamic>)
        .map<FoodOrder>((item) => _orderFromJson(item as Map<String, dynamic>))
        .toList();
    _deliveryAddress = json['deliveryAddress'] ?? '';
    _specialInstructions = json['specialInstructions'] ?? '';
    _deliveryFee = (json['deliveryFee'] ?? 2.99).toDouble();
    _taxRate = (json['taxRate'] ?? 0.08).toDouble();
    notifyListeners();
  }

  Map<String, dynamic> _orderToJson(FoodOrder order) {
    return {
      'foodItem': {
        'id': order.foodItem.id,
        'nameEn': order.foodItem.nameEn,
        'nameZh': order.foodItem.nameZh,
        'price': order.foodItem.price,
        'images': order.foodItem.images,
        'cookingTime': order.foodItem.cookingTime,
        'isSpicy': order.foodItem.isSpicy,
        'isVegetarian': order.foodItem.isVegetarian,
      },
      'quantity': order.quantity,
      'selectedAddOns': order.selectedAddOns.map((addOn) => {
        'id': addOn.id,
        'nameEn': addOn.nameEn,
        'nameZh': addOn.nameZh,
        'price': addOn.price,
      }).toList(),
      'specialInstructions': order.specialInstructions,
    };
  }

  FoodOrder _orderFromJson(Map<String, dynamic> json) {
    // This is a simplified version - in a real app, you'd want to fetch the full FoodItem from your data source
    final foodItemJson = json['foodItem'] as Map<String, dynamic>;
    final foodItem = FoodItem(
      id: foodItemJson['id'],
      nameEn: foodItemJson['nameEn'],
      nameZh: foodItemJson['nameZh'],
      descriptionEn: '', // You might want to store these or fetch from database
      descriptionZh: '',
      price: foodItemJson['price'],
      images: List<String>.from(foodItemJson['images']),
      rating: 4.5, // Default value
      reviewCount: 100, // Default value
      cookingTime: foodItemJson['cookingTime'],
      isSpicy: foodItemJson['isSpicy'],
      isVegetarian: foodItemJson['isVegetarian'],
      isVegan: false, // Default value
      ingredients: [], // You might want to store these
      allergens: [], // You might want to store these
      nutritionInfo: NutritionInfo( // Default values
        calories: 0,
        protein: 0,
        carbs: 0,
        fat: 0,
        fiber: 0,
        sugar: 0,
        sodium: 0,
      ),
      addOns: [], // You might want to store these
      category: 'Main Course', // Default value
      subCategory: 'General', // Default value
    );

    final addOnsJson = json['selectedAddOns'] as List;
    final selectedAddOns = addOnsJson.map((addOnJson) {
      return AddOn(
        id: addOnJson['id'],
        nameEn: addOnJson['nameEn'],
        nameZh: addOnJson['nameZh'],
        descriptionEn: '', // Default value
        descriptionZh: '', // Default value
        price: addOnJson['price'],
        isAvailable: true, // Default value
      );
    }).toList();

    return FoodOrder(
      foodItem: foodItem,
      quantity: json['quantity'],
      selectedAddOns: selectedAddOns,
      specialInstructions: json['specialInstructions'] ?? '',
    );
  }
}

