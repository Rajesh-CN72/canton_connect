import 'package:flutter/material.dart';
import 'package:canton_connect/core/constants/app_constants.dart';
import 'package:canton_connect/core/responsive.dart';

class CustomErrorWidget extends StatelessWidget {
  final String title;
  final String message;
  final String? buttonText;
  final VoidCallback? onRetry;
  final IconData? icon;
  final Color? iconColor;
  final bool showIcon;

  const CustomErrorWidget({
    Key? key,
    required this.title,
    required this.message,
    this.buttonText,
    this.onRetry,
    this.icon,
    this.iconColor,
    this.showIcon = true,
  }) : super(key: key);

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
    return Padding(
      padding: EdgeInsets.all(Responsive.getHorizontalPadding(context)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showIcon) ...[
              Icon(
                icon ?? Icons.error_outline,
                size: Responsive.responsiveValue<double>(
                  context,
                  mobile: 64,
                  tablet: 80,
                  desktop: 96,
                ),
                color: iconColor ?? const Color(AppConstants.primaryColorValue),
              ),
              const SizedBox(height: 24),
            ],
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Responsive.getTitleFontSize(context),
                fontWeight: FontWeight.w700,
                color: const Color(AppConstants.primaryColorValue),
                fontFamily: AppConstants.primaryFont,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.responsiveValue<double>(
                  context,
                  mobile: 16,
                  tablet: 32,
                  desktop: 48,
                ),
              ),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Responsive.getBodyFontSize(context),
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 32),
              SizedBox(
                width: Responsive.responsiveValue<double>(
                  context,
                  mobile: double.infinity,
                  tablet: 200,
                  desktop: 200,
                ),
                child: ElevatedButton(
                  onPressed: onRetry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(AppConstants.primaryColorValue),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      vertical: Responsive.responsiveValue<double>(
                        context,
                        mobile: 16,
                        tablet: 18,
                        desktop: 20,
                      ),
                      horizontal: 24,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: Text(
                    buttonText ?? 'Retry',
                    style: TextStyle(
                      fontSize: Responsive.getBodyFontSize(context),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),
            // Additional help text for persistent errors
            if (onRetry != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  'If the problem persists, contact support',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Responsive.getBodyFontSize(context) - 2,
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
    Key? key,
    this.onRetry,
    this.customMessage,
  }) : super(key: key);

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
    Key? key,
    required this.title,
    required this.message,
    this.buttonText,
    this.onAction,
    this.icon = Icons.inbox,
  }) : super(key: key);

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
    return Padding(
      padding: EdgeInsets.all(Responsive.getHorizontalPadding(context)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: Responsive.responsiveValue<double>(
                context,
                mobile: 72,
                tablet: 88,
                desktop: 104,
              ),
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 24),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Responsive.getTitleFontSize(context),
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.responsiveValue<double>(
                  context,
                  mobile: 24,
                  tablet: 48,
                  desktop: 72,
                ),
              ),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Responsive.getBodyFontSize(context),
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
              ),
            ),
            if (onAction != null) ...[
              const SizedBox(height: 24),
              SizedBox(
                width: Responsive.responsiveValue<double>(
                  context,
                  mobile: double.infinity,
                  tablet: 200,
                  desktop: 200,
                ),
                child: OutlinedButton(
                  onPressed: onAction,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(AppConstants.primaryColorValue),
                    side: const BorderSide(
                      color: Color(AppConstants.primaryColorValue),
                      width: 1.5,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: Responsive.responsiveValue<double>(
                        context,
                        mobile: 14,
                        tablet: 16,
                        desktop: 18,
                      ),
                      horizontal: 24,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    buttonText ?? 'Action',
                    style: TextStyle(
                      fontSize: Responsive.getBodyFontSize(context),
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
