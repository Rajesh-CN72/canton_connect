import 'package:flutter/material.dart';
import 'package:canton_connect/core/constants/app_colors.dart';

class MenuCategoriesSection extends StatefulWidget {
  final String currentLanguage;
  final String selectedCategory;
  final Function(String) onCategorySelected;
  final List<String> categories;

  const MenuCategoriesSection({
    Key? key,
    required this.currentLanguage,
    required this.selectedCategory,
    required this.onCategorySelected,
    required this.categories,
  }) : super(key: key);

  @override
  State<MenuCategoriesSection> createState() => _MenuCategoriesSectionState();
}

class _MenuCategoriesSectionState extends State<MenuCategoriesSection> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToCategory(int index) {
    const double itemWidth = 120; // Approximate width of each chip
    final double screenWidth = MediaQuery.of(context).size.width;
    final double offset = (itemWidth * index) - (screenWidth / 2) + (itemWidth / 2);
    
    _scrollController.animateTo(
      offset.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70, // Slightly taller for better touch area
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = widget.categories[index];
          final isSelected = widget.selectedCategory == category;
          
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: ChoiceChip(
              label: Text(
                _getCategoryLabel(category),
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.textPrimary,
                  fontWeight: FontWeight.w600, // Slightly bolder
                  fontSize: 14,
                  fontFamily: widget.currentLanguage == 'zh' ? 'NotoSansSC' : 'Poppins',
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                widget.onCategorySelected(category);
                _scrollToCategory(index);
              },
              backgroundColor: Colors.white,
              selectedColor: AppColors.primary,
              side: BorderSide(
                color: isSelected ? AppColors.primary : AppColors.borderLight,
                width: isSelected ? 0 : 1.5, // Remove border when selected
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25), // More rounded
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              visualDensity: VisualDensity.compact,
              elevation: isSelected ? 2 : 0,
              shadowColor: Colors.black12,
            ),
          );
        },
      ),
    );
  }

  String _getCategoryLabel(String category) {
    final Map<String, Map<String, String>> categoryTranslations = {
      'All': {'en': 'All', 'zh': '全部'},
      'Family Packages': {'en': 'Family Packages', 'zh': '家庭套餐'},
      'Signature Dishes': {'en': 'Signature Dishes', 'zh': '招牌菜'},
      'Youth Favorites': {'en': 'Youth Favorites', 'zh': '青年最爱'},
      'Healthy Options': {'en': 'Healthy Options', 'zh': '健康选择'},
      'Desserts': {'en': 'Desserts', 'zh': '甜品'},
    };

    return categoryTranslations[category]?[widget.currentLanguage] ?? category;
  }
}
