enum OrderStatus {
  pending,
  confirmed,
  preparing,
  ready,
  outForDelivery,
  delivered,
  cancelled,
  refunded,
}

enum PaymentMethod {
  cash,
  card,
  mobilePayment,
}

enum PaymentStatus {
  pending,
  completed,
  failed,
  refunded,
}

class Order {
  final String orderId;
  final String customerName;
  final String customerPhone;
  final String customerEmail;
  final String deliveryAddress;
  final DateTime orderDate;
  OrderStatus status;
  final double totalAmount;
  final double deliveryFee;
  final double taxAmount;
  final PaymentMethod paymentMethod;
  PaymentStatus paymentStatus;
  final String? specialInstructions;
  
  final List<OrderItem> items;
  final List<OrderStatusHistory> statusHistory;
  final DeliveryInfo? deliveryInfo;

  Order({
    required this.orderId,
    required this.customerName,
    required this.customerPhone,
    required this.customerEmail,
    required this.deliveryAddress,
    required this.orderDate,
    required this.status,
    required this.totalAmount,
    required this.deliveryFee,
    required this.taxAmount,
    required this.paymentMethod,
    required this.paymentStatus,
    this.specialInstructions,
    required this.items,
    required this.statusHistory,
    this.deliveryInfo,
  });
}

class OrderItem {
  final String foodId;
  final String foodName;
  final int quantity;
  final double unitPrice;
  final double totalPrice;
  final List<String> customizations;
  final String? notes;

  OrderItem({
    required this.foodId,
    required this.foodName,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    this.customizations = const [],
    this.notes,
  });
}

class OrderStatusHistory {
  final OrderStatus status;
  final DateTime timestamp;
  final String? notes;

  OrderStatusHistory({
    required this.status,
    required this.timestamp,
    this.notes,
  });
}

class DeliveryInfo {
  final String? driverName;
  final String? driverPhone;
  final DateTime? estimatedDeliveryTime;
  final DateTime? actualDeliveryTime;
  final String? trackingUrl;
  final double? deliveryDistance;

  DeliveryInfo({
    this.driverName,
    this.driverPhone,
    this.estimatedDeliveryTime,
    this.actualDeliveryTime,
    this.trackingUrl,
    this.deliveryDistance,
  });
}
