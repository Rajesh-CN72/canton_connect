import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:canton_connect/core/providers/auth_provider.dart';
import 'package:canton_connect/core/providers/language_provider.dart';
import 'package:canton_connect/core/providers/currency_provider.dart';
import 'package:canton_connect/core/providers/order_provider.dart';
import 'package:canton_connect/data/services/api_service.dart';
import 'package:canton_connect/data/services/mock_notification_service.dart';
import 'package:canton_connect/core/widgets/custom_bottom_nav_bar.dart';
import 'package:canton_connect/core/widgets/custom_app_bar.dart';
import 'package:canton_connect/presentation/pages/home_page.dart';
import 'package:canton_connect/presentation/pages/menu_page.dart';
import 'package:canton_connect/presentation/pages/profile_page.dart';
import 'package:canton_connect/presentation/pages/order_page.dart';
import 'package:canton_connect/presentation/pages/health_concepts_page.dart';
import 'package:canton_connect/presentation/pages/customer/auth/login_page.dart';
import 'package:canton_connect/presentation/pages/admin/auth/admin_login_page.dart';
import 'package:canton_connect/routes/route_generator.dart';
import 'package:canton_connect/routes/app_routes.dart';
import 'package:canton_connect/presentation/pages/admin/order_management/orders_page.dart';
import 'package:canton_connect/presentation/pages/subscription_page.dart';
import 'package:canton_connect/presentation/pages/admin/subscription_management_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Add error handling for Flutter framework errors
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    // You can also log to your error reporting service here
    debugPrint('Flutter Error: ${details.exception}');
  };

  // Initialize ApiService before running the app
  await ApiService().initialize();
  
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => CurrencyProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
        Provider(create: (context) => ApiService()),
        Provider(create: (context) => MockNotificationService()),
      ],
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return MaterialApp(
            title: '广州连接',
            theme: _buildThemeData(languageProvider.currentLanguage),
            home: const AuthWrapper(),
            initialRoute: AppRoutes.home,
            onGenerateRoute: RouteGenerator.generateRoute,
            navigatorKey: NavigatorKeyHolder.navigatorKey,
            debugShowCheckedModeBanner: false,
            // Add builder to handle loading and errors
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: TextScaler.noScaling,
                ),
                child: child ?? const Scaffold(
                  body: Center(
                    child: Text('应用加载中...'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  ThemeData _buildThemeData(String currentLanguage) {
    // Determine which font to use based on language
    String defaultFontFamily = currentLanguage == 'zh' ? 'NotoSansSC' : 'Poppins';
    
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF27AE60), // Green color
        primary: const Color(0xFF27AE60),
        secondary: const Color(0xFFFF6B35), // Orange
        surface: const Color(0xFFF8F9FA), // Fixed: Replaced deprecated 'background' with 'surface'
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: defaultFontFamily,
      scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Color(0xFF2C3E50),
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFF2C3E50)),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontFamily: defaultFontFamily,
          fontWeight: FontWeight.w700,
          fontSize: 32,
          color: const Color(0xFF2C3E50),
        ),
        displayMedium: TextStyle(
          fontFamily: defaultFontFamily,
          fontWeight: FontWeight.w600,
          fontSize: 28,
          color: const Color(0xFF2C3E50),
        ),
        displaySmall: TextStyle(
          fontFamily: defaultFontFamily,
          fontWeight: FontWeight.w600,
          fontSize: 24,
          color: const Color(0xFF2C3E50),
        ),
        headlineMedium: TextStyle(
          fontFamily: defaultFontFamily,
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: const Color(0xFF2C3E50),
        ),
        headlineSmall: TextStyle(
          fontFamily: defaultFontFamily,
          fontWeight: FontWeight.w500,
          fontSize: 18,
          color: const Color(0xFF2C3E50),
        ),
        titleLarge: TextStyle(
          fontFamily: defaultFontFamily,
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: const Color(0xFF2C3E50),
        ),
        bodyLarge: TextStyle(
          fontFamily: defaultFontFamily,
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: const Color(0xFF566573),
        ),
        bodyMedium: TextStyle(
          fontFamily: defaultFontFamily,
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: const Color(0xFF566573),
        ),
        labelLarge: TextStyle(
          fontFamily: defaultFontFamily,
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: const Color(0xFF2C3E50),
        ),
      ),
      useMaterial3: true,
    );
  }
}

class NavigatorKeyHolder {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _isInitializing = true;
  bool _hasError = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      // Use WidgetsBinding to ensure this runs after the first frame
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        try {
          await Provider.of<AuthProvider>(context, listen: false).initialize();
          if (mounted) {
            setState(() {
              _isInitializing = false;
            });
          }
        } catch (error) {
          if (mounted) {
            setState(() {
              _isInitializing = false;
              _hasError = true;
              _errorMessage = error.toString();
            });
          }
        }
      });
    } catch (error) {
      if (mounted) {
        setState(() {
          _isInitializing = false;
          _hasError = true;
          _errorMessage = error.toString();
        });
      }
    }
  }

  void _retryInitialization() {
    setState(() {
      _isInitializing = true;
      _hasError = false;
      _errorMessage = null;
    });
    _initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final apiService = Provider.of<ApiService>(context, listen: false);
    
    // Show error screen if initialization failed
    if (_hasError) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                '初始化错误',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                  _errorMessage ?? '发生未知错误',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _retryInitialization,
                child: const Text('重试'),
              ),
            ],
          ),
        ),
      );
    }
    
    // Show loading while initializing
    if (_isInitializing) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Consumer<LanguageProvider>(
                builder: (context, languageProvider, child) {
                  return Text(
                    languageProvider.currentLanguage == 'zh' 
                        ? '正在加载广州连接...' 
                        : 'Loading Canton Connect...',
                    style: Theme.of(context).textTheme.bodyLarge,
                  );
                },
              ),
            ],
          ),
        ),
      );
    }
    
    // Show loading while checking auth state
    if (authProvider.isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Consumer<LanguageProvider>(
                builder: (context, languageProvider, child) {
                  return Text(
                    languageProvider.currentLanguage == 'zh'
                        ? '检查认证状态...'
                        : 'Checking authentication...',
                    style: Theme.of(context).textTheme.bodyLarge,
                  );
                },
              ),
            ],
          ),
        ),
      );
    }
    
    // Check if user is logged in via ApiService
    if (apiService.isLoggedIn) {
      return const MainApp();
    } else {
      // Navigate to login page if not logged in
      return const LoginPage();
    }
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentBottomNavIndex = 0;
  final int _cartItemCount = 3;
  bool _isAppBarScrolled = false;

  // Track scroll state for home page
  void _updateAppBarScroll(bool isScrolled) {
    if (mounted) {
      setState(() {
        _isAppBarScrolled = isScrolled;
      });
    }
  }

  // Build pages with scroll callback for home page
  List<Widget> get _pages => [
        HomePage(
          onScrollUpdate: _updateAppBarScroll,
        ),
        const MenuPage(),
        const HealthConceptsPage(),
        const OrderPage(),
        const ProfilePage(),
      ];

  void _handleBottomNavTap(int index) {
    if (mounted) {
      setState(() {
        _currentBottomNavIndex = index;
        // Reset scroll state when switching pages
        _isAppBarScrolled = false;
      });
    }
  }

  // Show admin access dialog
  void _showSecretAdminDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<LanguageProvider>(
          builder: (context, languageProvider, child) {
            final isChinese = languageProvider.currentLanguage == 'zh';
            
            return AlertDialog(
              title: Row(
                children: [
                  const Icon(Icons.admin_panel_settings, color: Colors.blue),
                  const SizedBox(width: 8),
                  Text(isChinese ? '管理员访问' : 'Admin Access'),
                ],
              ),
              content: Text(
                isChinese 
                  ? '选择管理功能：'
                  : 'Select admin function:',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(isChinese ? '取消' : 'Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _navigateToAdminPanel();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(isChinese ? '管理员登录' : 'Admin Login'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AdminOrdersPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(isChinese ? '订单管理' : 'Order Management'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubscriptionManagementPage(
                          currentLanguage: languageProvider.currentLanguage,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(isChinese ? '套餐管理' : 'Plan Management'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Navigate to admin panel
  void _navigateToAdminPanel() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => const AdminLoginPage(),
    ));
  }

  // Navigate to subscription page
  void _navigateToSubscriptionPage() {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SubscriptionPage(
          currentLanguage: languageProvider.currentLanguage,
          isAdmin: false,
        ),
      ),
    );
  }

  // Method for cart pressed
  void _onCartPressed() {
    debugPrint('Cart tapped from main app bar');
    // Navigate to cart page or show cart dialog
  }

  // Method for search pressed
  void _onSearchPressed() {
    debugPrint('Search tapped');
    // Navigate to search page or show search dialog
  }

  void _onProfilePressed() {
    debugPrint('Profile tapped');
    // Navigate to profile page
    if (mounted) {
      setState(() {
        _currentBottomNavIndex = 4; // Profile page index
      });
    }
  }

  void _onSubscriptionPlansTap() {
    debugPrint('Subscription plans tapped');
    _navigateToSubscriptionPage();
  }

  // Build app bar actions list
  List<AppBarAction> get _appBarActions {
    return [
      AppBarAction(
        type: AppBarActionType.search,
        icon: Icons.search,
        label: 'Search',
        onPressed: _onSearchPressed,
      ),
      AppBarAction(
        type: AppBarActionType.cart,
        icon: Icons.shopping_cart,
        label: 'Cart',
        onPressed: _onCartPressed,
        badgeCount: _cartItemCount,
      ),
      AppBarAction(
        type: AppBarActionType.profile,
        icon: Icons.person,
        label: 'Profile',
        onPressed: _onProfilePressed,
      ),
      AppBarAction(
        type: AppBarActionType.subscription,
        icon: Icons.subscriptions,
        label: 'Subscription Plans',
        onPressed: _onSubscriptionPlansTap,
      ),
      AppBarAction(
        type: AppBarActionType.language,
        icon: Icons.language,
        label: 'Switch Language',
        onPressed: () {
          // This will be handled by the language button in CustomAppBar
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final currentLanguage = languageProvider.currentLanguage;
    
    return Scaffold(
      appBar: CustomAppBar(
        isScrolled: _isAppBarScrolled,
        actions: _appBarActions,
        currentLanguage: currentLanguage,
        onLanguageChanged: (newLanguage) {
          languageProvider.setLanguage(newLanguage == 'zh');
        },
        onSubscriptionPlansTap: _onSubscriptionPlansTap,
        onTitleTap: _showSecretAdminDialog, // Secret admin access
      ),
      body: Stack(
        children: [
          IndexedStack(
            index: _currentBottomNavIndex,
            children: _pages,
          ),
          // TEMPORARY: Admin test button - REMOVE LATER
          if (kDebugMode)
            Positioned(
              top: 100,
              right: 20,
              child: FloatingActionButton(
                onPressed: _showSecretAdminDialog,
                backgroundColor: Colors.blue,
                mini: true,
                child: const Icon(Icons.admin_panel_settings, color: Colors.white),
              ),
            ),
        ],
      ),
      bottomNavigationBar: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return CustomBottomNavBar(
            currentIndex: _currentBottomNavIndex,
            currentLanguage: languageProvider.currentLanguage,
            onTap: _handleBottomNavTap,
            cartItemCount: _cartItemCount,
          );
        },
      ),
    );
  }
}
