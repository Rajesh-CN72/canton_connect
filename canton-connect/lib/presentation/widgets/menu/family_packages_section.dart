import 'package:flutter/material.dart';
import 'package:canton_connect/core/constants/app_constants.dart';
import 'package:canton_connect/data/models/food_item.dart';
import 'package:canton_connect/presentation/widgets/menu/data/menu_data.dart';

class FamilyPackagesSection extends StatelessWidget {
  final String currentLanguage;
  final Function(FoodItem) onFoodItemTap;

  const FamilyPackagesSection({
    super.key,
    required this.currentLanguage,
    required this.onFoodItemTap,
  });

  @override
  Widget build(BuildContext context) {
    final familyPackages = MenuData.sampleFoodItems.where((item) => 
      item.category == 'Main Course' && item.price > 25).toList();

    if (familyPackages.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            currentLanguage == 'zh' ? '家庭套餐' : 'Family Packages',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(AppConstants.accentColorValue),
              fontFamily: AppConstants.primaryFont,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            currentLanguage == 'zh' 
                ? '适合全家享用的超值套餐' 
                : 'Value packages perfect for the whole family',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          
          ...familyPackages.map(_buildFamilyPackageCard),
        ],
      ),
    );
  }

  Widget _buildFamilyPackageCard(FoodItem package) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => onFoodItemTap(package),
        borderRadius: BorderRadius.circular(12),
        child: Row(
          children: [
            // Package Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.asset(
                package.images.first,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 120,
                    height: 120,
                    color: Colors.grey[200],
                    child: const Icon(Icons.family_restroom, size: 40, color: Colors.grey),
                  );
                },
              ),
            ),
            
            // Package Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      package.getName(currentLanguage),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(AppConstants.accentColorValue),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      package.getDescription(currentLanguage),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    
                    // Features
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        _buildFeatureIcon(Icons.people, '3-4 people'),
                        _buildFeatureIcon(Icons.access_time, '${package.cookingTime} mins'),
                        if (package.isSpicy)
                          _buildFeatureIcon(Icons.local_fire_department, 'Spicy'),
                        if (package.isVegetarian)
                          _buildFeatureIcon(Icons.eco, 'Vegetarian'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    
                    // Price
                    Text(
                      '\$${package.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(AppConstants.primaryColorValue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureIcon(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.grey[600]),
        const SizedBox(width: 2),
        Text(
          text,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
