import 'package:flutter/material.dart';
import 'package:canton_connect/core/constants/app_constants.dart';
import 'package:canton_connect/data/models/subscription_plan.dart';
import 'package:canton_connect/presentation/pages/subscription_page.dart';
import 'package:canton_connect/presentation/pages/admin/subscription_management_page.dart';

class SubscriptionPlansSection extends StatelessWidget {
  final String currentLanguage;
  final bool isAdmin;
  final VoidCallback? onViewAllPlans;
  final VoidCallback? onAdminManage;

  const SubscriptionPlansSection({
    super.key,
    required this.currentLanguage,
    this.isAdmin = false,
    this.onViewAllPlans,
    this.onAdminManage,
  });

  @override
  Widget build(BuildContext context) {
    final plans = _getFeaturedPlans(currentLanguage);
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
          // Header with Admin Button
          _buildHeader(context),
          const SizedBox(height: 8),
          Text(
            currentLanguage == 'zh' 
                ? '专为广州生活设计的健康餐饮方案'
                : 'Healthy meal plans designed for Guangzhou lifestyle',
            style: const TextStyle(
              fontSize: 16,
              color: Color(AppConstants.accentColorValue),
              fontFamily: AppConstants.secondaryFont,
            ),
          ),
          const SizedBox(height: 50),
          
          // Plans Display
          if (isMobile) ..._buildMobilePlans(context, plans),
          if (!isMobile) ..._buildDesktopPlans(context, plans),
          
          // View All Plans Button
          const SizedBox(height: 40),
          SizedBox(
            width: isMobile ? double.infinity : 200,
            child: ElevatedButton(
              onPressed: onViewAllPlans ?? () => _navigateToSubscriptionPage(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: const Color(AppConstants.primaryColorValue),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
                  side: const BorderSide(
                    color: Color(AppConstants.primaryColorValue),
                    width: 2,
                  ),
                ),
                elevation: 0,
              ),
              child: Text(
                currentLanguage == 'zh' ? '查看所有套餐' : 'View All Plans',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppConstants.primaryFont,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Get featured plans for home page
  List<SubscriptionPlan> _getFeaturedPlans(String language) {
    return [
      SubscriptionPlan(
        id: 'office_power',
        name: language == 'zh' ? '办公能量午餐' : 'Office Power Lunch',
        description: language == 'zh' 
            ? '每周5份健康午餐，直接配送到办公室'
            : '5 healthy lunch meals per week, delivered to your office',
        price: 168.00,
        period: language == 'zh' ? '/周' : '/week',
        features: language == 'zh' ? [
          '周一至周五配送',
          '办公室友好包装',
          '45分钟配送窗口',
          '天河/珠江新城免费配送',
          '营养信息包含',
        ] : [
          'Monday to Friday delivery',
          'Office-friendly packaging', 
          '45-minute delivery window',
          'Free office delivery in Tianhe/Zhujiang',
          'Nutritional information included',
        ],
        isPopular: true, 
        category: 'young_professionals',
        icon: Icons.business_center,
        color: Colors.green,
        maxMenuItems: 20,
      ),
      SubscriptionPlan(
        id: 'nutritionist_designed',
        name: language == 'zh' ? '营养师定制套餐' : 'Nutritionist Designed',
        description: language == 'zh' 
            ? '专业营养师设计的科学均衡餐食'
            : 'Scientifically balanced meals designed by certified nutritionists',
        price: 258.00,
        period: language == 'zh' ? '/周' : '/week',
        features: language == 'zh' ? [
          '热量控制 (400-500 大卡)',
          '宏量营养素均衡',
          '低钠低糖',
          '每周营养报告',
          '有机食材优先',
        ] : [
          'Calorie-controlled (400-500 kcal)',
          'Macro-balanced',
          'Low sodium & sugar',
          'Weekly nutrition report',
          'Organic ingredients focus',
        ],
        isPopular: true, 
        category: 'health',
        icon: Icons.monitor_heart,
        color: Colors.purple,
        maxMenuItems: 30,
      ),
      SubscriptionPlan(
        id: 'family_feast',
        name: language == 'zh' ? '家庭盛宴套餐' : 'Family Feast',
        description: language == 'zh' 
            ? '每周4次，适合2-3人的完整晚餐'
            : 'Complete dinners for 2-3 people, 4 times per week',
        price: 388.00,
        period: language == 'zh' ? '/周' : '/week',
        features: language == 'zh' ? [
          '2道主菜 + 1汤 + 米饭',
          '家庭式分量',
          '儿童友好选项',
          '传统粤式食谱',
          '周末免费配送',
        ] : [
          '2 main dishes + 1 soup + rice',
          'Family-style portions',
          'Child-friendly options available',
          'Traditional Cantonese recipes',
          'Free weekend delivery',
        ],
        isPopular: false, 
        category: 'family',
        icon: Icons.family_restroom,
        color: Colors.red,
        maxMenuItems: 25,
      ),
    ];
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            currentLanguage == 'zh' ? '精选订阅套餐' : 'Featured Subscription Plans',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Color(AppConstants.accentColorValue),
              fontFamily: AppConstants.primaryFont,
            ),
          ),
        ),
        if (isAdmin) ...[
          const SizedBox(width: 16),
          _buildAdminButton(context),
        ],
      ],
    );
  }

  Widget _buildAdminButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onAdminManage ?? () => _navigateToAdminManagement(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[800],
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
        ),
      ),
      icon: const Icon(Icons.admin_panel_settings, size: 18),
      label: Text(
        currentLanguage == 'zh' ? '管理套餐' : 'Manage Plans',
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontFamily: AppConstants.primaryFont,
        ),
      ),
    );
  }

  void _navigateToSubscriptionPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => SubscriptionPage(
          currentLanguage: currentLanguage,
          isAdmin: isAdmin,
          showAppBar: true,
        ),
      ),
    );
  }

  void _navigateToAdminManagement(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => SubscriptionManagementPage(
          currentLanguage: currentLanguage,
        ),
      ),
    );
  }

  List<Widget> _buildMobilePlans(BuildContext context, List<SubscriptionPlan> plans) {
    return [
      ...plans.map((plan) => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: _buildPlanCard(context, plan, true),
      )),
    ];
  }

  List<Widget> _buildDesktopPlans(BuildContext context, List<SubscriptionPlan> plans) {
    return [
      Row(
        children: plans.map((plan) => Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: _buildPlanCard(context, plan, false),
          ),
        )).toList(),
      ),
    ];
  }

  Widget _buildPlanCard(BuildContext context, SubscriptionPlan plan, bool isMobile) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            // FIXED: Converted to double
            color: const Color(0xFF000000).withValues(alpha: (0.25 * 255.0).round().clamp(0, 255).toDouble()),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: plan.isPopular 
              ? const Color(AppConstants.secondaryColorValue) 
              // FIXED: Converted to double
              : const Color(0xFFE0E0E0).withValues(alpha: (0.2 * 255.0).round().clamp(0, 255).toDouble()),
          width: plan.isPopular ? 2 : 1,
        ),
      ),
      child: Stack(
        children: [
          if (plan.isPopular)
            Positioned(
              top: 0,
              right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: const BoxDecoration(
                  color: Color(AppConstants.secondaryColorValue),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Text(
                  currentLanguage == 'zh' ? '最受欢迎' : 'Most Popular',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppConstants.primaryFont,
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plan.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(AppConstants.accentColorValue),
                    fontFamily: AppConstants.primaryFont,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  plan.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(AppConstants.accentColorValue),
                    fontFamily: AppConstants.secondaryFont,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '¥${plan.price.toInt()}',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: Color(AppConstants.primaryColorValue),
                        fontFamily: AppConstants.primaryFont,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      plan.period,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(AppConstants.accentColorValue),
                        fontFamily: AppConstants.secondaryFont,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 20),
                ...plan.features.take(isMobile ? 3 : 4).map((feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Color(AppConstants.primaryColorValue),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          feature,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(AppConstants.accentColorValue),
                            fontFamily: AppConstants.secondaryFont,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
                if (plan.features.length > (isMobile ? 3 : 4)) ...[
                  const SizedBox(height: 8),
                  Text(
                    currentLanguage == 'zh' ? '更多功能...' : 'More features...',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _navigateToSubscriptionPage(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: plan.isPopular
                          ? const Color(AppConstants.secondaryColorValue)
                          : const Color(AppConstants.primaryColorValue),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
                      ),
                      elevation: 4,
                    ),
                    child: Text(
                      currentLanguage == 'zh' ? '立即订阅' : 'Subscribe Now',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppConstants.primaryFont,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
