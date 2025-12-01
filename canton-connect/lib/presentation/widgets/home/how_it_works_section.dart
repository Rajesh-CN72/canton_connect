import 'package:flutter/material.dart';
import 'package:canton_connect/core/constants/app_constants.dart';

class HowItWorksSection extends StatelessWidget {
  final String currentLanguage;

  const HowItWorksSection({
    super.key,
    required this.currentLanguage,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < AppConstants.tabletBreakpoint;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: 60,
      ),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            currentLanguage == 'zh' ? '如何使用我们的服务' : 'How It Works',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Color(AppConstants.accentColorValue),
              fontFamily: AppConstants.primaryFont,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            currentLanguage == 'zh' 
                ? '简单三步，享受正宗粤菜'
                : 'Three simple steps to enjoy authentic Cantonese cuisine',
            style: const TextStyle(
              fontSize: 16,
              color: Color(AppConstants.accentColorValue),
              fontFamily: AppConstants.secondaryFont,
            ),
          ),
          const SizedBox(height: 50),
          
          if (isMobile) ..._buildMobileSteps(),
          if (!isMobile) _buildDesktopSteps(),
        ],
      ),
    );
  }

  List<Widget> _buildMobileSteps() {
    return [
      _buildStep(
        number: 1,
        title: currentLanguage == 'zh' ? '选择套餐' : 'Choose Your Plan',
        description: currentLanguage == 'zh' 
            ? '根据您的需求选择适合的订阅套餐'
            : 'Select the subscription plan that fits your needs',
        icon: Icons.subscriptions,
      ),
      const SizedBox(height: 30),
      _buildStep(
        number: 2,
        title: currentLanguage == 'zh' ? '定制菜单' : 'Customize Menu',
        description: currentLanguage == 'zh' 
            ? '选择您喜欢的菜品和配送时间'
            : 'Choose your favorite dishes and delivery schedule',
        icon: Icons.menu_book,
      ),
      const SizedBox(height: 30),
      _buildStep(
        number: 3,
        title: currentLanguage == 'zh' ? '享受美食' : 'Enjoy Meals',
        description: currentLanguage == 'zh' 
            ? '新鲜制作的粤菜直接送到您家'
            : 'Freshly prepared Cantonese meals delivered to your door',
        icon: Icons.delivery_dining,
      ),
    ];
  }

  Widget _buildDesktopSteps() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: _buildStep(
            number: 1,
            title: currentLanguage == 'zh' ? '选择套餐' : 'Choose Your Plan',
            description: currentLanguage == 'zh' 
                ? '根据您的需求选择适合的订阅套餐'
                : 'Select the subscription plan that fits your needs',
            icon: Icons.subscriptions,
          ),
        ),
        const SizedBox(width: 40),
        Expanded(
          child: _buildStep(
            number: 2,
            title: currentLanguage == 'zh' ? '定制菜单' : 'Customize Menu',
            description: currentLanguage == 'zh' 
                ? '选择您喜欢的菜品和配送时间'
                : 'Choose your favorite dishes and delivery schedule',
            icon: Icons.menu_book,
          ),
        ),
        const SizedBox(width: 40),
        Expanded(
          child: _buildStep(
            number: 3,
            title: currentLanguage == 'zh' ? '享受美食' : 'Enjoy Meals',
            description: currentLanguage == 'zh' 
                ? '新鲜制作的粤菜直接送到您家'
                : 'Freshly prepared Cantonese meals delivered to your door',
            icon: Icons.delivery_dining,
          ),
        ),
      ],
    );
  }

  Widget _buildStep({
    required int number,
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(AppConstants.primaryColorValue),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(AppConstants.primaryColorValue).withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 32,
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        number.toString(),
                        style: const TextStyle(
                          color: Color(AppConstants.primaryColorValue),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(AppConstants.accentColorValue),
              fontFamily: AppConstants.primaryFont,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Color(AppConstants.accentColorValue),
              fontFamily: AppConstants.secondaryFont,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
