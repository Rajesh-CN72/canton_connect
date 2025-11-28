import 'package:flutter/material.dart';
import 'package:canton_connect/core/constants/app_constants.dart';

class ProblemSolveSection extends StatelessWidget {
  final String currentLanguage;

  const ProblemSolveSection({
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
      color: Colors.white,
      child: Column(
        children: [
          Text(
            currentLanguage == 'zh' ? '我们解决的问题' : 'Problems We Solve',
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
                ? '让您的生活更简单，更美味'
                : 'Making your life easier and more delicious',
            style: const TextStyle(
              fontSize: 16,
              color: Color(AppConstants.accentColorValue),
              fontFamily: AppConstants.secondaryFont,
            ),
          ),
          const SizedBox(height: 50),
          
          if (isMobile) ..._buildMobileProblems(),
          if (!isMobile) ..._buildDesktopProblems(),
        ],
      ),
    );
  }

  List<Widget> _buildMobileProblems() {
    return [
      _buildProblemCard(
        problem: currentLanguage == 'zh' ? '没时间做饭' : 'No Time to Cook',
        solution: currentLanguage == 'zh' 
            ? '我们为您准备新鲜制作的粤菜，节省您的时间'
            : 'We prepare freshly made Cantonese meals to save your time',
        icon: Icons.access_time,
        color: const Color(0xFF27AE60),
      ),
      const SizedBox(height: 20),
      _buildProblemCard(
        problem: currentLanguage == 'zh' ? '不会做粤菜' : "Can't Cook Cantonese",
        solution: currentLanguage == 'zh' 
            ? '专业厨师团队制作正宗粤菜，让您在家享受餐厅级美味'
            : 'Professional chefs create authentic Cantonese dishes for restaurant-quality meals at home',
        icon: Icons.restaurant, // FIXED: Changed from Icons.chef
        color: const Color(0xFFFF6B35),
      ),
      const SizedBox(height: 20),
      _buildProblemCard(
        problem: currentLanguage == 'zh' ? '食材采购麻烦' : 'Grocery Shopping Hassle',
        solution: currentLanguage == 'zh' 
            ? '我们负责采购新鲜食材，您只需享受美食'
            : 'We handle fresh ingredient sourcing, you just enjoy the meals',
        icon: Icons.shopping_cart,
        color: const Color(0xFF2C3E50),
      ),
      const SizedBox(height: 20),
      _buildProblemCard(
        problem: currentLanguage == 'zh' ? '饮食不健康' : 'Unhealthy Eating',
        solution: currentLanguage == 'zh' 
            ? '营养均衡的粤菜套餐，关注您的健康'
            : 'Nutritionally balanced Cantonese meal plans focused on your health',
        icon: Icons.health_and_safety,
        color: const Color(0xFF27AE60),
      ),
    ];
  }

  List<Widget> _buildDesktopProblems() {
    return [
      Row(
        children: [
          Expanded(
            child: _buildProblemCard(
              problem: currentLanguage == 'zh' ? '没时间做饭' : 'No Time to Cook',
              solution: currentLanguage == 'zh' 
                  ? '我们为您准备新鲜制作的粤菜，节省您的时间'
                  : 'We prepare freshly made Cantonese meals to save your time',
              icon: Icons.access_time,
              color: const Color(0xFF27AE60),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: _buildProblemCard(
              problem: currentLanguage == 'zh' ? '不会做粤菜' : "Can't Cook Cantonese",
              solution: currentLanguage == 'zh' 
                  ? '专业厨师团队制作正宗粤菜，让您在家享受餐厅级美味'
                  : 'Professional chefs create authentic Cantonese dishes for restaurant-quality meals at home',
              icon: Icons.restaurant, // FIXED: Changed from Icons.chef
              color: const Color(0xFFFF6B35),
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
      Row(
        children: [
          Expanded(
            child: _buildProblemCard(
              problem: currentLanguage == 'zh' ? '食材采购麻烦' : 'Grocery Shopping Hassle',
              solution: currentLanguage == 'zh' 
                  ? '我们负责采购新鲜食材，您只需享受美食'
                  : 'We handle fresh ingredient sourcing, you just enjoy the meals',
              icon: Icons.shopping_cart,
              color: const Color(0xFF2C3E50),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: _buildProblemCard(
              problem: currentLanguage == 'zh' ? '饮食不健康' : 'Unhealthy Eating',
              solution: currentLanguage == 'zh' 
                  ? '营养均衡的粤菜套餐，关注您的健康'
                  : 'Nutritionally balanced Cantonese meal plans focused on your health',
              icon: Icons.health_and_safety,
              color: const Color(0xFF27AE60),
            ),
          ),
        ],
      ),
    ];
  }

  Widget _buildProblemCard({
    required String problem,
    required String solution,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: color.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 30,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            problem,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: color,
              fontFamily: AppConstants.primaryFont,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            solution,
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
}
