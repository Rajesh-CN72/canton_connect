import 'package:flutter/material.dart';

class SubscriptionPlan {
  final String id;
  final String name;
  final double price;
  final String period;
  final String description;
  final List<String> features;
  final bool isPopular;
  final String category;
  final IconData icon;
  final Color color;
  final int maxMenuItems;
  
  // New meal selection properties
  final int mealsPerWeek;
  final List<String> availableMealTypes;
  final List<String> dietaryOptions;
  final int selectionDeadlineHours;
  final bool allowCustomization;
  final List<String> availableDeliveryDays;
  final List<String> availableTimeSlots;

  const SubscriptionPlan({
    required this.id,
    required this.name,
    required this.price,
    required this.period,
    required this.description,
    required this.features,
    required this.isPopular,
    required this.category, 
    required this.icon,
    required this.color,
    required this.maxMenuItems,
    
    // New parameters with default values
    this.mealsPerWeek = 5,
    this.availableMealTypes = const ['lunch', 'dinner'],
    this.dietaryOptions = const ['regular', 'vegetarian'],
    this.selectionDeadlineHours = 48,
    this.allowCustomization = true,
    this.availableDeliveryDays = const ['monday', 'tuesday', 'wednesday', 'thursday', 'friday'],
    this.availableTimeSlots = const ['11:00-13:00', '17:00-19:00'],
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'period': period,
      'description': description,
      'features': features,
      'isPopular': isPopular,
      'category': category,
      'maxMenuItems': maxMenuItems,
      'mealsPerWeek': mealsPerWeek,
      'availableMealTypes': availableMealTypes,
      'dietaryOptions': dietaryOptions,
      'selectionDeadlineHours': selectionDeadlineHours,
      'allowCustomization': allowCustomization,
      'availableDeliveryDays': availableDeliveryDays,
      'availableTimeSlots': availableTimeSlots,
    };
  }

  // Helper method to get display name for meal types
  String getMealTypeDisplayName(String mealType, String language) {
    final displayNames = {
      'lunch': {'en': 'Lunch', 'zh': '午餐'},
      'dinner': {'en': 'Dinner', 'zh': '晚餐'},
      'both': {'en': 'Lunch & Dinner', 'zh': '午餐和晚餐'},
    };
    return displayNames[mealType]?[language] ?? mealType;
  }

  // Helper method to get display name for dietary options
  String getDietaryOptionDisplayName(String option, String language) {
    final displayNames = {
      'regular': {'en': 'Regular', 'zh': '常规'},
      'vegetarian': {'en': 'Vegetarian', 'zh': '素食'},
      'vegan': {'en': 'Vegan', 'zh': '纯素'},
      'low_carb': {'en': 'Low Carb', 'zh': '低碳水'},
      'gluten_free': {'en': 'Gluten Free', 'zh': '无麸质'},
      'keto': {'en': 'Keto', 'zh': '生酮'},
    };
    return displayNames[option]?[language] ?? option;
  }

  // Helper method to check if plan supports a specific dietary option
  bool supportsDietaryOption(String option) {
    return dietaryOptions.contains(option);
  }

  // Helper method to check if plan supports a specific meal type
  bool supportsMealType(String mealType) {
    return availableMealTypes.contains(mealType);
  }

  // Helper method to get available days as display names
  List<String> getAvailableDeliveryDaysDisplay(String language) {
    final dayNames = {
      'monday': {'en': 'Monday', 'zh': '星期一'},
      'tuesday': {'en': 'Tuesday', 'zh': '星期二'},
      'wednesday': {'en': 'Wednesday', 'zh': '星期三'},
      'thursday': {'en': 'Thursday', 'zh': '星期四'},
      'friday': {'en': 'Friday', 'zh': '星期五'},
      'saturday': {'en': 'Saturday', 'zh': '星期六'},
      'sunday': {'en': 'Sunday', 'zh': '星期日'},
    };
    
    return availableDeliveryDays.map((day) => dayNames[day]?[language] ?? day).toList();
  }
}

class SubscriptionContentPlanner {
  static List<SubscriptionPlan> getPlans(String language) {
    final isChinese = language == 'zh';
    
    return [
      SubscriptionPlan(
        id: 'career_starter',
        name: isChinese ? '职场新人套餐' : 'Career Starter',
        price: 108.00,
        period: isChinese ? '/周' : '/week',
        description: isChinese ? '每周3餐，适合忙碌的职场新人' : '3 meals per week - perfect for busy young professionals',
        features: isChinese ? [
          '灵活配送日期',
          '中西餐结合',
          '经济实惠',
          '15分钟快速加热',
        ] : [
          'Flexible delivery days',
          'Mix of Chinese and Western options',
          'Budget-friendly',
          'Quick 15-min heat-up meals',
        ],
        isPopular: false, 
        category: 'young_professionals',
        icon: Icons.work_outline,
        color: Colors.blue,
        maxMenuItems: 10,
        mealsPerWeek: 3,
        availableMealTypes: ['lunch', 'dinner'],
        dietaryOptions: ['regular', 'vegetarian'],
        selectionDeadlineHours: 48,
        allowCustomization: true,
        availableDeliveryDays: ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'],
        availableTimeSlots: ['11:00-13:00', '17:00-19:00', '18:00-20:00'],
      ),
      SubscriptionPlan(
        id: 'office_power',
        name: isChinese ? '办公能量午餐' : 'Office Power Lunch',
        price: 168.00,
        period: isChinese ? '/周' : '/week',
        description: isChinese ? '每周5份健康午餐，直接配送到办公室' : '5 healthy lunch meals per week, delivered to your office',
        features: isChinese ? [
          '周一至周五配送',
          '办公室友好包装',
          '45分钟配送窗口',
          '天河/珠江新城免费配送',
          '营养信息包含',
        ] : [
          'Monday to Friday delivery',
          'Office-friendly packaging', 
          '45-minute delivery window',
          'Free office delivery in Tianhe/Zhujiang',
          'Nutritional information included',
        ],
        isPopular: true, 
        category: 'young_professionals',
        icon: Icons.business_center,
        color: Colors.green,
        maxMenuItems: 20,
        mealsPerWeek: 5,
        availableMealTypes: ['lunch'],
        dietaryOptions: ['regular', 'vegetarian', 'low_carb'],
        selectionDeadlineHours: 24,
        allowCustomization: false,
        availableDeliveryDays: ['monday', 'tuesday', 'wednesday', 'thursday', 'friday'],
        availableTimeSlots: ['11:00-12:00', '12:00-13:00'],
      ),
      SubscriptionPlan(
        id: 'nutritionist_designed',
        name: isChinese ? '营养师定制套餐' : 'Nutritionist Designed',
        price: 258.00,
        period: isChinese ? '/周' : '/week',
        description: isChinese ? '专业营养师设计的科学均衡餐食' : 'Scientifically balanced meals designed by certified nutritionists',
        features: isChinese ? [
          '热量控制 (400-500 大卡)',
          '宏量营养素均衡',
          '低钠低糖',
          '每周营养报告',
          '有机食材优先',
        ] : [
          'Calorie-controlled (400-500 kcal)',
          'Macro-balanced',
          'Low sodium & sugar',
          'Weekly nutrition report',
          'Organic ingredients focus',
        ],
        isPopular: true, 
        category: 'health',
        icon: Icons.monitor_heart,
        color: Colors.purple,
        maxMenuItems: 30,
        mealsPerWeek: 7,
        availableMealTypes: ['lunch', 'dinner'],
        dietaryOptions: ['regular', 'vegetarian', 'vegan', 'low_carb', 'gluten_free'],
        selectionDeadlineHours: 72,
        allowCustomization: true,
        availableDeliveryDays: ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'],
        availableTimeSlots: ['10:00-12:00', '12:00-14:00', '17:00-19:00', '19:00-21:00'],
      ),
      SubscriptionPlan(
        id: 'family_feast',
        name: isChinese ? '家庭盛宴套餐' : 'Family Feast',
        price: 388.00,
        period: isChinese ? '/周' : '/week',
        description: isChinese ? '每周4次，适合2-3人的完整晚餐' : 'Complete dinners for 2-3 people, 4 times per week',
        features: isChinese ? [
          '2道主菜 + 1汤 + 米饭',
          '家庭式分量',
          '儿童友好选项',
          '传统粤式食谱',
          '周末免费配送',
        ] : [
          '2 main dishes + 1 soup + rice',
          'Family-style portions',
          'Child-friendly options available',
          'Traditional Cantonese recipes',
          'Free weekend delivery',
        ],
        isPopular: true, 
        category: 'family',
        icon: Icons.family_restroom,
        color: Colors.red,
        maxMenuItems: 25,
        mealsPerWeek: 4,
        availableMealTypes: ['dinner'],
        dietaryOptions: ['regular', 'vegetarian', 'child_friendly'],
        selectionDeadlineHours: 48,
        allowCustomization: true,
        availableDeliveryDays: ['monday', 'wednesday', 'friday', 'saturday', 'sunday'],
        availableTimeSlots: ['17:00-19:00', '18:00-20:00'],
      ),
      SubscriptionPlan(
        id: 'guangzhou_wellness',
        name: isChinese ? '广州养生套餐' : 'Guangzhou Wellness',
        price: 228.00,
        period: isChinese ? '/周' : '/week',
        description: isChinese ? '传统粤式养生食材结合现代营养学' : 'Traditional Cantonese health foods with modern nutrition',
        features: isChinese ? [
          '养生煲汤',
          '时令食材',
          '中医养生原理',
          '低油高纤维',
          '地道广州风味',
        ] : [
          'Herbal soups (煲汤)',
          'Seasonal ingredients',
          'TCM principles',
          'Low oil, high fiber',
          'Local Guangzhou flavors',
        ],
        isPopular: false, 
        category: 'health',
        icon: Icons.spa,
        color: Colors.teal,
        maxMenuItems: 15,
        mealsPerWeek: 5,
        availableMealTypes: ['lunch', 'dinner'],
        dietaryOptions: ['regular', 'vegetarian', 'tcm_wellness'],
        selectionDeadlineHours: 72,
        allowCustomization: false,
        availableDeliveryDays: ['monday', 'tuesday', 'wednesday', 'thursday', 'friday'],
        availableTimeSlots: ['11:00-13:00', '17:00-19:00'],
      ),
      SubscriptionPlan(
        id: 'weekend_family',
        name: isChinese ? '周末家庭套餐' : 'Weekend Family',
        price: 198.00,
        period: isChinese ? '/周' : '/week',
        description: isChinese ? '专为周末设计的全家共享餐食' : 'Special weekend meals for the whole family',
        features: isChinese ? [
          '仅周六日配送',
          '共享大分量',
          '周末特色菜品',
          '家庭活动食谱卡',
        ] : [
          'Saturday & Sunday delivery only',
          'Larger portions for sharing',
          'Special weekend dishes',
          'Family activity recipe cards included',
        ],
        isPopular: false, 
        category: 'family',
        icon: Icons.weekend,
        color: Colors.orange,
        maxMenuItems: 10,
        mealsPerWeek: 2,
        availableMealTypes: ['lunch', 'dinner'],
        dietaryOptions: ['regular', 'vegetarian', 'child_friendly'],
        selectionDeadlineHours: 96,
        allowCustomization: true,
        availableDeliveryDays: ['saturday', 'sunday'],
        availableTimeSlots: ['10:00-12:00', '12:00-14:00', '17:00-19:00'],
      ),
    ];
  }

  static Map<String, String> getMetadata(String language) {
    final isChinese = language == 'zh';
    
    return {
      'title': isChinese ? '订阅套餐' : 'Subscription Plans',
      'subtitle': isChinese ? '选择适合您生活方式的套餐' : 'Choose the plan that fits your lifestyle',
      'cta': isChinese ? '立即订阅' : 'Subscribe Now',
      'popularBadge': isChinese ? '最受欢迎' : 'Most Popular',
    };
  }

  static List<SubscriptionPlan> getPlansByCategory(String category, String language) {
    return getPlans(language).where((plan) => plan.category == category).toList();
  }

  static List<SubscriptionPlan> getPopularPlans(String language) {
    return getPlans(language).where((plan) => plan.isPopular).toList();
  }

  static SubscriptionPlan? getPlanById(String id, String language) {
    try {
      return getPlans(language).firstWhere((plan) => plan.id == id);
    } catch (e) {
      return null;
    }
  }

  static List<SubscriptionPlan> getPlansByDietaryOption(String dietaryOption, String language) {
    return getPlans(language).where((plan) => plan.supportsDietaryOption(dietaryOption)).toList();
  }

  static List<SubscriptionPlan> getPlansByMealType(String mealType, String language) {
    return getPlans(language).where((plan) => plan.supportsMealType(mealType)).toList();
  }
}

class VendorSubscriptionPlans {
  static const List<SubscriptionPlan> vendorPlans = [
    SubscriptionPlan(
      id: 'vendor_basic',
      name: 'Basic Vendor',
      price: 9.99,
      period: '/month',
      description: 'Perfect for home cooks starting out',
      features: [
        'Up to 5 menu items',
        'Basic analytics',
        'Customer reviews',
      ],
      isPopular: false,
      category: 'vendor',
      icon: Icons.restaurant_menu,
      color: Colors.blue,
      maxMenuItems: 5,
      mealsPerWeek: 0,
    ),
    SubscriptionPlan(
      id: 'vendor_professional',
      name: 'Professional Vendor',
      price: 19.99,
      period: '/month',
      description: 'For serious home cooks',
      features: [
        'Up to 20 menu items',
        'Advanced analytics',
        'Priority listing',
        'Custom branding',
      ],
      isPopular: true,
      category: 'vendor',
      icon: Icons.star,
      color: Colors.green,
      maxMenuItems: 20,
      mealsPerWeek: 0,
    ),
    SubscriptionPlan(
      id: 'vendor_enterprise',
      name: 'Enterprise Vendor',
      price: 39.99,
      period: '/month',
      description: 'For established food businesses',
      features: [
        'Up to 100 menu items',
        'Full analytics suite',
        'Featured placement',
        'Dedicated support',
        'Custom domain',
      ],
      isPopular: false,
      category: 'vendor',
      icon: Icons.diamond,
      color: Colors.purple,
      maxMenuItems: 100,
      mealsPerWeek: 0,
    ),
  ];

  static SubscriptionPlan getVendorPlanById(String id) {
    return vendorPlans.firstWhere((plan) => plan.id == id);
  }
}
