// lib/routes/route_generator.dart

import 'package:flutter/material.dart';
import 'package:canton_connect/routes/app_routes.dart';

// Main App Pages
import 'package:canton_connect/presentation/pages/home_page.dart';
import 'package:canton_connect/presentation/pages/menu_page.dart';
import 'package:canton_connect/presentation/pages/order_page.dart';
import 'package:canton_connect/presentation/pages/profile_page.dart';

// Auth Pages (Customer)
import 'package:canton_connect/presentation/pages/customer/auth/login_page.dart';
import 'package:canton_connect/presentation/pages/customer/auth/register_page.dart';
import 'package:canton_connect/presentation/pages/customer/auth/forgot_password_page.dart';

// Admin Auth Pages
import 'package:canton_connect/presentation/pages/admin/auth/admin_login_page.dart';
import 'package:canton_connect/presentation/pages/admin/auth/admin_register_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {
      // ============ MAIN APP PAGES ============
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case AppRoutes.menu:
        return MaterialPageRoute(builder: (_) => const MenuPage());
      case AppRoutes.order:
        return MaterialPageRoute(builder: (_) => const OrderPage());
      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());

      // ============ CUSTOMER AUTH PAGES ============
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());

      // ============ ADMIN AUTH PAGES ============
      case AppRoutes.adminLogin:
        return MaterialPageRoute(builder: (_) => const AdminLoginPage());
      case AppRoutes.adminRegister:
        return MaterialPageRoute(builder: (_) => const AdminRegisterPage());

      // ============ DEFAULT/ERROR ROUTE ============
      default:
        return _errorRoute('Route not found: ${settings.name}');
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
          backgroundColor: Colors.red,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(_).pushNamedAndRemoveUntil(
                    AppRoutes.home,
                    (route) => false,
                  );
                },
                child: const Text('Go to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
