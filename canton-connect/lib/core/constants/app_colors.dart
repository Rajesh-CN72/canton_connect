import 'package:flutter/material.dart';

class AppColors {
  // ==============================
  // PRIMARY COLOR PALETTE
  // ==============================
  static const Color primary = Color(0xFF27AE60);    // Fresh Green
  static const Color primaryDark = Color(0xFF229954); // Darker Green
  static const Color primaryLight = Color(0xFF58D68D); // Lighter Green
  static const Color primaryContainer = Color(0xFFD5F4E2); // Very Light Green

  // ==============================
  // SECONDARY COLOR PALETTE
  // ==============================
  static const Color secondary = Color(0xFFFF6B35);    // Warm Orange for CTAs
  static const Color secondaryDark = Color(0xFFE55A2B); // Darker Orange
  static const Color secondaryLight = Color(0xFFFF8E63); // Lighter Orange
  static const Color secondaryContainer = Color(0xFFFFE0D6); // Very Light Orange

  // ==============================
  // ACCENT & NEUTRAL COLORS
  // ==============================
  static const Color accent = Color(0xFF2C3E50);       // Sophisticated Grey for text
  static const Color accentDark = Color(0xFF1C2833);   // Darker Grey
  static const Color accentLight = Color(0xFF566573);  // Lighter Grey
  static const Color accentContainer = Color(0xFFEAEDF0); // Very Light Grey

  // ==============================
  // BACKGROUND COLORS
  // ==============================
  static const Color background = Color(0xFFF8F9FA);   // Soft Off-White
  static const Color surface = Color(0xFFFFFFFF);      // Clean White
  static const Color card = Color(0xFFFFFFFF);         // Card background

  // ==============================
  // TEXT COLORS
  // ==============================
  static const Color textPrimary = Color(0xFF2C3E50);   // Main text color
  static const Color textSecondary = Color(0xFF566573); // Secondary text
  static const Color textDisabled = Color(0xFF85929E);  // Disabled text
  static const Color textInverse = Color(0xFFFFFFFF);   // Text on dark backgrounds
  static const Color textOnPrimary = Color(0xFFFFFFFF); // Text on primary color
  static const Color textOnSecondary = Color(0xFFFFFFFF); // Text on secondary color

  // ==============================
  // SEMANTIC COLORS
  // ==============================
  static const Color success = Color(0xFF27AE60);      // Green for success
  static const Color successLight = Color(0xFFD5F4E2); // Light success background
  static const Color warning = Color(0xFFF39C12);      // Orange for warnings
  static const Color warningLight = Color(0xFFFDEDD3); // Light warning background
  static const Color error = Color(0xFFE74C3C);        // Red for errors
  static const Color errorLight = Color(0xFFFADBD8);   // Light error background
  static const Color info = Color(0xFF3498DB);         // Blue for information
  static const Color infoLight = Color(0xFFD6EAF8);    // Light info background

  // ==============================
  // BORDER & DIVIDER COLORS
  // ==============================
  static const Color borderLight = Color(0xFFEAEDF0);  // Light borders
  static const Color borderMedium = Color(0xFFD5D8DC); // Medium borders
  static const Color borderDark = Color(0xFFAAB7B8);   // Dark borders
  static const Color divider = Color(0xFFEAEDF0);      // Divider lines

  // ==============================
  // STATE COLORS
  // ==============================
  static const Color hover = Color(0xFFF2F4F4);        // Hover state
  static const Color focus = Color(0xFFE8F6F3);        // Focus state
  static const Color selected = Color(0xFFD5F4E2);     // Selected state
  static const Color disabled = Color(0xFFF2F4F4);     // Disabled state

  // ==============================
  // GRADIENT COLORS
  // ==============================
  static const Gradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF27AE60), Color(0xFF2ECC71)],
  );

  static const Gradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF6B35), Color(0xFFFD8A5E)],
  );

  static const Gradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2C3E50), Color(0xFF566573)],
  );

  // ==============================
  // SHADOW COLORS
  // ==============================
  static const Color shadowLight = Color(0x1A000000);  // Light shadow
  static const Color shadowMedium = Color(0x33000000); // Medium shadow
  static const Color shadowDark = Color(0x4D000000);   // Dark shadow

  // ==============================
  // OVERLAY COLORS
  // ==============================
  static const Color overlayLight = Color(0x0D000000); // Light overlay
  static const Color overlayMedium = Color(0x1A000000); // Medium overlay
  static const Color overlayDark = Color(0x33000000);  // Dark overlay

  // ==============================
  // FOOD-SPECIFIC COLORS
  // ==============================
  static const Color spicyBadge = Color(0xFFE74C3C);   // Spicy food badge
  static const Color vegetarianBadge = Color(0xFF27AE60); // Vegetarian badge
  static const Color veganBadge = Color(0xFF229954);   // Vegan badge
  static const Color popularBadge = Color(0xFFF39C12); // Popular item badge
  static const Color newBadge = Color(0xFF3498DB);     // New item badge

  // ==============================
  // RATING COLORS
  // ==============================
  static const Color rating = Color(0xFFF39C12);       // Star rating color
  static const Color ratingEmpty = Color(0xFFD5D8DC);  // Empty star color

  // ==============================
  // SOCIAL MEDIA COLORS
  // ==============================
  static const Color facebook = Color(0xFF3B5998);
  static const Color twitter = Color(0xFF1DA1F2);
  static const Color instagram = Color(0xFFE4405F);
  static const Color wechat = Color(0xFF07C160);
  static const Color weibo = Color(0xFFE6162D);

  // ==============================
  // HELPER METHODS TO REPLACE DEPRECATED METHODS
  // ==============================
  
  /// Replaces deprecated .withOpacity() method
  static Color withOpacity(Color color, double opacity) {
    return color.withAlpha((255 * opacity).round());
  }
  
  /// Replaces deprecated color component accessors (.r, .g, .b)
  static int getRedComponent(Color color) => (color.r * 255.0).round().clamp(0, 255);
  static int getGreenComponent(Color color) => (color.g * 255.0).round().clamp(0, 255);
  static int getBlueComponent(Color color) => (color.b * 255.0).round().clamp(0, 255);
  
  /// Creates a color from RGB values with optional opacity
  static Color fromRGB(int r, int g, int b, [double opacity = 1.0]) {
    return Color.fromRGBO(r, g, b, opacity);
  }
  
  /// Creates a color from hex string
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

// Extension for easy color access in themes
extension AppColorsTheme on AppColors {
  static MaterialColor get primarySwatch {
    return MaterialColor(
      AppColors.primary.toARGB32(), // FIXED: Replaced .value with .toARGB32()
      const <int, Color>{
        50: Color(0xFFE8F5E8),
        100: Color(0xFFC8E6C9),
        200: Color(0xFFA5D6A7),
        300: Color(0xFF81C784),
        400: Color(0xFF66BB6A),
        500: Color(0xFF27AE60),
        600: Color(0xFF43A047),
        700: Color(0xFF388E3C),
        800: Color(0xFF2E7D32),
        900: Color(0xFF1B5E20),
      },
    );
  }

  static MaterialColor get secondarySwatch {
    return MaterialColor(
      AppColors.secondary.toARGB32(), // FIXED: Replaced .value with .toARGB32()
      const <int, Color>{
        50: Color(0xFFFFF3E0),
        100: Color(0xFFFFE0B2),
        200: Color(0xFFFFCC80),
        300: Color(0xFFFFB74D),
        400: Color(0xFFFFA726),
        500: Color(0xFFFF6B35),
        600: Color(0xFFFB8C00),
        700: Color(0xFFF57C00),
        800: Color(0xFFEF6C00),
        900: Color(0xFFE65100),
      },
    );
  }

  static MaterialColor get accentSwatch {
    return MaterialColor(
      AppColors.accent.toARGB32(), // FIXED: Replaced .value with .toARGB32()
      const <int, Color>{
        50: Color(0xFFECEFF1),
        100: Color(0xFFCFD8DC),
        200: Color(0xFFB0BEC5),
        300: Color(0xFF90A4AE),
        400: Color(0xFF78909C),
        500: Color(0xFF2C3E50),
        600: Color(0xFF546E7A),
        700: Color(0xFF455A64),
        800: Color(0xFF37474F),
        900: Color(0xFF263238),
      },
    );
  }
}

// Extension methods for easy color manipulation
extension ColorUtils on Color {
  /// Replacement for deprecated .withOpacity()
  Color withCustomOpacity(double opacity) {
    return withAlpha((255 * opacity).round());
  }
  
  /// Get color components as integers (0-255) - FIXED: Use new color component accessors
  int get redComponent => (r * 255.0).round().clamp(0, 255);
  int get greenComponent => (g * 255.0).round().clamp(0, 255);
  int get blueComponent => (b * 255.0).round().clamp(0, 255);
  
  /// Darken the color by [amount] (0-1)
  Color darken([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
  
  /// Lighten the color by [amount] (0-1)
  Color lighten([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }
}
