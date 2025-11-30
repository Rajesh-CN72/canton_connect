import 'package:canton_connect/presentation/pages/admin/food_management/add_food_page.dart';
import 'package:canton_connect/presentation/pages/admin/subscription_management_page.dart';
import 'package:canton_connect/presentation/pages/admin/order_management/orders_page.dart';
import 'package:canton_connect/presentation/pages/admin/customers_page.dart';
import 'package:canton_connect/presentation/pages/admin/analytics_page.dart';
import 'package:canton_connect/presentation/pages/admin/settings_page.dart';
import 'package:canton_connect/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:canton_connect/core/providers/auth_provider.dart';
import 'package:canton_connect/core/providers/language_provider.dart';
import 'dart:async';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isChinese = languageProvider.currentLanguage == 'zh';

    return Scaffold(
      appBar: AdminAppBar(
        title: isChinese ? '管理员面板' : 'Admin Dashboard',
        showBackButton: false,
        currentLanguage: languageProvider.currentLanguage,
        onLanguageChanged: (newLanguage) {
          languageProvider.setLanguageByCode(newLanguage);
        },
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
            tooltip: isChinese ? '退出登录' : 'Logout',
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
              isChinese ? '欢迎, ${user?.name ?? '管理员'}!' : 'Welcome, ${user?.name ?? 'Admin'}!',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isChinese ? '高效管理您的餐厅' : 'Manage your restaurant efficiently',
              style: TextStyle(color: Colors.grey[600]),
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
                    title: isChinese ? '食品管理' : 'Food Management',
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
                    title: isChinese ? '订阅计划' : 'Subscription Plans',
                    icon: Icons.subscriptions,
                    color: Colors.red,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubscriptionManagementPage(
                            currentLanguage: languageProvider.currentLanguage,
                          ),
                        ),
                      );
                    },
                  ),
                  _buildDashboardCard(
                    title: isChinese ? '订单管理' : 'Order Management',
                    icon: Icons.shopping_cart,
                    color: Colors.green,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminOrdersPage(),
                        ),
                      );
                    },
                  ),
                  _buildDashboardCard(
                    title: isChinese ? '客户管理' : 'Customer Management',
                    icon: Icons.people,
                    color: Colors.orange,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CustomersPage(),
                        ),
                      );
                    },
                  ),
                  _buildDashboardCard(
                    title: isChinese ? '数据分析' : 'Analytics',
                    icon: Icons.analytics,
                    color: Colors.purple,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AnalyticsPage(),
                        ),
                      );
                    },
                  ),
                  _buildDashboardCard(
                    title: isChinese ? '设置' : 'Settings',
                    icon: Icons.settings,
                    color: Colors.brown,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsPage(),
                        ),
                      );
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
                  color: color.withAlpha(26),
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
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    final isChinese = languageProvider.currentLanguage == 'zh';

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isChinese ? '退出登录' : 'Logout'),
        content: Text(isChinese ? '您确定要退出登录吗？' : 'Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(isChinese ? '取消' : 'Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(isChinese ? '退出登录' : 'Logout'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await Provider.of<AuthProvider>(context, listen: false).logout();
      
      // Fixed: Check if context is still mounted after async operation
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context, 
          '/admin-login', 
          (route) => false
        );
      }
    }
  }
}
