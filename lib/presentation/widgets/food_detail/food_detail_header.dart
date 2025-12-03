import 'package:flutter/material.dart';
import 'package:canton_connect/data/models/food_item.dart';
import 'package:canton_connect/core/constants/app_colors.dart';

class FoodDetailHeader extends StatelessWidget {
  final FoodItem foodItem;
  final String currentLanguage;
  final bool isFavorite;
  final VoidCallback onBackPressed;
  final VoidCallback onFavoritePressed;
  final VoidCallback onSharePressed;

  const FoodDetailHeader({
    super.key,
    required this.foodItem,
    required this.currentLanguage,
    required this.isFavorite,
    required this.onBackPressed,
    required this.onFavoritePressed,
    required this.onSharePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Custom App Bar
        _buildAppBar(context),
        
        // Food Images
        _buildImageSection(),
        
        // Food Basic Info
        _buildBasicInfoSection(),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context) {
    Widget buildIconButton({
      required Icon icon,
      required VoidCallback onPressed,
      String? tooltip,
      Color? iconColor,
    }) {
      return IconButton(
        icon: icon,
        onPressed: onPressed,
        tooltip: tooltip,
        color: iconColor ?? AppColors.textSecondary,
        style: IconButton.styleFrom(
          backgroundColor: AppColors.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Row(
            children: [
              buildIconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: onBackPressed,
                tooltip: 'Back',
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  currentLanguage == 'zh' ? foodItem.nameZh : foodItem.nameEn,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              buildIconButton(
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                onPressed: onFavoritePressed,
                tooltip: isFavorite ? 'Remove from favorites' : 'Add to favorites',
                iconColor: isFavorite ? Colors.red : null,
              ),
              const SizedBox(width: 8),
              buildIconButton(
                icon: const Icon(Icons.share),
                onPressed: onSharePressed,
                tooltip: 'Share',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return SizedBox(
      height: 250,
      child: Stack(
        children: [
          // Main Image
          PageView.builder(
            itemCount: foodItem.images.length,
            itemBuilder: (context, index) {
              return Image.network(
                foodItem.images[index],
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.primary.withAlpha(25),
                    child: const Icon(
                      Icons.fastfood,
                      size: 80,
                      color: AppColors.primary,
                    ),
                  );
                },
              );
            },
          ),
          
          // Badges
          Positioned(
            top: 16,
            left: 16,
            child: Wrap(
              spacing: 8,
              direction: Axis.vertical,
              children: [
                if (foodItem.isSpicy)
                  _buildBadge('🌶️ Spicy', Colors.red),
                if (foodItem.isVegetarian)
                  _buildBadge('🥬 Vegetarian', Colors.green),
                if (foodItem.isVegan)
                  _buildBadge('🌱 Vegan', Colors.lightGreen),
                if (foodItem.isPopular)
                  _buildBadge('🔥 Popular', Colors.orange),
                if (foodItem.isNew)
                  _buildBadge('🆕 New', Colors.blue),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildBasicInfoSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Food Name
          Text(
            currentLanguage == 'zh' ? foodItem.nameZh : foodItem.nameEn,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          
          // Description
          Text(
            currentLanguage == 'zh' ? foodItem.descriptionZh : foodItem.descriptionEn,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          
          // Rating and Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Rating
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    foodItem.rating.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '(${foodItem.reviewCount})',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              
              // Price
              Text(
                '\$${foodItem.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
