// lib/presentation/pages/customer/auth/register_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// Removed unused import: 'package:meta/meta.dart'
import 'package:canton_connect/data/services/api_service.dart';
import 'package:canton_connect/presentation/widgets/custom_text_field.dart';
import 'package:canton_connect/presentation/widgets/primary_button.dart';
import 'package:canton_connect/presentation/widgets/auth_header.dart';
import 'package:canton_connect/utils/validators.dart';
import 'package:canton_connect/routes/app_routes.dart';

class RegisterPage extends HookConsumerWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    final fullNameController = useTextEditingController();
    final phoneController = useTextEditingController();

    final isLoading = useState(false);
    final errorMessage = useState<String?>(null);
    final obscurePassword = useState(true);
    final obscureConfirmPassword = useState(true);
    final acceptedTerms = useState(false);

    Future<void> _register() async {
      if (!formKey.currentState!.validate()) return;

      if (!acceptedTerms.value) {
        errorMessage.value = 'Please accept the Terms & Conditions';
        return;
      }

      if (passwordController.text != confirmPasswordController.text) {
        errorMessage.value = 'Passwords do not match';
        return;
      }

      isLoading.value = true;
      errorMessage.value = null;

      try {
        final authResponse = await ApiService.signUp(
          emailController.text.trim(),
          passwordController.text,
          {
            'full_name': fullNameController.text.trim(),
            'phone_number': phoneController.text.trim(),
            'role': 'customer',
            'created_at': DateTime.now().toIso8601String(),
          },
        );

        if (authResponse.user != null) {
          // Success - navigate to home or verification page
          if (context.mounted) {
            // FIX: Remove the email verification check and navigate directly
            // You can implement email verification logic separately if needed
            context.go(AppRoutes.home);
          }
        } else {
          errorMessage.value = 'Registration failed. Please try again.';
        }
      } catch (e) {
        errorMessage.value = _getErrorMessage(e);
      } finally {
        isLoading.value = false;
      }
    }

    void _navigateToLogin() {
      if (!isLoading.value) {
        // FIX: Remove unawaited and just push without waiting
        context.push(AppRoutes.login);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                
                // Back button - FIX: Use lambda instead of tearoff for context.pop
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, size: 20),
                  onPressed: () => context.pop(), // Use lambda for void function
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
                  controller: fullNameController,
                  label: 'Full Name',
                  hintText: 'Enter your full name',
                  prefixIcon: Icons.person_outline,
                  validator: Validators.validateName,
                ),

                const SizedBox(height: 16),

                // Email Field
                CustomTextField(
                  controller: emailController,
                  label: 'Email Address',
                  hintText: 'Enter your email',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.validateEmail,
                ),

                const SizedBox(height: 16),

                // Phone Field (Optional)
                CustomTextField(
                  controller: phoneController,
                  label: 'Phone Number (Optional)',
                  hintText: 'Enter your phone number',
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  validator: Validators.validatePhone,
                ),

                const SizedBox(height: 16),

                // Password Field
                CustomTextField(
                  controller: passwordController,
                  label: 'Password',
                  hintText: 'Create a password',
                  prefixIcon: Icons.lock_outline,
                  obscureText: obscurePassword.value,
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword.value 
                          ? Icons.visibility_off_outlined 
                          : Icons.visibility_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () => obscurePassword.value = !obscurePassword.value,
                  ),
                  validator: Validators.validatePassword,
                ),

                const SizedBox(height: 16),

                // Confirm Password Field
                CustomTextField(
                  controller: confirmPasswordController,
                  label: 'Confirm Password',
                  hintText: 'Confirm your password',
                  prefixIcon: Icons.lock_outline,
                  obscureText: obscureConfirmPassword.value,
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscureConfirmPassword.value 
                          ? Icons.visibility_off_outlined 
                          : Icons.visibility_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () => obscureConfirmPassword.value = !obscureConfirmPassword.value,
                  ),
                  validator: (value) => Validators.validateConfirmPassword(value, passwordController.text),
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
                        value: acceptedTerms.value,
                        onChanged: isLoading.value 
                            ? null 
                            : (value) => acceptedTerms.value = value ?? false,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: isLoading.value ? null : () {
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
                if (errorMessage.value != null)
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
                            errorMessage.value!,
                            style: TextStyle(
                              color: Colors.red[700],
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                if (errorMessage.value != null) const SizedBox(height: 16),

                // Register Button
                PrimaryButton(
                  onPressed: isLoading.value ? null : _register,
                  isLoading: isLoading.value,
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
