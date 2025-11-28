import 'package:flutter/material.dart';
import 'package:canton_connect/core/constants/app_colors.dart';
import 'package:canton_connect/core/constants/app_constants.dart';
import 'package:canton_connect/core/widgets/buttons/primary_button.dart';
import 'package:canton_connect/core/widgets/buttons/secondary_button.dart';

class EmptyCartState extends StatelessWidget {
  final Function() onStartShopping;
  final Function() onBrowseMenu;
  final String currentLanguage;

  const EmptyCartState({
    Key? key,
    required this.onStartShopping,
    required this.onBrowseMenu,
    required this.currentLanguage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.defaultPadding * 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration
          Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
              color: AppColors.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: AppColors.primary,
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Title
          Text(
            currentLanguage == 'zh' ? '购物车是空的' : 'Your cart is empty',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              fontFamily: AppConstants.primaryFont,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 16),
          
          // Description
          Text(
            currentLanguage == 'zh' 
                ? '看起来您还没有添加任何美食到购物车。开始探索我们的美味佳肴吧！'
                : 'Looks like you haven\'t added any delicious food to your cart yet. Start exploring our mouth-watering dishes!',
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
              height: 1.5,
              fontFamily: AppConstants.primaryFont,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 40),
          
          // Action Buttons
          Column(
            children: [
              PrimaryButton(
                text: currentLanguage == 'zh' ? '开始购物' : 'Start Shopping',
                onPressed: onStartShopping,
                height: 50,
              ),
              
              const SizedBox(height: 12),
              
              SecondaryButton(
                text: currentLanguage == 'zh' ? '浏览菜单' : 'Browse Menu',
                onPressed: onBrowseMenu,
                height: 50,
              ),
            ],
          ),
          
          const SizedBox(height: 32),
          
          // Features List
          _buildFeaturesList(),
        ],
      ),
    );
  }

  Widget _buildFeaturesList() {
    final features = currentLanguage == 'zh' 
        ? [
            '新鲜食材，每日准备',
            '快速配送，30分钟送达',
            '100%满意保证',
            '支持多种支付方式',
          ]
        : [
            'Fresh ingredients, prepared daily',
            'Fast delivery, 30 minutes or less',
            '100% satisfaction guarantee',
            'Multiple payment methods supported',
          ];

    return Column(
      children: [
        Text(
          currentLanguage == 'zh' ? '为什么选择我们？' : 'Why choose us?',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
            fontFamily: AppConstants.primaryFont,
          ),
        ),
        
        const SizedBox(height: 16),
        
        Column(
          children: features.map((feature) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 16,
                      color: AppColors.textOnPrimary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      feature,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

// Alternative compact version for modal bottomsheets
class CompactEmptyCartState extends StatelessWidget {
  final Function() onStartShopping;
  final String currentLanguage;

  const CompactEmptyCartState({
    Key? key,
    required this.onStartShopping,
    required this.currentLanguage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.defaultPadding * 1.5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Illustration
          Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(
              color: AppColors.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.shopping_cart_outlined,
              size: 50,
              color: AppColors.primary,
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Title
          Text(
            currentLanguage == 'zh' ? '购物车是空的' : 'Cart is Empty',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              fontFamily: AppConstants.primaryFont,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Description
          Text(
            currentLanguage == 'zh' 
                ? '添加一些美食开始下单吧！'
                : 'Add some delicious items to get started!',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              fontFamily: AppConstants.primaryFont,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 24),
          
          // Action Button
          PrimaryButton(
            text: currentLanguage == 'zh' ? '浏览菜单' : 'Browse Menu',
            onPressed: onStartShopping,
            height: 50,
          ),
        ],
      ),
    );
  }
}
