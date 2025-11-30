import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:canton_connect/core/providers/language_provider.dart';
import 'package:canton_connect/core/providers/auth_provider.dart';
import 'package:canton_connect/core/widgets/custom_app_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _pushNotifications = true;
  bool _emailNotifications = false;
  bool _smsNotifications = true;
  bool _lowStockAlerts = true;
  bool _newOrderAlerts = true;
  bool _darkMode = false;
  bool _autoBackup = true;

  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _openingTimeController = TextEditingController();
  final TextEditingController _closingTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize with sample data
    _businessNameController.text = 'Canton Connect Restaurant';
    _phoneController.text = '+1 (555) 123-4567';
    _emailController.text = 'contact@cantonconnect.com';
    _addressController.text = '123 Food Street, Canton District, Beijing, China';
    _openingTimeController.text = '09:00';
    _closingTimeController.text = '22:00';
  }

  @override
  void dispose() {
    _businessNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _openingTimeController.dispose();
    _closingTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final isChinese = languageProvider.currentLanguage == 'zh';

    return Scaffold(
      appBar: AdminAppBar(
        title: isChinese ? '设置' : 'Settings',
        showBackButton: true,
        currentLanguage: languageProvider.currentLanguage,
        onLanguageChanged: (newLanguage) {
          languageProvider.setLanguageByCode(newLanguage);
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Profile Section
            _buildUserProfileSection(authProvider, isChinese),
            const SizedBox(height: 24),

            // Notification Settings
            _buildSectionTitle(isChinese ? '通知设置' : 'Notification Settings'),
            _buildNotificationSettings(isChinese),
            const SizedBox(height: 24),

            // Business Information
            _buildSectionTitle(isChinese ? '商家信息' : 'Business Information'),
            _buildBusinessInformation(isChinese),
            const SizedBox(height: 24),

            // App Settings
            _buildSectionTitle(isChinese ? '应用设置' : 'App Settings'),
            _buildAppSettings(isChinese),
            const SizedBox(height: 24),

            // Security
            _buildSectionTitle(isChinese ? '安全' : 'Security'),
            _buildSecuritySettings(isChinese, context),
            const SizedBox(height: 24),

            // Support & About
            _buildSectionTitle(isChinese ? '支持与关于' : 'Support & About'),
            _buildSupportAbout(isChinese, context),
            const SizedBox(height: 32),

            // Action Buttons
            _buildActionButtons(isChinese, context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfileSection(AuthProvider authProvider, bool isChinese) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: const Color(0xFF1a237e),
              child: Text(
                authProvider.user?.name?.substring(0, 1).toUpperCase() ?? 'A',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    authProvider.user?.name ?? 'Admin User',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    authProvider.user?.email ?? 'admin@cantonconnect.com',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isChinese ? '管理员' : 'Administrator',
                    style: TextStyle(
                      color: Colors.green[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () => _editProfile(isChinese, context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildNotificationSettings(bool isChinese) {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          _buildSettingsSwitch(
            isChinese ? '推送通知' : 'Push Notifications',
            isChinese ? '接收应用内推送通知' : 'Receive push notifications in the app',
            _pushNotifications,
            (value) => setState(() => _pushNotifications = value),
          ),
          _buildDivider(),
          _buildSettingsSwitch(
            isChinese ? '邮件通知' : 'Email Notifications',
            isChinese ? '接收订单和更新邮件' : 'Receive order updates via email',
            _emailNotifications,
            (value) => setState(() => _emailNotifications = value),
          ),
          _buildDivider(),
          _buildSettingsSwitch(
            isChinese ? '短信通知' : 'SMS Notifications',
            isChinese ? '接收重要通知短信' : 'Receive important updates via SMS',
            _smsNotifications,
            (value) => setState(() => _smsNotifications = value),
          ),
          _buildDivider(),
          _buildSettingsSwitch(
            isChinese ? '库存不足提醒' : 'Low Stock Alerts',
            isChinese ? '当商品库存不足时提醒' : 'Get alerts when items are running low',
            _lowStockAlerts,
            (value) => setState(() => _lowStockAlerts = value),
          ),
          _buildDivider(),
          _buildSettingsSwitch(
            isChinese ? '新订单提醒' : 'New Order Alerts',
            isChinese ? '即时接收新订单通知' : 'Get instant notifications for new orders',
            _newOrderAlerts,
            (value) => setState(() => _newOrderAlerts = value),
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessInformation(bool isChinese) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSettingsTextField(
              isChinese ? '商家名称' : 'Business Name',
              _businessNameController,
            ),
            const SizedBox(height: 12),
            _buildSettingsTextField(
              isChinese ? '联系电话' : 'Phone Number',
              _phoneController,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 12),
            _buildSettingsTextField(
              isChinese ? '邮箱地址' : 'Email Address',
              _emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),
            _buildSettingsTextField(
              isChinese ? '商家地址' : 'Business Address',
              _addressController,
              maxLines: 2,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildSettingsTextField(
                    isChinese ? '营业开始时间' : 'Opening Time',
                    _openingTimeController,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSettingsTextField(
                    isChinese ? '营业结束时间' : 'Closing Time',
                    _closingTimeController,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppSettings(bool isChinese) {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          _buildSettingsSwitch(
            isChinese ? '深色模式' : 'Dark Mode',
            isChinese ? '启用深色主题' : 'Enable dark theme',
            _darkMode,
            (value) => setState(() => _darkMode = value),
          ),
          _buildDivider(),
          _buildSettingsSwitch(
            isChinese ? '自动备份' : 'Auto Backup',
            isChinese ? '自动备份数据到云端' : 'Automatically backup data to cloud',
            _autoBackup,
            (value) => setState(() => _autoBackup = value),
          ),
          _buildDivider(),
          ListTile(
            leading: const Icon(Icons.language, color: Colors.blue),
            title: Text(isChinese ? '语言设置' : 'Language Settings'),
            subtitle: Text(isChinese ? '更改应用语言' : 'Change app language'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => _showLanguageDialog(isChinese, context),
          ),
          _buildDivider(),
          ListTile(
            leading: const Icon(Icons.notifications_active, color: Colors.orange),
            title: Text(isChinese ? '通知音效' : 'Notification Sounds'),
            subtitle: Text(isChinese ? '自定义通知声音' : 'Customize notification sounds'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => _showSoundSettings(isChinese, context),
          ),
        ],
      ),
    );
  }

  Widget _buildSecuritySettings(bool isChinese, BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.lock, color: Colors.green),
            title: Text(isChinese ? '更改密码' : 'Change Password'),
            subtitle: Text(isChinese ? '更新您的登录密码' : 'Update your login password'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => _changePassword(isChinese, context),
          ),
          _buildDivider(),
          ListTile(
            leading: const Icon(Icons.fingerprint, color: Colors.purple),
            title: Text(isChinese ? '生物识别登录' : 'Biometric Login'),
            subtitle: Text(isChinese ? '启用指纹或面部识别' : 'Enable fingerprint or face recognition'),
            trailing: Switch(
              value: true,
              onChanged: (value) {},
            ),
          ),
          _buildDivider(),
          ListTile(
            leading: const Icon(Icons.security, color: Colors.red),
            title: Text(isChinese ? '两步验证' : 'Two-Factor Authentication'),
            subtitle: Text(isChinese ? '增强账户安全性' : 'Enhanced account security'),
            trailing: Switch(
              value: false,
              onChanged: (value) {},
            ),
          ),
          _buildDivider(),
          ListTile(
            leading: const Icon(Icons.devices, color: Colors.grey),
            title: Text(isChinese ? '登录设备管理' : 'Login Devices'),
            subtitle: Text(isChinese ? '管理已登录的设备' : 'Manage logged-in devices'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => _showLoginDevices(isChinese, context),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportAbout(bool isChinese, BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.help, color: Colors.blue),
            title: Text(isChinese ? '帮助中心' : 'Help Center'),
            subtitle: Text(isChinese ? '获取使用帮助' : 'Get help and support'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => _showHelpCenter(isChinese, context),
          ),
          _buildDivider(),
          ListTile(
            leading: const Icon(Icons.contact_support, color: Colors.green),
            title: Text(isChinese ? '联系我们' : 'Contact Us'),
            subtitle: Text(isChinese ? '获取技术支持' : 'Get technical support'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => _contactSupport(isChinese, context),
          ),
          _buildDivider(),
          ListTile(
            leading: const Icon(Icons.description, color: Colors.orange),
            title: Text(isChinese ? '隐私政策' : 'Privacy Policy'),
            subtitle: Text(isChinese ? '查看我们的隐私政策' : 'View our privacy policy'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => _showPrivacyPolicy(isChinese, context),
          ),
          _buildDivider(),
          ListTile(
            leading: const Icon(Icons.description, color: Colors.purple),
            title: Text(isChinese ? '服务条款' : 'Terms of Service'),
            subtitle: Text(isChinese ? '查看服务条款' : 'View terms of service'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => _showTermsOfService(isChinese, context),
          ),
          _buildDivider(),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.grey),
            title: Text(isChinese ? '关于应用' : 'About App'),
            subtitle: const Text('Version 1.0.0'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => _showAboutApp(isChinese, context),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(bool isChinese, BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => _saveSettings(isChinese, context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1a237e),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              isChinese ? '保存设置' : 'Save Settings',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => _logout(isChinese, context),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: const BorderSide(color: Colors.red),
            ),
            child: Text(
              isChinese ? '退出登录' : 'Logout',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsSwitch(String title, String subtitle, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildSettingsTextField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, thickness: 1);
  }

  // Action Methods
  void _editProfile(bool isChinese, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isChinese ? '编辑资料' : 'Edit Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: isChinese ? '姓名' : 'Name',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                labelText: isChinese ? '邮箱' : 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                labelText: isChinese ? '电话' : 'Phone',
              ),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(isChinese ? '取消' : 'Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessMessage(isChinese ? '资料更新成功' : 'Profile updated successfully', context);
            },
            child: Text(isChinese ? '保存' : 'Save'),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(bool isChinese, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isChinese ? '选择语言' : 'Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('English'),
              trailing: const Icon(Icons.check, color: Colors.green),
              onTap: () {
                context.read<LanguageProvider>().setLanguageByCode('en');
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('中文'),
              trailing: const Icon(Icons.check, color: Colors.green),
              onTap: () {
                context.read<LanguageProvider>().setLanguageByCode('zh');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _changePassword(bool isChinese, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isChinese ? '更改密码' : 'Change Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: isChinese ? '当前密码' : 'Current Password',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: isChinese ? '新密码' : 'New Password',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: isChinese ? '确认新密码' : 'Confirm New Password',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(isChinese ? '取消' : 'Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessMessage(isChinese ? '密码更新成功' : 'Password updated successfully', context);
            },
            child: Text(isChinese ? '更新' : 'Update'),
          ),
        ],
      ),
    );
  }

  void _showLoginDevices(bool isChinese, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isChinese ? '登录设备' : 'Login Devices'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              _buildDeviceItem('iPhone 13 Pro', 'Last active: 2 hours ago', Icons.phone_iphone),
              _buildDeviceItem('MacBook Pro', 'Last active: 1 day ago', Icons.laptop_mac),
              _buildDeviceItem('iPad Air', 'Last active: 3 days ago', Icons.tablet_mac),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(isChinese ? '关闭' : 'Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceItem(String device, String status, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(device),
      subtitle: Text(status),
      trailing: IconButton(
        icon: const Icon(Icons.logout, color: Colors.red, size: 18),
        onPressed: () {},
      ),
    );
  }

  void _showSoundSettings(bool isChinese, BuildContext context) {
    // Implement sound settings
    _showComingSoon(isChinese, context);
  }

  void _showHelpCenter(bool isChinese, BuildContext context) {
    // Implement help center
    _showComingSoon(isChinese, context);
  }

  void _contactSupport(bool isChinese, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isChinese ? '联系我们' : 'Contact Us'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('+1 (555) 123-4567'),
              subtitle: Text(isChinese ? '客服电话' : 'Customer Service'),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('support@cantonconnect.com'),
              subtitle: Text(isChinese ? '技术支持邮箱' : 'Technical Support'),
            ),
            ListTile(
              leading: const Icon(Icons.access_time),
              title: Text(isChinese ? '周一至周五 9:00-18:00' : 'Mon-Fri 9:00-18:00'),
              subtitle: Text(isChinese ? '工作时间' : 'Business Hours'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(isChinese ? '关闭' : 'Close'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicy(bool isChinese, BuildContext context) {
    // Implement privacy policy
    _showComingSoon(isChinese, context);
  }

  void _showTermsOfService(bool isChinese, BuildContext context) {
    // Implement terms of service
    _showComingSoon(isChinese, context);
  }

  void _showAboutApp(bool isChinese, BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Canton Connect',
      applicationVersion: '1.0.0',
      applicationIcon: const FlutterLogo(size: 64),
      children: [
        Text(isChinese 
          ? 'Canton Connect 是一个专业的餐厅管理系统，帮助您高效管理订单、库存和客户。'
          : 'Canton Connect is a professional restaurant management system that helps you efficiently manage orders, inventory, and customers.'
        ),
        const SizedBox(height: 16),
        Text(isChinese 
          ? '© 2024 Canton Connect. 保留所有权利。'
          : '© 2024 Canton Connect. All rights reserved.'
        ),
      ],
    );
  }

  void _saveSettings(bool isChinese, BuildContext context) {
    // In a real app, you would save these settings to your backend
    _showSuccessMessage(isChinese ? '设置保存成功' : 'Settings saved successfully', context);
  }

  void _logout(bool isChinese, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isChinese ? '退出登录' : 'Logout'),
        content: Text(isChinese 
          ? '您确定要退出登录吗？'
          : 'Are you sure you want to logout?'
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(isChinese ? '取消' : 'Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.pushNamedAndRemoveUntil(context, '/admin-login', (route) => false);
            },
            child: Text(isChinese ? '退出登录' : 'Logout', style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showComingSoon(bool isChinese, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isChinese ? '即将推出' : 'Coming Soon'),
        content: Text(isChinese 
          ? '此功能正在开发中，即将推出。'
          : 'This feature is under development and will be available soon.'
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(isChinese ? '确定' : 'OK'),
          ),
        ],
      ),
    );
  }

  void _showSuccessMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
