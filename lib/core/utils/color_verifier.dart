import 'dart:math';
import 'package:flutter/material.dart';

class ColorVerifier {
  // Primary Colors
  static const Color primaryGreen = Color(0xFF27AE60);
  static const Color cleanWhite = Color(0xFFFFFFFF);

  // Secondary Colors
  static const Color warmOrange = Color(0xFFFF6B35);

  // Accent Colors
  static const Color accentGrey = Color(0xFF2C3E50);

  // Background Colors
  static const Color softOffWhite = Color(0xFFF8F9FA);

  // Additional Utility Colors
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color errorRed = Color(0xFFE74C3C);
  static const Color warningYellow = Color(0xFFFFC107);
  static const Color infoBlue = Color(0xFF2196F3);

  // Text Colors
  static const Color textPrimary = Color(0xFF2C3E50);
  static const Color textSecondary = Color(0xFF7F8C8D);
  static const Color textDisabled = Color(0xFFBDC3C7);

  // Border Colors
  static const Color borderLight = Color(0xFFECF0F1);
  static const Color borderMedium = Color(0xFFBDC3C7);

  // Helper method to verify color contrast
  static bool hasGoodContrast(Color background, Color text) {
    // Calculate relative luminance using the corrected method
    double luminance(Color color) {
      // Get RGB components using the new method - FIXED: use .r, .g, .b instead of .red, .green, .blue
      final r = color.r * 255.0;
      final g = color.g * 255.0;
      final b = color.b * 255.0;
      
      // Apply gamma correction
      final rLinear = r <= 0.03928 ? r / 12.92 : pow((r + 0.055) / 1.055, 2.4);
      final gLinear = g <= 0.03928 ? g / 12.92 : pow((g + 0.055) / 1.055, 2.4);
      final bLinear = b <= 0.03928 ? b / 12.92 : pow((b + 0.055) / 1.055, 2.4);
      
      return 0.2126 * rLinear + 0.7152 * gLinear + 0.0722 * bLinear;
    }

    final l1 = luminance(background);
    final l2 = luminance(text);
    final contrast = (max(l1, l2) + 0.05) / (min(l1, l2) + 0.05);
    
    return contrast >= 4.5; // WCAG AA standard
  }

  // Helper methods for min/max calculations
  static double max(double a, double b) => a > b ? a : b;
  static double min(double a, double b) => a < b ? a : b;

  // Method to get text color that provides good contrast on a background
  static Color getContrastText(Color backgroundColor) {
    // Calculate relative luminance
    double calculateLuminance(Color color) {
      // FIXED: use .r, .g, .b instead of .red, .green, .blue
      final r = color.r * 255.0;
      final g = color.g * 255.0;
      final b = color.b * 255.0;
      
      final rLinear = r <= 0.03928 ? r / 12.92 : pow((r + 0.055) / 1.055, 2.4);
      final gLinear = g <= 0.03928 ? g / 12.92 : pow((g + 0.055) / 1.055, 2.4);
      final bLinear = b <= 0.03928 ? b / 12.92 : pow((b + 0.055) / 1.055, 2.4);
      
      return 0.2126 * rLinear + 0.7152 * gLinear + 0.0722 * bLinear;
    }

    final backgroundLuminance = calculateLuminance(backgroundColor);
    
    // Use white text on dark backgrounds, black text on light backgrounds
    return backgroundLuminance > 0.5 ? textPrimary : cleanWhite;
  }

  // Method to check if a color is light
  static bool isLightColor(Color color) {
    // FIXED: use .r, .g, .b instead of .red, .green, .blue
    final luminance = (0.299 * (color.r * 255.0) +
                      0.587 * (color.g * 255.0) +
                      0.114 * (color.b * 255.0)) / 255;
    return luminance > 0.5;
  }

  // Method to get a darker shade of a color
  static Color darken(Color color, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  // Method to get a lighter shade of a color
  static Color lighten(Color color, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }

  // Utility method to create colors with opacity without using deprecated methods
  static Color withOpacity(Color color, double opacity) {
    return color.withAlpha((opacity * 255).round());
  }

  // NEW: Alternative method using withValues for better precision (Flutter's recommended approach)
  static Color withValuesOpacity(Color color, double opacity) {
    return color.withValues(alpha: opacity);
  }

  // FIXED: Convert color to hex string using proper integer conversion
  static String toHex(Color color) {
    // Convert double components (0.0-1.0) to integers (0-255)
    final r = (color.r * 255).round();
    final g = (color.g * 255).round();
    final b = (color.b * 255).round();
    
    return '#${r.toRadixString(16).padLeft(2, '0')}'
        '${g.toRadixString(16).padLeft(2, '0')}'
        '${b.toRadixString(16).padLeft(2, '0')}';
  }

  // NEW: Create color from RGB values using new approach
  static Color fromRGB(int r, int g, int b, [double opacity = 1.0]) {
    return Color.fromRGBO(r, g, b, opacity);
  }

  // NEW: Get color brightness (alternative to isLightColor)
  static double getBrightness(Color color) {
    return (0.299 * color.r + 0.587 * color.g + 0.114 * color.b);
  }

  // NEW: Check if color meets WCAG accessibility standards
  static Map<String, dynamic> checkAccessibility(Color background, Color text) {
    final contrastRatio = _calculateContrastRatio(background, text);
    final meetsAA = contrastRatio >= 4.5;
    final meetsAAA = contrastRatio >= 7.0;
    
    return {
      'contrastRatio': contrastRatio,
      'meetsAA': meetsAA,
      'meetsAAA': meetsAAA,
      'rating': meetsAAA ? 'AAA' : (meetsAA ? 'AA' : 'Fail'),
    };
  }

  static double _calculateContrastRatio(Color color1, Color color2) {
    final l1 = _relativeLuminance(color1);
    final l2 = _relativeLuminance(color2);
    
    if (l1 > l2) {
      return (l1 + 0.05) / (l2 + 0.05);
    } else {
      return (l2 + 0.05) / (l1 + 0.05);
    }
  }

  static double _relativeLuminance(Color color) {
    final r = _linearizeComponent(color.r);
    final g = _linearizeComponent(color.g);
    final b = _linearizeComponent(color.b);
    
    return 0.2126 * r + 0.7152 * g + 0.0722 * b;
  }

  static double _linearizeComponent(double component) {
    return component <= 0.03928 
        ? component / 12.92 
        : pow((component + 0.055) / 1.055, 2.4).toDouble();
  }
}

// Extension for easy color manipulation - UPDATED with non-deprecated methods
extension ColorUtils on Color {
  Color withCustomOpacity(double opacity) {
    return withAlpha((opacity * 255).round());
  }

  // NEW: Get color components as 0-255 integers
  int get red255 => (r * 255).round();
  int get green255 => (g * 255).round();
  int get blue255 => (b * 255).round();

  // NEW: Create a new color with adjusted brightness
  Color withBrightness(double factor) {
    final hsl = HSLColor.fromColor(this);
    return hsl.withLightness((hsl.lightness * factor).clamp(0.0, 1.0)).toColor();
  }

  // NEW: Check if this color is accessible on another color
  bool isAccessibleOn(Color background) {
    return ColorVerifier.hasGoodContrast(background, this);
  }

  // NEW: Get appropriate text color for this background
  Color get contrastText {
    return ColorVerifier.getContrastText(this);
  }

  // NEW: Convert color to hex string
  String toHexString() {
    return ColorVerifier.toHex(this);
  }
}
