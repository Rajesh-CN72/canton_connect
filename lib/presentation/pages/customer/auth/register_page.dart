// lib/presentation/pages/customer/auth/register_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:canton_connect/data/services/api_service.dart';
import 'package:canton_connect/presentation/widgets/custom_text_field.dart';
import 'package:canton_connect/presentation/widgets/primary_button.dart';
import 'package:canton_connect/presentation/widgets/auth_header.dart';
import 'package:canton_connect/utils/validators.dart';
import 'package:canton_connect/routes/app_routes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptedTerms = false;

  ApiService get _apiService => Provider.of<ApiService>(context, listen: false);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _fullNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    if (!_acceptedTerms) {
      setState(() {
        _errorMessage = 'Please accept the Terms & Conditions';
      });
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _errorMessage = 'Passwords do not match';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final authResponse = await _apiService.signUp(
        _emailController.text.trim(),
        _passwordController.text,
        {
          'full_name': _fullNameController.text.trim(),
          'phone_number': _phoneController.text.trim(),
          'role': 'customer',
          'created_at': DateTime.now().toIso8601String(),
        },
      );

      if (authResponse['user'] != null) {
        // Success - navigate to home
        if (mounted) {
          Navigator.pushReplacementNamed(context, AppRoutes.home);
        }
      } else {
        setState(() {
          _errorMessage = 'Registration failed. Please try again.';
        });
      }
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

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  void _toggleTermsAccepted(bool? value) {
    if (!_isLoading) {
      setState(() {
        _acceptedTerms = value ?? false;
      });
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
                  title: 'Create Account',
                  subtitle: 'Sign up to start your culinary journey',
                ),

                const SizedBox(height: 32),

                // Full Name Field
                CustomTextField(
                  controller: _fullNameController,
                  label: 'Full Name',
                  hintText: 'Enter your full name',
                  prefixIcon: Icons.person_outline,
                  validator: Validators.validateName,
                ),

                const SizedBox(height: 16),

                // Email Field
                CustomTextField(
                  controller: _emailController,
                  label: 'Email Address',
                  hintText: 'Enter your email',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.validateEmail,
                ),

                const SizedBox(height: 16),

                // Phone Field (Optional)
                CustomTextField(
                  controller: _phoneController,
                  label: 'Phone Number (Optional)',
                  hintText: 'Enter your phone number',
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  validator: Validators.validatePhone,
                ),

                const SizedBox(height: 16),

                // Password Field
                CustomTextField(
                  controller: _passwordController,
                  label: 'Password',
                  hintText: 'Create a password',
                  prefixIcon: Icons.lock_outline,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword 
                          ? Icons.visibility_off_outlined 
                          : Icons.visibility_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                  validator: Validators.validatePassword,
                ),

                const SizedBox(height: 16),

                // Confirm Password Field
                CustomTextField(
                  controller: _confirmPasswordController,
                  label: 'Confirm Password',
                  hintText: 'Confirm your password',
                  prefixIcon: Icons.lock_outline,
                  obscureText: _obscureConfirmPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword 
                          ? Icons.visibility_off_outlined 
                          : Icons.visibility_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: _toggleConfirmPasswordVisibility,
                  ),
                  validator: (value) => Validators.validateConfirmPassword(value, _passwordController.text),
                ),

                const SizedBox(height: 16),

                // Terms & Conditions
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: _acceptedTerms,
                        onChanged: _toggleTermsAccepted,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: _isLoading ? null : () {
                          _showTermsDialog(context);
                        },
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              height: 1.4,
                            ),
                            children: [
                              const TextSpan(text: 'I agree to the '),
                              TextSpan(
                                text: 'Terms & Conditions',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const TextSpan(text: ' and '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
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

                // Register Button
                PrimaryButton(
                  onPressed: _isLoading ? null : _register,
                  isLoading: _isLoading,
                  text: 'Create Account',
                ),

                const SizedBox(height: 32),

                // Login Redirect
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: _navigateToLogin,
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showTermsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Terms & Conditions'),
        content: SingleChildScrollView(
          child: Text(
            'By creating an account, you agree to our Terms of Service and Privacy Policy. '
            'You acknowledge that your data will be processed in accordance with our privacy practices.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
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

  String _getErrorMessage(dynamic error) {
    final errorString = error.toString();
    
    if (errorString.contains('User already registered')) {
      return 'An account with this email already exists.';
    } else if (errorString.contains('Invalid email')) {
      return 'Please enter a valid email address.';
    } else if (errorString.contains('Password should be at least')) {
      return 'Password must be at least 6 characters long.';
    } else if (errorString.contains('network')) {
      return 'Network error. Please check your connection.';
    } else {
      return 'Registration failed. Please try again.';
    }
  }
}
