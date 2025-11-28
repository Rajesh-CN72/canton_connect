import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_constants.dart';


class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isEnabled;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final Color? loadingColor;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool hasShadow;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const SecondaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.width,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.loadingColor,
    this.borderRadius = AppConstants.buttonBorderRadius,
    this.padding,
    this.hasShadow = false,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: hasShadow && isEnabled && !isLoading
            ? [
                const BoxShadow(
                  color: AppColors.shadowLight,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: OutlinedButton(
        onPressed: (isEnabled && !isLoading) ? onPressed : null,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor ?? Colors.transparent,
          foregroundColor: _getTextColor(context),
          disabledBackgroundColor: AppColors.disabled,
          disabledForegroundColor: AppColors.textDisabled,
          side: BorderSide(
            color: _getBorderColor(context),
            width: 2.0,
          ),
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

  Color _getTextColor(BuildContext context) {
    if (!isEnabled) return AppColors.textDisabled;
    return textColor ?? AppColors.primary;
  }

  Color _getBorderColor(BuildContext context) {
    if (!isEnabled) return AppColors.borderMedium;
    if (isLoading) return AppColors.primary.withOpacity(0.5);
    return borderColor ?? AppColors.primary;
  }

  Widget _buildChild() {
    if (isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            loadingColor ?? AppColors.primary,
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

// Secondary button with accent colors
class SecondaryAccentButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isEnabled;
  final double? width;
  final double? height;

  const SecondaryAccentButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SecondaryButton(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      isEnabled: isEnabled,
      width: width,
      height: height,
      textColor: AppColors.accent,
      borderColor: AppColors.accent,
      loadingColor: AppColors.accent,
    );
  }
}

// Secondary button with error colors
class SecondaryErrorButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isEnabled;
  final double? width;
  final double? height;

  const SecondaryErrorButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SecondaryButton(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      isEnabled: isEnabled,
      width: width,
      height: height,
      textColor: AppColors.error,
      borderColor: AppColors.error,
      loadingColor: AppColors.error,
    );
  }
}

// Small secondary button for compact spaces
class SecondarySmallButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isEnabled;
  final Color? textColor;
  final Color? borderColor;

  const SecondarySmallButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.textColor,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.0,
      child: SecondaryButton(
        text: text,
        onPressed: onPressed,
        isLoading: isLoading,
        isEnabled: isEnabled,
        textColor: textColor ?? AppColors.primary,
        borderColor: borderColor ?? AppColors.primary,
        borderRadius: 18.0,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        hasShadow: false,
      ),
    );
  }
}

// Icon-only secondary button
class SecondaryIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final bool isLoading;
  final bool isEnabled;
  final double size;
  final Color? iconColor;
  final Color? borderColor;
  final String? tooltip;

  const SecondaryIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.isLoading = false,
    this.isEnabled = true,
    this.size = 40.0,
    this.iconColor,
    this.borderColor,
    this.tooltip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final button = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
      ),
      child: OutlinedButton(
        onPressed: (isEnabled && !isLoading) ? onPressed : null,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          foregroundColor: iconColor ?? AppColors.primary,
          disabledForegroundColor: AppColors.textDisabled,
          side: BorderSide(
            color: _getBorderColor(context),
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size / 2),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    iconColor ?? AppColors.primary,
                  ),
                ),
              )
            : IconTheme(
                data: IconThemeData(
                  size: size * 0.5,
                  color: _getIconColor(context),
                ),
                child: icon,
              ),
      ),
    );

    if (tooltip != null) {
      return Tooltip(
        message: tooltip,
        child: button,
      );
    }

    return button;
  }

  Color _getIconColor(BuildContext context) {
    if (!isEnabled) return AppColors.textDisabled;
    return iconColor ?? AppColors.primary;
  }

  Color _getBorderColor(BuildContext context) {
    if (!isEnabled) return AppColors.borderMedium;
    return borderColor ?? AppColors.primary;
  }
}
