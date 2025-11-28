import 'package:flutter/material.dart';
import 'package:canton_connect/core/constants/app_constants.dart';

class FinalCtaSection extends StatelessWidget {
  final String currentLanguage;
  final VoidCallback onGetStarted;
  final VoidCallback onContactUs;

  const FinalCtaSection({
    super.key,
    required this.currentLanguage,
    required this.onGetStarted,
    required this.onContactUs,
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
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(AppConstants.primaryColorValue),
            Color(0xFF2ECC71),
          ],
        ),
      ),
      child: Column(
        children: [
          // Headline
          Text(
            currentLanguage == 'zh' 
                ? '准备好品尝正宗粤菜了吗？' 
                : 'Ready to Taste Authentic Cantonese Cuisine?',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontFamily: AppConstants.primaryFont,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // Subheadline
          Text(
            currentLanguage == 'zh'
                ? '立即订阅，享受新鲜制作的粤式家常菜直接送到您家'
                : 'Subscribe now and enjoy freshly prepared Cantonese home cooking delivered to your door',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white70,
              fontFamily: AppConstants.secondaryFont,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),

          // Features Grid
          if (!isMobile) _buildDesktopFeatures(),
          if (isMobile) _buildMobileFeatures(),
          const SizedBox(height: 40),

          // CTA Buttons
          if (isMobile) ..._buildMobileButtons(),
          if (!isMobile) ..._buildDesktopButtons(),

          // Trust Indicators
          const SizedBox(height: 40),
          _buildTrustIndicators(),
        ],
      ),
    );
  }

  Widget _buildDesktopFeatures() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildFeatureItem(
          icon: Icons.food_bank,
          title: currentLanguage == 'zh' ? '新鲜食材' : 'Fresh Ingredients',
          description: currentLanguage == 'zh'
              ? '每日采购优质食材'
              : 'Daily sourced premium ingredients',
        ),
        _buildFeatureItem(
          icon: Icons.health_and_safety,
          title: currentLanguage == 'zh' ? '健康安全' : 'Health & Safety',
          description: currentLanguage == 'zh'
              ? '严格卫生标准'
              : 'Strict hygiene standards',
        ),
        _buildFeatureItem(
          icon: Icons.delivery_dining,
          title: currentLanguage == 'zh' ? '准时配送' : 'Timely Delivery',
          description: currentLanguage == 'zh'
              ? '保证送达时间'
              : 'Guaranteed delivery time',
        ),
        _buildFeatureItem(
          icon: Icons.thumb_up,
          title: currentLanguage == 'zh' ? '满意保证' : 'Satisfaction Guaranteed',
          description: currentLanguage == 'zh'
              ? '100%满意保证'
              : '100% satisfaction guarantee',
        ),
      ],
    );
  }

  Widget _buildMobileFeatures() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildFeatureItem(
              icon: Icons.food_bank,
              title: currentLanguage == 'zh' ? '新鲜食材' : 'Fresh Ingredients',
              description: currentLanguage == 'zh'
                  ? '每日采购优质食材'
                  : 'Daily sourced premium ingredients',
            ),
            _buildFeatureItem(
              icon: Icons.health_and_safety,
              title: currentLanguage == 'zh' ? '健康安全' : 'Health & Safety',
              description: currentLanguage == 'zh'
                  ? '严格卫生标准'
                  : 'Strict hygiene standards',
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildFeatureItem(
              icon: Icons.delivery_dining,
              title: currentLanguage == 'zh' ? '准时配送' : 'Timely Delivery',
              description: currentLanguage == 'zh'
                  ? '保证送达时间'
                  : 'Guaranteed delivery time',
            ),
            _buildFeatureItem(
              icon: Icons.thumb_up,
              title: currentLanguage == 'zh' ? '满意保证' : 'Satisfaction Guaranteed',
              description: currentLanguage == 'zh'
                  ? '100%满意保证'
                  : '100% satisfaction guarantee',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontFamily: AppConstants.primaryFont,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white70,
              fontFamily: AppConstants.secondaryFont,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDesktopButtons() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: onGetStarted,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(AppConstants.secondaryColorValue),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
              ),
              elevation: 4,
            ),
            child: Text(
              currentLanguage == 'zh' ? '立即开始' : 'Get Started Now',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: AppConstants.primaryFont,
              ),
            ),
          ),
          const SizedBox(width: 20),
          OutlinedButton(
            onPressed: onContactUs,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
              ),
            ),
            child: Text(
              currentLanguage == 'zh' ? '联系我们' : 'Contact Us',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                fontFamily: AppConstants.primaryFont,
              ),
            ),
          ),
        ],
      ),
    ];
  }

  List<Widget> _buildMobileButtons() {
    return [
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onGetStarted,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(AppConstants.secondaryColorValue),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
            ),
            elevation: 4,
          ),
          child: Text(
            currentLanguage == 'zh' ? '立即开始' : 'Get Started Now',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: AppConstants.primaryFont,
            ),
          ),
        ),
      ),
      const SizedBox(height: 12),
      SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: onContactUs,
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: Colors.white),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
            ),
          ),
          child: Text(
            currentLanguage == 'zh' ? '联系我们' : 'Contact Us',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: AppConstants.primaryFont,
            ),
          ),
        ),
      ),
    ];
  }

  Widget _buildTrustIndicators() {
    return Column(
      children: [
        Text(
          currentLanguage == 'zh' ? '受到数百个家庭的信任' : 'Trusted by Hundreds of Families',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white60,
            fontFamily: AppConstants.secondaryFont,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTrustItem('4.9/5', currentLanguage == 'zh' ? '评分' : 'Rating'),
            _buildTrustDivider(),
            _buildTrustItem('1000+', currentLanguage == 'zh' ? '满意客户' : 'Happy Customers'),
            _buildTrustDivider(),
            _buildTrustItem('50+', currentLanguage == 'zh' ? '菜品选择' : 'Dish Options'),
          ],
        ),
      ],
    );
  }

  Widget _buildTrustItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontFamily: AppConstants.primaryFont,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white60,
            fontFamily: AppConstants.secondaryFont,
          ),
        ),
      ],
    );
  }

  Widget _buildTrustDivider() {
    return Container(
      width: 1,
      height: 30,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.white30,
    );
  }
}
