import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AppLocalizations {
  final Locale locale;
  
  AppLocalizations(this.locale);
  
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }
  
  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appTitle': 'CantonConnect',
      'appSlogan': 'Taste the Fusion, Feel the Connection',
      'home': 'Home',
      'menu': 'Menu',
      'subscribe': 'Subscribe',
      'healthPhilosophy': 'Health Philosophy',
      'corporateOrders': 'Corporate Orders',
      'order': 'Order',
      'delivery': 'Delivery',
      'profile': 'Profile',
      'search': 'Search',
      'cart': 'Cart',
      'login': 'Login',
      'logout': 'Logout',
      'settings': 'Settings',
      'about': 'About',
      'contact': 'Contact',
      'welcome': 'Welcome',
      'featured': 'Featured',
      'popular': 'Popular',
      'newArrival': 'New Arrival',
      'seeAll': 'See All',
      'addToCart': 'Add to Cart',
      'buyNow': 'Buy Now',
      'price': 'Price',
      'quantity': 'Quantity',
      'subtotal': 'Subtotal',
      'total': 'Total',
      'checkout': 'Checkout',
      'continueShopping': 'Continue Shopping',
      'yourCart': 'Your Cart',
      'emptyCart': 'Your cart is empty',
      'orderSummary': 'Order Summary',
      'shipping': 'Shipping',
      'tax': 'Tax',
      'discount': 'Discount',
      'apply': 'Apply',
      'promoCode': 'Promo Code',
      'payment': 'Payment',
      'shippingAddress': 'Shipping Address',
      'billingAddress': 'Billing Address',
      'confirmOrder': 'Confirm Order',
      'orderConfirmed': 'Order Confirmed',
      'thankYou': 'Thank You!',
      'trackOrder': 'Track Order',
      'orderHistory': 'Order History',
      'myAccount': 'My Account',
      'personalInfo': 'Personal Information',
      'changePassword': 'Change Password',
      'notifications': 'Notifications',
      'help': 'Help',
      'faq': 'FAQ',
      'privacyPolicy': 'Privacy Policy',
      'termsOfService': 'Terms of Service',
      'customerService': 'Customer Service',
      'feedback': 'Feedback',
      'rateApp': 'Rate App',
      'shareApp': 'Share App',
      'language': 'Language',
      'english': 'English',
      'chinese': '中文',
      'getStarted': 'Get Started',
      'viewMenu': 'View Menu',
      'subscribeNow': 'Subscribe Now',
      'learnMore': 'Learn More',
    },
    'zh': {
      'appTitle': '粤味通',
      'appSlogan': '融合美味，连接心意',
      'home': '首页',
      'menu': '菜单',
      'subscribe': '订阅',
      'healthPhilosophy': '健康理念',
      'corporateOrders': '企业订购',
      'order': '订购',
      'delivery': '配送',
      'profile': '我的',
      'search': '搜索',
      'cart': '购物车',
      'login': '登录',
      'logout': '退出',
      'settings': '设置',
      'about': '关于',
      'contact': '联系',
      'welcome': '欢迎',
      'featured': '精选',
      'popular': '热门',
      'newArrival': '新品',
      'seeAll': '查看全部',
      'addToCart': '加入购物车',
      'buyNow': '立即购买',
      'price': '价格',
      'quantity': '数量',
      'subtotal': '小计',
      'total': '总计',
      'checkout': '结算',
      'continueShopping': '继续购物',
      'yourCart': '您的购物车',
      'emptyCart': '购物车为空',
      'orderSummary': '订单摘要',
      'shipping': '运费',
      'tax': '税费',
      'discount': '折扣',
      'apply': '应用',
      'promoCode': '优惠码',
      'payment': '支付',
      'shippingAddress': '收货地址',
      'billingAddress': '账单地址',
      'confirmOrder': '确认订单',
      'orderConfirmed': '订单已确认',
      'thankYou': '谢谢！',
      'trackOrder': '跟踪订单',
      'orderHistory': '订单历史',
      'myAccount': '我的账户',
      'personalInfo': '个人信息',
      'changePassword': '修改密码',
      'notifications': '通知',
      'help': '帮助',
      'faq': '常见问题',
      'privacyPolicy': '隐私政策',
      'termsOfService': '服务条款',
      'customerService': '客户服务',
      'feedback': '反馈',
      'rateApp': '评价应用',
      'shareApp': '分享应用',
      'language': '语言',
      'english': 'English',
      'chinese': '中文',
      'getStarted': '开始使用',
      'viewMenu': '查看菜单',
      'subscribeNow': '立即订阅',
      'learnMore': '了解更多',
    },
  };
  
  String _getText(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? 
           _localizedValues['en']?[key] ?? 
           key;
  }
  
  // App info
  String get appTitle => _getText('appTitle');
  String get appSlogan => _getText('appSlogan');
  
  // Navigation
  String get home => _getText('home');
  String get menu => _getText('menu');
  String get subscribe => _getText('subscribe');
  String get healthPhilosophy => _getText('healthPhilosophy');
  String get corporateOrders => _getText('corporateOrders');
  String get order => _getText('order');
  String get delivery => _getText('delivery');
  String get profile => _getText('profile');
  
  // Common UI
  String get search => _getText('search');
  String get cart => _getText('cart');
  String get login => _getText('login');
  String get logout => _getText('logout');
  String get settings => _getText('settings');
  String get about => _getText('about');
  String get contact => _getText('contact');
  String get welcome => _getText('welcome');
  
  // Products
  String get featured => _getText('featured');
  String get popular => _getText('popular');
  String get newArrival => _getText('newArrival');
  String get seeAll => _getText('seeAll');
  String get addToCart => _getText('addToCart');
  String get buyNow => _getText('buyNow');
  String get price => _getText('price');
  String get quantity => _getText('quantity');
  
  // Cart & Checkout
  String get subtotal => _getText('subtotal');
  String get total => _getText('total');
  String get checkout => _getText('checkout');
  String get continueShopping => _getText('continueShopping');
  String get yourCart => _getText('yourCart');
  String get emptyCart => _getText('emptyCart');
  String get orderSummary => _getText('orderSummary');
  String get shipping => _getText('shipping');
  String get tax => _getText('tax');
  String get discount => _getText('discount');
  String get apply => _getText('apply');
  String get promoCode => _getText('promoCode');
  String get payment => _getText('payment');
  String get shippingAddress => _getText('shippingAddress');
  String get billingAddress => _getText('billingAddress');
  String get confirmOrder => _getText('confirmOrder');
  String get orderConfirmed => _getText('orderConfirmed');
  String get thankYou => _getText('thankYou');
  String get trackOrder => _getText('trackOrder');
  String get orderHistory => _getText('orderHistory');
  
  // Account
  String get myAccount => _getText('myAccount');
  String get personalInfo => _getText('personalInfo');
  String get changePassword => _getText('changePassword');
  String get notifications => _getText('notifications');
  
  // Support
  String get help => _getText('help');
  String get faq => _getText('faq');
  String get privacyPolicy => _getText('privacyPolicy');
  String get termsOfService => _getText('termsOfService');
  String get customerService => _getText('customerService');
  String get feedback => _getText('feedback');
  String get rateApp => _getText('rateApp');
  String get shareApp => _getText('shareApp');
  
  // Language
  String get language => _getText('language');
  String get english => _getText('english');
  String get chinese => _getText('chinese');
  
  // Additional methods
  String get getStarted => _getText('getStarted');
  String get viewMenu => _getText('viewMenu');
  String get subscribeNow => _getText('subscribeNow');
  String get learnMore => _getText('learnMore');

  // Helper method to get current language code
  String get currentLanguageCode => locale.languageCode;
  
  // Helper method to get navigation items as list
  List<String> get navigationItems {
    return [home, menu, subscribe, healthPhilosophy, corporateOrders];
  }
  
  // Helper method to get bottom nav labels as list
  List<String> get bottomNavLabels {
    return [home, menu, order, delivery, profile];
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
