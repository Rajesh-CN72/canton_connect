import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:canton_connect/core/providers/language_provider.dart';
import 'package:canton_connect/core/utils/color_verifier.dart';

class HealthPhilosophySection extends StatelessWidget {
  const HealthPhilosophySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isChinese = languageProvider.isChinese;

    return Container(
      color: const Color(0xFFF8F9FA),
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        children: [
          Text(
            isChinese ? '????' : 'Health Philosophy',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            isChinese 
                ? '??????????????'
                : 'We believe food should be both delicious and healthy',
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
              
              if (screenWidth < 810) { // Mobile: 0-809px
                crossAxisCount = 1;
              } else if (screenWidth < 1200) { // Tablet: 810-1199px
                crossAxisCount = 2;
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
                itemCount: 4,
                itemBuilder: (context, index) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 250 + (index * 100)),
                    curve: Curves.easeInOut,
                    child: _buildPhilosophyItem(
                      _philosophies[index]['icon']!,
                      isChinese ? _philosophies[index]['title_zh']! : _philosophies[index]['title_en']!,
                      isChinese ? _philosophies[index]['desc_zh']! : _philosophies[index]['desc_en']!,
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
      return 1.8;
    } else if (screenWidth < 1200) { // Tablet
      return 1.4;
    } else { // Desktop
      return 1.0;
    }
  }

  Widget _buildPhilosophyItem(IconData icon, String title, String description, double screenWidth) {
    final isMobile = screenWidth < 810;
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: isMobile ? const EdgeInsets.all(16) : const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: isMobile ? 32 : 40,
              color: ColorVerifier.primaryGreen,
            ),
            SizedBox(height: isMobile ? 12 : 16),
            Flexible(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 16 : 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2C3E50),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: isMobile ? 8 : 12),
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 13 : 14,
                    color: const Color(0xFF7F8C8D),
                    height: 1.4,
                  ),
                  maxLines: 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const List<Map<String, dynamic>> _philosophies = [
    {
      'icon': Icons.food_bank,
      'title_en': 'Fresh Ingredients',
      'title_zh': '????',
      'desc_en': 'Only the freshest local ingredients',
      'desc_zh': '???????????',
    },
    {
      'icon': Icons.balance,
      'title_en': 'Balanced Nutrition',
      'title_zh': '????',
      'desc_en': 'Perfect balance of proteins, carbs and vegetables',
      'desc_zh': '?????????????????',
    },
    {
      'icon': Icons.local_fire_department,
      'title_en': 'Low Oil Cooking',
      'title_zh': '????',
      'desc_en': 'Healthy cooking methods with minimal oil',
      'desc_zh': '???????,?????',
    },
    {
      'icon': Icons.agriculture,
      'title_en': 'Sustainable Sourcing',
      'title_zh': '?????',
      'desc_en': 'Responsibly sourced ingredients from trusted suppliers',
      'desc_zh': '??????????????????',
    },
  ];
}
