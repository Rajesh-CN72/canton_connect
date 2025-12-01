import 'package:flutter/material.dart';
import 'package:canton_connect/core/constants/app_colors.dart';

class CategoryChip extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;

  const CategoryChip({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
    this.selectedColor,
    this.unselectedColor,
    this.selectedTextColor,
    this.unselectedTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected 
              ? (selectedColor ?? AppColors.primary) 
              : (unselectedColor ?? AppColors.background),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected 
                ? (selectedColor ?? AppColors.primary) 
                : AppColors.borderMedium,
            width: 1.5,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isSelected 
                ? (selectedTextColor ?? Colors.white) 
                : (unselectedTextColor ?? AppColors.textSecondary),
          ),
        ),
      ),
    );
  }
}
