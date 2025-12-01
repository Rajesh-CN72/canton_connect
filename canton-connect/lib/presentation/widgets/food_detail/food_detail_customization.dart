import 'package:flutter/material.dart';
import 'package:canton_connect/data/models/food_item.dart';
import 'package:canton_connect/core/constants/app_colors.dart';

class FoodDetailCustomization extends StatefulWidget {
  final FoodItem foodItem;
  final String currentLanguage;
  final List<AddOn> selectedAddOns;
  final Function(List<AddOn>) onAddOnsChanged;
  final Function(AddOn)? onAddOnToggled;

  const FoodDetailCustomization({
    super.key,
    required this.foodItem,
    required this.currentLanguage,
    required this.selectedAddOns,
    required this.onAddOnsChanged,
    required this.onAddOnToggled,
  });

  @override
  State<FoodDetailCustomization> createState() => _FoodDetailCustomizationState();
}

class _FoodDetailCustomizationState extends State<FoodDetailCustomization> {
  void _toggleAddOn(AddOn addOn) {
    final newSelectedAddOns = List<AddOn>.from(widget.selectedAddOns);
    if (newSelectedAddOns.contains(addOn)) {
      newSelectedAddOns.remove(addOn);
    } else {
      newSelectedAddOns.add(addOn);
    }
    widget.onAddOnsChanged(newSelectedAddOns);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.foodItem.availableAddOns.isEmpty) {
      return const SizedBox.shrink();
    }

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
          Row(
            children: [
              const Icon(
                Icons.tune,
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                widget.currentLanguage == 'zh' ? '定制选项' : 'Customization',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Add-ons List
          Column(
            children: widget.foodItem.availableAddOns.map((addOn) {
              final isSelected = widget.selectedAddOns.contains(addOn);
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _toggleAddOn(addOn),
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary.withAlpha(25) : AppColors.background,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.borderLight,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected ? AppColors.primary : Colors.transparent,
                              border: Border.all(
                                color: isSelected ? AppColors.primary : AppColors.borderMedium,
                              ),
                            ),
                            child: isSelected
                                ? const Icon(
                                    Icons.check,
                                    size: 14,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.currentLanguage == 'zh' ? addOn.nameZh : addOn.nameEn,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                if (addOn.descriptionEn.isNotEmpty)
                                  Text(
                                    widget.currentLanguage == 'zh' ? addOn.descriptionZh : addOn.descriptionEn,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textSecondary,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                              ],
                            ),
                          ),
                          Text(
                            '\$${addOn.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
