import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:canton_connect/core/providers/auth_provider.dart';
import 'package:canton_connect/presentation/pages/admin/admin_dashboard.dart';
import 'package:canton_connect/presentation/pages/admin/auth/admin_login_page.dart';
import 'package:canton_connect/core/constants/app_constants.dart';

class AdminSplashPage extends StatefulWidget {
  const AdminSplashPage({super.key});

  @override
  State<AdminSplashPage> createState() => _AdminSplashPageState();
}

class _AdminSplashPageState extends State<AdminSplashPage> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  void _initializeApp() async {
    // Initialize auth provider
    await Provider.of<AuthProvider>(context, listen: false).initialize();
    
    // Check authentication status after a brief delay
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      _checkAuthStatus();
    }
  }

  void _checkAuthStatus() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    if (authProvider.isLoggedIn && authProvider.isAdmin) {
      // User is logged in as admin, go to dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AdminDashboardPage()),
      );
    } else {
      // User is not logged in or not admin, go to login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AdminLoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppConstants.primaryColorValue),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Admin Icon
            const Icon(
              Icons.admin_panel_settings,
              size: 80,
              color: Colors.white,
            ),
            const SizedBox(height: 24),
            
            // App Name
            const Text(
              'Canton Connect',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            
            // Admin Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Admin Portal',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 48),
            
            // Loading Indicator
            const CircularProgressIndicator(
              color: Colors.white,
            ),
            const SizedBox(height: 24),
            
            // Loading Text
            const Text(
              'Loading Admin Portal...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
