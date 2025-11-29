// lib/presentation/pages/profile_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:canton_connect/core/constants/app_constants.dart';
import 'package:canton_connect/core/providers/language_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _getCurrentLanguage(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    return languageProvider.currentLanguage;
  }

  @override
  Widget build(BuildContext context) {
    final currentLanguage = _getCurrentLanguage(context);
    
    return Scaffold(
      backgroundColor: const Color(AppConstants.backgroundColorValue),
      // NO APP BAR HERE - it's managed by main.dart
      body: _buildContent(context, currentLanguage),
    );
  }

  Widget _buildContent(BuildContext context, String currentLanguage) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16), // Added top padding since no app bar
          _buildProfileHeader(currentLanguage),
          const SizedBox(height: 32),
          _buildProfileStats(currentLanguage),
          const SizedBox(height: 32),
          _buildProfileActions(currentLanguage),
          const SizedBox(height: 32),
          _buildPreferencesSection(currentLanguage),
          const SizedBox(height: 32),
          _buildSupportSection(context, currentLanguage),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(String currentLanguage) {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(AppConstants.primaryColorValue),
              width: 3,
            ),
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/images/default_avatar.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(AppConstants.primaryColorValue).withAlpha(25),
                  child: const Icon(
                    Icons.person,
                    size: 60,
                    color: Color(AppConstants.primaryColorValue),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          currentLanguage == 'zh' ? '用户姓名' : 'User Name',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(AppConstants.primaryColorValue),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'user@example.com',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF666666),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            _showEditProfileDialog(context, currentLanguage);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(AppConstants.primaryColorValue),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: Text(
            currentLanguage == 'zh' ? '编辑资料' : 'Edit Profile',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileStats(String currentLanguage) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1), // FIXED: withOpacity to withValues
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            '12',
            currentLanguage == 'zh' ? '订单' : 'Orders',
            Icons.shopping_bag,
          ),
          _buildStatItem(
            '4.8',
            currentLanguage == 'zh' ? '评分' : 'Rating',
            Icons.star,
          ),
          _buildStatItem(
            '18',
            currentLanguage == 'zh' ? '收藏' : 'Favorites',
            Icons.favorite,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(AppConstants.primaryColorValue).withAlpha(25),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: const Color(AppConstants.primaryColorValue),
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(AppConstants.primaryColorValue),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF666666),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileActions(String currentLanguage) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1), // FIXED: withOpacity to withValues
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildActionItem(
            Icons.history,
            currentLanguage == 'zh' ? '订单历史' : 'Order History',
            () {
              _showComingSoon(context, currentLanguage);
            },
          ),
          _buildActionItem(
            Icons.favorite_border,
            currentLanguage == 'zh' ? '我的收藏' : 'My Favorites',
            () {
              _showComingSoon(context, currentLanguage);
            },
          ),
          _buildActionItem(
            Icons.location_on,
            currentLanguage == 'zh' ? '送餐地址' : 'Delivery Addresses',
            () {
              _showComingSoon(context, currentLanguage);
            },
          ),
          _buildActionItem(
            Icons.payment,
            currentLanguage == 'zh' ? '支付方式' : 'Payment Methods',
            () {
              _showComingSoon(context, currentLanguage);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(AppConstants.primaryColorValue).withAlpha(25),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: const Color(AppConstants.primaryColorValue),
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }

  Widget _buildPreferencesSection(String currentLanguage) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1), // FIXED: withOpacity to withValues
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            currentLanguage == 'zh' ? '偏好设置' : 'Preferences',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(AppConstants.primaryColorValue),
            ),
          ),
          const SizedBox(height: 16),
          _buildPreferenceItem(
            currentLanguage == 'zh' ? '通知设置' : 'Notifications',
            Icons.notifications,
          ),
          _buildPreferenceItem(
            currentLanguage == 'zh' ? '隐私设置' : 'Privacy',
            Icons.security,
          ),
          _buildPreferenceItem(
            currentLanguage == 'zh' ? '语言设置' : 'Language',
            Icons.language,
          ),
        ],
      ),
    );
  }

  Widget _buildPreferenceItem(String title, IconData icon) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(AppConstants.primaryColorValue).withAlpha(25),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: const Color(AppConstants.primaryColorValue),
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Switch(
        value: true,
        onChanged: (value) {},
        activeTrackColor: const Color(AppConstants.primaryColorValue),
      ),
    );
  }

  Widget _buildSupportSection(BuildContext context, String currentLanguage) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1), // FIXED: withOpacity to withValues
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            currentLanguage == 'zh' ? '支持' : 'Support',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(AppConstants.primaryColorValue),
            ),
          ),
          const SizedBox(height: 16),
          _buildSupportItem(
            Icons.help_outline,
            currentLanguage == 'zh' ? '帮助中心' : 'Help Center',
            () {
              _showComingSoon(context, currentLanguage);
            },
          ),
          _buildSupportItem(
            Icons.contact_support,
            currentLanguage == 'zh' ? '联系我们' : 'Contact Us',
            () {
              _showComingSoon(context, currentLanguage);
            },
          ),
          _buildSupportItem(
            Icons.description,
            currentLanguage == 'zh' ? '条款与条件' : 'Terms & Conditions',
            () {
              _showComingSoon(context, currentLanguage);
            },
          ),
          _buildSupportItem(
            Icons.exit_to_app,
            currentLanguage == 'zh' ? '退出登录' : 'Logout',
            () {
              _showLogoutDialog(context, currentLanguage);
            },
            isLogout: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSupportItem(IconData icon, String title, VoidCallback onTap, {bool isLogout = false}) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isLogout 
              ? Colors.red.withAlpha(25)
              : const Color(AppConstants.primaryColorValue).withAlpha(25),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: isLogout ? Colors.red : const Color(AppConstants.primaryColorValue),
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isLogout ? Colors.red : null,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }

  void _showEditProfileDialog(BuildContext context, String currentLanguage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(currentLanguage == 'zh' ? '编辑资料' : 'Edit Profile'),
          content: Text(currentLanguage == 'zh' 
              ? '此功能即将推出' 
              : 'This feature is coming soon'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(currentLanguage == 'zh' ? '确定' : 'OK'),
            ),
          ],
        );
      },
    );
  }

  void _showComingSoon(BuildContext context, String currentLanguage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(currentLanguage == 'zh' 
            ? '功能即将推出' 
            : 'Feature coming soon'),
        backgroundColor: const Color(AppConstants.primaryColorValue),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, String currentLanguage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(currentLanguage == 'zh' ? '退出登录' : 'Logout'),
          content: Text(currentLanguage == 'zh' 
              ? '确定要退出登录吗？' 
              : 'Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(currentLanguage == 'zh' ? '取消' : 'Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _performLogout(context, currentLanguage);
              },
              child: Text(
                currentLanguage == 'zh' ? '退出' : 'Logout',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void _performLogout(BuildContext context, String currentLanguage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(currentLanguage == 'zh' 
            ? '已退出登录' 
            : 'Logged out successfully'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
