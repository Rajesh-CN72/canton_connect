import 'package:canton_connect/presentation/pages/admin/food_management/add_food_page.dart';
import 'package:canton_connect/presentation/pages/admin/subscription_management_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:canton_connect/core/providers/auth_provider.dart';
import 'package:canton_connect/core/constants/app_constants.dart';
import 'dart:async'; // Add this import for unawaited

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: const Color(AppConstants.primaryColorValue),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome message
            Text(
              'Welcome, ${user?.name ?? 'Admin'}!',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Manage your restaurant efficiently',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),

            // Dashboard cards
            Expanded(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                children: [
                  _buildDashboardCard(
                    title: 'Food Management',
                    icon: Icons.restaurant_menu,
                    color: Colors.blue,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AddFoodPage()),
                      );
                    },
                  ),
                  _buildDashboardCard(
                    title: 'Subscription Plans',
                    icon: Icons.subscriptions,
                    color: Colors.red,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SubscriptionManagementPage(
                            currentLanguage: 'en', // You can make this dynamic
                          ),
                        ),
                      );
                    },
                  ),
                  _buildDashboardCard(
                    title: 'Orders',
                    icon: Icons.shopping_cart,
                    color: Colors.green,
                    onTap: () {
                      // Navigate to order management
                      _showComingSoon(context);
                    },
                  ),
                  _buildDashboardCard(
                    title: 'Customers',
                    icon: Icons.people,
                    color: Colors.orange,
                    onTap: () {
                      // Navigate to customer management
                      _showComingSoon(context);
                    },
                  ),
                  _buildDashboardCard(
                    title: 'Analytics',
                    icon: Icons.analytics,
                    color: Colors.purple,
                    onTap: () {
                      // Navigate to analytics
                      _showComingSoon(context);
                    },
                  ),
                  _buildDashboardCard(
                    title: 'Settings',
                    icon: Icons.settings,
                    color: Colors.brown,
                    onTap: () {
                      // Navigate to settings
                      _showComingSoon(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1), // FIX: Replace withOpacity with withValues
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await Provider.of<AuthProvider>(context, listen: false).logout();
      // Navigate to login page - FIX: Use unawaited for navigation
      unawaited(
        Navigator.pushNamedAndRemoveUntil(
          context, 
          '/admin-login', 
          (route) => false
        ),
      );
    }
  }

  void _showComingSoon(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Coming Soon'),
        content: const Text('This feature is under development and will be available soon.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
