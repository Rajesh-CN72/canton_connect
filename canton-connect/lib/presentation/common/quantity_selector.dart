import 'package:flutter/material.dart';
import 'package:canton_connect/core/constants/app_colors.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final ValueChanged<int> onChanged;
  final int minQuantity;
  final int maxQuantity;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool compact;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onChanged,
    this.minQuantity = 1,
    this.maxQuantity = 10,
    this.backgroundColor,
    this.foregroundColor,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = foregroundColor ?? AppColors.primary;
    final bgColor = backgroundColor ?? AppColors.primary.withAlpha(25);

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(compact ? 20 : 8),
      ),
      child: Row(
        mainAxisSize: compact ? MainAxisSize.min : MainAxisSize.max,
        children: [
          // Decrease Button
          IconButton(
            icon: Icon(
              compact ? Icons.remove : Icons.remove,
              color: quantity > minQuantity ? primaryColor : AppColors.textDisabled,
              size: compact ? 18 : 24,
            ),
            onPressed: quantity > minQuantity ? () => onChanged(quantity - 1) : null,
            padding: compact ? const EdgeInsets.all(4) : const EdgeInsets.all(8),
            constraints: const BoxConstraints(),
          ),
          
          // Quantity Display
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              '$quantity',
              style: TextStyle(
                fontSize: compact ? 14 : 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          
          // Increase Button
          IconButton(
            icon: Icon(
              compact ? Icons.add : Icons.add,
              color: quantity < maxQuantity ? primaryColor : AppColors.textDisabled,
              size: compact ? 18 : 24,
            ),
            onPressed: quantity < maxQuantity ? () => onChanged(quantity + 1) : null,
            padding: compact ? const EdgeInsets.all(4) : const EdgeInsets.all(8),
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}
