import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:canton_connect/core/constants/app_constants.dart';
import 'package:canton_connect/data/models/food_item.dart';
import 'package:canton_connect/presentation/pages/food_detail_page.dart';
import 'package:canton_connect/core/providers/language_provider.dart';
import 'package:canton_connect/presentation/widgets/menu/all_menu_section.dart';
import 'package:canton_connect/presentation/widgets/menu/menu_header_section.dart';
import 'package:canton_connect/presentation/widgets/menu/family_packages_section.dart';
import 'package:canton_connect/presentation/widgets/menu/data/menu_data.dart';
import 'package:canton_connect/core/utils/responsive.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String _selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final PageController _categoryPageController = PageController();

  // Enhanced categories with icons and counts
  final List<MenuCategory> _categories = [
    MenuCategory(id: 'All', name: 'All', nameZh: '全部', icon: Icons.all_inclusive, count: 0),
    MenuCategory(id: 'Family Packages', name: 'Family Packages', nameZh: '家庭套餐', icon: Icons.people, count: 4),
    MenuCategory(id: 'Signature Dishes', name: 'Signature Dishes', nameZh: '招牌菜', icon: Icons.star, count: 6),
    MenuCategory(id: 'Youth Favorites', name: 'Youth Favorites', nameZh: '年轻人最爱', icon: Icons.favorite, count: 5),
    MenuCategory(id: 'Healthy Options', name: 'Healthy Options', nameZh: '健康选择', icon: Icons.eco, count: 4),
    MenuCategory(id: 'Desserts', name: 'Desserts', nameZh: '甜品', icon: Icons.cake, count: 3),
    MenuCategory(id: 'Appetizers', name: 'Appetizers', nameZh: '开胃菜', icon: Icons.restaurant, count: 4),
    MenuCategory(id: 'Main Courses', name: 'Main Courses', nameZh: '主菜', icon: Icons.dinner_dining, count: 8),
    MenuCategory(id: 'Soups', name: 'Soups', nameZh: '汤品', icon: Icons.soup_kitchen, count: 3),
  ];

  @override
  void initState() {
    super.initState();
    // Initialize category counts
    _updateCategoryCounts();
  }

  void _updateCategoryCounts() {
    for (var category in _categories) {
      if (category.id == 'All') {
        category.count = MenuData.sampleFoodItems.length;
      } else {
        category.count = MenuData.sampleFoodItems
            .where((item) => item.category == category.id)
            .length;
      }
    }
  }

  void _handleSearchTap() {
    // Get current language from provider
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    final currentLanguage = languageProvider.isChinese ? 'zh' : 'en';
    _showSearchDialog(context, currentLanguage);
  }

  void _handleCategorySelected(String categoryId) {
    setState(() {
      _selectedCategory = categoryId;
    });
    
    // Smooth scroll to top when category changes
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _handleFoodItemTap(FoodItem foodItem) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FoodDetailPage(foodItem: foodItem),
      ),
    );
  }

  void _showSearchDialog(BuildContext context, String currentLanguage) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                currentLanguage == 'zh' ? '搜索菜单' : 'Search Menu',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: currentLanguage == 'zh' ? '输入菜品名称...' : 'Enter food name...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                autofocus: true,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(currentLanguage == 'zh' ? '取消' : 'Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _performSearch(_searchController.text, currentLanguage);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(AppConstants.primaryColorValue),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(currentLanguage == 'zh' ? '搜索' : 'Search'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _performSearch(String query, String currentLanguage) {
    if (query.isEmpty) {
      _showComingSoon(context, currentLanguage, 
        currentLanguage == 'zh' ? '请输入搜索关键词' : 'Please enter search keywords'
      );
      return;
    }
    
    _showComingSoon(context, currentLanguage, 
      currentLanguage == 'zh' ? '搜索功能即将推出' : 'Search feature coming soon'
    );
  }

  void _showComingSoon(BuildContext context, String currentLanguage, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(AppConstants.primaryColorValue),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  List<FoodItem> get _filteredFoodItems {
    if (_selectedCategory == 'All') {
      return MenuData.sampleFoodItems;
    }
    return MenuData.sampleFoodItems
        .where((item) => item.category == _selectedCategory)
        .toList();
  }

  Widget _buildCurrentSection(String currentLanguage) {
    _categories.firstWhere(
      (cat) => cat.id == _selectedCategory,
      orElse: () => _categories.first,
    );

    switch (_selectedCategory) {
      case 'All':
        return Column(
          children: [
            // Featured items section (like Tsquaredeats)
            if (_hasFeaturedItems) _buildFeaturedSection(currentLanguage),
            AllMenuSection(
              currentLanguage: currentLanguage,
              foodItems: _filteredFoodItems,
              onFoodItemTap: _handleFoodItemTap,
            ),
            FamilyPackagesSection(
              currentLanguage: currentLanguage,
              onFoodItemTap: _handleFoodItemTap,
            ),
          ],
        );
      case 'Family Packages':
        return FamilyPackagesSection(
          currentLanguage: currentLanguage,
          onFoodItemTap: _handleFoodItemTap,
        );
      default:
        return AllMenuSection(
          currentLanguage: currentLanguage,
          foodItems: _filteredFoodItems,
          onFoodItemTap: _handleFoodItemTap,
        );
    }
  }

  bool get _hasFeaturedItems {
    return MenuData.sampleFoodItems.any((item) => item.isFeatured);
  }

  Widget _buildFeaturedSection(String currentLanguage) {
    final featuredItems = MenuData.sampleFoodItems
        .where((item) => item.isFeatured)
        .take(3)
        .toList();

    if (featuredItems.isEmpty) return const SizedBox();

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: _getHorizontalPadding(context),
            ),
            child: Text(
              currentLanguage == 'zh' ? '特色推荐' : 'Featured Items',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(AppConstants.primaryColorValue),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(
                horizontal: _getHorizontalPadding(context),
              ),
              itemCount: featuredItems.length,
              itemBuilder: (context, index) {
                final foodItem = featuredItems[index];
                return Container(
                  width: 280,
                  margin: EdgeInsets.only(
                    right: index == featuredItems.length - 1 ? 0 : 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: NetworkImage(foodItem.images.first),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withAlpha(204),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(AppConstants.secondaryColorValue),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            currentLanguage == 'zh' ? '推荐' : 'Featured',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          currentLanguage == 'zh' ? foodItem.nameZh : foodItem.nameEn,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '¥${foodItem.price}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  double _getHeaderHeight(BuildContext context) {
    if (context.isMobile) {
      return 80.0;
    } else if (context.isTablet) {
      return 100.0;
    } else {
      return 120.0;
    }
  }

  // NEW: Helper method to replace the deprecated getHorizontalPadding
  double _getHorizontalPadding(BuildContext context) {
    final responsive = Responsive(context);
    return responsive.getResponsivePadding(
      16.0, // mobile
      tablet: 20.0,
      desktop: 24.0,
      largeDesktop: 32.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final headerHeight = _getHeaderHeight(context);
    
    // FIX: Use Consumer to properly listen to language changes
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        final currentLanguage = languageProvider.isChinese ? 'zh' : 'en';
        
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Color(0xFFF8F9FA),
                ],
              ),
            ),
            child: _buildContent(headerHeight, currentLanguage),
          ),
        );
      },
    );
  }

  Widget _buildContent(double headerHeight, String currentLanguage) {
    return Column(
      children: [
        // Header Section
        Container(
          height: headerHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000).withAlpha(25),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: MenuHeaderSection(
            currentLanguage: currentLanguage,
            onSearchTap: _handleSearchTap,
            isCompact: headerHeight <= 100,
          ),
        ),
        
        // Categories Section - Enhanced with better design
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000).withAlpha(15),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: _buildEnhancedCategoriesSection(currentLanguage),
        ),
        
        // Main Content
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFFF8F9FA),
            ),
            child: _buildMainContent(currentLanguage),
          ),
        ),
      ],
    );
  }

  Widget _buildEnhancedCategoriesSection(String currentLanguage) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: _getHorizontalPadding(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              currentLanguage == 'zh' ? '菜品分类' : 'Menu Categories',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(AppConstants.accentColorValue),
              ),
            ),
          ),
          
          // Categories
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category.id;
                
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          category.icon,
                          size: 16,
                          color: isSelected ? Colors.white : const Color(AppConstants.primaryColorValue),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          currentLanguage == 'zh' ? category.nameZh : category.name,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.white : const Color(AppConstants.accentColorValue),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white.withAlpha(76) : const Color(AppConstants.primaryColorValue).withAlpha(25),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            category.count.toString(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : const Color(AppConstants.primaryColorValue),
                            ),
                          ),
                        ),
                      ],
                    ),
                    selected: isSelected,
                    onSelected: (selected) => _handleCategorySelected(category.id),
                    backgroundColor: Colors.white,
                    selectedColor: const Color(AppConstants.primaryColorValue),
                    checkmarkColor: Colors.white,
                    shape: StadiumBorder(
                      side: BorderSide(
                        color: isSelected 
                            ? const Color(AppConstants.primaryColorValue)
                            : Colors.grey.shade300,
                        width: isSelected ? 0 : 1,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(String currentLanguage) {
    final selectedCategory = _categories.firstWhere(
      (cat) => cat.id == _selectedCategory,
      orElse: () => _categories.first,
    );

    return CustomScrollView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      slivers: [
        // Header with category info
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: _getHorizontalPadding(context),
              vertical: 24,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentLanguage == 'zh' 
                          ? selectedCategory.nameZh 
                          : selectedCategory.name,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Color(AppConstants.primaryColorValue),
                        fontFamily: AppConstants.primaryFont,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${selectedCategory.count} ${currentLanguage == 'zh' ? '个菜品可选' : 'items available'}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                
                // Quick filters (like Grain.com.sg)
                if (context.isDesktop) ...[
                  Row(
                    children: [
                      _buildQuickFilter('Vegetarian', currentLanguage == 'zh' ? '素食' : 'Vegetarian'),
                      const SizedBox(width: 8),
                      _buildQuickFilter('Spicy', currentLanguage == 'zh' ? '辣味' : 'Spicy'),
                      const SizedBox(width: 8),
                      _buildQuickFilter('Popular', currentLanguage == 'zh' ? '热门' : 'Popular'),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
        
        // Menu content
        SliverToBoxAdapter(
          child: _buildCurrentSection(currentLanguage),
        ),
        
        // Bottom spacing
        const SliverToBoxAdapter(
          child: SizedBox(height: 40),
        ),
      ],
    );
  }

  Widget _buildQuickFilter(String type, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getFilterIcon(type),
            size: 14,
            color: Colors.grey.shade600,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getFilterIcon(String type) {
    switch (type) {
      case 'Vegetarian':
        return Icons.eco;
      case 'Spicy':
        return Icons.local_fire_department;
      case 'Popular':
        return Icons.trending_up;
      default:
        return Icons.filter_list;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _categoryPageController.dispose();
    super.dispose();
  }
}

class MenuCategory {
  final String id;
  final String name;
  final String nameZh;
  final IconData icon;
  int count;

  MenuCategory({
    required this.id,
    required this.name,
    required this.nameZh,
    required this.icon,
    required this.count,
  });
}
