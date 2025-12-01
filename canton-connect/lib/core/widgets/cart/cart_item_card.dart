import 'package:flutter/material.dart';
import 'package:canton_connect/core/constants/app_colors.dart';
import 'package:canton_connect/core/constants/app_constants.dart';
import 'package:canton_connect/core/constants/app_strings.dart';
import 'package:canton_connect/core/widgets/buttons/secondary_icon_button.dart';
import 'package:canton_connect/data/models/food_item.dart'; // Import FoodOrder from here

class CartItemCard extends StatelessWidget {
  final FoodOrder foodOrder; // Changed from CartItem to FoodOrder
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;
  final String currentLanguage;

  const CartItemCard({
    super.key, // Fixed: Using super parameter
    required this.foodOrder, // Changed parameter name
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
    required this.currentLanguage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Main Item Content
          Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Food Image
                _buildFoodImage(),
                const SizedBox(width: 12),
                
                // Food Details
                Expanded(
                  child: _buildFoodDetails(),
                ),
                
                // Remove Button
                SecondaryIconButton(
                  icon: const Icon(Icons.close),
                  onPressed: onRemove,
                  size: 32,
                  tooltip: AppStrings.delete,
                ),
              ],
            ),
          ),
          
          // Add-ons Section
          if (foodOrder.selectedAddOns.isNotEmpty) ...[
            const Divider(height: 1),
            _buildAddOnsSection(),
          ],
          
          // Quantity Controls
          const Divider(height: 1),
          _buildQuantityControls(),
        ],
      ),
    );
  }

  Widget _buildFoodImage() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        color: AppColors.primaryContainer,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        child: foodOrder.foodItem.images.isNotEmpty
            ? Image.network(
                foodOrder.foodItem.images.first,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.primaryContainer,
                    child: const Icon(
                      Icons.fastfood,
                      size: 32,
                      color: AppColors.primary,
                    ),
                  );
                },
              )
            : Container(
                color: AppColors.primaryContainer,
                child: const Icon(
                  Icons.fastfood,
                  size: 32,
                  color: AppColors.primary,
                ),
              ),
      ),
    );
  }

  Widget _buildFoodDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Food Name
        Text(
          currentLanguage == 'zh' 
              ? foodOrder.foodItem.nameZh
              : foodOrder.foodItem.nameEn,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
            fontFamily: AppConstants.primaryFont,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        
        const SizedBox(height: 4),
        
        // Description
        Text(
          currentLanguage == 'zh'
              ? foodOrder.foodItem.descriptionZh
              : foodOrder.foodItem.descriptionEn,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
            fontFamily: AppConstants.primaryFont,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        
        const SizedBox(height: 8),
        
        // Price
        Text(
          AppStrings.formatPrice(foodOrder.foodItem.price),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
            fontFamily: AppConstants.primaryFont,
          ),
        ),
      ],
    );
  }

  Widget _buildAddOnsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            currentLanguage == 'zh' ? '附加项目' : 'Add-ons',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: foodOrder.selectedAddOns.map((addOn) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      currentLanguage == 'zh' ? addOn.nameZh : addOn.nameEn,
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      AppStrings.formatPrice(addOn.price),
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: 12,
      ),
      child: Row(
        children: [
          // Quantity Label
          const Text(
            AppStrings.quantity,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          
          const Spacer(),
          
          // Quantity Controls
          Container(
            decoration: BoxDecoration(
              color: AppColors.primaryContainer,
              borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
            ),
            child: Row(
              children: [
                // Decrease Button
                IconButton(
                  icon: Icon(
                    Icons.remove,
                    color: foodOrder.quantity > 1
                        ? AppColors.primary 
                        : AppColors.textDisabled,
                    size: 18,
                  ),
                  onPressed: foodOrder.quantity > 1 ? onDecrease : null,
                  padding: const EdgeInsets.all(4),
                  constraints: const BoxConstraints(
                    minWidth: 36,
                    minHeight: 36,
                  ),
                ),
                
                // Quantity Display
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    '${foodOrder.quantity}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                
                // Increase Button
                IconButton(
                  icon: Icon(
                    Icons.add,
                    color: foodOrder.quantity < AppConstants.maxQuantityPerItem
                        ? AppColors.primary 
                        : AppColors.textDisabled,
                    size: 18,
                  ),
                  onPressed: foodOrder.quantity < AppConstants.maxQuantityPerItem
                      ? onIncrease 
                      : null,
                  padding: const EdgeInsets.all(4),
                  constraints: const BoxConstraints(
                    minWidth: 36,
                    minHeight: 36,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Total Price
          Text(
            AppStrings.formatPrice(foodOrder.totalPrice),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
              fontFamily: AppConstants.primaryFont,
            ),
          ),
        ],
      ),
    );
  }
}
