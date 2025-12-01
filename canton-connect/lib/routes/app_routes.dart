// lib/routes/app_routes.dart

class AppRoutes {
  // ============ AUTH ROUTES ============
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String verifyEmail = '/verify-email';

  // ============ MAIN APP ROUTES ============
  static const String splash = '/splash';
  static const String home = '/';
  static const String menu = '/menu';
  static const String order = '/order';
  static const String profile = '/profile';
  static const String foodDetail = '/food-detail';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String subscription = '/subscription';
  static const String search = '/search';
  static const String healthConcepts = '/health-concepts';
  static const String addresses = '/addresses';
  static const String addAddress = '/add-address';
  static const String editAddress = '/edit-address';
  static const String orderHistory = '/order-history';
  static const String orderDetails = '/order-details';
  static const String paymentMethods = '/payment-methods';
  static const String addPaymentMethod = '/add-payment-method';

  // ============ ADMIN ROUTES ============
  static const String adminSplash = '/admin';
  static const String adminLogin = '/admin/login';
  static const String adminRegister = '/admin/register';
  static const String adminDashboard = '/admin/dashboard';
  static const String adminFoodList = '/admin/food-list';
  static const String adminAddFood = '/admin/add-food';
  static const String adminEditFood = '/admin/edit-food';
  static const String adminCategories = '/admin/categories';
  static const String adminSubcategories = '/admin/subcategories';
  static const String adminOrders = '/admin/orders';
  static const String adminOrderDetails = '/admin/order-details';
  static const String adminUsers = '/admin/users';
  static const String adminUserDetails = '/admin/user-details';
  static const String adminDiscounts = '/admin/discounts';
  static const String adminAnalytics = '/admin/analytics';
  static const String adminSettings = '/admin/settings';
  static const String adminSubscriptionPlans = '/admin/subscription-plans';
  static const String adminAddSubscriptionPlan = '/admin/add-subscription-plan';

  // ============ ROUTE PATHS FOR DEEP LINKING ============
  static const Map<String, String> paths = {
    // Auth
    login: 'login',
    register: 'register',
    forgotPassword: 'forgot-password',
    resetPassword: 'reset-password',
    verifyEmail: 'verify-email',
    
    // Main App
    splash: 'splash',
    home: 'home',
    menu: 'menu',
    order: 'order',
    profile: 'profile',
    foodDetail: 'food',
    cart: 'cart',
    checkout: 'checkout',
    subscription: 'subscription',
    search: 'search',
    healthConcepts: 'health-concepts',
    addresses: 'addresses',
    addAddress: 'add-address',
    editAddress: 'edit-address',
    orderHistory: 'order-history',
    orderDetails: 'order-details',
    paymentMethods: 'payment-methods',
    addPaymentMethod: 'add-payment-method',
    
    // Admin
    adminSplash: 'admin',
    adminLogin: 'admin/login',
    adminRegister: 'admin/register',
    adminDashboard: 'admin/dashboard',
    adminFoodList: 'admin/food-list',
    adminAddFood: 'admin/add-food',
    adminEditFood: 'admin/edit-food',
    adminCategories: 'admin/categories',
    adminSubcategories: 'admin/subcategories',
    adminOrders: 'admin/orders',
    adminOrderDetails: 'admin/order-details',
    adminUsers: 'admin/users',
    adminUserDetails: 'admin/user-details',
    adminDiscounts: 'admin/discounts',
    adminAnalytics: 'admin/analytics',
    adminSettings: 'admin/settings',
    adminSubscriptionPlans: 'admin/subscription-plans',
    adminAddSubscriptionPlan: 'admin/add-subscription-plan',
  };

  // ============ UTILITY METHODS ============

  /// Get route name from path
  static String getRouteFromPath(String path) {
    return paths.entries.firstWhere(
      (entry) => entry.value == path,
      orElse: () => const MapEntry(home, 'home'),
    ).key;
  }

  /// Check if route requires authentication
  static bool requiresAuth(String route) {
    final authRequiredRoutes = [
      // Main app auth-required routes
      order,
      profile,
      cart,
      checkout,
      subscription,
      addresses,
      addAddress,
      editAddress,
      orderHistory,
      orderDetails,
      paymentMethods,
      addPaymentMethod,
      
      // All admin routes except login/register
      adminDashboard,
      adminFoodList,
      adminAddFood,
      adminEditFood,
      adminCategories,
      adminSubcategories,
      adminOrders,
      adminOrderDetails,
      adminUsers,
      adminUserDetails,
      adminDiscounts,
      adminAnalytics,
      adminSettings,
      adminSubscriptionPlans,
      adminAddSubscriptionPlan,
    ];
    
    return authRequiredRoutes.contains(route);
  }

  /// Check if route requires admin authentication
  static bool requiresAdminAuth(String route) {
    final adminRoutes = [
      adminDashboard,
      adminFoodList,
      adminAddFood,
      adminEditFood,
      adminCategories,
      adminSubcategories,
      adminOrders,
      adminOrderDetails,
      adminUsers,
      adminUserDetails,
      adminDiscounts,
      adminAnalytics,
      adminSettings,
      adminSubscriptionPlans,
      adminAddSubscriptionPlan,
    ];
    
    return adminRoutes.contains(route);
  }

  /// Check if route is a main tab
  static bool isMainTab(String route) {
    return [
      home,
      menu,
      healthConcepts,
      order,
      profile,
    ].contains(route);
  }

  /// Check if route is an admin route
  static bool isAdminRoute(String route) {
    return route.startsWith('/admin');
  }

  /// Get tab index from route
  static int getTabIndex(String route) {
    switch (route) {
      case home:
        return 0;
      case menu:
        return 1;
      case healthConcepts:
        return 2;
      case order:
        return 3;
      case profile:
        return 4;
      default:
        return 0;
    }
  }

  /// Get route from tab index
  static String getRouteFromIndex(int index) {
    switch (index) {
      case 0:
        return home;
      case 1:
        return menu;
      case 2:
        return healthConcepts;
      case 3:
        return order;
      case 4:
        return profile;
      default:
        return home;
    }
  }

  /// Get admin route display name
  static String getAdminRouteDisplayName(String route, {String language = 'en'}) {
    final isChinese = language == 'zh';
    
    switch (route) {
      case adminDashboard:
        return isChinese ? '管理员面板' : 'Admin Dashboard';
      case adminFoodList:
        return isChinese ? '菜品管理' : 'Food Management';
      case adminAddFood:
        return isChinese ? '添加菜品' : 'Add Food Item';
      case adminEditFood:
        return isChinese ? '编辑菜品' : 'Edit Food Item';
      case adminCategories:
        return isChinese ? '分类管理' : 'Categories';
      case adminSubcategories:
        return isChinese ? '子分类管理' : 'Subcategories';
      case adminOrders:
        return isChinese ? '订单管理' : 'Orders';
      case adminOrderDetails:
        return isChinese ? '订单详情' : 'Order Details';
      case adminUsers:
        return isChinese ? '用户管理' : 'Users';
      case adminUserDetails:
        return isChinese ? '用户详情' : 'User Details';
      case adminDiscounts:
        return isChinese ? '折扣管理' : 'Discounts';
      case adminAnalytics:
        return isChinese ? '数据分析' : 'Analytics';
      case adminSettings:
        return isChinese ? '设置' : 'Settings';
      case adminSubscriptionPlans:
        return isChinese ? '订阅计划' : 'Subscription Plans';
      case adminAddSubscriptionPlan:
        return isChinese ? '添加订阅计划' : 'Add Subscription Plan';
      default:
        return isChinese ? '管理员' : 'Admin';
    }
  }

  /// Get route parameters (for routes that require parameters)
  static Map<String, String> getRouteParameters(String route) {
    switch (route) {
      case adminEditFood:
        return {'foodId': ''}; // Requires foodId parameter
      case foodDetail:
        return {'foodId': ''}; // Requires foodId parameter
      case editAddress:
        return {'addressId': ''}; // Requires addressId parameter
      case orderDetails:
        return {'orderId': ''}; // Requires orderId parameter
      case adminOrderDetails:
        return {'orderId': ''}; // Requires orderId parameter
      case adminUserDetails:
        return {'userId': ''}; // Requires userId parameter
      case resetPassword:
        return {'token': ''}; // Requires reset token
      default:
        return {};
    }
  }

  /// Check if route has parameters
  static bool hasParameters(String route) {
    return getRouteParameters(route).isNotEmpty;
  }

  /// Validate route parameters
  static bool validateParameters(String route, Map<String, dynamic> parameters) {
    final requiredParams = getRouteParameters(route);
    
    for (final param in requiredParams.keys) {
      if (!parameters.containsKey(param) || parameters[param] == null) {
        return false;
      }
    }
    
    return true;
  }

  /// Get parameterized route
  static String getParameterizedRoute(String route, Map<String, dynamic> parameters) {
    var result = route;
    
    for (final param in parameters.keys) {
      result = result.replaceFirst(':$param', parameters[param]?.toString() ?? '');
    }
    
    return result;
  }

  // ============ ROUTE COLLECTIONS ============

  /// Get main app routes (non-admin)
  static List<String> get mainAppRoutes => [
    splash,
    home,
    menu,
    order,
    profile,
    foodDetail,
    cart,
    checkout,
    subscription,
    search,
    login,
    register,
    forgotPassword,
    resetPassword,
    verifyEmail,
    healthConcepts,
    addresses,
    addAddress,
    editAddress,
    orderHistory,
    orderDetails,
    paymentMethods,
    addPaymentMethod,
  ];

  /// Get auth routes
  static List<String> get authRoutes => [
    login,
    register,
    forgotPassword,
    resetPassword,
    verifyEmail,
  ];

  /// Get admin routes
  static List<String> get adminRoutes => [
    adminSplash,
    adminLogin,
    adminRegister,
    adminDashboard,
    adminFoodList,
    adminAddFood,
    adminEditFood,
    adminCategories,
    adminSubcategories,
    adminOrders,
    adminOrderDetails,
    adminUsers,
    adminUserDetails,
    adminDiscounts,
    adminAnalytics,
    adminSettings,
    adminSubscriptionPlans,
    adminAddSubscriptionPlan,
  ];

  /// Get all routes
  static List<String> get allRoutes => [...mainAppRoutes, ...adminRoutes];

  /// Check if route exists
  static bool routeExists(String route) {
    return allRoutes.contains(route);
  }

  /// Get route category
  static String getRouteCategory(String route) {
    if (isAdminRoute(route)) {
      return 'admin';
    } else if (isMainTab(route)) {
      return 'main';
    } else if (authRoutes.contains(route)) {
      return 'auth';
    } else {
      return 'other';
    }
  }

  /// Check if route is public (no auth required)
  static bool isPublicRoute(String route) {
    return !requiresAuth(route);
  }

  /// Get redirect route based on authentication status
  static String getRedirectRoute(bool isAuthenticated, bool isAdmin, String currentRoute) {
    // If trying to access auth routes while authenticated
    if (isAuthenticated && authRoutes.contains(currentRoute)) {
      return home;
    }
    
    // If trying to access admin routes without admin privileges
    if (isAuthenticated && requiresAdminAuth(currentRoute) && !isAdmin) {
      return home;
    }
    
    // If trying to access protected routes without authentication
    if (!isAuthenticated && requiresAuth(currentRoute)) {
      return login;
    }
    
    // Default: allow the route
    return currentRoute;
  }
}

