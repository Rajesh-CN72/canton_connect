import 'package:flutter/material.dart';
import 'package:canton_connect/data/models/food_item.dart';
import 'package:canton_connect/core/constants/app_colors.dart';

class FoodCard extends StatelessWidget {
  final FoodItem foodItem;
  final String currentLanguage;
  final VoidCallback onTap;
  final VoidCallback? onFavorite;
  final VoidCallback? onQuickAdd;
  final bool isFavorite;
  final int? itemCount;

  const FoodCard({
    super.key,
    required this.foodItem,
    required this.currentLanguage,
    required this.onTap,
    this.onFavorite,
    this.onQuickAdd,
    this.isFavorite = false,
    this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(0),
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          // FIXED: Use Container with constraints instead of relying on Expanded
          constraints: BoxConstraints(
            minHeight: _getCardMinHeight(context),
            maxHeight: _getCardMaxHeight(context),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // FIXED: Use min to prevent expansion
            children: [
              // Image Section
              _buildImageSection(context),
              
              // Content Section - FIXED: Remove Expanded and use flexible content
              _buildContentSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    return SizedBox(
      height: _getImageHeight(context),
      width: double.infinity,
      child: Stack(
        children: [
          // Food Image with better loading states
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              image: foodItem.images.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(foodItem.images.first),
                      fit: BoxFit.cover,
                    )
                  : const DecorationImage(
                      image: AssetImage('assets/images/food_placeholder.png'),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          
          // Subtle gradient overlay (Grain style)
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withAlpha(38),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.7],
              ),
            ),
          ),
          
          // Top badges - More organized layout
          Positioned(
            top: 8,
            left: 8,
            right: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left badges - Featured, New, etc.
                Flexible(
                  child: Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: _buildPrimaryBadges(),
                  ),
                ),
                
                // Right actions - Favorite button
                if (onFavorite != null)
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(229),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(25),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: onFavorite,
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : AppColors.textSecondary,
                        size: 16,
                      ),
                      padding: EdgeInsets.zero,
                      iconSize: 16,
                    ),
                  ),
              ],
            ),
          ),
          
          // Bottom overlay with quick actions (Tsquaredeats style)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withAlpha(178),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.5],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Dietary badges
                  Wrap(
                    spacing: 4,
                    children: _buildDietaryBadges(),
                  ),
                  
                  // Quick add button (Tsquaredeats feature)
                  if (onQuickAdd != null && itemCount == null)
                    Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: onQuickAdd,
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 16,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  
                  // Quantity selector (Tsquaredeats feature)
                  if (itemCount != null && itemCount! > 0)
                    Container(
                      height: 28,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              // Decrease quantity - you'll need to implement this
                            },
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: 16,
                            ),
                            padding: const EdgeInsets.all(4),
                            constraints: const BoxConstraints(
                              minWidth: 28,
                              minHeight: 28,
                            ),
                          ),
                          Text(
                            itemCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          IconButton(
                            onPressed: onQuickAdd,
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 16,
                            ),
                            padding: const EdgeInsets.all(4),
                            constraints: const BoxConstraints(
                              minWidth: 28,
                              minHeight: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentSection(BuildContext context) {
    return Flexible( // FIXED: Use Flexible instead of Expanded
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // FIXED: Use min to prevent expansion
          children: [
            // Food Name - Clean typography (Grain style)
            Text(
              currentLanguage == 'zh' ? foodItem.nameZh : foodItem.nameEn,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            
            const SizedBox(height: 4),
            
            // Food Description - Minimalist (Grain style)
            // FIXED: Use Flexible to handle text overflow properly
            Flexible(
              child: Text(
                currentLanguage == 'zh' ? foodItem.descriptionZh : foodItem.descriptionEn,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Bottom row with price and attributes
            _buildBottomRow(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomRow(BuildContext context) {
    return Container( // FIXED: Wrap in Container for better layout control
      constraints: BoxConstraints(
        maxHeight: 24,
        minWidth: MediaQuery.of(context).size.width,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Price - More prominent (Grain style)
          Flexible(
            flex: 2,
            child: Text(
              _formatPrice(foodItem.price),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          
          // Food Attributes - Clean and compact
          Flexible(
            flex: 3,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Rating
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 14,
                      ),
                      const SizedBox(width: 2),
                      Flexible(
                        child: Text(
                          foodItem.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 8),
                
                // Cooking Time
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.schedule,
                        color: AppColors.textSecondary,
                        size: 12,
                      ),
                      const SizedBox(width: 2),
                      Flexible(
                        child: Text(
                          '${foodItem.cookingTime}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPrimaryBadges() {
    final badges = <Widget>[];
    
    // Priority order for badges
    if (foodItem.isFeatured) {
      badges.add(_buildBadge('推荐', Colors.purple, Icons.star));
    }
    if (foodItem.isNew) {
      badges.add(_buildBadge('新品', const Color(0xFF27AE60), Icons.fiber_new));
    }
    if (foodItem.isPopular) {
      badges.add(_buildBadge('热门', const Color(0xFFE67E22), Icons.trending_up));
    }
    
    return badges;
  }

  List<Widget> _buildDietaryBadges() {
    final badges = <Widget>[];
    
    if (foodItem.isSpicy) {
      badges.add(_buildSmallBadge('🌶️', '辣'));
    }
    if (foodItem.isVegetarian) {
      badges.add(_buildSmallBadge('🥬', '素食'));
    }
    if (foodItem.isVegan) {
      badges.add(_buildSmallBadge('🌱', '纯素'));
    }
    
    return badges;
  }

  Widget _buildBadge(String text, Color color, IconData? icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Icon(
              icon,
              size: 10,
              color: Colors.white,
            ),
          if (icon != null) const SizedBox(width: 2),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallBadge(String emoji, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(178),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 10),
          ),
          const SizedBox(width: 2),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // Format price - Clean formatting
  String _formatPrice(double price) {
    if (price == price.truncateToDouble()) {
      return '¥${price.toInt()}';
    }
    return '¥${price.toStringAsFixed(2)}';
  }

  // Image height - Optimized for different screen sizes
  double _getImageHeight(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth < 600) {
      return 120; // Mobile: compact
    } else if (screenWidth < 900) {
      return 140; // Tablet: balanced
    } else {
      return 160; // Desktop: spacious
    }
  }

  // FIXED: Add minimum and maximum height constraints
  double _getCardMinHeight(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth < 600) {
      return 220; // Mobile minimum height
    } else if (screenWidth < 900) {
      return 240; // Tablet minimum height
    } else {
      return 260; // Desktop minimum height
    }
  }

  double _getCardMaxHeight(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth < 600) {
      return 280; // Mobile maximum height
    } else if (screenWidth < 900) {
      return 300; // Tablet maximum height
    } else {
      return 320; // Desktop maximum height
    }
  }
}
