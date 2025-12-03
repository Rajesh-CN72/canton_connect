// lib/presentation/pages/customer/auth/reset_password_page.dart

import 'package:flutter/material.dart';

class ResetPasswordPage extends StatelessWidget {
  final String resetToken;
  
  const ResetPasswordPage({super.key, required this.resetToken});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: const Center(
        child: Text('Reset Password Page - Coming Soon'),
      ),
    );
  }
}
