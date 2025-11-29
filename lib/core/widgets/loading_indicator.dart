import 'package:flutter/material.dart';
import 'package:canton_connect/core/utils/responsive.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final String? message;
  final Color? color;
  final double? size;
  final double strokeWidth;
  final bool usePrimaryColor;
  final bool showMessage;
  final Axis direction;
  final MainAxisAlignment alignment;

  const CustomLoadingIndicator({
    super.key, // Fixed: Using super parameter
    this.message,
    this.color,
    this.size,
    this.strokeWidth = 4.0,
    this.usePrimaryColor = true,
    this.showMessage = true,
    this.direction = Axis.vertical,
    this.alignment = MainAxisAlignment.center,
  });

  factory CustomLoadingIndicator.small({
    String? message,
    Color? color,
  }) {
    return CustomLoadingIndicator(
      message: message,
      color: color,
      size: 20,
      strokeWidth: 2.0,
      showMessage: message != null,
    );
  }

  factory CustomLoadingIndicator.large({
    String? message,
    Color? color,
  }) {
    return CustomLoadingIndicator(
      message: message,
      color: color,
      size: 48,
      strokeWidth: 4.0,
    );
  }

  factory CustomLoadingIndicator.page({
    String? message,
  }) {
    return CustomLoadingIndicator(
      message: message ?? 'Loading...',
      size: 40,
      strokeWidth: 4.0,
      direction: Axis.vertical,
      alignment: MainAxisAlignment.center,
    );
  }

  factory CustomLoadingIndicator.button() {
    return const CustomLoadingIndicator(
      message: null,
      size: 20,
      strokeWidth: 2.0,
      showMessage: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    
    final effectiveColor = color ?? 
        (usePrimaryColor 
            ? Theme.of(context).primaryColor
            : Colors.grey.shade600);

    final effectiveSize = size ?? responsive.responsiveValue(
      mobile: 32.0,
      tablet: 36.0,
      desktop: 40.0,
    );

    final widget = Flex(
      direction: direction,
      mainAxisAlignment: alignment,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: effectiveSize,
          height: effectiveSize,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(effectiveColor),
            strokeWidth: strokeWidth,
          ),
        ),
        if (showMessage && message != null) ...[
          if (direction == Axis.vertical) 
            SizedBox(height: responsive.spacingM)
          else 
            SizedBox(width: responsive.spacingM),
          Flexible(
            child: Text(
              message!,
              style: TextStyle(
                fontSize: responsive.fontSizeBodyMedium,
                color: effectiveColor,
                fontWeight: FontWeight.w500,
              ),
              textAlign: direction == Axis.vertical ? TextAlign.center : TextAlign.left,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ],
    );

    return direction == Axis.vertical
        ? Center(child: widget)
        : widget;
  }
}

class ShimmerLoading extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Color? baseColor;
  final Color? highlightColor;

  const ShimmerLoading({
    super.key, // Fixed: Using super parameter
    required this.width,
    required this.height,
    this.borderRadius = 8,
    this.baseColor,
    this.highlightColor,
  });

  factory ShimmerLoading.card() {
    return const ShimmerLoading(
      width: double.infinity,
      height: 120,
      borderRadius: 12,
    );
  }

  factory ShimmerLoading.listTile() {
    return const ShimmerLoading(
      width: double.infinity,
      height: 72,
      borderRadius: 8,
    );
  }

  factory ShimmerLoading.circle({double size = 40}) {
    return ShimmerLoading(
      width: size,
      height: size,
      borderRadius: size / 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: baseColor ?? Colors.grey.shade300,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

class LoadingGrid extends StatelessWidget {
  final int itemCount;
  final double childAspectRatio;
  final double spacing;

  const LoadingGrid({
    super.key, // Fixed: Using super parameter
    this.itemCount = 6,
    this.childAspectRatio = 0.8,
    this.spacing = 16,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: responsive.getGridCrossAxisCount(
          mobile: 2,
          tablet: 3,
          desktop: 4,
        ),
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return ShimmerLoading.card();
      },
    );
  }
}

class LoadingList extends StatelessWidget {
  final int itemCount;
  final double itemHeight;
  final double spacing;

  const LoadingList({
    super.key, // Fixed: Using super parameter
    this.itemCount = 5,
    this.itemHeight = 80,
    this.spacing = 12,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      separatorBuilder: (context, index) => SizedBox(height: spacing),
      itemBuilder: (context, index) {
        return ShimmerLoading.listTile();
      },
    );
  }
}

class ProgressiveImageLoader extends StatefulWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;

  const ProgressiveImageLoader({
    super.key, // Fixed: Using super parameter
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = 8,
    this.placeholder,
    this.errorWidget,
  });

  @override
  State<ProgressiveImageLoader> createState() => _ProgressiveImageLoaderState();
}

class _ProgressiveImageLoaderState extends State<ProgressiveImageLoader> {
  late final Future<void> _imageLoading;

  @override
  void initState() {
    super.initState();
    _imageLoading = _loadImage();
  }

  Future<void> _loadImage() async {
    try {
      final provider = NetworkImage(widget.imageUrl);
      await precacheImage(provider, context);
    } catch (e) {
      // Handle image loading error
      debugPrint('Failed to load image: ${widget.imageUrl} - $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _imageLoading,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.placeholder ??
              ShimmerLoading(
                width: widget.width ?? double.infinity,
                height: widget.height ?? 200,
                borderRadius: widget.borderRadius,
              );
        } else if (snapshot.hasError) {
          return widget.errorWidget ??
              Container(
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
                child: Icon(
                  Icons.broken_image,
                  color: Colors.grey.shade400,
                  size: 40,
                ),
              );
        } else {
          return ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: Image.network(
              widget.imageUrl,
              width: widget.width,
              height: widget.height,
              fit: widget.fit,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return ShimmerLoading(
                  width: widget.width ?? double.infinity,
                  height: widget.height ?? 200,
                  borderRadius: widget.borderRadius,
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return widget.errorWidget ??
                    Container(
                      width: widget.width,
                      height: widget.height,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(widget.borderRadius),
                      ),
                      child: Icon(
                        Icons.broken_image,
                        color: Colors.grey.shade400,
                        size: 40,
                      ),
                    );
              },
            ),
          );
        }
      },
    );
  }
}

// Additional loading widgets for common use cases
class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final String? message;
  final Color? overlayColor;

  const LoadingOverlay({
    super.key, // Fixed: Using super parameter
    required this.isLoading,
    required this.child,
    this.message,
    this.overlayColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: overlayColor ?? Colors.black54,
            child: Center(
              child: CustomLoadingIndicator.page(message: message),
            ),
          ),
      ],
    );
  }
}

class LoadingButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final Widget child;
  final double? width;
  final double? height;
  final Color? loadingColor;

  const LoadingButton({
    super.key, // Fixed: Using super parameter
    required this.isLoading,
    required this.onPressed,
    required this.child,
    this.width,
    this.height,
    this.loadingColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? CustomLoadingIndicator.button()
            : child,
      ),
    );
  }
}
