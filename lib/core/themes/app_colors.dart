import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF27AE60); // Fresh Green
  static const Color secondary = Color(0xFFFF6B35); // Warm Orange
  
  // Background & Surface Colors
  static const Color background = Color(0xFFF8F9FA); // Soft Off-White
  static const Color white = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF); // Added surface color
  
  // Text Colors
  static const Color textPrimary = Color(0xFF2C3E50); // Sophisticated Grey
  static const Color textSecondary = Color(0xFF666666);
  static const Color textLight = Color(0xFF999999);
  
  // UI Colors
  static const Color border = Color(0xFFE0E0E0);
  static const Color shadow = Color(0x1A000000); // 10% opacity black
  
  // State Colors
  static const Color success = Color(0xFF27AE60);
  static const Color warning = Color(0xFFF39C12);
  static const Color error = Color(0xFFE74C3C);
  static const Color info = Color(0xFF3498DB);
  
  // Gradient Colors
  static const Gradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF27AE60), Color(0xFF2ECC71)],
  );
  
  static const Gradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF6B35), Color(0xFFF79C4E)],
  );
}
