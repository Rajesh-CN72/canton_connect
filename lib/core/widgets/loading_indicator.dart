import 'package:flutter/material.dart';
import 'package:canton_connect/core/constants/app_constants.dart';
import 'package:canton_connect/core/responsive.dart';

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
    Key? key,
    this.message,
    this.color,
    this.size,
    this.strokeWidth = 4.0,
    this.usePrimaryColor = true,
    this.showMessage = true,
    this.direction = Axis.vertical,
    this.alignment = MainAxisAlignment.center,
  }) : super(key: key);

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
    final effectiveColor = color ?? 
        (usePrimaryColor 
            ? const Color(AppConstants.primaryColorValue)
            : Colors.grey.shade600);

    final effectiveSize = size ?? Responsive.responsiveValue<double>(
      context,
      mobile: 32,
      tablet: 36,
      desktop: 40,
    );

    // FIXED: Use const constructor for Flex widget
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
            const SizedBox(height: 16)
          else 
            const SizedBox(width: 16),
          Flexible(
            child: Text(
              message!,
              style: TextStyle(
                fontSize: Responsive.getBodyFontSize(context),
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
    Key? key,
    required this.width,
    required this.height,
    this.borderRadius = 8,
    this.baseColor,
    this.highlightColor,
  }) : super(key: key);

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
  final int crossAxisCount;
  final double childAspectRatio;
  final double spacing;

  const LoadingGrid({
    Key? key,
    this.itemCount = 6,
    this.crossAxisCount = 2,
    this.childAspectRatio = 0.8,
    this.spacing = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      // FIXED: Removed const from NeverScrollableScrollPhysics constructor
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Responsive.responsiveValue<int>(
          context,
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
        // FIXED: Removed const from ShimmerLoading.card() constructor
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
    Key? key,
    this.itemCount = 5,
    this.itemHeight = 80,
    this.spacing = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      // FIXED: Added const to NeverScrollableScrollPhysics constructor
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      separatorBuilder: (context, index) => SizedBox(height: spacing),
      itemBuilder: (context, index) {
        // FIXED: Removed const from ShimmerLoading.listTile() constructor
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
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = 8,
    this.placeholder,
    this.errorWidget,
  }) : super(key: key);

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
      await precacheImage(AssetImage(widget.imageUrl), context);
    } catch (e) {
      // Handle image loading error
      debugPrint('Failed to load image: ${widget.imageUrl}');
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
            child: Image.asset(
              widget.imageUrl,
              width: widget.width,
              height: widget.height,
              fit: widget.fit,
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
