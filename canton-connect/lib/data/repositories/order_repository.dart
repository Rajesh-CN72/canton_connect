// Order Models
enum OrderStatus {
  pending,
  confirmed,
  preparing,
  ready,
  onTheWay,
  delivered,
  cancelled,
  refunded,
}

enum PaymentMethod {
  cash,
  card,
  mobileMoney,
  wallet,
}

enum PaymentStatus {
  pending,
  processing,
  completed,
  failed,
  refunded,
}

class OrderItem {
  final String id;
  final String menuItemId;
  final String name;
  final String description;
  final double price;
  final int quantity;
  final String imageUrl;
  final List<String> customizations;
  final String? specialInstructions;

  const OrderItem({
    required this.id,
    required this.menuItemId,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    this.customizations = const [],
    this.specialInstructions,
  });

  double get totalPrice => price * quantity;
}

class Order {
  final String id;
  final String userId;
  final String restaurantId;
  final String restaurantName;
  final List<OrderItem> items;
  final OrderStatus status;
  final PaymentMethod paymentMethod;
  final PaymentStatus paymentStatus;
  final double subtotal;
  final double deliveryFee;
  final double taxAmount;
  final double discountAmount;
  final double tipAmount;
  final double totalAmount;
  final DateTime orderDate;
  final DateTime? estimatedDeliveryTime;
  final DateTime? actualDeliveryTime;
  final String? specialInstructions;
  final String? riderName;

  const Order({
    required this.id,
    required this.userId,
    required this.restaurantId,
    required this.restaurantName,
    required this.items,
    required this.status,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.subtotal,
    required this.deliveryFee,
    required this.taxAmount,
    required this.discountAmount,
    required this.tipAmount,
    required this.totalAmount,
    required this.orderDate,
    this.estimatedDeliveryTime,
    this.actualDeliveryTime,
    this.specialInstructions,
    this.riderName,
  });

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
  bool get canBeCancelled => status == OrderStatus.pending || status == OrderStatus.confirmed;
}

// Order Repository
class OrderRepository {
  final List<Order> _orders = [];

  OrderRepository() {
    _initializeData();
  }

  void _initializeData() {
    // Mock orders data
    _orders.addAll([
      Order(
        id: '1',
        userId: 'user1',
        restaurantId: 'rest1',
        restaurantName: 'Canton Delights',
        items: const [
          OrderItem(
            id: '1',
            menuItemId: '3',
            name: 'Kung Pao Chicken',
            description: 'Spicy stir-fried chicken with peanuts and vegetables',
            price: 14.99,
            quantity: 1,
            imageUrl: 'assets/images/kung_pao_chicken.jpg',
          ),
          OrderItem(
            id: '2',
            menuItemId: '1',
            name: 'Spring Rolls',
            description: 'Crispy vegetable spring rolls with sweet chili sauce',
            price: 6.99,
            quantity: 2,
            imageUrl: 'assets/images/spring_rolls.jpg',
          ),
        ],
        status: OrderStatus.delivered,
        paymentMethod: PaymentMethod.card,
        paymentStatus: PaymentStatus.completed,
        subtotal: 28.97,
        deliveryFee: 2.99,
        taxAmount: 2.32,
        discountAmount: 0,
        tipAmount: 3.00,
        totalAmount: 37.28,
        orderDate: DateTime.now().subtract(const Duration(days: 2)),
        actualDeliveryTime: DateTime.now().subtract(const Duration(days: 2, hours: 1)),
      ),
      Order(
        id: '2',
        userId: 'user1',
        restaurantId: 'rest1',
        restaurantName: 'Canton Delights',
        items: const [
          OrderItem(
            id: '3',
            menuItemId: '4',
            name: 'Sweet and Sour Pork',
            description: 'Crispy pork with tangy sweet and sour sauce',
            price: 12.59,
            quantity: 1,
            imageUrl: 'assets/images/sweet_sour_pork.jpg',
          ),
        ],
        status: OrderStatus.preparing,
        paymentMethod: PaymentMethod.mobileMoney,
        paymentStatus: PaymentStatus.completed,
        subtotal: 12.59,
        deliveryFee: 2.99,
        taxAmount: 1.26,
        discountAmount: 1.40,
        tipAmount: 2.00,
        totalAmount: 18.84,
        orderDate: DateTime.now(),
        estimatedDeliveryTime: DateTime.now().add(const Duration(minutes: 45)),
      ),
    ]);
  }

  // Place a new order
  Future<Order> placeOrder(Order order) async {
    await Future.delayed(const Duration(seconds: 2));
    
    final newOrder = Order(
      id: '${_orders.length + 1}',
      userId: order.userId,
      restaurantId: order.restaurantId,
      restaurantName: order.restaurantName,
      items: order.items,
      status: OrderStatus.pending,
      paymentMethod: order.paymentMethod,
      paymentStatus: PaymentStatus.pending,
      subtotal: order.subtotal,
      deliveryFee: order.deliveryFee,
      taxAmount: order.taxAmount,
      discountAmount: order.discountAmount,
      tipAmount: order.tipAmount,
      totalAmount: order.totalAmount,
      orderDate: DateTime.now(),
      estimatedDeliveryTime: DateTime.now().add(const Duration(minutes: 45)),
      specialInstructions: order.specialInstructions,
    );
    
    _orders.insert(0, newOrder);
    return newOrder;
  }

  // Get orders for user
  Future<List<Order>> getOrders({
    String? userId,
    int? limit,
    List<String>? statuses,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    var orders = _orders;
    
    if (userId != null) {
      orders = orders.where((order) => order.userId == userId).toList();
    }
    
    if (statuses != null) {
      orders = orders.where((order) {
        return statuses.contains(order.status.name);
      }).toList();
    }
    
    if (limit != null) {
      orders = orders.take(limit).toList();
    }
    
    return orders;
  }

  // Get order by ID
  Future<Order?> getOrderById(String orderId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    try {
      return _orders.firstWhere((order) => order.id == orderId);
    } catch (e) {
      return null;
    }
  }

  // Update order status
  Future<Order?> updateOrderStatus(
    String orderId,
    OrderStatus newStatus, {
    String? note,
    String? updatedBy,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    final orderIndex = _orders.indexWhere((order) => order.id == orderId);
    if (orderIndex == -1) return null;
    
    final currentOrder = _orders[orderIndex];
    final updatedOrder = Order(
      id: currentOrder.id,
      userId: currentOrder.userId,
      restaurantId: currentOrder.restaurantId,
      restaurantName: currentOrder.restaurantName,
      items: currentOrder.items,
      status: newStatus,
      paymentMethod: currentOrder.paymentMethod,
      paymentStatus: currentOrder.paymentStatus,
      subtotal: currentOrder.subtotal,
      deliveryFee: currentOrder.deliveryFee,
      taxAmount: currentOrder.taxAmount,
      discountAmount: currentOrder.discountAmount,
      tipAmount: currentOrder.tipAmount,
      totalAmount: currentOrder.totalAmount,
      orderDate: currentOrder.orderDate,
      estimatedDeliveryTime: currentOrder.estimatedDeliveryTime,
      actualDeliveryTime: newStatus == OrderStatus.delivered ? DateTime.now() : currentOrder.actualDeliveryTime,
      specialInstructions: currentOrder.specialInstructions,
      riderName: currentOrder.riderName,
    );
    
    _orders[orderIndex] = updatedOrder;
    return updatedOrder;
  }

  // Cancel order
  Future<bool> cancelOrder(String orderId, {String? reason}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    final orderIndex = _orders.indexWhere((order) => order.id == orderId);
    if (orderIndex == -1) return false;
    
    final currentOrder = _orders[orderIndex];
    if (!currentOrder.canBeCancelled) return false;
    
    _orders[orderIndex] = Order(
      id: currentOrder.id,
      userId: currentOrder.userId,
      restaurantId: currentOrder.restaurantId,
      restaurantName: currentOrder.restaurantName,
      items: currentOrder.items,
      status: OrderStatus.cancelled,
      paymentMethod: currentOrder.paymentMethod,
      paymentStatus: PaymentStatus.refunded,
      subtotal: currentOrder.subtotal,
      deliveryFee: currentOrder.deliveryFee,
      taxAmount: currentOrder.taxAmount,
      discountAmount: currentOrder.discountAmount,
      tipAmount: currentOrder.tipAmount,
      totalAmount: currentOrder.totalAmount,
      orderDate: currentOrder.orderDate,
      estimatedDeliveryTime: currentOrder.estimatedDeliveryTime,
      actualDeliveryTime: currentOrder.actualDeliveryTime,
      specialInstructions: currentOrder.specialInstructions,
      riderName: currentOrder.riderName,
    );
    
    return true;
  }

  // Get active orders for user
  Future<List<Order>> getActiveOrders(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return _orders.where((order) {
      return order.userId == userId &&
             order.status != OrderStatus.delivered &&
             order.status != OrderStatus.cancelled &&
             order.status != OrderStatus.refunded;
    }).toList();
  }

  // Rate order
  Future<bool> rateOrder(
    String orderId, {
    required double rating,
    required String comment,
    Map<String, double>? itemRatings,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return true;
  }

  // Reorder
  Future<Order?> reorder(String orderId) async {
    await Future.delayed(const Duration(seconds: 1));
    
    final originalOrder = await getOrderById(orderId);
    if (originalOrder == null) return null;
    
    return await placeOrder(originalOrder);
  }

  // Get order statistics
  Future<Map<String, dynamic>> getOrderStatistics(String userId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    final userOrders = _orders.where((order) => order.userId == userId).toList();
    final totalOrders = userOrders.length;
    final completedOrders = userOrders.where((o) => o.status == OrderStatus.delivered).length;
    final cancelledOrders = userOrders.where((o) => o.status == OrderStatus.cancelled).length;
    final totalSpent = userOrders
        .where((o) => o.status == OrderStatus.delivered)
        .fold(0.0, (sum, order) => sum + order.totalAmount);
    
    return {
      'totalOrders': totalOrders,
      'completedOrders': completedOrders,
      'cancelledOrders': cancelledOrders,
      'totalSpent': totalSpent,
      'successRate': totalOrders > 0 ? (completedOrders / totalOrders) * 100 : 0,
    };
  }
}
