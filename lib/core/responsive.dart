import 'package:flutter/widgets.dart';

class Responsive {
  // Screen size breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;
  static const double largeDesktopBreakpoint = 1800;

  // Device type detection
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileBreakpoint;
  }
  
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileBreakpoint && width < tabletBreakpoint;
  }
  
  static bool isDesktop(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= tabletBreakpoint && width < largeDesktopBreakpoint;
  }

  static bool isLargeDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= largeDesktopBreakpoint;
  }

  // Screen size getters
  static double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
  static double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

  // Responsive value calculation - FIXED: Removed dead null-aware expressions
  static T responsiveValue<T>(
    BuildContext context, {
    T? mobile,
    T? tablet,
    T? desktop,
    T? largeDesktop,
    T? fallback,
  }) {
    final width = screenWidth(context);
    
    if (width < mobileBreakpoint && mobile != null) {
      return mobile;
    } else if (width < tabletBreakpoint && tablet != null) {
      return tablet;
    } else if (width < largeDesktopBreakpoint && desktop != null) {
      return desktop;
    } else if (largeDesktop != null) {
      return largeDesktop;
    }
    
    // Fallback chain without dead null-aware expressions
    if (fallback != null) return fallback;
    if (mobile != null) return mobile;
    if (tablet != null) return tablet;
    if (desktop != null) return desktop;
    if (largeDesktop != null) return largeDesktop;
    
    throw ArgumentError('No value provided for responsiveValue and no fallback available');
  }

  // Responsive dimensions
  static double responsiveDimension(
    BuildContext context, {
    double? mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    return responsiveValue<double>(
      context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
      fallback: mobile ?? 0,
    );
  }

  // Image height helpers
  static double getImageHeight(BuildContext context, {double aspectRatio = 16 / 9}) {
    final width = screenWidth(context);
    
    if (width < mobileBreakpoint) {
      return width * 0.6; // 60% of screen width on mobile
    } else if (width < tabletBreakpoint) {
      return width * 0.4; // 40% of screen width on tablet
    } else {
      return width * 0.3; // 30% of screen width on desktop
    }
  }

  static double getCardHeight(BuildContext context) {
    return responsiveDimension(
      context,
      mobile: 160,
      tablet: 200,
      desktop: 240,
      largeDesktop: 280,
    );
  }

  // Grid layout helpers
  static int getGridCrossAxisCount(BuildContext context) {
    return responsiveValue<int>(
      context,
      mobile: 2,
      tablet: 3,
      desktop: 4,
      largeDesktop: 5,
    );
  }

  static double getGridChildAspectRatio(BuildContext context) {
    return responsiveValue<double>(
      context,
      mobile: 0.8,   // Taller cards on mobile
      tablet: 0.9,   // Slightly taller on tablet
      desktop: 1.0,  // Square on desktop
      largeDesktop: 1.1, // Wider on large desktop
    );
  }

  // Font size helpers
  static double getTitleFontSize(BuildContext context) {
    return responsiveDimension(
      context,
      mobile: 18,
      tablet: 20,
      desktop: 24,
      largeDesktop: 28,
    );
  }

  static double getBodyFontSize(BuildContext context) {
    return responsiveDimension(
      context,
      mobile: 14,
      tablet: 15,
      desktop: 16,
      largeDesktop: 17,
    );
  }

  // Padding helpers
  static EdgeInsets getContainerPadding(BuildContext context) {
    return responsiveValue<EdgeInsets>(
      context,
      mobile: const EdgeInsets.all(16),
      tablet: const EdgeInsets.all(20),
      desktop: const EdgeInsets.all(24),
      largeDesktop: const EdgeInsets.all(32),
    );
  }

  static double getHorizontalPadding(BuildContext context) {
    return responsiveDimension(
      context,
      mobile: 16,
      tablet: 20,
      desktop: 24,
      largeDesktop: 32,
    );
  }

  // Layout helpers
  static bool useSidebarLayout(BuildContext context) {
    return isDesktop(context) || isLargeDesktop(context);
  }

  static double getSidebarWidth(BuildContext context) {
    return responsiveDimension(
      context,
      mobile: 0, // No sidebar on mobile
      tablet: 200,
      desktop: 250,
      largeDesktop: 300,
    );
  }

  // Orientation helpers
  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  // Safe area helpers
  static double getSafeAreaTop(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static double getSafeAreaBottom(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }

  // Device pixel ratio helper
  static double getPixelRatio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  // Text scale factor helper - FIXED: Replaced deprecated textScaleFactor with textScaler
  static double getTextScaleFactor(BuildContext context) {
    return MediaQuery.of(context).textScaler.scale(1.0);
  }
}

// Extension methods for easier usage
extension ResponsiveExtensions on BuildContext {
  bool get isMobile => Responsive.isMobile(this);
  bool get isTablet => Responsive.isTablet(this);
  bool get isDesktop => Responsive.isDesktop(this);
  bool get isLargeDesktop => Responsive.isLargeDesktop(this);
  bool get isPortrait => Responsive.isPortrait(this);
  bool get isLandscape => Responsive.isLandscape(this);
  
  double get screenWidth => Responsive.screenWidth(this);
  double get screenHeight => Responsive.screenHeight(this);
  double get safeAreaTop => Responsive.getSafeAreaTop(this);
  double get safeAreaBottom => Responsive.getSafeAreaBottom(this);
}


