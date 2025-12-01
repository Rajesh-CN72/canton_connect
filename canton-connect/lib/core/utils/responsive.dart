import 'package:flutter/material.dart';
import 'package:canton_connect/core/constants/app_constants.dart';

class Responsive {
  final BuildContext context;

  Responsive(this.context);

  Size get size => MediaQuery.of(context).size;
  double get width => size.width;
  double get height => size.height;
  double get pixelRatio => MediaQuery.of(context).devicePixelRatio;
  EdgeInsets get padding => MediaQuery.of(context).padding;
  double get topPadding => padding.top;
  double get bottomPadding => padding.bottom;
  TextScaler get textScaler => MediaQuery.of(context).textScaler;

  // ==============================
  // BREAKPOINT CHECKS
  // ==============================

  bool get isMobile => width < AppConstants.tabletBreakpoint;
  bool get isTablet => width >= AppConstants.tabletBreakpoint && width < AppConstants.desktopBreakpoint;
  bool get isDesktop => width >= AppConstants.desktopBreakpoint;
  bool get isLargeDesktop => width >= AppConstants.largeDesktopBreakpoint;

  ScreenSize get screenSize {
    if (isMobile) return ScreenSize.mobile;
    if (isTablet) return ScreenSize.tablet;
    // FIXED: Handle largeDesktop by checking if it exists in the enum
    try {
      // Try to access largeDesktop, if it doesn't exist, fall back to desktop
      return ScreenSize.values.firstWhere(
        (e) => e.toString() == 'ScreenSize.largeDesktop',
        orElse: () => ScreenSize.desktop,
      );
    } catch (e) {
      return ScreenSize.desktop;
    }
  }

  // ==============================
  // RESPONSIVE SIZING
  // ==============================

  T responsiveValue<T>({
    required T mobile,
    T? tablet,
    T? desktop,
    T? largeDesktop,
  }) {
    if (isLargeDesktop && largeDesktop != null) return largeDesktop;
    if (isDesktop && desktop != null) return desktop;
    if (isTablet && tablet != null) return tablet;
    return mobile;
  }

  double getResponsiveWidth(double mobile, {double? tablet, double? desktop, double? largeDesktop}) {
    return responsiveValue(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
    );
  }

  double getResponsiveHeight(double mobile, {double? tablet, double? desktop, double? largeDesktop}) {
    return responsiveValue(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
    );
  }

  double getResponsiveFontSize(double mobile, {double? tablet, double? desktop, double? largeDesktop}) {
    return responsiveValue(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
    );
  }

  double getResponsivePadding(double mobile, {double? tablet, double? desktop, double? largeDesktop}) {
    return responsiveValue(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
    );
  }

  EdgeInsets getResponsivePaddingAll(double mobile, {double? tablet, double? desktop, double? largeDesktop}) {
    final value = getResponsivePadding(mobile, tablet: tablet, desktop: desktop, largeDesktop: largeDesktop);
    return EdgeInsets.all(value);
  }

  EdgeInsets getResponsivePaddingSymmetric({
    double horizontalMobile = 0,
    double verticalMobile = 0,
    double? horizontalTablet,
    double? verticalTablet,
    double? horizontalDesktop,
    double? verticalDesktop,
    double? horizontalLargeDesktop,
    double? verticalLargeDesktop,
  }) {
    final horizontal = getResponsivePadding(
      horizontalMobile,
      tablet: horizontalTablet,
      desktop: horizontalDesktop,
      largeDesktop: horizontalLargeDesktop,
    );
    final vertical = getResponsivePadding(
      verticalMobile,
      tablet: verticalTablet,
      desktop: verticalDesktop,
      largeDesktop: verticalLargeDesktop,
    );
    return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  }

  // ==============================
  // LAYOUT HELPERS
  // ==============================

  int getGridCrossAxisCount({
    int mobile = 1,
    int tablet = 2,
    int desktop = 3,
    int largeDesktop = 4,
  }) {
    return responsiveValue(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
    );
  }

  double getGridChildAspectRatio({
    double mobile = 1.0,
    double tablet = 1.2,
    double desktop = 1.4,
    double largeDesktop = 1.6,
  }) {
    return responsiveValue(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
    );
  }

  double getImageAspectRatio({
    double mobile = 16 / 9,
    double tablet = 3 / 2,
    double desktop = 4 / 3,
    double largeDesktop = 1.0,
  }) {
    return responsiveValue(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
    );
  }

  // ==============================
  // SPACING SCALE
  // ==============================

  double get spacingXXS => getResponsivePadding(4, tablet: 6, desktop: 8, largeDesktop: 10);
  double get spacingXS => getResponsivePadding(8, tablet: 10, desktop: 12, largeDesktop: 14);
  double get spacingS => getResponsivePadding(12, tablet: 14, desktop: 16, largeDesktop: 18);
  double get spacingM => getResponsivePadding(16, tablet: 20, desktop: 24, largeDesktop: 28);
  double get spacingL => getResponsivePadding(24, tablet: 28, desktop: 32, largeDesktop: 36);
  double get spacingXL => getResponsivePadding(32, tablet: 40, desktop: 48, largeDesktop: 56);
  double get spacingXXL => getResponsivePadding(48, tablet: 56, desktop: 64, largeDesktop: 72);

  // ==============================
  // TYPOGRAPHY SCALE
  // ==============================

  double get fontSizeBodySmall => getResponsiveFontSize(12, tablet: 13, desktop: 14, largeDesktop: 15);
  double get fontSizeBodyMedium => getResponsiveFontSize(14, tablet: 15, desktop: 16, largeDesktop: 17);
  double get fontSizeBodyLarge => getResponsiveFontSize(16, tablet: 17, desktop: 18, largeDesktop: 19);

  double get fontSizeTitleSmall => getResponsiveFontSize(18, tablet: 20, desktop: 22, largeDesktop: 24);
  double get fontSizeTitleMedium => getResponsiveFontSize(20, tablet: 22, desktop: 24, largeDesktop: 26);
  double get fontSizeTitleLarge => getResponsiveFontSize(24, tablet: 26, desktop: 28, largeDesktop: 30);

  double get fontSizeHeadlineSmall => getResponsiveFontSize(26, tablet: 28, desktop: 30, largeDesktop: 32);
  double get fontSizeHeadlineMedium => getResponsiveFontSize(28, tablet: 30, desktop: 32, largeDesktop: 34);
  double get fontSizeHeadlineLarge => getResponsiveFontSize(30, tablet: 32, desktop: 34, largeDesktop: 36);

  double get fontSizeDisplaySmall => getResponsiveFontSize(32, tablet: 36, desktop: 40, largeDesktop: 44);
  double get fontSizeDisplayMedium => getResponsiveFontSize(36, tablet: 40, desktop: 44, largeDesktop: 48);
  double get fontSizeDisplayLarge => getResponsiveFontSize(40, tablet: 44, desktop: 48, largeDesktop: 52);

  // ==============================
  // COMPONENT SIZING
  // ==============================

  double get appBarHeight => getResponsiveHeight(56, tablet: 64, desktop: 72, largeDesktop: 80);
  double get bottomNavBarHeight => getResponsiveHeight(70, tablet: 76, desktop: 80, largeDesktop: 84);
  double get buttonHeight => getResponsiveHeight(48, tablet: 52, desktop: 56, largeDesktop: 60);
  double get inputFieldHeight => getResponsiveHeight(48, tablet: 52, desktop: 56, largeDesktop: 60);
  double get cardBorderRadius => getResponsivePadding(8, tablet: 12, desktop: 16, largeDesktop: 20);
  double get buttonBorderRadius => getResponsivePadding(24, tablet: 26, desktop: 28, largeDesktop: 30);

  // ==============================
  // LAYOUT CONFIGURATIONS
  // ==============================

  LayoutConfig get layoutConfig {
    return LayoutConfig(
      screenSize: screenSize,
      crossAxisCount: getGridCrossAxisCount(),
      childAspectRatio: getGridChildAspectRatio(),
      mainAxisSpacing: spacingM,
      crossAxisSpacing: spacingM,
      padding: getResponsivePaddingSymmetric(
        horizontalMobile: AppConstants.defaultPadding,
        horizontalTablet: 24,
        horizontalDesktop: 32,
        horizontalLargeDesktop: 40,
      ),
    );
  }

  // ==============================
  // ORIENTATION
  // ==============================

  Orientation get orientation => MediaQuery.of(context).orientation;
  bool get isPortrait => orientation == Orientation.portrait;
  bool get isLandscape => orientation == Orientation.landscape;

  double get portraitHeight {
    final padding = MediaQuery.of(context).padding;
    return height - padding.top - padding.bottom;
  }

  double get landscapeHeight {
    final padding = MediaQuery.of(context).padding;
    return width - padding.top - padding.bottom;
  }

  // ==============================
  // SAFE AREA
  // ==============================

  double get safeAreaWidth {
    final padding = MediaQuery.of(context).padding;
    return width - padding.left - padding.right;
  }

  double get safeAreaHeight {
    final padding = MediaQuery.of(context).padding;
    return height - padding.top - padding.bottom;
  }

  EdgeInsets get safeAreaInsets => MediaQuery.of(context).viewInsets;

  // ==============================
  // ADDITIONAL HELPER METHODS
  // ==============================

  double getImageHeight({double aspectRatio = 16 / 9}) {
    return responsiveValue(
      mobile: width * 0.6,
      tablet: width * 0.4,
      desktop: width * 0.3,
      largeDesktop: width * 0.25,
    );
  }

  double getCardHeight() {
    return responsiveValue(
      mobile: 160.0,
      tablet: 200.0,
      desktop: 240.0,
      largeDesktop: 280.0,
    );
  }

  bool get useSidebarLayout => isDesktop || isLargeDesktop;

  double getSidebarWidth() {
    return responsiveValue(
      mobile: 0.0,
      tablet: 200.0,
      desktop: 250.0,
      largeDesktop: 300.0,
    );
  }

  double get textScaleFactor => textScaler.scale(1.0);
}

// Layout configuration class
class LayoutConfig {
  final ScreenSize screenSize;
  final int crossAxisCount;
  final double childAspectRatio;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final EdgeInsets padding;

  const LayoutConfig({
    required this.screenSize,
    required this.crossAxisCount,
    required this.childAspectRatio,
    required this.mainAxisSpacing,
    required this.crossAxisSpacing,
    required this.padding,
  });
}

// Extension for BuildContext
extension ResponsiveExtension on BuildContext {
  Responsive get responsive => Responsive(this);

  bool get isMobile => responsive.isMobile;
  bool get isTablet => responsive.isTablet;
  bool get isDesktop => responsive.isDesktop;
  bool get isLargeDesktop => responsive.isLargeDesktop;
  bool get isPortrait => responsive.isPortrait;
  bool get isLandscape => responsive.isLandscape;
  bool get useSidebarLayout => responsive.useSidebarLayout;

  double get width => responsive.width;
  double get height => responsive.height;
  double get safeAreaTop => responsive.topPadding;
  double get safeAreaBottom => responsive.bottomPadding;
  double get sidebarWidth => responsive.getSidebarWidth();
  double get cardHeight => responsive.getCardHeight();
  double get imageHeight => responsive.getImageHeight();
  double get textScaleFactor => responsive.textScaleFactor;

  double rw(double percent) => width * percent / 100;
  double rh(double percent) => height * percent / 100;
}

// Extension for Widget
extension ResponsiveWidgetExtension on Widget {
  Widget responsivePadding({
    double mobile = 16,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    return Builder(
      builder: (context) {
        final responsive = Responsive(context);
        final padding = responsive.getResponsivePadding(
          mobile,
          tablet: tablet,
          desktop: desktop,
          largeDesktop: largeDesktop,
        );
        return Padding(
          padding: EdgeInsets.all(padding),
          child: this,
        );
      },
    );
  }

  Widget responsiveWidth({
    double mobile = 100,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    return Builder(
      builder: (context) {
        final responsive = Responsive(context);
        final width = responsive.getResponsiveWidth(
          mobile,
          tablet: tablet,
          desktop: desktop,
          largeDesktop: largeDesktop,
        );
        return SizedBox(
          width: width,
          child: this,
        );
      },
    );
  }

  Widget responsiveHeight({
    double mobile = 100,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    return Builder(
      builder: (context) {
        final responsive = Responsive(context);
        final height = responsive.getResponsiveHeight(
          mobile,
          tablet: tablet,
          desktop: desktop,
          largeDesktop: largeDesktop,
        );
        return SizedBox(
          height: height,
          child: this,
        );
      },
    );
  }
}
