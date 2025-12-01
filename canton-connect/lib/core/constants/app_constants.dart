// ==============================
// PRICE DISPLAY STYLE ENUM (MOVED OUTSIDE CLASS)
// ==============================
enum PriceDisplayStyle {
  symbolOnly,      // ¥25.99
  yuanOnly,        // 25.99元
  symbolWithCode,  // ¥25.99 CNY
  yuanWithName,    // 25.99元 人民币
  compactSymbol,   // ¥26
  compactYuan,     // 26元
}

class AppConstants {
  // ==============================
  // 1. APP INFO
  // ==============================
  static const String appNameEn = 'Canton Connect';
  static const String appNameZh = '粤味通';
  static const String sloganEn = 'Taste the Fusion, Feel the Connection';
  static const String sloganZh = '融合美味，连接心意';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';

  // ==============================
  // 2. SUPABASE CONFIGURATION (UPDATED)
  // ==============================
  static const String supabaseUrl = 'https://ezhocoqzatvuyefjiykr.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV6aG9jb3F6YXR2dXllZmppeWtyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQwNTI2OTAsImV4cCI6MjA3OTYyODY5MH0.zgSfsTZwIZbWT3ejD0mEh4DCvRtrsXdt3TJWcp9scKk';

  // ==============================
  // 3. DESIGN CONSTANTS
  // ==============================
  static const double defaultPadding = 16.0;
  static const double defaultMargin = 16.0;
  static const double defaultBorderRadius = 12.0;
  static const double cardBorderRadius = 8.0;
  static const double buttonBorderRadius = 25.0;
  static const double appBarHeight = 64.0;
  static const double bottomNavBarHeight = 70.0;

  // ==============================
  // 4. COLOR REFERENCES (Use AppColors instead)
  // ==============================
  static const int primaryColorValue = 0xFF27AE60;
  static const int secondaryColorValue = 0xFFFF6B35;
  static const int accentColorValue = 0xFF2C3E50;
  static const int backgroundColorValue = 0xFFF8F9FA;
  static const int whiteColorValue = 0xFFFFFFFF;

  // ==============================
  // 5. ANIMATION DURATIONS
  // ==============================
  static const Duration pageTransitionDuration = Duration(milliseconds: 300);
  static const Duration buttonAnimationDuration = Duration(milliseconds: 200);
  static const Duration hoverAnimationDuration = Duration(milliseconds: 150);
  static const Duration loadingAnimationDuration = Duration(milliseconds: 1000);
  static const Duration snackbarDuration = Duration(seconds: 3);
  static const Duration tooltipDuration = Duration(milliseconds: 1500);

  // ==============================
  // 6. RESPONSIVE BREAKPOINTS
  // ==============================
  static const double mobileBreakpoint = 809.0;
  static const double tabletBreakpoint = 810.0;
  static const double desktopBreakpoint = 1200.0;
  static const double largeDesktopBreakpoint = 1440.0;

  // ==============================
  // 7. SUPPORTED LANGUAGES
  // ==============================
  static const List<AppLanguage> supportedLanguages = [
    AppLanguage(
      code: 'en',
      name: 'English',
      nativeName: 'English',
      locale: 'en_US',
    ),
    AppLanguage(
      code: 'zh',
      name: 'Chinese',
      nativeName: '中文',
      locale: 'zh_CN',
    ),
  ];

  // ==============================
  // 8. ASSET PATHS
  // ==============================
  static const String logoWhitePath = 'assets/images/logo_white.png';
  static const String logoPath = 'assets/images/logo.png';
  static const String faviconPath = 'assets/images/favicon.png';
  static const String icon192Path = 'assets/icons/icon-192.png';
  static const String icon512Path = 'assets/icons/icon-512.png';

  // ==============================
  // 9. FONT FAMILIES
  // ==============================
  static const String primaryFont = 'Poppins';
  static const String secondaryFont = 'NotoSansSC';

  // ==============================
  // 10. API & NETWORK CONSTANTS
  // ==============================
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
  static const int sendTimeout = 30000;

  // ==============================
  // 11. STORAGE KEYS
  // ==============================
  static const String themeKey = 'app_theme';
  static const String languageKey = 'app_language';
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';
  static const String cartDataKey = 'cart_data';

  // ==============================
  // 12. FOOD & ORDER CONSTANTS
  // ==============================
  static const double minimumOrderAmount = 15.00;
  static const double deliveryFee = 2.99;
  static const double taxRate = 0.08; // 8% tax
  static const int maxQuantityPerItem = 99;
  static const int estimatedPreparationTime = 30; // minutes

  // ==============================
  // 13. CURRENCY CONSTANTS (RMB/CNY)
  // ==============================
  static const String currencySymbol = '¥';
  static const String currencySymbolChinese = '元';
  static const String currencyCode = 'CNY';
  static const String currencyName = 'RMB';
  static const String currencyNameChinese = '人民币';

  // Currency formatting - ADDED NULL SAFETY
  static String formatPrice(double price) {
    return '$currencySymbol${price.toStringAsFixed(2)}';
  }

  static String formatPriceChinese(double price) {
    return '${price.toStringAsFixed(2)}$currencySymbolChinese';
  }

  static String formatPriceWithCode(double price) {
    return '${price.toStringAsFixed(2)} $currencyCode';
  }

  static String formatPriceChineseFull(double price) {
    return '$currencySymbol${price.toStringAsFixed(2)} $currencyNameChinese';
  }

  static String formatPriceCompact(double price) {
    if (price >= 1000) {
      return '$currencySymbol${(price / 1000).toStringAsFixed(1)}K';
    }
    return '$currencySymbol${price.toStringAsFixed(0)}';
  }

  static String formatPriceCompactChinese(double price) {
    if (price >= 1000) {
      return '${(price / 1000).toStringAsFixed(1)}K$currencySymbolChinese';
    }
    return '${price.toStringAsFixed(0)}$currencySymbolChinese';
  }

  // Price display styles - FIXED FUNCTION (NO DEFAULT CASE)
  static String formatPriceWithStyle(double price, PriceDisplayStyle style) {
    switch (style) {
      case PriceDisplayStyle.symbolOnly:
        return formatPrice(price);
      case PriceDisplayStyle.yuanOnly:
        return formatPriceChinese(price);
      case PriceDisplayStyle.symbolWithCode:
        return '${formatPrice(price)} $currencyCode';
      case PriceDisplayStyle.yuanWithName:
        return '${formatPriceChinese(price)} $currencyNameChinese';
      case PriceDisplayStyle.compactSymbol:
        return formatPriceCompact(price);
      case PriceDisplayStyle.compactYuan:
        return formatPriceCompactChinese(price);
    }
  }

  // ==============================
  // 14. QUANTITY CONSTANTS
  // ==============================
  static const String quantityAbbreviation = 'Qty';
  static const String quantityAbbreviationChinese = '数量';
  static const String quantityFull = 'Quantity';
  static const String quantityFullChinese = '数量';
  
  // Quantity validation messages
  static const String quantityRequiredMessage = 'Quantity is required';
  static const String quantityMinMessage = 'Minimum quantity is 1';
  static const String quantityMaxMessage = 'Maximum quantity is $maxQuantityPerItem';
  static const String quantityInvalidMessage = 'Please enter a valid quantity';

  // ==============================
  // 15. ORDER STATUS CONSTANTS
  // ==============================
  static const Map<String, String> orderStatusMessages = {
    'pending': 'Order Pending',
    'confirmed': 'Order Confirmed',
    'preparing': 'Preparing Your Food',
    'ready': 'Ready for Pickup',
    'onTheWay': 'On the Way',
    'delivered': 'Delivered',
    'cancelled': 'Cancelled',
  };

  static const Map<String, String> orderStatusMessagesChinese = {
    'pending': '订单待处理',
    'confirmed': '订单已确认',
    'preparing': '正在准备您的食物',
    'ready': '准备取餐',
    'onTheWay': '配送中',
    'delivered': '已送达',
    'cancelled': '已取消',
  };

  // ==============================
  // 16. DELIVERY CONSTANTS
  // ==============================
  static const double freeDeliveryThreshold = 50.00;
  static const int standardDeliveryTime = 45; // minutes
  static const int expressDeliveryTime = 25; // minutes
  static const double expressDeliveryFee = 5.99;

  // ==============================
  // 17. CART & CHECKOUT CONSTANTS
  // ==============================
  static const int maxCartItems = 20;
  static const double serviceFee = 1.50;
  static const double packagingFee = 0.50;
  
  // Tip options (percentage)
  static const List<double> tipOptions = [0, 10, 15, 20, 25];
  static const double defaultTipPercentage = 15.0;

  // ==============================
  // 18. TIME CONSTANTS
  // ==============================
  static const int orderExpiryTime = 15; // minutes to complete order
  static const int orderHistoryDays = 30; // days to show in order history
  static const int cancellationTimeLimit = 5; // minutes to cancel after ordering

  // ==============================
  // 19. NOTIFICATION CONSTANTS
  // ==============================
  static const int orderReminderTime = 10; // minutes before estimated delivery
  static const int reviewReminderTime = 60; // minutes after delivery to ask for review

  // ==============================
  // 20. LOYALTY & REWARDS
  // ==============================
  static const int pointsPerYuan = 1; // 1 point per 1 RMB spent
  static const int pointsForFreeDelivery = 100;
  static const int pointsForDiscount = 500;
  static const double discountPerPoints = 5.00; // 5 RMB discount per 500 points

  // ==============================
  // 21. SEARCH & FILTER CONSTANTS
  // ==============================
  static const int searchDebounceTime = 500; // milliseconds
  static const int minSearchCharacters = 2;
  static const int maxSearchResults = 50;

  // ==============================
  // 22. HELPER METHODS FOR UI
  // ==============================
  
  // Helper method to get style name for UI
  static String getStyleName(PriceDisplayStyle style) {
    switch (style) {
      case PriceDisplayStyle.symbolOnly:
        return '¥ Symbol';
      case PriceDisplayStyle.yuanOnly:
        return '元 Symbol';
      case PriceDisplayStyle.symbolWithCode:
        return '¥ with CNY';
      case PriceDisplayStyle.yuanWithName:
        return '元 with 人民币';
      case PriceDisplayStyle.compactSymbol:
        return 'Compact ¥';
      case PriceDisplayStyle.compactYuan:
        return 'Compact 元';
    }
  }

  // Helper method to get style name in Chinese
  static String getStyleNameChinese(PriceDisplayStyle style) {
    switch (style) {
      case PriceDisplayStyle.symbolOnly:
        return '¥ 符号';
      case PriceDisplayStyle.yuanOnly:
        return '元 符号';
      case PriceDisplayStyle.symbolWithCode:
        return '¥ 带 CNY';
      case PriceDisplayStyle.yuanWithName:
        return '元 带 人民币';
      case PriceDisplayStyle.compactSymbol:
        return '简洁 ¥';
      case PriceDisplayStyle.compactYuan:
        return '简洁 元';
    }
  }

  // Get all available styles
  static List<PriceDisplayStyle> get allStyles => PriceDisplayStyle.values;
}

class AppLanguage {
  final String code;
  final String name;
  final String nativeName;
  final String locale;

  const AppLanguage({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.locale,
  });
}

// Extension for responsive breakpoints
enum ScreenSize {
  mobile,    // 0 - 809px
  tablet,    // 810 - 1199px
  desktop,   // 1200px+
}

extension ScreenSizeExtension on ScreenSize {
  static ScreenSize getScreenSize(double width) {
    if (width < AppConstants.mobileBreakpoint) {
      return ScreenSize.mobile;
    } else if (width < AppConstants.desktopBreakpoint) {
      return ScreenSize.tablet;
    } else {
      return ScreenSize.desktop;
    }
  }

  bool get isMobile => this == ScreenSize.mobile;
  bool get isTablet => this == ScreenSize.tablet;
  bool get isDesktop => this == ScreenSize.desktop;
}

// Currency formatting extension for easier use
extension PriceFormatting on double {
  // ¥ format
  String get toRMB => AppConstants.formatPrice(this);
  String get toRMBWithCode => AppConstants.formatPriceWithCode(this);
  String get toRMBCompact => AppConstants.formatPriceCompact(this);
  
  // 元 format
  String get toYuan => AppConstants.formatPriceChinese(this);
  String get toYuanFull => AppConstants.formatPriceChineseFull(this);
  String get toYuanCompact => AppConstants.formatPriceCompactChinese(this);
  
  // Style-based formatting
  String toPriceStyle(PriceDisplayStyle style) {
    return AppConstants.formatPriceWithStyle(this, style);
  }
  
  // Common combinations
  String get forProductCard => toRMB;
  String get forCart => toYuan;
  String get forReceipt => toYuanFull;
  String get forQuickView => toRMBCompact;
}

// Quantity formatting extension
extension QuantityFormatting on int {
  String get withQtyLabel => '$this ${AppConstants.quantityAbbreviation}';
  String get withQtyLabelChinese => '$this ${AppConstants.quantityAbbreviationChinese}';
  
  bool get isValidQuantity => this > 0 && this <= AppConstants.maxQuantityPerItem;
  bool get isMaxQuantity => this >= AppConstants.maxQuantityPerItem;
  bool get isMinQuantity => this <= 1;
}

// Order status helper extension
extension OrderStatusHelper on String {
  String get orderStatusMessage => AppConstants.orderStatusMessages[this] ?? 'Unknown Status';
  String get orderStatusMessageChinese => AppConstants.orderStatusMessagesChinese[this] ?? '未知状态';
}
