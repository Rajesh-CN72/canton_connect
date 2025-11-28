// lib/data/models/user_model.dart
class UserModel {
  final String id;
  final String email;
  final String? name;
  final String? phone;
  final UserRole role;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? address;
  final List<String>? favoriteFoods;
  final bool isEmailVerified;
  final Map<String, dynamic>? preferences;
  
  // ADD: Subscription-related fields
  final String? subscriptionPlanId;
  final DateTime? subscriptionExpiry;
  final int menuItemsCount;

  UserModel({
    required this.id,
    required this.email,
    this.name,
    this.phone,
    this.role = UserRole.customer,
    this.createdAt,
    this.updatedAt,
    this.address,
    this.favoriteFoods,
    this.isEmailVerified = false,
    this.preferences,
    
    // ADD: Subscription-related parameters
    this.subscriptionPlanId,
    this.subscriptionExpiry,
    this.menuItemsCount = 0,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      role: UserRole.values.firstWhere(
        (e) => e.name == json['role'],
        orElse: () => UserRole.customer,
      ),
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      address: json['address'],
      favoriteFoods: json['favoriteFoods'] != null ? List<String>.from(json['favoriteFoods']) : null,
      isEmailVerified: json['isEmailVerified'] ?? false,
      preferences: json['preferences'],
      
      // ADD: Subscription-related fields from JSON
      subscriptionPlanId: json['subscriptionPlanId'],
      subscriptionExpiry: json['subscriptionExpiry'] != null 
          ? DateTime.parse(json['subscriptionExpiry']) 
          : null,
      menuItemsCount: json['menuItemsCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'role': role.name,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'address': address,
      'favoriteFoods': favoriteFoods,
      'isEmailVerified': isEmailVerified,
      'preferences': preferences,
      
      // ADD: Subscription-related fields to JSON
      'subscriptionPlanId': subscriptionPlanId,
      'subscriptionExpiry': subscriptionExpiry?.toIso8601String(),
      'menuItemsCount': menuItemsCount,
    };
  }

  bool get isAdmin => role == UserRole.admin;
  bool get isCustomer => role == UserRole.customer;
  bool get isVendor => role == UserRole.vendor;
  
  // ADD: Subscription-related computed properties
  bool get hasActiveSubscription {
    if (subscriptionPlanId == null || subscriptionExpiry == null) {
      return false;
    }
    return subscriptionExpiry!.isAfter(DateTime.now());
  }

  // Note: This method requires access to subscription plan details
  // You'll need to pass the plan or have access to AppSubscriptionPlans
  bool canAddMoreMenuItems(SubscriptionPlan plan) {
    if (!hasActiveSubscription) return false;
    return menuItemsCount < plan.maxMenuItems;
  }

  // Note: This method requires access to subscription plan details
  int getRemainingMenuItems(SubscriptionPlan plan) {
    if (!hasActiveSubscription) return 0;
    return plan.maxMenuItems - menuItemsCount;
  }

  UserModel copyWith({
    String? name,
    String? phone,
    String? address,
    bool? isEmailVerified,
    Map<String, dynamic>? preferences,
    
    // ADD: Subscription-related copy parameters
    String? subscriptionPlanId,
    DateTime? subscriptionExpiry,
    int? menuItemsCount,
  }) {
    return UserModel(
      id: id,
      email: email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      role: role,
      createdAt: createdAt,
      updatedAt: updatedAt,
      address: address ?? this.address,
      favoriteFoods: favoriteFoods,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      preferences: preferences ?? this.preferences,
      
      // ADD: Subscription-related copy
      subscriptionPlanId: subscriptionPlanId ?? this.subscriptionPlanId,
      subscriptionExpiry: subscriptionExpiry ?? this.subscriptionExpiry,
      menuItemsCount: menuItemsCount ?? this.menuItemsCount,
    );
  }
}

enum UserRole {
  customer('customer'),
  admin('admin'),
  vendor('vendor');

  const UserRole(this.name);
  final String name;
}

// ADD: You'll also need the SubscriptionPlan model
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

// ADD: Subscription plans collection
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
