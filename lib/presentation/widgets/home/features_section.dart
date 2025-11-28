import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:canton_connect/core/providers/language_provider.dart';
import 'package:canton_connect/core/utils/color_verifier.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isChinese = languageProvider.isChinese;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        children: [
          Text(
            isChinese ? '我们的特色' : 'Our Features', // FIXED CHINESE TEXT
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            isChinese 
                ? '体验正宗粤菜与现代融合的完美结合' // FIXED CHINESE TEXT
                : 'Experience the perfect blend of authentic Cantonese cuisine with modern fusion',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF7F8C8D),
            ),
          ),
          const SizedBox(height: 40),
          
          // Responsive GridView
          LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;
              int crossAxisCount;
              
              // Responsive breakpoints
              if (screenWidth < 810) { // Mobile: 0-809px - 2 columns
                crossAxisCount = 2;
              } else if (screenWidth < 1200) { // Tablet: 810-1199px - 4 columns
                crossAxisCount = 4;
              } else { // Desktop: 1200px+ - 6 columns
                crossAxisCount = 6;
              }
              
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: _getChildAspectRatio(screenWidth),
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 200 + (index * 150)), // Staggered animation
                    curve: Curves.easeInOut,
                    child: _buildFeatureCard(
                      context,
                      _features[index]['icon']!,
                      isChinese ? _features[index]['title_zh']! : _features[index]['title_en']!,
                      isChinese ? _features[index]['desc_zh']! : _features[index]['desc_en']!,
                      screenWidth,
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
    if (screenWidth < 810) { // Mobile
      return 0.9;
    } else if (screenWidth < 1200) { // Tablet
      return 0.8;
    } else { // Desktop
      return 0.7;
    }
  }

  Widget _buildFeatureCard(BuildContext context, IconData icon, String title, String description, double screenWidth) {
    final isMobile = screenWidth < 810;
    
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: isMobile ? const EdgeInsets.all(12) : const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: isMobile ? 40 : 50,
              height: isMobile ? 40 : 50,
              decoration: const BoxDecoration(
                color: ColorVerifier.primaryGreen,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: isMobile ? 20 : 24,
              ),
            ),
            SizedBox(height: isMobile ? 8 : 12),
            Flexible(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 14 : 16,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2C3E50),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: isMobile ? 4 : 8),
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 11 : 12,
                    color: const Color(0xFF7F8C8D),
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const List<Map<String, dynamic>> _features = [
    {
      'icon': Icons.restaurant,
      'title_en': 'Authentic Taste',
      'title_zh': '正宗口味', // FIXED CHINESE TEXT
      'desc_en': 'Traditional Cantonese recipes',
      'desc_zh': '传统粤菜配方', // FIXED CHINESE TEXT
    },
    {
      'icon': Icons.health_and_safety,
      'title_en': 'Healthy',
      'title_zh': '健康', // FIXED CHINESE TEXT
      'desc_en': 'Fresh, quality ingredients',
      'desc_zh': '新鲜优质食材', // FIXED CHINESE TEXT
    },
    {
      'icon': Icons.delivery_dining,
      'title_en': 'Fast Delivery',
      'title_zh': '快速配送', // FIXED CHINESE TEXT
      'desc_en': 'Quick reliable delivery',
      'desc_zh': '快速可靠配送', // FIXED CHINESE TEXT
    },
    {
      'icon': Icons.eco,
      'title_en': 'Eco Friendly',
      'title_zh': '环保', // FIXED CHINESE TEXT
      'desc_en': 'Sustainable packaging',
      'desc_zh': '可持续包装', // FIXED CHINESE TEXT
    },
    {
      'icon': Icons.schedule,
      'title_en': 'Meal Plans',
      'title_zh': '膳食计划', // FIXED CHINESE TEXT
      'desc_en': 'Customizable plans',
      'desc_zh': '可定制计划', // FIXED CHINESE TEXT
    },
    {
      'icon': Icons.star,
      'title_en': 'Premium',
      'title_zh': '优质', // FIXED CHINESE TEXT
      'desc_en': 'Finest ingredients',
      'desc_zh': '精选食材', // FIXED CHINESE TEXT
    },
  ];
}
