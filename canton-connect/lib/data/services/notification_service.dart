// D:\FlutterProjects\Home_Cook\canton_connect\lib\data\services\notification_service.dart

import 'package:flutter/material.dart';
import 'dart:async';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final StreamController<String?> _onNotification = StreamController<String?>.broadcast();
  Stream<String?> get onNotification => _onNotification.stream;

  // For showing in-app notifications (SnackBar, Dialog, etc.)
  final StreamController<InAppNotification> _inAppNotifications = StreamController<InAppNotification>.broadcast();
  Stream<InAppNotification> get inAppNotifications => _inAppNotifications.stream;

  // Simple notification methods that don't require the local notifications package
  void showAddressAddedNotification(BuildContext? context) {
    _onNotification.add('address_added');
    
    // Show in-app notification
    _inAppNotifications.add(InAppNotification(
      title: 'Address Added',
      message: 'Your new address has been saved successfully',
      type: NotificationType.success,
    ));

    // Optional: Show SnackBar if context is provided
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Address added successfully'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void showAddressUpdatedNotification(BuildContext? context) {
    _onNotification.add('address_updated');
    
    _inAppNotifications.add(InAppNotification(
      title: 'Address Updated',
      message: 'Your address has been updated successfully',
      type: NotificationType.success,
    ));

    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Address updated successfully'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void showOrderStatusNotification(String status, String orderId, BuildContext? context) {
    _onNotification.add('order_$orderId');
    
    _inAppNotifications.add(InAppNotification(
      title: 'Order $status',
      message: 'Your order #$orderId is now $status',
      type: _getNotificationType(status),
    ));

    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order #$orderId is $status'),
          backgroundColor: _getSnackBarColor(status),
        ),
      );
    }
  }

  void showErrorNotification(String message, BuildContext? context) {
    _inAppNotifications.add(InAppNotification(
      title: 'Error',
      message: message,
      type: NotificationType.error,
    ));

    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void showSuccessNotification(String message, BuildContext? context) {
    _inAppNotifications.add(InAppNotification(
      title: 'Success',
      message: message,
      type: NotificationType.success,
    ));

    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void showInfoNotification(String message, BuildContext? context) {
    _inAppNotifications.add(InAppNotification(
      title: 'Information',
      message: message,
      type: NotificationType.info,
    ));

    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.blue,
        ),
      );
    }
  }

  void showWarningNotification(String message, BuildContext? context) {
    _inAppNotifications.add(InAppNotification(
      title: 'Warning',
      message: message,
      type: NotificationType.warning,
    ));

    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  NotificationType _getNotificationType(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'delivered':
        return NotificationType.success;
      case 'cancelled':
      case 'failed':
        return NotificationType.error;
      default:
        return NotificationType.info;
    }
  }

  Color _getSnackBarColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'delivered':
        return Colors.green;
      case 'cancelled':
      case 'failed':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  void dispose() {
    _onNotification.close();
    _inAppNotifications.close();
  }
}

enum NotificationType {
  success,
  error,
  warning,
  info,
}

class InAppNotification {
  final String title;
  final String message;
  final NotificationType type;
  final DateTime timestamp;

  InAppNotification({
    required this.title,
    required this.message,
    required this.type,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  Color get color {
    switch (type) {
      case NotificationType.success:
        return Colors.green;
      case NotificationType.error:
        return Colors.red;
      case NotificationType.warning:
        return Colors.orange;
      case NotificationType.info:
        return Colors.blue;
    }
  }

  IconData get icon {
    switch (type) {
      case NotificationType.success:
        return Icons.check_circle;
      case NotificationType.error:
        return Icons.error;
      case NotificationType.warning:
        return Icons.warning;
      case NotificationType.info:
        return Icons.info;
    }
  }

  @override
  String toString() {
    return 'InAppNotification{title: $title, message: $message, type: $type, timestamp: $timestamp}';
  }
}

// Helper extension for easy notification display
extension NotificationExtension on BuildContext {
  void showSuccessNotification(String message) {
    NotificationService().showSuccessNotification(message, this);
  }

  void showErrorNotification(String message) {
    NotificationService().showErrorNotification(message, this);
  }

  void showInfoNotification(String message) {
    NotificationService().showInfoNotification(message, this);
  }

  void showWarningNotification(String message) {
    NotificationService().showWarningNotification(message, this);
  }

  void showOrderStatusNotification(String status, String orderId) {
    NotificationService().showOrderStatusNotification(status, orderId, this);
  }
}
