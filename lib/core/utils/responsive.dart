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
    return ScreenSize.desktop;
  }

  // ==============================
  // RESPONSIVE SIZING
  // ==============================

  double getResponsiveWidth(double mobile, {double? tablet, double? desktop}) {
    if (isDesktop && desktop != null) return desktop;
    if (isTablet && tablet != null) return tablet;
    return mobile;
  }

  double getResponsiveHeight(double mobile, {double? tablet, double? desktop}) {
    if (isDesktop && desktop != null) return desktop;
    if (isTablet && tablet != null) return tablet;
    return mobile;
  }

  double getResponsiveFontSize(double mobile, {double? tablet, double? desktop}) {
    if (isDesktop && desktop != null) return desktop;
    if (isTablet && tablet != null) return tablet;
    return mobile;
  }

  double getResponsivePadding(double mobile, {double? tablet, double? desktop}) {
    if (isDesktop && desktop != null) return desktop;
    if (isTablet && tablet != null) return tablet;
    return mobile;
  }

  EdgeInsets getResponsivePaddingAll(double mobile, {double? tablet, double? desktop}) {
    final value = getResponsivePadding(mobile, tablet: tablet, desktop: desktop);
    return EdgeInsets.all(value);
  }

  EdgeInsets getResponsivePaddingSymetric({
    double horizontalMobile = 0,
    double verticalMobile = 0,
    double? horizontalTablet,
    double? verticalTablet,
    double? horizontalDesktop,
    double? verticalDesktop,
  }) {
    final horizontal = getResponsivePadding(
      horizontalMobile,
      tablet: horizontalTablet,
      desktop: horizontalDesktop,
    );
    final vertical = getResponsivePadding(
      verticalMobile,
      tablet: verticalTablet,
      desktop: verticalDesktop,
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
    if (isLargeDesktop) return largeDesktop;
    if (isDesktop) return desktop;
    if (isTablet) return tablet;
    return mobile;
  }

  double getGridChildAspectRatio({
    double mobile = 1.0,
    double tablet = 1.2,
    double desktop = 1.4,
  }) {
    if (isDesktop) return desktop;
    if (isTablet) return tablet;
    return mobile;
  }

  double getImageAspectRatio({
    double mobile = 16 / 9,
    double tablet = 3 / 2,
    double desktop = 4 / 3,
  }) {
    if (isDesktop) return desktop;
    if (isTablet) return tablet;
    return mobile;
  }

  // ==============================
  // SPACING SCALE
  // ==============================

  double get spacingXXS => getResponsivePadding(4, tablet: 6, desktop: 8);
  double get spacingXS => getResponsivePadding(8, tablet: 10, desktop: 12);
  double get spacingS => getResponsivePadding(12, tablet: 14, desktop: 16);
  double get spacingM => getResponsivePadding(16, tablet: 20, desktop: 24);
  double get spacingL => getResponsivePadding(24, tablet: 28, desktop: 32);
  double get spacingXL => getResponsivePadding(32, tablet: 40, desktop: 48);
  double get spacingXXL => getResponsivePadding(48, tablet: 56, desktop: 64);

  // ==============================
  // TYPOGRAPHY SCALE
  // ==============================

  double get fontSizeBodySmall => getResponsiveFontSize(12, tablet: 13, desktop: 14);
  double get fontSizeBodyMedium => getResponsiveFontSize(14, tablet: 15, desktop: 16);
  double get fontSizeBodyLarge => getResponsiveFontSize(16, tablet: 17, desktop: 18);

  double get fontSizeTitleSmall => getResponsiveFontSize(18, tablet: 20, desktop: 22);
  double get fontSizeTitleMedium => getResponsiveFontSize(20, tablet: 22, desktop: 24);
  double get fontSizeTitleLarge => getResponsiveFontSize(24, tablet: 26, desktop: 28);

  double get fontSizeHeadlineSmall => getResponsiveFontSize(26, tablet: 28, desktop: 30);
  double get fontSizeHeadlineMedium => getResponsiveFontSize(28, tablet: 30, desktop: 32);
  double get fontSizeHeadlineLarge => getResponsiveFontSize(30, tablet: 32, desktop: 34);

  double get fontSizeDisplaySmall => getResponsiveFontSize(32, tablet: 36, desktop: 40);
  double get fontSizeDisplayMedium => getResponsiveFontSize(36, tablet: 40, desktop: 44);
  double get fontSizeDisplayLarge => getResponsiveFontSize(40, tablet: 44, desktop: 48);

  // ==============================
  // COMPONENT SIZING
  // ==============================

  double get appBarHeight => getResponsiveHeight(56, tablet: 64, desktop: 72);
  double get bottomNavBarHeight => getResponsiveHeight(70, tablet: 76, desktop: 80);
  double get buttonHeight => getResponsiveHeight(48, tablet: 52, desktop: 56);
  double get inputFieldHeight => getResponsiveHeight(48, tablet: 52, desktop: 56);
  double get cardBorderRadius => getResponsivePadding(8, tablet: 12, desktop: 16);
  double get buttonBorderRadius => getResponsivePadding(24, tablet: 26, desktop: 28);

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
      padding: getResponsivePaddingSymetric(
        horizontalMobile: AppConstants.defaultPadding,
        horizontalTablet: 24,
        horizontalDesktop: 32,
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
    return width - padding.top - padding.bottom; // In landscape, width becomes height
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

  double get width => responsive.width;
  double get height => responsive.height;

  double rw(double percent) => width * percent / 100;
  double rh(double percent) => height * percent / 100;
}

// Extension for Widget
extension ResponsiveWidgetExtension on Widget {
  Widget responsivePadding({
    double mobile = 16,
    double? tablet,
    double? desktop,
  }) {
    return Builder(
      builder: (context) {
        final responsive = Responsive(context);
        final padding = responsive.getResponsivePadding(
          mobile,
          tablet: tablet,
          desktop: desktop,
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
  }) {
    return Builder(
      builder: (context) {
        final responsive = Responsive(context);
        final width = responsive.getResponsiveWidth(
          mobile,
          tablet: tablet,
          desktop: desktop,
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
  }) {
    return Builder(
      builder: (context) {
        final responsive = Responsive(context);
        final height = responsive.getResponsiveHeight(
          mobile,
          tablet: tablet,
          desktop: desktop,
        );
        return SizedBox(
          height: height,
          child: this,
        );
      },
    );
  }
}
