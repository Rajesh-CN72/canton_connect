import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:canton_connect/core/providers/language_provider.dart';
import 'package:canton_connect/core/utils/color_verifier.dart';
import 'package:canton_connect/core/providers/currency_provider.dart'; // This should work now

class FeaturedMenuSection extends StatelessWidget {
  const FeaturedMenuSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isChinese = languageProvider.isChinese;

    return Container(
      color: const Color(0xFFF8F9FA),
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        children: [
          // Centered Header Section
          Column(
            children: [
              // Title - Now centered
              LayoutBuilder(
                builder: (context, constraints) {
                  final screenWidth = constraints.maxWidth;
                  final isMobile = screenWidth < 810;
                  
                  return Text(
                    isChinese ? '特色菜单' : 'Featured Menu',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isMobile ? 24 : 32,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2C3E50),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              // Subtitle
              Text(
                isChinese 
                    ? '品尝我们最受欢迎的粤菜佳肴'
                    : 'Taste our most popular Cantonese delicacies',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF7F8C8D),
                ),
              ),
              const SizedBox(height: 20),
              // View All Button - Now centered below the title
              LayoutBuilder(
                builder: (context, constraints) {
                  final screenWidth = constraints.maxWidth;
                  final isMobile = screenWidth < 810;
                  
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: ColorVerifier.warmOrange,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        isChinese ? '查看全部' : 'View All',
                        style: TextStyle(
                          fontSize: isMobile ? 14 : 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 40),
          
          // Responsive Menu Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;
              int crossAxisCount;
              
              // Responsive breakpoints
              if (screenWidth < 600) { // Small mobile
                crossAxisCount = 1;
              } else if (screenWidth < 810) { // Mobile: 0-809px
                crossAxisCount = 2;
              } else if (screenWidth < 1200) { // Tablet: 810-1199px
                crossAxisCount = 3;
              } else { // Desktop: 1200px+
                crossAxisCount = 4;
              }
              
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: _getChildAspectRatio(screenWidth),
                ),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 200 + (index * 150)),
                    curve: Curves.easeInOut,
                    child: _buildMenuItem(
                      context,
                      isChinese ? _menuItems[index]['name_zh']! : _menuItems[index]['name_en']!,
                      isChinese ? _menuItems[index]['desc_zh']! : _menuItems[index]['desc_en']!,
                      _menuItems[index]['price']!,
                      _menuItems[index]['icon']!,
                      screenWidth,
                      isChinese,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  double _getChildAspectRatio(double screenWidth) {
    if (screenWidth < 600) { // Small mobile
      return 1.6;
    } else if (screenWidth < 810) { // Mobile
      return 1.2;
    } else if (screenWidth < 1200) { // Tablet
      return 0.9;
    } else { // Desktop
      return 0.8;
    }
  }

  Widget _buildMenuItem(BuildContext context, String name, String description, String price, IconData icon, double screenWidth, bool isChinese) {
    final isSmallMobile = screenWidth < 600;
    final isMobile = screenWidth < 810;
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Food icon instead of image
          Container(
            height: isSmallMobile ? 120 : isMobile ? 140 : 160,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.8),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Center(
              child: Icon(
                icon,
                size: 50,
                color: ColorVerifier.primaryGreen,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: isSmallMobile 
                  ? const EdgeInsets.all(12) 
                  : const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: isSmallMobile ? 14 : 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2C3E50),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: isSmallMobile ? 4 : 8),
                  Expanded(
                    child: Text(
                      description,
                      style: TextStyle(
                        fontSize: isSmallMobile ? 11 : 12,
                        color: const Color(0xFF7F8C8D),
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: isSmallMobile ? 8 : 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Use Consumer to get CurrencyProvider and format price
                      Consumer<CurrencyProvider>(
                        builder: (context, currency, child) {
                          double priceValue = double.tryParse(price) ?? 0.0;
                          return Text(
                            currency.formatPrice(priceValue),
                            style: TextStyle(
                              fontSize: isSmallMobile ? 14 : 16,
                              fontWeight: FontWeight.bold,
                              color: ColorVerifier.primaryGreen,
                            ),
                          );
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: ColorVerifier.warmOrange,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          isSmallMobile ? '+' : (isChinese ? '加入购物车' : 'Add to Cart'),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static const List<Map<String, dynamic>> _menuItems = [
    {
      'name_en': 'Steamed Shrimp Dumplings',
      'name_zh': '虾饺',
      'desc_en': 'Fresh shrimp wrapped in thin dough',
      'desc_zh': '新鲜虾肉包裹在薄面皮中',
      'price': '12.99',
      'icon': Icons.dinner_dining,
    },
    {
      'name_en': 'Crispy Roast Duck',
      'name_zh': '脆皮烤鸭',
      'desc_en': 'Traditional Cantonese roast duck',
      'desc_zh': '传统粤式烤鸭',
      'price': '24.99',
      'icon': Icons.emoji_food_beverage,
    },
    {
      'name_en': 'Wonton Noodle Soup',
      'name_zh': '云吞面',
      'desc_en': 'Shrimp wontons in clear broth',
      'desc_zh': '鲜虾云吞配清汤',
      'price': '8.99',
      'icon': Icons.soup_kitchen,
    },
    {
      'name_en': 'Barbecue Pork',
      'name_zh': '叉烧',
      'desc_en': 'Sweet and savory roasted pork',
      'desc_zh': '甜咸适中的烤猪肉',
      'price': '15.99',
      'icon': Icons.outdoor_grill,
    },
    {
      'name_en': 'Portuguese Egg Tart',
      'name_zh': '葡式蛋挞',
      'desc_en': 'Creamy custard in flaky pastry',
      'desc_zh': '酥皮包裹奶油蛋羹',
      'price': '3.99',
      'icon': Icons.cake,
    },
    {
      'name_en': 'Century Egg Congee',
      'name_zh': '皮蛋瘦肉粥',
      'desc_en': 'Rice porridge with century egg',
      'desc_zh': '皮蛋配瘦肉粥',
      'price': '6.99',
      'icon': Icons.breakfast_dining,
    },
    {
      'name_en': 'Spring Rolls',
      'name_zh': '春卷',
      'desc_en': 'Crispy vegetable spring rolls',
      'desc_zh': '脆皮蔬菜春卷',
      'price': '5.99',
      'icon': Icons.bakery_dining,
    },
    {
      'name_en': 'Mango Pudding',
      'name_zh': '芒果布丁',
      'desc_en': 'Fresh mango dessert',
      'desc_zh': '新鲜芒果甜点',
      'price': '4.99',
      'icon': Icons.icecream,
    },
  ];
}
