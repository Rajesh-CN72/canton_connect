import 'package:flutter/material.dart';
import 'package:canton_connect/core/constants/app_constants.dart';
import 'package:canton_connect/core/utils/responsive.dart';

class CustomErrorWidget extends StatelessWidget {
  final String title;
  final String message;
  final String? buttonText;
  final VoidCallback? onRetry;
  final IconData? icon;
  final Color? iconColor;
  final bool showIcon;

  const CustomErrorWidget({
    super.key, // Fixed: Using super parameter
    required this.title,
    required this.message,
    this.buttonText,
    this.onRetry,
    this.icon,
    this.iconColor,
    this.showIcon = true,
  });

  factory CustomErrorWidget.networkError({
    VoidCallback? onRetry,
    String? buttonText,
  }) {
    return CustomErrorWidget(
      title: 'Connection Error',
      message: 'Unable to connect to the server. '
          'Please check your internet connection and try again.',
      buttonText: buttonText ?? 'Retry',
      onRetry: onRetry,
      icon: Icons.wifi_off,
      iconColor: Colors.orange,
    );
  }

  factory CustomErrorWidget.serverError({
    VoidCallback? onRetry,
    String? buttonText,
  }) {
    return CustomErrorWidget(
      title: 'Server Error',
      message: 'We\'re experiencing technical difficulties. '
          'Please try again in a few moments.',
      buttonText: buttonText ?? 'Retry',
      onRetry: onRetry,
      icon: Icons.error_outline,
      iconColor: Colors.red,
    );
  }

  factory CustomErrorWidget.notFound({
    String? customMessage,
    VoidCallback? onRetry,
  }) {
    return CustomErrorWidget(
      title: 'Not Found',
      message: customMessage ?? 'The requested content could not be found.',
      buttonText: 'Go Back',
      onRetry: onRetry,
      icon: Icons.search_off,
      iconColor: Colors.grey,
    );
  }

  factory CustomErrorWidget.genericError({
    VoidCallback? onRetry,
    String? buttonText,
  }) {
    return CustomErrorWidget(
      title: 'Something Went Wrong',
      message: 'An unexpected error occurred. '
          'Please try again later.',
      buttonText: buttonText ?? 'Retry',
      onRetry: onRetry,
      icon: Icons.sentiment_dissatisfied,
      iconColor: Colors.grey,
    );
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    
    return Padding(
      padding: EdgeInsets.all(responsive.spacingL),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showIcon) ...[
              Icon(
                icon ?? Icons.error_outline,
                size: responsive.responsiveValue(
                  mobile: 64.0,
                  tablet: 80.0,
                  desktop: 96.0,
                ),
                color: iconColor ?? Theme.of(context).primaryColor,
              ),
              SizedBox(height: responsive.spacingL),
            ],
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: responsive.fontSizeTitleLarge,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor,
                fontFamily: AppConstants.primaryFont,
              ),
            ),
            SizedBox(height: responsive.spacingM),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: responsive.responsiveValue(
                  mobile: 16.0,
                  tablet: 32.0,
                  desktop: 48.0,
                ),
              ),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: responsive.fontSizeBodyMedium,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
              ),
            ),
            if (onRetry != null) ...[
              SizedBox(height: responsive.spacingXL),
              SizedBox(
                width: responsive.responsiveValue(
                  mobile: double.infinity,
                  tablet: 200.0,
                  desktop: 200.0,
                ),
                child: ElevatedButton(
                  onPressed: onRetry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      vertical: responsive.responsiveValue(
                        mobile: 16.0,
                        tablet: 18.0,
                        desktop: 20.0,
                      ),
                      horizontal: 24,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(responsive.buttonBorderRadius),
                    ),
                    elevation: 2,
                  ),
                  child: Text(
                    buttonText ?? 'Retry',
                    style: TextStyle(
                      fontSize: responsive.fontSizeBodyMedium,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
            SizedBox(height: responsive.spacingM),
            // Additional help text for persistent errors
            if (onRetry != null)
              Padding(
                padding: EdgeInsets.only(top: responsive.spacingM),
                child: Text(
                  'If the problem persists, contact support',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: responsive.fontSizeBodySmall,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Specialized error widgets for common scenarios
class NetworkErrorWidget extends StatelessWidget {
  final VoidCallback? onRetry;
  final String? customMessage;

  const NetworkErrorWidget({
    super.key, // Fixed: Using super parameter
    this.onRetry,
    this.customMessage,
  });

  @override
  Widget build(BuildContext context) {
    return CustomErrorWidget.networkError(
      onRetry: onRetry,
      buttonText: 'Retry Connection',
    );
  }
}

class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String message;
  final String? buttonText;
  final VoidCallback? onAction;
  final IconData icon;

  const EmptyStateWidget({
    super.key, // Fixed: Using super parameter
    required this.title,
    required this.message,
    this.buttonText,
    this.onAction,
    this.icon = Icons.inbox,
  });

  factory EmptyStateWidget.noItems({String? message, VoidCallback? onAction}) {
    return EmptyStateWidget(
      title: 'No Items',
      message: message ?? 'There are no items to display at the moment.',
      buttonText: 'Refresh',
      onAction: onAction,
      icon: Icons.inventory_2,
    );
  }

  factory EmptyStateWidget.noSearchResults({String? query, VoidCallback? onAction}) {
    return EmptyStateWidget(
      title: 'No Results',
      message: query != null
          ? 'No results found for "$query". Try different keywords.'
          : 'No results found. Try different search terms.',
      buttonText: 'Clear Search',
      onAction: onAction,
      icon: Icons.search_off,
    );
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    
    return Padding(
      padding: EdgeInsets.all(responsive.spacingL),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: responsive.responsiveValue(
                mobile: 72.0,
                tablet: 88.0,
                desktop: 104.0,
              ),
              color: Colors.grey.shade400,
            ),
            SizedBox(height: responsive.spacingL),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: responsive.fontSizeTitleLarge,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: responsive.spacingM),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: responsive.responsiveValue(
                  mobile: 24.0,
                  tablet: 48.0,
                  desktop: 72.0,
                ),
              ),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: responsive.fontSizeBodyMedium,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
              ),
            ),
            if (onAction != null) ...[
              SizedBox(height: responsive.spacingL),
              SizedBox(
                width: responsive.responsiveValue(
                  mobile: double.infinity,
                  tablet: 200.0,
                  desktop: 200.0,
                ),
                child: OutlinedButton(
                  onPressed: onAction,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Theme.of(context).primaryColor,
                    side: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 1.5,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: responsive.responsiveValue(
                        mobile: 14.0,
                        tablet: 16.0,
                        desktop: 18.0,
                      ),
                      horizontal: 24,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(responsive.buttonBorderRadius),
                    ),
                  ),
                  child: Text(
                    buttonText ?? 'Action',
                    style: TextStyle(
                      fontSize: responsive.fontSizeBodyMedium,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Additional specialized error widgets
class PermissionErrorWidget extends StatelessWidget {
  final String permissionName;
  final VoidCallback? onRequestPermission;

  const PermissionErrorWidget({
    super.key, // Fixed: Using super parameter
    required this.permissionName,
    this.onRequestPermission,
  });

  @override
  Widget build(BuildContext context) {
    // Fixed: Removed unused responsive variable or use it
// Now used in the widget
    
    return CustomErrorWidget(
      title: 'Permission Required',
      message: 'This app needs $permissionName permission to function properly. '
          'Please enable it in your device settings.',
      buttonText: 'Grant Permission',
      onRetry: onRequestPermission,
      icon: Icons.lock, // Fixed: Replaced non-existent 'permission_rounded' with 'lock'
      iconColor: Colors.blue,
    );
  }
}

class LocationErrorWidget extends StatelessWidget {
  final VoidCallback? onEnableLocation;

  const LocationErrorWidget({
    super.key, // Fixed: Using super parameter
    this.onEnableLocation,
  });

  @override
  Widget build(BuildContext context) {
    return CustomErrorWidget(
      title: 'Location Services Required',
      message: 'Location services are disabled. '
          'Please enable location services to use this feature.',
      buttonText: 'Enable Location',
      onRetry: onEnableLocation,
      icon: Icons.location_off,
      iconColor: Colors.orange,
    );
  }
}

// Extension for easy error widget access
extension ErrorWidgetExtension on BuildContext {
  Widget buildNetworkError({VoidCallback? onRetry}) {
    return NetworkErrorWidget(onRetry: onRetry);
  }

  Widget buildEmptyState({
    required String title,
    required String message,
    VoidCallback? onAction,
  }) {
    return EmptyStateWidget(
      title: title,
      message: message,
      onAction: onAction,
    );
  }

  Widget buildLoadingError({VoidCallback? onRetry}) {
    return CustomErrorWidget.genericError(onRetry: onRetry);
  }
}

