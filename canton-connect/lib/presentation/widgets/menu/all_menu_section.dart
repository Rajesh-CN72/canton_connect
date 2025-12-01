import 'package:flutter/material.dart';
import 'package:canton_connect/data/models/food_item.dart';
import 'package:canton_connect/core/utils/responsive.dart';
import 'package:canton_connect/presentation/common/food_card.dart';

class AllMenuSection extends StatelessWidget {
  final String currentLanguage;
  final List<FoodItem> foodItems;
  final Function(FoodItem) onFoodItemTap;

  const AllMenuSection({
    super.key,
    required this.currentLanguage,
    required this.foodItems,
    required this.onFoodItemTap,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    
    if (foodItems.isEmpty) {
      return _buildEmptyState();
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: _getHorizontalPadding(responsive),
      ),
      child: _buildFoodGrid(responsive),
    );
  }

  Widget _buildFoodGrid(Responsive responsive) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _getCrossAxisCount(responsive),
        crossAxisSpacing: _getGridSpacing(responsive),
        mainAxisSpacing: _getGridSpacing(responsive),
        childAspectRatio: _getChildAspectRatio(responsive),
      ),
      itemCount: foodItems.length,
      itemBuilder: (context, index) {
        return FoodCard(
          foodItem: foodItems[index],
          currentLanguage: currentLanguage,
          onTap: () => onFoodItemTap(foodItems[index]),
        );
      },
    );
  }

  // NEW: Helper method to replace the deprecated getHorizontalPadding
  double _getHorizontalPadding(Responsive responsive) {
    return responsive.getResponsivePadding(
      16.0, // mobile
      tablet: 20.0,
      desktop: 24.0,
      largeDesktop: 32.0,
    );
  }

  int _getCrossAxisCount(Responsive responsive) {
    return responsive.responsiveValue(
      mobile: 2,  // Mobile: 2 columns
      tablet: 3,  // Tablet: 3 columns  
      desktop: 4, // Desktop: 4 columns
      largeDesktop: 5, // Large desktop: 5 columns
    );
  }

  double _getChildAspectRatio(Responsive responsive) {
    return responsive.responsiveValue(
      mobile: 0.75,   // Taller cards on mobile
      tablet: 0.85,   // Medium aspect ratio on tablet
      desktop: 0.9,   // Wider cards on desktop
      largeDesktop: 0.9, // Same as desktop for large desktop
    );
  }

  double _getGridSpacing(Responsive responsive) {
    return responsive.responsiveValue(
      mobile: 12.0,   // Tighter spacing on mobile
      tablet: 16.0,   // Medium spacing on tablet
      desktop: 20.0,  // More spacious on desktop
      largeDesktop: 20.0, // Same as desktop
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Icon(
            Icons.fastfood,
            size: 64,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            currentLanguage == 'zh' ? '暂无菜品' : 'No items available',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[500],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            currentLanguage == 'zh' 
                ? '请选择其他分类' 
                : 'Please select another category',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}
