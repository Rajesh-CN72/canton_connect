// lib/presentation/pages/customer/auth/forgot_password_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:canton_connect/data/services/api_service.dart';
import 'package:canton_connect/presentation/widgets/custom_text_field.dart';
import 'package:canton_connect/presentation/widgets/primary_button.dart';
import 'package:canton_connect/presentation/widgets/auth_header.dart';
import 'package:canton_connect/utils/validators.dart';
import 'package:canton_connect/routes/app_routes.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  ApiService get _apiService => Provider.of<ApiService>(context, listen: false);

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _successMessage = null;
    });

    try {
      await _apiService.resetPassword(_emailController.text.trim());
      
      setState(() {
        _successMessage = 'Password reset instructions have been sent to your email.';
      });
      _emailController.clear();
    } catch (e) {
      setState(() {
        _errorMessage = _getErrorMessage(e);
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _navigateToLogin() {
    if (!_isLoading) {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
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
                const SizedBox(height: 20),
                
                // Back button
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, size: 20),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),

                const SizedBox(height: 40),

                // Header
                const AuthHeader(
                  title: 'Forgot Password',
                  subtitle: "Enter your email and we'll send you reset instructions",
                ),

                const SizedBox(height: 32),

                // Success Message
                if (_successMessage != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green[200]!),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle_outline, color: Colors.green[600], size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _successMessage!,
                            style: TextStyle(
                              color: Colors.green[700],
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                if (_successMessage != null) const SizedBox(height: 16),

                // Email Field
                CustomTextField(
                  controller: _emailController,
                  label: 'Email Address',
                  hintText: 'Enter your email address',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.validateEmail,
                ),

                const SizedBox(height: 24),

                // Error Message
                if (_errorMessage != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red[200]!),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline, color: Colors.red[600], size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _errorMessage!,
                            style: TextStyle(
                              color: Colors.red[700],
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                if (_errorMessage != null) const SizedBox(height: 16),

                // Reset Password Button
                PrimaryButton(
                  onPressed: _isLoading ? null : _resetPassword,
                  isLoading: _isLoading,
                  text: 'Send Reset Instructions',
                ),

                const SizedBox(height: 24),

                // Help Text
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue[200]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.blue[600], size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'What happens next?',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.blue[800],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'We will send a password reset link to your email address. '
                        'Click the link in the email to create a new password.',
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Back to Login
                Center(
                  child: GestureDetector(
                    onTap: _navigateToLogin,
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        children: [
                          const TextSpan(text: 'Remember your password? '),
                          TextSpan(
                            text: 'Back to Sign In',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getErrorMessage(dynamic error) {
    final errorString = error.toString();
    
    if (errorString.contains('user not found')) {
      return 'No account found with this email address.';
    } else if (errorString.contains('Invalid email')) {
      return 'Please enter a valid email address.';
    } else if (errorString.contains('network') || errorString.contains('SocketException')) {
      return 'Network error. Please check your internet connection.';
    } else if (errorString.contains('rate limit')) {
      return 'Too many attempts. Please try again later.';
    } else {
      return 'Failed to send reset instructions. Please try again.';
    }
  }
}
