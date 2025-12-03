import 'package:flutter/material.dart';
import 'package:canton_connect/data/models/food_item.dart';
import 'package:canton_connect/core/constants/app_colors.dart';
import 'package:canton_connect/core/widgets/buttons/secondary_button.dart';

class FoodDetailInfo extends StatelessWidget {
  final FoodItem foodItem;
  final String currentLanguage;
  final num Function(String) getNutritionValue;

  const FoodDetailInfo({
    super.key,
    required this.foodItem,
    required this.currentLanguage,
    required this.getNutritionValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Food Attributes
        _buildAttributesSection(),
        
        // Additional Sections
        _buildNutritionSection(),
        _buildIngredientsSection(),
        _buildAllergensSection(),
        _buildReviewsSection(),
      ],
    );
  }

  Widget _buildAttributesSection() {
    Widget buildAttributeItem(IconData icon, String value, String label) {
      return Column(
        children: [
          Icon(icon, color: AppColors.primary, size: 24),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildAttributeItem(Icons.schedule, '${foodItem.preparationTime} min', 'Prep Time'),
          buildAttributeItem(Icons.local_fire_department, '${getNutritionValue('calories')} cal', 'Calories'),
          buildAttributeItem(Icons.people, '${foodItem.serves} serves', 'Serves'),
        ],
      ),
    );
  }

  Widget _buildNutritionSection() {
    Widget buildNutritionRow(String label, String value) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      );
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
                Icons.restaurant_menu,
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                currentLanguage == 'zh' ? '营养信息' : 'Nutrition',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Nutrition Facts Box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Column(
              children: [
                buildNutritionRow(
                  currentLanguage == 'zh' ? '卡路里' : 'Calories', 
                  '${getNutritionValue('calories')} kcal',
                ),
                const Divider(color: AppColors.borderLight, height: 20),
                buildNutritionRow(
                  currentLanguage == 'zh' ? '蛋白质' : 'Protein', 
                  '${getNutritionValue('protein')}g',
                ),
                const Divider(color: AppColors.borderLight, height: 20),
                buildNutritionRow(
                  currentLanguage == 'zh' ? '碳水化合物' : 'Carbohydrates', 
                  '${getNutritionValue('carbs')}g',
                ),
                const Divider(color: AppColors.borderLight, height: 20),
                buildNutritionRow(
                  currentLanguage == 'zh' ? '脂肪' : 'Fat', 
                  '${getNutritionValue('fat')}g',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientsSection() {
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
                Icons.list_alt,
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                currentLanguage == 'zh' ? '主要成分' : 'Ingredients',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: foodItem.ingredients.map((ingredient) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(25),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  ingredient,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAllergensSection() {
    if (foodItem.allergens.isEmpty) {
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
                Icons.warning,
                color: Colors.orange,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                currentLanguage == 'zh' ? '过敏原信息' : 'Allergens',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: foodItem.allergens.map((allergen) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red.withAlpha(25),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.red),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.warning, color: Colors.red, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      allergen,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsSection() {
    Widget buildReviewItem(String name, String comment, int rating) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Rating Stars
            Row(
              children: List.generate(5, (index) {
                return const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 16,
                );
              }),
            ),
            const SizedBox(height: 8),
            
            // Comment
            Text(
              comment,
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            
            // Reviewer Name
            Text(
              name,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.reviews,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    currentLanguage == 'zh' ? '顾客评价' : 'Customer Reviews',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              Text(
                '${foodItem.rating} ⭐ (${foodItem.reviewCount})',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.amber,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Sample Reviews
          buildReviewItem(
            '张先生',
            '作为广东人，这家的粤菜非常正宗！每周都订，省去了很多做饭的麻烦。',
            5,
          ),
          const SizedBox(height: 12),
          buildReviewItem(
            'Lisa Chen',
            'Fresh ingredients, great taste, timely delivery. Already recommended to all my colleagues!',
            5,
          ),
          const SizedBox(height: 12),
          buildReviewItem(
            '王女士',
            '健康又美味，孩子很喜欢。解决了双职工家庭的吃饭问题。',
            4,
          ),
          
          const SizedBox(height: 16),
          SecondaryButton(
            text: currentLanguage == 'zh' ? '查看所有评价' : 'View All Reviews',
            onPressed: () {
              // Navigate to reviews page
            },
          ),
        ],
      ),
    );
  }
}
