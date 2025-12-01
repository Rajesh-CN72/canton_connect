import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:canton_connect/core/providers/language_provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        final isChinese = languageProvider.isChinese;
        
        return Scaffold(
          appBar: AppBar(
            title: Text(
              isChinese ? '我的账户' : 'My Account',
              style: const TextStyle(
                color: Color(0xFF2C3E50),
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Color(0xFF2C3E50)),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Profile section
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xFF27AE60),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'John Doe',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'john.doe@example.com',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(39, 174, 96, 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  isChinese ? '高级会员' : 'Premium Member',
                                  style: const TextStyle(
                                    color: Color(0xFF27AE60),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // Edit profile
                          },
                          icon: const Icon(Icons.edit, color: Color(0xFF27AE60)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Menu items
                _buildMenuCard(
                  isChinese ? '订阅计划' : 'Subscription Plan',
                  Icons.card_membership,
                  const Color(0xFF27AE60),
                ),
                _buildMenuCard(
                  isChinese ? '配送地址' : 'Delivery Address',
                  Icons.location_on,
                  const Color(0xFF3498DB),
                ),
                _buildMenuCard(
                  isChinese ? '支付方式' : 'Payment Methods',
                  Icons.payment,
                  const Color(0xFF9B59B6),
                ),
                _buildMenuCard(
                  isChinese ? '订单历史' : 'Order History',
                  Icons.history,
                  const Color(0xFFE74C3C),
                ),
                _buildMenuCard(
                  isChinese ? '设置' : 'Settings',
                  Icons.settings,
                  const Color(0xFF95A5A6),
                ),
                _buildMenuCard(
                  isChinese ? '帮助与支持' : 'Help & Support',
                  Icons.help_outline,
                  const Color(0xFFF39C12),
                ),

                const SizedBox(height: 20),
                
                // Logout button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle logout
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      isChinese ? '退出登录' : 'Log Out',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMenuCard(
    String title,
    IconData icon,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Color.fromRGBO(
              (color.red * 255.0).round().clamp(0, 255),
              (color.green * 255.0).round().clamp(0, 255),
              (color.blue * 255.0).round().clamp(0, 255),
              0.1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {
          // Handle menu item tap
        },
      ),
    );
  }
}
