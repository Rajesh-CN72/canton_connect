import 'package:flutter/material.dart';
import 'package:canton_connect/core/utils/responsive.dart';

class PlaceholderImage extends StatelessWidget {
  final String text;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color color;
  final bool showIcon;
  final BorderRadiusGeometry borderRadius;
  final bool useResponsive;

  const PlaceholderImage({
    super.key,
    required this.text,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.color = Colors.grey,
    this.showIcon = true,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.useResponsive = true,
  });

  @override
  Widget build(BuildContext context) {
    final responsiveInstance = Responsive(context);
    final backgroundColor = _generateColorFromString(text);
    final actualWidth = _getActualWidth(responsiveInstance);
    final actualHeight = _getActualHeight(responsiveInstance);
    
    return Container(
      width: actualWidth,
      height: actualHeight,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1), // Fixed: Replaced deprecated withOpacity
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (showIcon)
            Icon(
              _getIconForFood(text),
              color: Colors.white.withAlpha(204), // 80% opacity
              size: _getIconSize(actualHeight),
            ),
          if (showIcon) SizedBox(height: _getSpacing(actualHeight)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: _getHorizontalPadding(actualWidth)),
            child: Text(
              _truncateText(text, actualWidth),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: _getFontSize(actualHeight),
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
              maxLines: _getMaxLines(actualHeight),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  double _getActualWidth(Responsive responsive) {
    if (width != null) return width!;
    if (useResponsive) { // Fixed: Using boolean flag instead of Responsive instance
      return responsive.getImageHeight() * 1.5; // Responsive width based on image height
    }
    return double.infinity;
  }

  double _getActualHeight(Responsive responsive) {
    if (height != null) return height!;
    if (useResponsive) { // Fixed: Using boolean flag instead of Responsive instance
      return responsive.getImageHeight(); // Use responsive image height
    }
    return 120;
  }

  Color _generateColorFromString(String input) {
    final colors = [
      const Color(0xFFEF5350), // Red 400
      const Color(0xFF42A5F5), // Blue 400
      const Color(0xFF66BB6A), // Green 400
      const Color(0xFFFFA726), // Orange 400
      const Color(0xFFAB47BC), // Purple 400
      const Color(0xFF26A69A), // Teal 400
      const Color(0xFFEC407A), // Pink 400
      const Color(0xFF5C6BC0), // Indigo 400
      const Color(0xFFFFB300), // Amber 600
      const Color(0xFF26C6DA), // Cyan 400
      const Color(0xFF29B6F6), // Light Blue 400
      const Color(0xFF9CCC65), // Light Green 400
      const Color(0xFFFF7043), // Deep Orange 400
      const Color(0xFF8D6E63), // Brown 400
      const Color(0xFF78909C), // Blue Grey 400
    ];
    
    final index = input.hashCode.abs() % colors.length;
    return colors[index];
  }

  IconData _getIconForFood(String foodName) {
    final lowerName = foodName.toLowerCase();
    
    // Chinese food names
    if (lowerName.contains('鸡') || lowerName.contains('chicken')) {
      return Icons.emoji_food_beverage;
    } else if (lowerName.contains('猪') || lowerName.contains('pork')) {
      return Icons.emoji_food_beverage;
    } else if (lowerName.contains('牛') || lowerName.contains('beef')) {
      return Icons.emoji_food_beverage;
    } else if (lowerName.contains('鱼') || lowerName.contains('fish')) {
      return Icons.set_meal;
    } else if (lowerName.contains('虾') || lowerName.contains('shrimp')) {
      return Icons.set_meal;
    } else if (lowerName.contains('饭') || lowerName.contains('rice')) {
      return Icons.rice_bowl;
    } else if (lowerName.contains('面') || lowerName.contains('noodle') || lowerName.contains('粉')) {
      return Icons.ramen_dining;
    } else if (lowerName.contains('菜') || lowerName.contains('vegetable') || lowerName.contains('veg')) {
      return Icons.eco;
    } else if (lowerName.contains('豆腐') || lowerName.contains('tofu')) {
      return Icons.eco;
    } else if (lowerName.contains('甜') || lowerName.contains('dessert') || lowerName.contains('布丁') || lowerName.contains('pudding')) {
      return Icons.cake;
    } else if (lowerName.contains('茶') || lowerName.contains('tea') || lowerName.contains('drink')) {
      return Icons.local_drink;
    } else if (lowerName.contains('套餐') || lowerName.contains('family') || lowerName.contains('feast') || lowerName.contains('combo')) {
      return Icons.family_restroom;
    } else if (lowerName.contains('春卷') || lowerName.contains('spring') || lowerName.contains('dumpling')) {
      return Icons.breakfast_dining;
    } else if (lowerName.contains('汤') || lowerName.contains('soup')) {
      return Icons.soup_kitchen;
    } else if (lowerName.contains('招牌') || lowerName.contains('signature') || lowerName.contains('烤鸭') || lowerName.contains('duck')) {
      return Icons.star;
    } else if (lowerName.contains('年轻人') || lowerName.contains('youth') || lowerName.contains('favorite') || lowerName.contains('crispy')) {
      return Icons.emoji_food_beverage;
    } else if (lowerName.contains('健康') || lowerName.contains('healthy') || lowerName.contains('罗汉') || lowerName.contains('buddha')) {
      return Icons.spa;
    } else if (lowerName.contains('宫保') || lowerName.contains('kung pao')) {
      return Icons.local_fire_department;
    } else if (lowerName.contains('麻辣') || lowerName.contains('spicy')) {
      return Icons.local_fire_department;
    } else {
      return Icons.restaurant;
    }
  }

  double _getIconSize(double height) {
    if (height < 60) return 16;
    if (height < 100) return 24;
    if (height < 150) return 32;
    if (height < 200) return 40;
    return 48;
  }

  double _getFontSize(double height) {
    if (height < 60) return 8;
    if (height < 100) return 10;
    if (height < 150) return 12;
    if (height < 200) return 14;
    return 16;
  }

  double _getSpacing(double height) {
    if (height < 60) return 4;
    if (height < 100) return 6;
    if (height < 150) return 8;
    return 10;
  }

  double _getHorizontalPadding(double width) {
    if (width < 100) return 4;
    if (width < 200) return 8;
    return 12;
  }

  int _getMaxLines(double height) {
    if (height < 80) return 1;
    if (height < 150) return 2;
    return 3;
  }

  String _truncateText(String text, double width) {
    final maxChars = _getMaxChars(width);
    if (text.length <= maxChars) return text;
    return '${text.substring(0, maxChars - 3)}...';
  }

  int _getMaxChars(double width) {
    if (width < 80) return 8;
    if (width < 120) return 12;
    if (width < 180) return 16;
    if (width < 240) return 20;
    return 25;
  }
}

// Enhanced version with image loading fallback and responsive design
class SmartPlaceholderImage extends StatelessWidget {
  final String? imageUrl;
  final String placeholderText;
  final double? width;
  final double? height;
  final BoxFit fit;
  final bool showIcon;
  final BorderRadiusGeometry borderRadius;
  final bool useResponsive;

  const SmartPlaceholderImage({
    super.key,
    this.imageUrl,
    required this.placeholderText,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.showIcon = true,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.useResponsive = true,
  });

  @override
  Widget build(BuildContext context) {
    final responsiveInstance = Responsive(context);
    
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      // Check if it's a network image or asset
      if (imageUrl!.startsWith('http')) {
        return Image.network(
          imageUrl!,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (context, error, stackTrace) {
            return PlaceholderImage(
              text: placeholderText,
              width: width,
              height: height,
              showIcon: showIcon,
              borderRadius: borderRadius,
              useResponsive: useResponsive,
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return _buildLoadingPlaceholder(responsiveInstance);
          },
        );
      } else {
        // Asset image
        return Image.asset(
          imageUrl!,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (context, error, stackTrace) {
            return PlaceholderImage(
              text: placeholderText,
              width: width,
              height: height,
              showIcon: showIcon,
              borderRadius: borderRadius,
              useResponsive: useResponsive,
            );
          },
        );
      }
    }
    
    return PlaceholderImage(
      text: placeholderText,
      width: width,
      height: height,
      showIcon: showIcon,
      borderRadius: borderRadius,
      useResponsive: useResponsive,
    );
  }

  Widget _buildLoadingPlaceholder(Responsive responsive) {
    final actualWidth = _getActualWidth(responsive);
    final actualHeight = _getActualHeight(responsive);
    
    return Container(
      width: actualWidth,
      height: actualHeight,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: borderRadius,
      ),
      child: const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
        ),
      ),
    );
  }

  double _getActualWidth(Responsive responsive) {
    if (width != null) return width!;
    if (useResponsive) { // Fixed: Using boolean flag instead of Responsive instance
      return responsive.getImageHeight() * 1.5;
    }
    return double.infinity;
  }

  double _getActualHeight(Responsive responsive) {
    if (height != null) return height!;
    if (useResponsive) { // Fixed: Using boolean flag instead of Responsive instance
      return responsive.getImageHeight();
    }
    return 120;
  }
}

// Specialized placeholder for food items with common food categories
class FoodPlaceholderImage extends StatelessWidget {
  final String foodName;
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadiusGeometry borderRadius;

  const FoodPlaceholderImage({
    super.key,
    required this.foodName,
    this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  });

  @override
  Widget build(BuildContext context) {
    return SmartPlaceholderImage(
      imageUrl: imageUrl,
      placeholderText: foodName,
      width: width,
      height: height,
      fit: fit,
      showIcon: true,
      borderRadius: borderRadius,
      useResponsive: true,
    );
  }
}
