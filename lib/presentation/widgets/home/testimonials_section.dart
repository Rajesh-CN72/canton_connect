import 'package:flutter/material.dart';
import 'package:canton_connect/core/constants/app_constants.dart';

class TestimonialsSection extends StatelessWidget {
  final String currentLanguage;

  const TestimonialsSection({
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
      color: const Color(AppConstants.backgroundColorValue),
      child: Column(
        children: [
          Text(
            currentLanguage == 'zh' ? '顾客评价' : 'Customer Testimonials',
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
                ? '听听我们的顾客怎么说'
                : 'See what our customers are saying',
            style: const TextStyle(
              fontSize: 16,
              color: Color(AppConstants.accentColorValue),
              fontFamily: AppConstants.secondaryFont,
            ),
          ),
          const SizedBox(height: 50),
          
          if (isMobile) ..._buildMobileTestimonials(),
          if (!isMobile) ..._buildDesktopTestimonials(),
        ],
      ),
    );
  }

  List<Widget> _buildMobileTestimonials() {
    return [
      _buildTestimonialCard(
        name: '张先生',
        location: currentLanguage == 'zh' ? '广州' : 'Guangzhou',
        rating: 5,
        comment: currentLanguage == 'zh' 
            ? '作为广东人，这家的粤菜非常正宗！每周都订，省去了很多做饭的麻烦。'
            : 'As a Cantonese native, the food here is very authentic! I order every week, saving me a lot of cooking hassle.',
        avatar: '张',
      ),
      const SizedBox(height: 20),
      _buildTestimonialCard(
        name: 'Lisa Chen',
        location: currentLanguage == 'zh' ? '上海' : 'Shanghai',
        rating: 5,
        comment: currentLanguage == 'zh' 
            ? '菜品新鲜，味道好，配送准时。已经推荐给所有同事了！'
            : 'Fresh ingredients, great taste, timely delivery. Already recommended to all my colleagues!',
        avatar: 'L',
      ),
      const SizedBox(height: 20),
      _buildTestimonialCard(
        name: '王女士',
        location: currentLanguage == 'zh' ? '北京' : 'Beijing',
        rating: 4,
        comment: currentLanguage == 'zh' 
            ? '健康又美味，孩子很喜欢。解决了双职工家庭的吃饭问题。'
            : 'Healthy and delicious, my kids love it. Solved our dual-income family meal problems.',
        avatar: '王',
      ),
    ];
  }

  List<Widget> _buildDesktopTestimonials() {
    return [
      Row(
        children: [
          Expanded(
            child: _buildTestimonialCard(
              name: '张先生',
              location: currentLanguage == 'zh' ? '广州' : 'Guangzhou',
              rating: 5,
              comment: currentLanguage == 'zh' 
                  ? '作为广东人，这家的粤菜非常正宗！每周都订，省去了很多做饭的麻烦。'
                  : 'As a Cantonese native, the food here is very authentic! I order every week, saving me a lot of cooking hassle.',
              avatar: '张',
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: _buildTestimonialCard(
              name: 'Lisa Chen',
              location: currentLanguage == 'zh' ? '上海' : 'Shanghai',
              rating: 5,
              comment: currentLanguage == 'zh' 
                  ? '菜品新鲜，味道好，配送准时。已经推荐给所有同事了！'
                  : 'Fresh ingredients, great taste, timely delivery. Already recommended to all my colleagues!',
              avatar: 'L',
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: _buildTestimonialCard(
              name: '王女士',
              location: currentLanguage == 'zh' ? '北京' : 'Beijing',
              rating: 4,
              comment: currentLanguage == 'zh' 
                  ? '健康又美味，孩子很喜欢。解决了双职工家庭的吃饭问题。'
                  : 'Healthy and delicious, my kids love it. Solved our dual-income family meal problems.',
              avatar: '王',
            ),
          ),
        ],
      ),
    ];
  }

  Widget _buildTestimonialCard({
    required String name,
    required String location,
    required int rating,
    required String comment,
    required String avatar,
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
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rating stars
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: const Color(AppConstants.secondaryColorValue),
                size: 20,
              );
            }),
          ),
          const SizedBox(height: 16),
          // Comment
          Text(
            comment,
            style: const TextStyle(
              fontSize: 14,
              color: Color(AppConstants.accentColorValue),
              fontFamily: AppConstants.secondaryFont,
              height: 1.6,
            ),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 20),
          // User info
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(AppConstants.primaryColorValue),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    avatar,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(AppConstants.accentColorValue),
                        fontFamily: AppConstants.primaryFont,
                      ),
                    ),
                    Text(
                      location,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(AppConstants.accentColorValue),
                        fontFamily: AppConstants.secondaryFont,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
