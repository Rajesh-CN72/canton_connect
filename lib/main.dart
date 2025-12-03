import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:canton_connect/core/constants/app_constants.dart';
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
import 'package:canton_connect/presentation/pages/admin/auth/admin_login_page.dart';
import 'package:canton_connect/routes/route_generator.dart';
import 'package:canton_connect/routes/app_routes.dart';
import 'package:canton_connect/presentation/pages/admin/order_management/orders_page.dart';
import 'package:canton_connect/presentation/pages/subscription_page.dart';
import 'package:canton_connect/presentation/pages/admin/subscription_management_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    debugPrint('Flutter Error: ${details.exception}');
  };
  
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
            title: 'Canton Connect',
            theme: _buildThemeData(languageProvider.currentLanguage),
            home: const AuthWrapper(),
            initialRoute: AppRoutes.home,
            onGenerateRoute: RouteGenerator.generateRoute,
            navigatorKey: NavigatorKeyHolder.navigatorKey,
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: TextScaler.noScaling,
                ),
                child: child ?? const Scaffold(
                  body: Center(
                    child: Text('Application loading...'),
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
    String defaultFontFamily = currentLanguage == 'zh' ? 'NotoSansSC' : 'Poppins';
    
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(AppConstants.primaryColorValue),
        primary: const Color(AppConstants.primaryColorValue),
        secondary: const Color(AppConstants.secondaryColorValue),
        surface: const Color(AppConstants.backgroundColorValue),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: defaultFontFamily,
      scaffoldBackgroundColor: const Color(AppConstants.backgroundColorValue),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Color(AppConstants.primaryColorValue),
        elevation: 0,
        centerTitle: true,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontFamily: defaultFontFamily,
          fontWeight: FontWeight.w700,
          fontSize: 32,
        ),
        displayMedium: TextStyle(
          fontFamily: defaultFontFamily,
          fontWeight: FontWeight.w600,
          fontSize: 28,
        ),
        displaySmall: TextStyle(
          fontFamily: defaultFontFamily,
          fontWeight: FontWeight.w600,
          fontSize: 24,
        ),
        headlineMedium: TextStyle(
          fontFamily: defaultFontFamily,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        headlineSmall: TextStyle(
          fontFamily: defaultFontFamily,
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
        titleLarge: TextStyle(
          fontFamily: defaultFontFamily,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        bodyLarge: TextStyle(
          fontFamily: defaultFontFamily,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          fontFamily: defaultFontFamily,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        labelLarge: TextStyle(
          fontFamily: defaultFontFamily,
          fontWeight: FontWeight.w500,
          fontSize: 14,
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
    
    if (_hasError) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Initialization Error',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                  _errorMessage ?? 'Unknown error occurred',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _retryInitialization,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }
    
    if (_isInitializing) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                'Loading Canton Connect...',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      );
    }
    
    if (authProvider.isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                'Checking authentication...',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      );
    }
    
    return const MainApp();
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

  void _updateAppBarScroll(bool isScrolled) {
    if (mounted) {
      setState(() {
        _isAppBarScrolled = isScrolled;
      });
    }
  }

  // Updated pages list with SubscriptionPage as index 4
  List<Widget> get _pages => [
        HomePage(
          onScrollUpdate: _updateAppBarScroll,
        ),
        const MenuPage(),
        const OrderPage(),
        const ProfilePage(),
        // Subscription page as bottom nav item
        Consumer<LanguageProvider>(
          builder: (context, languageProvider, child) {
            return SubscriptionPage(
              currentLanguage: languageProvider.currentLanguage,
              isAdmin: false,
              showAppBar: false, // Don't show app bar since we have CustomAppBar
            );
          },
        ),
      ];

  void _handleBottomNavTap(int index) {
    if (mounted) {
      setState(() {
        _currentBottomNavIndex = index;
        _isAppBarScrolled = false;
      });
    }
  }

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

  void _navigateToAdminPanel() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => const AdminLoginPage(),
    ));
  }

  void _onHealthConceptsPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const HealthConceptsPage(),
      ),
    );
  }

  void _onCartPressed() {
    debugPrint('Cart tapped from main app bar');
  }

  void _onSearchPressed() {
    debugPrint('Search tapped');
  }

  void _onProfilePressed() {
    debugPrint('Profile tapped');
    if (mounted) {
      setState(() {
        _currentBottomNavIndex = 3; // Profile page index
      });
    }
  }

  // Updated app bar actions: removed subscription, added health concepts
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
      // Health Concepts in app bar
      AppBarAction(
        type: AppBarActionType.health,
        icon: Icons.health_and_safety,
        label: 'Health Concepts',
        onPressed: _onHealthConceptsPressed,
      ),
      AppBarAction(
        type: AppBarActionType.language,
        icon: Icons.language,
        label: 'Switch Language',
        onPressed: () {
          // Handled by language button in CustomAppBar
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
          languageProvider.setLanguage(Locale(newLanguage));
        },
        onTitleTap: _showSecretAdminDialog,
      ),
      body: Stack(
        children: [
          IndexedStack(
            index: _currentBottomNavIndex,
            children: _pages,
          ),
          // TEMPORARY: Admin test button
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
