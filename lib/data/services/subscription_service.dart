// lib/data/services/subscription_service.dart

import 'package:flutter/foundation.dart'; // Added for debugPrint

// Define the models here since they don't exist in your project yet
class SubscriptionPlan {
  final String id;
  final String name;
  final String description;
  final double price;
  final int maxMenuItems;
  final List<String> features;
  final bool isPopular;

  const SubscriptionPlan({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.maxMenuItems,
    required this.features,
    this.isPopular = false,
  });
}

class AppSubscriptionPlans {
  static const List<SubscriptionPlan> plans = [
    SubscriptionPlan(
      id: 'basic',
      name: 'Basic',
      description: 'Perfect for home cooks starting out',
      price: 9.99,
      maxMenuItems: 5,
      features: [
        'Up to 5 menu items',
        'Basic analytics',
        'Customer reviews',
      ],
    ),
    SubscriptionPlan(
      id: 'professional',
      name: 'Professional',
      description: 'For serious home cooks',
      price: 19.99,
      maxMenuItems: 20,
      features: [
        'Up to 20 menu items',
        'Advanced analytics',
        'Priority listing',
        'Custom branding',
      ],
      isPopular: true,
    ),
    SubscriptionPlan(
      id: 'enterprise',
      name: 'Enterprise',
      description: 'For established food businesses',
      price: 39.99,
      maxMenuItems: 100,
      features: [
        'Up to 100 menu items',
        'Full analytics suite',
        'Featured placement',
        'Dedicated support',
        'Custom domain',
      ],
    ),
  ];

  static SubscriptionPlan getPlanById(String id) {
    return plans.firstWhere((plan) => plan.id == id);
  }
}

class User {
  final String id;
  final String email;
  final String fullName;
  final String? phoneNumber;
  final String role;
  final DateTime createdAt;
  final String? subscriptionPlanId;
  final DateTime? subscriptionExpiry;
  final int menuItemsCount;

  const User({
    required this.id,
    required this.email,
    required this.fullName,
    this.phoneNumber,
    required this.role,
    required this.createdAt,
    this.subscriptionPlanId,
    this.subscriptionExpiry,
    this.menuItemsCount = 0,
  });

  bool get hasActiveSubscription {
    if (subscriptionPlanId == null || subscriptionExpiry == null) {
      return false;
    }
    return subscriptionExpiry!.isAfter(DateTime.now());
  }

  bool get canAddMoreMenuItems {
    if (!hasActiveSubscription) return false;
    
    final plan = AppSubscriptionPlans.getPlanById(subscriptionPlanId!);
    return menuItemsCount < plan.maxMenuItems;
  }

  int get remainingMenuItems {
    if (!hasActiveSubscription) return 0;
    
    final plan = AppSubscriptionPlans.getPlanById(subscriptionPlanId!);
    return plan.maxMenuItems - menuItemsCount;
  }

  User copyWith({
    String? subscriptionPlanId,
    DateTime? subscriptionExpiry,
    int? menuItemsCount,
  }) {
    return User(
      id: id,
      email: email,
      fullName: fullName,
      phoneNumber: phoneNumber,
      role: role,
      createdAt: createdAt,
      subscriptionPlanId: subscriptionPlanId ?? this.subscriptionPlanId,
      subscriptionExpiry: subscriptionExpiry ?? this.subscriptionExpiry,
      menuItemsCount: menuItemsCount ?? this.menuItemsCount,
    );
  }
}

class SubscriptionService {
  static Future<void> subscribeToPlan({
    required String userId,
    required String planId,
    required String paymentMethodId,
  }) async {
    try {
      // 1. Process payment (integrate with Stripe, PayPal, etc.)
      final paymentSuccess = await _processPayment(planId, paymentMethodId);
      
      if (!paymentSuccess) {
        throw Exception('Payment failed');
      }

      // 2. Calculate expiry date (e.g., 30 days from now)
      final expiryDate = DateTime.now().add(const Duration(days: 30));

      // 3. Update user subscription in database
      await _updateUserSubscription(userId, planId, expiryDate);

      // 4. Send confirmation email
      await _sendConfirmationEmail(userId, planId);
      
    } catch (e) {
      throw Exception('Subscription failed: ${e.toString()}');
    }
  }

  static Future<bool> canUserAddMenuItem(String userId) async {
    final user = await _getUser(userId);
    return user.canAddMoreMenuItems;
  }

  static Future<int> getUserRemainingMenuItems(String userId) async {
    final user = await _getUser(userId);
    return user.remainingMenuItems;
  }

  static Future<void> incrementMenuItemCount(String userId) async {
    final user = await _getUser(userId);
    final updatedCount = user.menuItemsCount + 1;
    
    if (updatedCount > AppSubscriptionPlans.getPlanById(user.subscriptionPlanId!).maxMenuItems) {
      throw Exception('Menu item limit reached for current subscription plan');
    }

    await _updateUserMenuItemCount(userId, updatedCount);
  }

  // Private helper methods
  static Future<bool> _processPayment(String planId, String paymentMethodId) async {
    // Integrate with your payment provider
    // For now, simulate success
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  static Future<void> _updateUserSubscription(
    String userId, 
    String planId, 
    DateTime expiryDate,
  ) async {
    // Update user in your database
    // Implementation depends on your database setup
    // FIXED: Replaced print with debugPrint
    debugdebugPrint('Updating user $userId subscription to plan $planId until $expiryDate');
    // TODO: Implement actual database update
  }

  static Future<User> _getUser(String userId) async {
    // Fetch user from database
    // This is a placeholder - implement your actual user fetching logic
    // For now, return a dummy user for testing
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
    
    return User(
      id: userId,
      email: 'test@example.com',
      fullName: 'Test User',
      role: 'customer',
      createdAt: DateTime.now(),
      subscriptionPlanId: 'basic', // Default plan
      subscriptionExpiry: DateTime.now().add(const Duration(days: 30)),
      menuItemsCount: 0,
    );
  }

  static Future<void> _updateUserMenuItemCount(String userId, int count) async {
    // Update user in database
    // Implementation depends on your database setup
    // FIXED: Replaced print with debugPrint
    debugdebugPrint('Updating user $userId menu item count to $count');
    // TODO: Implement actual database update
  }

  static Future<void> _sendConfirmationEmail(String userId, String planId) async {
    // Send email logic
    // FIXED: Replaced print with debugPrint
    debugdebugPrint('Sending confirmation email to user $userId for plan $planId');
    // TODO: Implement actual email service
  }
}
