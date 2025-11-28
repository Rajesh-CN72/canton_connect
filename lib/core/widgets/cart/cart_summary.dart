import 'package:flutter/material.dart';
import 'package:canton_connect/core/providers/cart_provider.dart';
import 'package:canton_connect/core/constants/app_colors.dart';
import 'package:canton_connect/core/constants/app_constants.dart';
import 'package:canton_connect/core/constants/app_strings.dart';
import 'package:canton_connect/core/utils/helpers.dart';
import 'package:canton_connect/core/widgets/buttons/primary_button.dart';

class CartSummary extends StatelessWidget {
  final CartProvider cartProvider;
  final VoidCallback onCheckout; // Changed to non-nullable VoidCallback
  final String currentLanguage;
  final bool isLoading;

  const CartSummary({
    Key? key,
    required this.cartProvider,
    required this.onCheckout, // Now requires a non-nullable function
    required this.currentLanguage,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subtotal = cartProvider.totalAmount;
    final tax = Helpers.calculateTax(subtotal);
    final deliveryFee = Helpers.calculateDeliveryFee(subtotal);
    final total = subtotal + tax + deliveryFee;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Order Summary Header
          Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Row(
              children: [
                const Icon(
                  Icons.receipt_long,
                  color: AppColors.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  currentLanguage == 'zh' ? '订单摘要' : AppStrings.orderSummary,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    fontFamily: AppConstants.primaryFont,
                  ),
                ),
              ],
            ),
          ),
          
          const Divider(height: 1),
          
          // Price Breakdown
          Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Column(
              children: [
                _buildPriceRow(
                  currentLanguage == 'zh' ? '小计' : AppStrings.subtotal,
                  AppStrings.formatPrice(subtotal),
                ),
                const SizedBox(height: 8),
                _buildPriceRow(
                  AppStrings.tax,
                  AppStrings.formatPrice(tax),
                ),
                const SizedBox(height: 8),
                _buildPriceRow(
                  currentLanguage == 'zh' ? '配送费' : AppStrings.deliveryFee,
                  deliveryFee == 0 
                      ? AppStrings.free 
                      : AppStrings.formatPrice(deliveryFee),
                  isFree: deliveryFee == 0,
                ),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 12),
                _buildPriceRow(
                  currentLanguage == 'zh' ? '总计' : AppStrings.grandTotal,
                  AppStrings.formatPrice(total),
                  isTotal: true,
                ),
                
                // Free Delivery Message
                if (deliveryFee == 0) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.successLight,
                      borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.local_shipping,
                          color: AppColors.success,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            currentLanguage == 'zh' 
                                ? '已享受免费配送！' 
                                : 'Free delivery applied!',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.success,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          
          const Divider(height: 1),
          
          // Checkout Button
          Padding(
            padding: EdgeInsets.only(
              left: AppConstants.defaultPadding,
              right: AppConstants.defaultPadding,
              bottom: AppConstants.defaultPadding + MediaQuery.of(context).padding.bottom,
              top: AppConstants.defaultPadding,
            ),
            child: PrimaryButton(
              text: currentLanguage == 'zh' ? '立即结算' : AppStrings.checkout,
              onPressed: cartProvider.isCartEmpty ? () {} : onCheckout,
              isEnabled: !cartProvider.isCartEmpty,
              isLoading: isLoading,
              height: 50,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false, bool isFree = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
            color: isTotal ? AppColors.textPrimary : AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isFree ? AppColors.success : (isTotal ? AppColors.primary : AppColors.textPrimary),
          ),
        ),
      ],
    );
  }
}

// Extension for CartProvider to calculate fees
extension CartProviderExtension on CartProvider {
  double get subtotal => totalAmount;
  
  double get tax {
    return Helpers.calculateTax(subtotal);
  }
  
  double get deliveryFee {
    return Helpers.calculateDeliveryFee(subtotal);
  }
  
  double get grandTotal {
    return subtotal + tax + deliveryFee;
  }
}
