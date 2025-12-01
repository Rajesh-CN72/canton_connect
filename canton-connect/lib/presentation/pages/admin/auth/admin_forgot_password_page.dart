import 'package:flutter/material.dart';
import 'package:canton_connect/core/utils/validators.dart';
import 'package:canton_connect/presentation/pages/admin/auth/admin_login_page.dart';
import 'package:canton_connect/core/constants/app_constants.dart';

class AdminForgotPasswordPage extends StatefulWidget {
  const AdminForgotPasswordPage({super.key});

  @override
  State<AdminForgotPasswordPage> createState() => _AdminForgotPasswordPageState();
}

class _AdminForgotPasswordPageState extends State<AdminForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _adminCodeController = TextEditingController();
  bool _isSubmitted = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _adminCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerLeft,
                ),
                const SizedBox(height: 20),

                // Header
                _buildHeader(),
                const SizedBox(height: 32),

                if (!_isSubmitted) ...[
                  // Admin-specific instructions
                  _buildAdminNotice(),
                  const SizedBox(height: 24),

                  // Email Field
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Admin Email',
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(),
                      hintText: 'admin@cantonconnect.com',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      final emailError = Validators.validateEmail(value);
                      if (emailError != null) return emailError;
                      
                      // Additional admin email validation
                      if (value != null && 
                          !value.toLowerCase().contains('admin') &&
                          !value.toLowerCase().contains('canton')) {
                        return 'Please use your admin email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Admin Security Code Field
                  TextFormField(
                    controller: _adminCodeController,
                    decoration: const InputDecoration(
                      labelText: 'Admin Security Code',
                      prefixIcon: Icon(Icons.security_outlined),
                      border: OutlineInputBorder(),
                      hintText: 'Enter 6-digit security code',
                    ),
                    obscureText: true,
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Security code is required';
                      }
                      if (value.length != 6) {
                        return 'Security code must be 6 digits';
                      }
                      if (!RegExp(r'^[0-9]{6}$').hasMatch(value)) {
                        return 'Please enter numbers only';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildSecurityCodeHelp(),
                  const SizedBox(height: 32),

                  // Reset Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _resetPassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(AppConstants.primaryColorValue),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Reset Admin Password',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ] else ...[
                  // Success Message
                  _buildSuccessMessage(),
                  const SizedBox(height: 32),

                  // Back to Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminLoginPage(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: const BorderSide(
                          color: Color(AppConstants.primaryColorValue),
                        ),
                      ),
                      child: const Text(
                        'Back to Admin Login',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(AppConstants.primaryColorValue),
                        ),
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 24),

                // Emergency Contact
                _buildEmergencyContact(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Admin Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(AppConstants.primaryColorValue).withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(AppConstants.primaryColorValue),
              width: 1,
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.admin_panel_settings,
                size: 16,
                color: Color(AppConstants.primaryColorValue),
              ),
              SizedBox(width: 6),
              Text(
                'Admin Access',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(AppConstants.primaryColorValue),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Title
        const Text(
          'Admin Password Reset',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),

        // Subtitle
        const Text(
          'Secure password recovery for administrators only. '
          'Please verify your identity with the security code.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildAdminNotice() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_amber, color: Colors.orange[800], size: 20),
              const SizedBox(width: 8),
              const Text(
                'Admin Access Required',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'This feature is restricted to authorized administrators only. '
            'Please use your admin email and security code provided by the system administrator.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityCodeHelp() {
    return GestureDetector(
      onTap: _showSecurityCodeHelp,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: const Row(
          children: [
            Icon(Icons.help_outline, size: 16, color: Colors.grey),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Forgot your security code? Contact system administrator',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
            Icon(Icons.chevron_right, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessMessage() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green),
      ),
      child: Column(
        children: [
          Icon(Icons.verified, color: Colors.green[800], size: 48),
          const SizedBox(height: 16),
          const Text(
            'Admin Password Reset Request Sent',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          const Text(
            'Your password reset request has been sent to the system administrator '
            'for verification. You will receive an email with further instructions '
            'within 15 minutes.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.access_time, size: 16, color: Colors.orange),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'For security reasons, admin password resets require manual approval',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyContact() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Emergency Contact',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'If you are locked out of your admin account and need immediate assistance:',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.phone, size: 16, color: Colors.red),
              const SizedBox(width: 8),
              const Text(
                'System Administrator:',
                style: TextStyle(fontSize: 14),
              ),
              const Spacer(),
              TextButton(
                onPressed: _contactAdministrator,
                child: const Text(
                  '+1 (555) 123-ADMIN',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call to admin password reset
      await Future.delayed(const Duration(seconds: 2));

      // Validate admin security code (in real app, this would be verified with backend)
      if (_adminCodeController.text != '123456') { // Demo code
        setState(() {
          _isLoading = false;
        });
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid security code. Please try again.'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
        return;
      }

      // Validate admin email (in real app, this would check if email belongs to admin)
      if (!_emailController.text.toLowerCase().contains('admin')) {
        setState(() {
          _isLoading = false;
        });
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('This email is not registered as an administrator.'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
        return;
      }

      setState(() {
        _isLoading = false;
        _isSubmitted = true;
      });

      if (mounted) {
        // Log the reset request (in real app, this would be sent to backend)
        debugPrint('Admin password reset requested for: ${_emailController.text}');
      }
    }
  }

  void _showSecurityCodeHelp() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.security, color: Colors.blue),
            SizedBox(width: 8),
            Text('Admin Security Code'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your admin security code is a 6-digit number that was provided '
              'when your admin account was created.',
            ),
            SizedBox(height: 16),
            Text(
              'If you have lost your security code:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('• Contact the system administrator'),
            Text('• Use the emergency contact number below'),
            Text('• Verify your identity in person at the office'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _contactAdministrator();
            },
            child: const Text('Contact Admin'),
          ),
        ],
      ),
    );
  }

  void _contactAdministrator() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Contact System Administrator'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('For immediate assistance with admin account issues:'),
            SizedBox(height: 16),
            Text('📞 +1 (555) 123-ADMIN',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('📧 admin-support@cantonconnect.com',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text('Available 24/7 for critical system issues'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
