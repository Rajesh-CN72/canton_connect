import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_constants.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // FIXED: Changed to nullable
  final bool isLoading;
  final bool isEnabled;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? loadingColor;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool hasShadow;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const PrimaryButton({
    super.key, // FIXED: Using super parameter
    required this.text,
    this.onPressed, // FIXED: Removed required since it's nullable
    this.isLoading = false,
    this.isEnabled = true,
    this.width,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.loadingColor,
    this.borderRadius = AppConstants.buttonBorderRadius,
    this.padding,
    this.hasShadow = true,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    // FIXED: Calculate effective enabled state
    final effectiveEnabled = isEnabled && onPressed != null && !isLoading;
    
    return Container(
      width: width ?? double.infinity,
      height: height ?? 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: hasShadow && effectiveEnabled
            ? [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: ElevatedButton(
        onPressed: effectiveEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: _getBackgroundColor(context, effectiveEnabled),
          foregroundColor: textColor ?? AppColors.textOnPrimary,
          disabledBackgroundColor: AppColors.disabled,
          disabledForegroundColor: AppColors.textDisabled,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: padding ??
              const EdgeInsets.symmetric(
                horizontal: AppConstants.defaultPadding,
                vertical: 12.0,
              ),
          textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
                fontFamily: AppConstants.primaryFont,
              ),
        ),
        child: _buildChild(),
      ),
    );
  }

  Color _getBackgroundColor(BuildContext context, bool effectiveEnabled) {
    if (!effectiveEnabled) return AppColors.disabled;
    if (isLoading) return AppColors.primary.withOpacity(0.7);
    return backgroundColor ?? AppColors.primary;
  }

  Widget _buildChild() {
    if (isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            loadingColor ?? AppColors.textOnPrimary,
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (prefixIcon != null) ...[
          prefixIcon!,
          const SizedBox(width: 8),
        ],
        Flexible(
          child: Text(
            text,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        if (suffixIcon != null) ...[
          const SizedBox(width: 8),
          suffixIcon!,
        ],
      ],
    );
  }
}

// Gradient variant of primary button
class PrimaryGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // FIXED: Changed to nullable
  final bool isLoading;
  final bool isEnabled;
  final double? width;
  final double? height;
  final Gradient? gradient;
  final Color? textColor;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool hasShadow;

  const PrimaryGradientButton({
    super.key, // FIXED: Using super parameter
    required this.text,
    this.onPressed, // FIXED: Removed required since it's nullable
    this.isLoading = false,
    this.isEnabled = true,
    this.width,
    this.height,
    this.gradient,
    this.textColor,
    this.borderRadius = AppConstants.buttonBorderRadius,
    this.padding,
    this.hasShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    // FIXED: Calculate effective enabled state
    final effectiveEnabled = isEnabled && onPressed != null && !isLoading;
    
    return Container(
      width: width ?? double.infinity,
      height: height ?? 50.0,
      decoration: BoxDecoration(
        gradient: effectiveEnabled
            ? gradient ?? AppColors.primaryGradient
            : const LinearGradient(
                colors: [
                  AppColors.disabled,
                  AppColors.disabled,
                ],
              ),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: hasShadow && effectiveEnabled
            ? [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: ElevatedButton(
        onPressed: effectiveEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: textColor ?? AppColors.textOnPrimary,
          disabledBackgroundColor: Colors.transparent,
          disabledForegroundColor: AppColors.textDisabled,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: padding ??
              const EdgeInsets.symmetric(
                horizontal: AppConstants.defaultPadding,
                vertical: 12.0,
              ),
          textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
                fontFamily: AppConstants.primaryFont,
              ),
        ),
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    textColor ?? AppColors.textOnPrimary,
                  ),
                ),
              )
            : Text(
                text,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
      ),
    );
  }
}

// Small primary button for compact spaces
class PrimarySmallButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // FIXED: Changed to nullable
  final bool isLoading;
  final bool isEnabled;
  final Color? backgroundColor;
  final Color? textColor;

  const PrimarySmallButton({
    super.key, // FIXED: Using super parameter
    required this.text,
    this.onPressed, // FIXED: Removed required since it's nullable
    this.isLoading = false,
    this.isEnabled = true,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.0,
      child: PrimaryButton(
        text: text,
        onPressed: onPressed,
        isLoading: isLoading,
        isEnabled: isEnabled,
        backgroundColor: backgroundColor ?? AppColors.primary,
        textColor: textColor ?? AppColors.textOnPrimary,
        borderRadius: 18.0,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        hasShadow: false,
      ),
    );
  }
}
