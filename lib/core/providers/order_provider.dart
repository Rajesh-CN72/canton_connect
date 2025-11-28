import 'package:flutter/foundation.dart';
import 'package:canton_connect/data/models/order_model.dart';

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];

  // Example dummy data for testing
  OrderProvider() {
    _orders = _createSampleOrders();
  }

  List<Order> _createSampleOrders() {
    return [
      Order(
        orderId: 'ORD-001',
        customerName: 'John Doe',
        customerPhone: '+1234567890',
        customerEmail: 'john.doe@example.com',
        deliveryAddress: '123 Main St, City, Country',
        orderDate: DateTime.now().subtract(const Duration(hours: 2)),
        status: OrderStatus.preparing,
        totalAmount: 45.99,
        deliveryFee: 5.00,
        taxAmount: 3.50,
        paymentMethod: PaymentMethod.card,
        paymentStatus: PaymentStatus.completed,
        specialInstructions: 'Please knock on the door',
        items: [
          OrderItem(
            foodId: '1',
            foodName: 'Kung Pao Chicken',
            quantity: 2,
            unitPrice: 18.99,
            totalPrice: 37.98,
            customizations: ['Extra spicy'],
          ),
        ],
        statusHistory: [
          OrderStatusHistory(
            status: OrderStatus.pending,
            timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          ),
          OrderStatusHistory(
            status: OrderStatus.confirmed,
            timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 45)),
          ),
          OrderStatusHistory(
            status: OrderStatus.preparing,
            timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
          ),
        ],
        deliveryInfo: DeliveryInfo(
          driverName: 'Mike Johnson',
          driverPhone: '+0987654321',
          estimatedDeliveryTime: DateTime.now().add(const Duration(minutes: 30)),
        ),
      ),
      // Add more sample orders as needed
    ];
  }

  List<Order> get orders => _orders;

  List<Order> getFilteredOrders({
    String status = 'all',
    String searchQuery = '',
    String timeFilter = 'all',
  }) {
    var filtered = _orders;

    // Filter by status
    if (status != 'all') {
      filtered = filtered.where((order) {
        return order.status.toString().split('.').last == status;
      }).toList();
    }

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((order) {
        return order.orderId.toLowerCase().contains(searchQuery.toLowerCase()) ||
            order.customerName.toLowerCase().contains(searchQuery.toLowerCase()) ||
            order.customerPhone.contains(searchQuery);
      }).toList();
    }

    // Filter by time
    if (timeFilter == 'today') {
      final now = DateTime.now();
      filtered = filtered.where((order) {
        return order.orderDate.day == now.day &&
            order.orderDate.month == now.month &&
            order.orderDate.year == now.year;
      }).toList();
    } else if (timeFilter == 'week') {
      final weekAgo = DateTime.now().subtract(const Duration(days: 7));
      filtered = filtered.where((order) => order.orderDate.isAfter(weekAgo)).toList();
    } else if (timeFilter == 'high') {
      // Example: High priority orders (maybe pending for long or high value)
      filtered = filtered.where((order) => order.totalAmount > 50).toList();
    }

    return filtered;
  }

  Future<void> refreshOrders() async {
    // Simulate network request
    await Future.delayed(const Duration(seconds: 2));
    // In a real app, you would fetch orders from an API
    notifyListeners();
  }

  void updateOrderStatus(String orderId, OrderStatus newStatus) {
    final orderIndex = _orders.indexWhere((order) => order.orderId == orderId);
    if (orderIndex != -1) {
      _orders[orderIndex].statusHistory.add(OrderStatusHistory(
        status: newStatus,
        timestamp: DateTime.now(),
      ));
      // In a real app, you would update the order in the backend as well
      notifyListeners();
    }
  }

  // Add more methods as needed: addOrder, removeOrder, etc.
}
