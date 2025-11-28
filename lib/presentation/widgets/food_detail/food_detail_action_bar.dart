import 'package:flutter/material.dart';
import 'package:canton_connect/core/constants/app_colors.dart';
import 'package:canton_connect/core/widgets/buttons/primary_button.dart';
import 'package:canton_connect/core/widgets/buttons/secondary_button.dart';

class FoodDetailActionBar extends StatelessWidget {
  final int quantity;
  final double totalPrice;
  final Function(int) onQuantityChanged;
  final VoidCallback onAddToCart;
  final VoidCallback onBuyNow;

  const FoodDetailActionBar({
    super.key,
    required this.quantity,
    required this.totalPrice,
    required this.onQuantityChanged,
    required this.onAddToCart,
    required this.onBuyNow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).padding.bottom + 16,
            top: 16,
          ),
          child: Row(
            children: [
              // Quantity Selector
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(25),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.remove,
                        color: quantity > 1 ? AppColors.primary : AppColors.textDisabled,
                      ),
                      onPressed: quantity > 1 ? () => onQuantityChanged(quantity - 1) : null,
                    ),
                    Text(
                      '$quantity',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add,
                        color: quantity < 10 ? AppColors.primary : AppColors.textDisabled,
                      ),
                      onPressed: quantity < 10 
                          ? () => onQuantityChanged(quantity + 1) 
                          : null,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Price Display
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '\$${totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Action Buttons
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                      child: SecondaryButton(
                        text: 'Add to Cart',
                        onPressed: onAddToCart,
                        height: 50,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: PrimaryButton(
                        text: 'Buy Now',
                        onPressed: onBuyNow,
                        height: 50,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
