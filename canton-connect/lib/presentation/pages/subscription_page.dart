import 'package:flutter/material.dart';
import 'package:canton_connect/core/constants/app_constants.dart';
import 'package:canton_connect/data/models/subscription_plan.dart';
import 'package:canton_connect/data/models/food_item.dart';
import 'package:canton_connect/presentation/pages/admin/subscription_management_page.dart';
import 'package:canton_connect/presentation/widgets/menu/data/menu_data.dart';

class SubscriptionPage extends StatefulWidget {
  final String currentLanguage;
  final bool isAdmin;

  const SubscriptionPage({
    super.key,
    required this.currentLanguage,
    this.isAdmin = false,
  });

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> with SingleTickerProviderStateMixin {
  String? _selectedPlanId;
  int _selectedDuration = 0;
  final Map<String, int> _selectedMeals = {};
  final Map<String, int> _selectedAddOns = {};
  final Map<String, int> _selectedDrinks = {};
  String? _selectedCategory;
  late TabController _tabController;

  // Get all available items
  List<FoodItem> get _availableMeals => MenuData.sampleFoodItems;
  List<FoodItem> get _availableDrinks => MenuData.getFoodItemsByCategory('Drinks');

  final List<AddOnItem> _availableAddOns = [
    const AddOnItem(
      id: 'addon1',
      nameEn: 'Extra Protein',
      nameZh: '额外蛋白质',
      descriptionEn: 'Additional chicken breast',
      descriptionZh: '额外鸡胸肉',
      price: 5.99,
      image: 'assets/images/addons/extra_rice.jpg',
    ),
    const AddOnItem(
      id: 'addon2',
      nameEn: 'Brown Rice',
      nameZh: '糙米',
      descriptionEn: 'Healthy brown rice',
      descriptionZh: '健康糙米',
      price: 2.99,
      image: 'assets/images/addons/extra_rice.jpg',
    ),
    const AddOnItem(
      id: 'addon3',
      nameEn: 'Extra Sauce',
      nameZh: '额外酱料',
      descriptionEn: 'Additional special sauce',
      descriptionZh: '额外特制酱料',
      price: 1.50,
      image: 'assets/images/addons/extra_sauce.jpg',
    ),
  ];

  // Get all plans
  List<SubscriptionPlan> get _allPlans => _getAllPlans(widget.currentLanguage);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<SubscriptionPlan> _getAllPlans(String language) {
    return [
      // Young Professional Plans
      SubscriptionPlan(
        id: 'career_starter',
        name: language == 'zh' ? '职场新人套餐' : 'Career Starter',
        description: language == 'zh' 
            ? '每周3餐，适合忙碌的职场新人'
            : '3 meals per week - perfect for busy young professionals',
        price: 108.00,
        period: language == 'zh' ? '/周' : '/week',
        features: language == 'zh' ? [
          '灵活配送日期',
          '中西餐结合',
          '经济实惠',
          '15分钟快速加热',
        ] : [
          'Flexible delivery days',
          'Mix of Chinese and Western options',
          'Budget-friendly',
          'Quick 15-min heat-up meals',
        ],
        isPopular: false, 
        category: 'young_professionals',
        icon: Icons.work_outline,
        color: Colors.blue,
        maxMenuItems: 10, // ADDED: maxMenuItems parameter
      ),
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
        maxMenuItems: 20, // ADDED: maxMenuItems parameter
      ),

      // Health & Wellness Plans
      SubscriptionPlan(
        id: 'guangzhou_wellness',
        name: language == 'zh' ? '广州养生套餐' : 'Guangzhou Wellness',
        description: language == 'zh' 
            ? '传统粤式养生食材结合现代营养学'
            : 'Traditional Cantonese health foods with modern nutrition',
        price: 228.00,
        period: language == 'zh' ? '/周' : '/week',
        features: language == 'zh' ? [
          '养生煲汤',
          '时令食材',
          '中医养生原理',
          '低油高纤维',
          '地道广州风味',
        ] : [
          'Herbal soups (煲汤)',
          'Seasonal ingredients',
          'TCM principles',
          'Low oil, high fiber',
          'Local Guangzhou flavors',
        ],
        isPopular: false, 
        category: 'health',
        icon: Icons.spa,
        color: Colors.teal,
        maxMenuItems: 15, // ADDED: maxMenuItems parameter
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
        maxMenuItems: 30, // ADDED: maxMenuItems parameter
      ),

      // Family Plans
      SubscriptionPlan(
        id: 'weekend_family',
        name: language == 'zh' ? '周末家庭套餐' : 'Weekend Family',
        description: language == 'zh' 
            ? '专为周末设计的全家共享餐食'
            : 'Special weekend meals for the whole family',
        price: 198.00,
        period: language == 'zh' ? '/周' : '/week',
        features: language == 'zh' ? [
          '仅周六日配送',
          '共享大分量',
          '周末特色菜品',
          '家庭活动食谱卡',
        ] : [
          'Saturday & Sunday delivery only',
          'Larger portions for sharing',
          'Special weekend dishes',
          'Family activity recipe cards included',
        ],
        isPopular: false, 
        category: 'family',
        icon: Icons.weekend,
        color: Colors.orange,
        maxMenuItems: 10, // ADDED: maxMenuItems parameter
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
        isPopular: true, 
        category: 'family',
        icon: Icons.family_restroom,
        color: Colors.red,
        maxMenuItems: 25, // ADDED: maxMenuItems parameter
      ),
    ];
  }

  // Get filtered plans based on category
  List<SubscriptionPlan> get _filteredPlans {
    if (_selectedCategory == null) return _allPlans;
    return _allPlans.where((plan) => plan.category == _selectedCategory).toList();
  }

  // Helper getters to check if there are selected items
  bool get _hasSelectedAddOns => _selectedAddOns.entries.any((entry) => entry.value > 0);
  bool get _hasSelectedDrinks => _selectedDrinks.entries.any((entry) => entry.value > 0);
  bool get _hasSelectedMeals => _selectedMeals.entries.any((entry) => entry.value > 0);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < AppConstants.tabletBreakpoint;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(widget.currentLanguage == 'zh' ? '订阅套餐' : 'Subscription Plans'),
        backgroundColor: const Color(AppConstants.primaryColorValue),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (widget.isAdmin) ...[
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: _navigateToAdminManagement,
              tooltip: widget.currentLanguage == 'zh' ? '管理套餐' : 'Manage Plans',
            ),
          ],
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          tabs: [
            Tab(text: widget.currentLanguage == 'zh' ? '精选套餐' : 'Featured'),
            Tab(text: widget.currentLanguage == 'zh' ? '附加项目' : 'Add-ons'),
            Tab(text: widget.currentLanguage == 'zh' ? '饮品' : 'Drinks'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFeaturedTab(isMobile),
          _buildAddOnsTab(isMobile),
          _buildDrinksTab(isMobile),
        ],
      ),
    );
  }

  Widget _buildFeaturedTab(bool isMobile) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 40,
          vertical: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            _buildHeroSection(isMobile),
            const SizedBox(height: 32),
            
            // Duration Selection
            _buildDurationSelector(),
            const SizedBox(height: 32),
            
            // Category Filter
            _buildCategoryFilter(),
            const SizedBox(height: 24),
            
            // Subscription Plans
            if (isMobile) ..._buildMobilePlans(isMobile),
            if (!isMobile) ..._buildDesktopPlans(isMobile),
            
            // Selected Plan Summary
            if (_selectedPlanId != null) ..._buildSelectedPlanSummary(isMobile),
            
            // Action Buttons
            const SizedBox(height: 32),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildAddOnsTab(bool isMobile) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 16 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.currentLanguage == 'zh' ? '附加项目' : 'Add-ons',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Color(AppConstants.accentColorValue),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.currentLanguage == 'zh' 
                ? '为您的套餐添加额外美味'
                : 'Add extra deliciousness to your plan',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: _availableAddOns.map(_buildAddOnCard).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDrinksTab(bool isMobile) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 16 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.currentLanguage == 'zh' ? '精选饮品' : 'Featured Drinks',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Color(AppConstants.accentColorValue),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.currentLanguage == 'zh' 
                ? '搭配您的美味餐食'
                : 'Perfect pairing for your meals',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: _availableDrinks.take(6).map(_buildDrinkCard).toList(),
          ),
        ],
      ),
    );
  }

  // Hero Section
  Widget _buildHeroSection(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(AppConstants.primaryColorValue),
            Color(AppConstants.secondaryColorValue),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(AppConstants.primaryColorValue).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.currentLanguage == 'zh' ? '品味广州' : 'Taste Guangzhou',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.currentLanguage == 'zh' 
                      ? '每周新鲜制作的粤式美食直接送到您家'
                      : 'Fresh Cantonese meals delivered weekly to your doorstep',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextButton(
                    onPressed: _navigateToSubscriptionSelection,
                    child: Text(
                      widget.currentLanguage == 'zh' ? '立即订阅' : 'Subscribe Now',
                      style: const TextStyle(
                        color: Color(AppConstants.primaryColorValue),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.2),
            ),
            child: const Icon(
              Icons.restaurant_menu,
              color: Colors.white,
              size: 60,
            ),
          ),
        ],
      ),
    );
  }

  // Duration Selector
  Widget _buildDurationSelector() {
    final durations = widget.currentLanguage == 'zh' 
        ? ['周付', '月付', '季付']
        : ['Weekly', 'Monthly', 'Quarterly'];
    
    final savings = [0, 10, 20];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.currentLanguage == 'zh' ? '选择付费周期' : 'Select Billing Period',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(AppConstants.accentColorValue),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: List.generate(durations.length, (index) {
            final isSelected = _selectedDuration == index;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDuration = index;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(right: index < durations.length - 1 ? 12 : 0),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(AppConstants.primaryColorValue) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? const Color(AppConstants.primaryColorValue) : Colors.grey[300]!,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        durations[index],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                      if (savings[index] > 0) ...[
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white : Colors.green,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${savings[index]}% OFF',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: isSelected ? const Color(AppConstants.primaryColorValue) : Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  // Category Filter
  Widget _buildCategoryFilter() {
    final categories = [
      {'id': null, 'nameEn': 'All Plans', 'nameZh': '全部套餐', 'icon': Icons.all_inclusive},
      {'id': 'young_professionals', 'nameEn': 'Young Professionals', 'nameZh': '上班族', 'icon': Icons.work},
      {'id': 'health', 'nameEn': 'Health & Wellness', 'nameZh': '健康养生', 'icon': Icons.favorite},
      {'id': 'family', 'nameEn': 'Family', 'nameZh': '家庭', 'icon': Icons.family_restroom},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.currentLanguage == 'zh' ? '套餐分类' : 'Plan Categories',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(AppConstants.accentColorValue),
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories.map((category) {
              final isSelected = _selectedCategory == category['id'];
              return Container(
                margin: const EdgeInsets.only(right: 12),
                child: Material(
                  color: isSelected ? const Color(AppConstants.primaryColorValue) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  elevation: 2,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selectedCategory = isSelected ? null : category['id'] as String?;
                      });
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Row(
                        children: [
                          Icon(
                            category['icon'] as IconData,
                            color: isSelected ? Colors.white : const Color(AppConstants.primaryColorValue),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            widget.currentLanguage == 'zh' 
                                ? category['nameZh'] as String
                                : category['nameEn'] as String,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w500,
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
        ),
      ],
    );
  }

  List<Widget> _buildMobilePlans(bool isMobile) {
    return [
      ..._filteredPlans.map((plan) => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: _buildPlanCard(plan, isMobile),
      )),
    ];
  }

  List<Widget> _buildDesktopPlans(bool isMobile) {
    return [
      Wrap(
        spacing: 20,
        runSpacing: 20,
        children: _filteredPlans.map((plan) => SizedBox(
          width: 360,
          child: _buildPlanCard(plan, isMobile),
        )).toList(),
      ),
    ];
  }

  Widget _buildPlanCard(SubscriptionPlan plan, bool isMobile) {
    final isSelected = _selectedPlanId == plan.id;
    final discountedPrice = _calculateDiscountedPrice(plan.price);
    
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          gradient: isSelected 
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    plan.color.withValues(alpha: 0.1),
                    plan.color.withValues(alpha: 0.05),
                  ],
                )
              : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? plan.color : Colors.grey.withValues(alpha: 0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Stack(
          children: [
            if (plan.isPopular)
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFFD700),
                        Color(0xFFFFA000),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, color: Colors.white, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        widget.currentLanguage == 'zh' ? '热门' : 'Popular',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isSelected) ...[
                    Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Color(AppConstants.primaryColorValue),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          widget.currentLanguage == 'zh' ? '已选择' : 'Selected',
                          style: const TextStyle(
                            color: Color(AppConstants.primaryColorValue),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                  
                  // Header with Icon and Title
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: plan.color.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(plan.icon, color: plan.color, size: 24),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              plan.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Color(AppConstants.accentColorValue),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              plan.description,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Price Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: plan.color.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '¥${discountedPrice.toInt()}',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                color: Color(AppConstants.primaryColorValue),
                              ),
                            ),
                            Text(
                              _getPeriodText(),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        if (_selectedDuration > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '${((1 - _getDiscountRate()) * 100).toInt()}% OFF',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Features
                  ...plan.features.map((feature) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: plan.color,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            feature,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                  
                  const SizedBox(height: 24),
                  
                  // Select Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedPlanId = plan.id;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSelected ? plan.color : const Color(AppConstants.primaryColorValue),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (isSelected) ...[
                            const Icon(Icons.check, size: 20),
                            const SizedBox(width: 8),
                          ],
                          Text(
                            isSelected 
                                ? (widget.currentLanguage == 'zh' ? '已选择' : 'Selected')
                                : (widget.currentLanguage == 'zh' ? '选择套餐' : 'Select Plan'),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddOnCard(AddOnItem addon) {
    final quantity = _selectedAddOns[addon.id] ?? 0;
    
    return Container(
      width: 280,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/addon_placeholder.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              
              // Name and Description
              Text(
                widget.currentLanguage == 'zh' ? addon.nameZh : addon.nameEn,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.currentLanguage == 'zh' ? addon.descriptionZh : addon.descriptionEn,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 12),
              
              // Price and Quantity
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '¥${addon.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(AppConstants.primaryColorValue),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: quantity > 0 ? () {
                          setState(() {
                            _selectedAddOns[addon.id] = quantity - 1;
                          });
                        } : null,
                        icon: const Icon(Icons.remove),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$quantity',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _selectedAddOns[addon.id] = quantity + 1;
                          });
                        },
                        icon: const Icon(Icons.add),
                        style: IconButton.styleFrom(
                          backgroundColor: const Color(AppConstants.primaryColorValue),
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrinkCard(FoodItem drink) {
    final quantity = _selectedDrinks[drink.id] ?? 0;
    
    return Container(
      width: 280,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(drink.images.isNotEmpty ? drink.images.first : 'assets/images/food_placeholder.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              
              // Name and Description
              Text(
                drink.getName(widget.currentLanguage),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                drink.getDescription(widget.currentLanguage),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 12),
              
              // Price and Quantity
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '¥${drink.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(AppConstants.primaryColorValue),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: quantity > 0 ? () {
                          setState(() {
                            _selectedDrinks[drink.id] = quantity - 1;
                          });
                        } : null,
                        icon: const Icon(Icons.remove),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$quantity',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _selectedDrinks[drink.id] = quantity + 1;
                          });
                        },
                        icon: const Icon(Icons.add),
                        style: IconButton.styleFrom(
                          backgroundColor: const Color(AppConstants.primaryColorValue),
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Selected Plan Summary - UPDATED with detailed breakdown
  List<Widget> _buildSelectedPlanSummary(bool isMobile) {
    if (_selectedPlanId == null) return [];

    final selectedPlan = _allPlans.firstWhere((plan) => plan.id == _selectedPlanId);
    final discountedPlanPrice = _calculateDiscountedPrice(selectedPlan.price);
    final weeks = _getWeeksInDuration();
    
    // Calculate individual totals
    double mealsTotal = _selectedMeals.entries.fold(0.0, (sum, entry) {
      final meal = _availableMeals.firstWhere((m) => m.id == entry.key);
      return sum + (meal.price * entry.value);
    });
    
    double addOnsTotal = _selectedAddOns.entries.fold(0.0, (sum, entry) {
      final addon = _availableAddOns.firstWhere((a) => a.id == entry.key);
      return sum + (addon.price * entry.value);
    });
    
    double drinksTotal = _selectedDrinks.entries.fold(0.0, (sum, entry) {
      final drink = _availableDrinks.firstWhere((d) => d.id == entry.key);
      return sum + (drink.price * entry.value);
    });
    
    double weeklySubtotal = discountedPlanPrice + mealsTotal + addOnsTotal + drinksTotal;
    double totalPrice = weeklySubtotal * weeks;

    return [
      const SizedBox(height: 24),
      Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                selectedPlan.color.withValues(alpha: 0.1),
                selectedPlan.color.withValues(alpha: 0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.currentLanguage == 'zh' ? '订单摘要' : 'Order Summary',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(AppConstants.accentColorValue),
                ),
              ),
              const SizedBox(height: 16),
              
              // Plan Details
              _buildSummaryRow(
                label: selectedPlan.name,
                value: '¥${discountedPlanPrice.toStringAsFixed(2)}/周',
                isHeader: true,
              ),
              _buildSummaryRow(
                label: _getDurationText(),
                value: _selectedDuration > 0 ? '${((1 - _getDiscountRate()) * 100).toInt()}% OFF' : '',
                isSecondary: true,
              ),
              
              const SizedBox(height: 12),
              
              // Add-ons Breakdown
              if (_hasSelectedAddOns)
                ..._buildAddOnsBreakdown(),
              
              // Drinks Breakdown  
              if (_hasSelectedDrinks)
                ..._buildDrinksBreakdown(),
              
              // Meals Breakdown
              if (_hasSelectedMeals)
                ..._buildMealsBreakdown(),
              
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 8),
              
              // Weekly Subtotal
              _buildSummaryRow(
                label: widget.currentLanguage == 'zh' ? '每周小计' : 'Weekly Subtotal',
                value: '¥${weeklySubtotal.toStringAsFixed(2)}',
                isSubtotal: true,
              ),
              
              // Duration Total
              if (weeks > 1)
                _buildSummaryRow(
                  label: widget.currentLanguage == 'zh' ? '${_getDurationText()} ($weeks周)' : '${_getDurationText()} ($weeks weeks)',
                  value: '¥${totalPrice.toStringAsFixed(2)}',
                  isTotal: true,
                ),
              
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 8),
              
              // Final Total
              _buildSummaryRow(
                label: widget.currentLanguage == 'zh' ? '总计' : 'Total',
                value: '¥${totalPrice.toInt()}',
                isFinalTotal: true,
              ),
            ],
          ),
        ),
      ),
    ];
  }

  // Helper method to build summary rows
  Widget _buildSummaryRow({
    required String label,
    required String value,
    bool isHeader = false,
    bool isSecondary = false,
    bool isSubtotal = false,
    bool isTotal = false,
    bool isFinalTotal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: isFinalTotal ? 18 : (isHeader ? 16 : 14),
                fontWeight: isFinalTotal ? FontWeight.bold : (isHeader ? FontWeight.w600 : FontWeight.normal),
                color: isSecondary ? Colors.grey[600] : Colors.black,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isFinalTotal ? 24 : (isHeader ? 16 : 14),
              fontWeight: isFinalTotal ? FontWeight.bold : (isHeader ? FontWeight.w600 : FontWeight.normal),
              color: isFinalTotal ? const Color(AppConstants.primaryColorValue) : 
                     isSubtotal || isTotal ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // Build add-ons breakdown
  List<Widget> _buildAddOnsBreakdown() {
    return [
      const SizedBox(height: 8),
      Text(
        widget.currentLanguage == 'zh' ? '附加项目:' : 'Add-ons:',
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ),
      ..._selectedAddOns.entries.where((entry) => entry.value > 0).map((entry) {
        final addon = _availableAddOns.firstWhere((a) => a.id == entry.key);
        final total = addon.price * entry.value;
        return _buildItemBreakdown(
          name: widget.currentLanguage == 'zh' ? addon.nameZh : addon.nameEn,
          quantity: entry.value,
          unitPrice: addon.price,
          total: total,
        );
      }),
    ];
  }

  // Build drinks breakdown
  List<Widget> _buildDrinksBreakdown() {
    return [
      const SizedBox(height: 8),
      Text(
        widget.currentLanguage == 'zh' ? '饮品:' : 'Drinks:',
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ),
      ..._selectedDrinks.entries.where((entry) => entry.value > 0).map((entry) {
        final drink = _availableDrinks.firstWhere((d) => d.id == entry.key);
        final total = drink.price * entry.value;
        return _buildItemBreakdown(
          name: drink.getName(widget.currentLanguage),
          quantity: entry.value,
          unitPrice: drink.price,
          total: total,
        );
      }),
    ];
  }

  // Build meals breakdown
  List<Widget> _buildMealsBreakdown() {
    return [
      const SizedBox(height: 8),
      Text(
        widget.currentLanguage == 'zh' ? '餐食:' : 'Meals:',
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ),
      ..._selectedMeals.entries.where((entry) => entry.value > 0).map((entry) {
        final meal = _availableMeals.firstWhere((m) => m.id == entry.key);
        final total = meal.price * entry.value;
        return _buildItemBreakdown(
          name: meal.getName(widget.currentLanguage),
          quantity: entry.value,
          unitPrice: meal.price,
          total: total,
        );
      }),
    ];
  }

  // Helper method to build individual item breakdown
  Widget _buildItemBreakdown({
    required String name,
    required int quantity,
    required double unitPrice,
    required double total,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: const TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '$quantity × ¥${unitPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(width: 8),
                Text(
                  '¥${total.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Action Buttons
  Widget _buildActionButtons() {
    final hasSelection = _selectedPlanId != null;
    
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: Navigator.of(context).pop,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: const BorderSide(color: Colors.grey),
            ),
            child: Text(
              widget.currentLanguage == 'zh' ? '返回' : 'Back',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: hasSelection ? _proceedToPayment : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(AppConstants.primaryColorValue),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
            ),
            child: Text(
              widget.currentLanguage == 'zh' ? '继续支付' : 'Proceed to Payment',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Helper methods
  double _calculateDiscountedPrice(double originalPrice) {
    return originalPrice * _getDiscountRate();
  }

  double _getDiscountRate() {
    switch (_selectedDuration) {
      case 0: return 1.0;
      case 1: return 0.9;
      case 2: return 0.8;
      default: return 1.0;
    }
  }

  int _getWeeksInDuration() {
    switch (_selectedDuration) {
      case 0: return 1;
      case 1: return 4;
      case 2: return 12;
      default: return 1;
    }
  }

  String _getPeriodText() {
    switch (_selectedDuration) {
      case 0: return widget.currentLanguage == 'zh' ? '/周' : '/week';
      case 1: return widget.currentLanguage == 'zh' ? '/月' : '/month';
      case 2: return widget.currentLanguage == 'zh' ? '/季度' : '/quarter';
      default: return widget.currentLanguage == 'zh' ? '/周' : '/week';
    }
  }

  String _getDurationText() {
    switch (_selectedDuration) {
      case 0: return widget.currentLanguage == 'zh' ? '周付' : 'Weekly billing';
      case 1: return widget.currentLanguage == 'zh' ? '月付 (4周)' : 'Monthly billing (4 weeks)';
      case 2: return widget.currentLanguage == 'zh' ? '季付 (12周)' : 'Quarterly billing (12 weeks)';
      default: return widget.currentLanguage == 'zh' ? '周付' : 'Weekly billing';
    }
  }

  void _navigateToSubscriptionSelection() {
    // Scroll to plans section or show selection dialog
  }

  void _proceedToPayment() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(widget.currentLanguage == 'zh' ? '确认订阅' : 'Confirm Subscription'),
        content: Text(widget.currentLanguage == 'zh' 
            ? '您即将订阅所选套餐。继续支付？'
            : 'You are about to subscribe to the selected plan. Proceed with payment?'),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: Text(widget.currentLanguage == 'zh' ? '取消' : 'Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showPaymentSuccess();
            },
            child: Text(widget.currentLanguage == 'zh' ? '确认支付' : 'Confirm Payment'),
          ),
        ],
      ),
    );
  }

  void _showPaymentSuccess() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(widget.currentLanguage == 'zh' ? '订阅成功' : 'Subscription Successful'),
        content: Text(widget.currentLanguage == 'zh' 
            ? '您的订阅已成功激活！'
            : 'Your subscription has been successfully activated!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text(widget.currentLanguage == 'zh' ? '完成' : 'Done'),
          ),
        ],
      ),
    );
  }

  void _navigateToAdminManagement() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => SubscriptionManagementPage(
          currentLanguage: widget.currentLanguage,
        ),
      ),
    );
  }
}

class AddOnItem {
  final String id;
  final String nameEn;
  final String nameZh;
  final String descriptionEn;
  final String descriptionZh;
  final double price;
  final String image;

  const AddOnItem({
    required this.id,
    required this.nameEn,
    required this.nameZh,
    required this.descriptionEn,
    required this.descriptionZh,
    required this.price,
    required this.image,
  });
}
