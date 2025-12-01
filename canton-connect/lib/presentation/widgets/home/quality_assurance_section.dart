import 'package:flutter/material.dart';
import 'package:canton_connect/core/constants/app_constants.dart';

class QualityAssuranceSection extends StatelessWidget {
  final String currentLanguage;

  const QualityAssuranceSection({
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
      color: const Color(AppConstants.backgroundColorValue),
      child: Column(
        children: [
          Text(
            currentLanguage == 'zh' ? '品质保证' : 'Quality Assurance',
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
                ? '我们致力于提供最高品质的餐饮体验'
                : 'We are committed to providing the highest quality dining experience',
            style: const TextStyle(
              fontSize: 16,
              color: Color(AppConstants.accentColorValue),
              fontFamily: AppConstants.secondaryFont,
            ),
          ),
          const SizedBox(height: 50),
          
          if (isMobile) ..._buildMobileQualityFeatures(),
          if (!isMobile) _buildDesktopQualityFeatures(),
          
          const SizedBox(height: 40),
          _buildCertificationBadges(),
        ],
      ),
    );
  }

  List<Widget> _buildMobileQualityFeatures() {
    return [
      _buildQualityFeature(
        icon: Icons.food_bank,
        title: currentLanguage == 'zh' ? '新鲜食材' : 'Fresh Ingredients',
        description: currentLanguage == 'zh' 
            ? '每日采购的新鲜食材，确保菜品质量'
            : 'Daily sourced fresh ingredients to ensure dish quality',
      ),
      const SizedBox(height: 30),
      _buildQualityFeature(
        icon: Icons.health_and_safety,
        title: currentLanguage == 'zh' ? '健康安全' : 'Health & Safety',
        description: currentLanguage == 'zh' 
            ? '严格的卫生标准和食品安全流程'
            : 'Strict hygiene standards and food safety procedures',
      ),
      const SizedBox(height: 30),
      _buildQualityFeature(
        icon: Icons.restaurant, // FIXED: Changed from Icons.chef
        title: currentLanguage == 'zh' ? '专业厨师' : 'Professional Chefs',
        description: currentLanguage == 'zh' 
            ? '经验丰富的粤菜厨师团队'
            : 'Experienced team of Cantonese chefs',
      ),
      const SizedBox(height: 30),
      _buildQualityFeature(
        icon: Icons.timer,
        title: currentLanguage == 'zh' ? '准时配送' : 'Timely Delivery',
        description: currentLanguage == 'zh' 
            ? '保证在预定时间内送达'
            : 'Guaranteed delivery within scheduled time',
      ),
    ];
  }

  Widget _buildDesktopQualityFeatures() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildQualityFeature(
                icon: Icons.food_bank,
                title: currentLanguage == 'zh' ? '新鲜食材' : 'Fresh Ingredients',
                description: currentLanguage == 'zh' 
                    ? '每日采购的新鲜食材，确保菜品质量'
                    : 'Daily sourced fresh ingredients to ensure dish quality',
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: _buildQualityFeature(
                icon: Icons.health_and_safety,
                title: currentLanguage == 'zh' ? '健康安全' : 'Health & Safety',
                description: currentLanguage == 'zh' 
                    ? '严格的卫生标准和食品安全流程'
                    : 'Strict hygiene standards and food safety procedures',
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
        Row(
          children: [
            Expanded(
              child: _buildQualityFeature(
                icon: Icons.restaurant, // FIXED: Changed from Icons.chef
                title: currentLanguage == 'zh' ? '专业厨师' : 'Professional Chefs',
                description: currentLanguage == 'zh' 
                    ? '经验丰富的粤菜厨师团队'
                    : 'Experienced team of Cantonese chefs',
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: _buildQualityFeature(
                icon: Icons.timer,
                title: currentLanguage == 'zh' ? '准时配送' : 'Timely Delivery',
                description: currentLanguage == 'zh' 
                    ? '保证在预定时间内送达'
                    : 'Guaranteed delivery within scheduled time',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQualityFeature({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: const Color(AppConstants.primaryColorValue),
              borderRadius: BorderRadius.circular(35),
              boxShadow: [
                BoxShadow(
                  color: const Color(AppConstants.primaryColorValue).withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
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

  Widget _buildCertificationBadges() {
    return Column(
      children: [
        Text(
          currentLanguage == 'zh' ? '认证与标准' : 'Certifications & Standards',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(AppConstants.accentColorValue),
            fontFamily: AppConstants.primaryFont,
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            _buildCertificationBadge(
              'HACCP',
              currentLanguage == 'zh' ? '食品安全认证' : 'Food Safety Certified',
            ),
            _buildCertificationBadge(
              'ISO 9001',
              currentLanguage == 'zh' ? '质量管理体系' : 'Quality Management',
            ),
            _buildCertificationBadge(
              'Halal',
              currentLanguage == 'zh' ? '清真认证' : 'Halal Certified',
            ),
            _buildCertificationBadge(
              'Organic',
              currentLanguage == 'zh' ? '有机食材' : 'Organic Ingredients',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCertificationBadge(String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: const Color(AppConstants.primaryColorValue).withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(AppConstants.primaryColorValue),
              fontFamily: AppConstants.primaryFont,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              color: Color(AppConstants.accentColorValue),
              fontFamily: AppConstants.secondaryFont,
            ),
          ),
        ],
      ),
    );
  }
}
