import 'package:flutter/material.dart';
import 'package:canton_connect/core/constants/app_constants.dart';

class HomeHeroSection extends StatelessWidget {
  final String currentLanguage;
  final VoidCallback onGetStarted;

  const HomeHeroSection({
    super.key,
    required this.currentLanguage,
    required this.onGetStarted,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = _getScreenSize(context);
    
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(AppConstants.primaryColorValue),
            Color(0xFF2ECC71),
          ],
        ),
      ),
      padding: _getPadding(screenSize),
      child: Column(
        children: [
          if (screenSize == ScreenSize.mobile) ...[
            // Mobile Layout
            _buildHeroImage(context, screenSize),
            const SizedBox(height: 30),
            _buildHeroContent(context, screenSize),
          ] else if (screenSize == ScreenSize.tablet) ...[
            // Tablet Layout
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: _buildHeroContent(context, screenSize),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 2,
                  child: _buildHeroImage(context, screenSize),
                ),
              ],
            ),
          ] else ...[
            // Desktop Layout
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: _buildHeroContent(context, screenSize),
                ),
                const SizedBox(width: 60),
                Expanded(
                  flex: 1,
                  child: _buildHeroImage(context, screenSize),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  // Determine screen size based on width
  ScreenSize _getScreenSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 810) {
      return ScreenSize.mobile;
    } else if (width < 1200) {
      return ScreenSize.tablet;
    } else {
      return ScreenSize.desktop;
    }
  }

  // Responsive padding
  EdgeInsets _getPadding(ScreenSize screenSize) {
    return switch (screenSize) {
      ScreenSize.mobile => const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      ScreenSize.tablet => const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      ScreenSize.desktop => const EdgeInsets.symmetric(horizontal: 80, vertical: 80),
    };
  }

  // Responsive font sizes
  double _getTitleFontSize(ScreenSize screenSize) {
    return switch (screenSize) {
      ScreenSize.mobile => 32,
      ScreenSize.tablet => 40,
      ScreenSize.desktop => 48,
    };
  }

  double _getSubtitleFontSize(ScreenSize screenSize) {
    return switch (screenSize) {
      ScreenSize.mobile => 14,
      ScreenSize.tablet => 16,
      ScreenSize.desktop => 18,
    };
  }

  Widget _buildHeroContent(BuildContext context, ScreenSize screenSize) {
    return Column(
      crossAxisAlignment: _getContentAlignment(screenSize),
      children: [
        Text(
          currentLanguage == 'zh' ? '正宗粤式家常菜' : 'Authentic Cantonese\nHome Cooking',
          style: TextStyle(
            fontSize: _getTitleFontSize(screenSize),
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontFamily: AppConstants.secondaryFont,
            height: 1.2,
          ),
          textAlign: _getTextAlignment(screenSize),
        ),
        const SizedBox(height: 16),
        Text(
          currentLanguage == 'zh' 
              ? '融合传统与现代的粤菜精髓，让您在家也能享受餐厅级的美味体验'
              : 'Experience the essence of traditional and modern Cantonese cuisine with restaurant-quality meals delivered to your home',
          style: TextStyle(
            fontSize: _getSubtitleFontSize(screenSize),
            color: Colors.white70,
            fontFamily: AppConstants.primaryFont,
            height: 1.5,
          ),
          textAlign: _getTextAlignment(screenSize),
        ),
        const SizedBox(height: 32),
        
        // CTA Buttons - Responsive layout
        _buildCTAButtons(context, screenSize),
        const SizedBox(height: 32),
        
        // Feature highlights
        _buildFeatureHighlights(screenSize),
      ],
    );
  }

  CrossAxisAlignment _getContentAlignment(ScreenSize screenSize) {
    return switch (screenSize) {
      ScreenSize.mobile => CrossAxisAlignment.center,
      ScreenSize.tablet => CrossAxisAlignment.start,
      ScreenSize.desktop => CrossAxisAlignment.start,
    };
  }

  TextAlign _getTextAlignment(ScreenSize screenSize) {
    return switch (screenSize) {
      ScreenSize.mobile => TextAlign.center,
      ScreenSize.tablet => TextAlign.start,
      ScreenSize.desktop => TextAlign.start,
    };
  }

  Widget _buildCTAButtons(BuildContext context, ScreenSize screenSize) {
    final isMobile = screenSize == ScreenSize.mobile;
    
    if (isMobile) {
      // Mobile - vertical buttons
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: _buildPrimaryButton(),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: _buildSecondaryButton(),
          ),
        ],
      );
    } else {
      // Tablet & Desktop - horizontal buttons
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildPrimaryButton(),
          const SizedBox(width: 16),
          _buildSecondaryButton(),
        ],
      );
    }
  }

  Widget _buildPrimaryButton() {
    return ElevatedButton(
      onPressed: onGetStarted,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(AppConstants.secondaryColorValue),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
        ),
        elevation: 4,
      ),
      child: Text(
        currentLanguage == 'zh' ? '立即订购' : 'Get Started',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: AppConstants.primaryFont,
        ),
      ),
    );
  }

  Widget _buildSecondaryButton() {
    return OutlinedButton(
      onPressed: () {
        // Handle learn more
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: const BorderSide(color: Colors.white),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
        ),
      ),
      child: Text(
        currentLanguage == 'zh' ? '了解更多' : 'Learn More',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: AppConstants.primaryFont,
        ),
      ),
    );
  }

  Widget _buildFeatureHighlights(ScreenSize screenSize) {
    final features = currentLanguage == 'zh' 
        ? ['新鲜食材', '专业厨师', '快速配送']
        : ['Fresh Ingredients', 'Professional Chefs', 'Fast Delivery'];

    if (screenSize == ScreenSize.mobile) {
      // Mobile layout - wrapped
      return Wrap(
        spacing: 16,
        runSpacing: 12,
        alignment: WrapAlignment.center,
        children: features.map((feature) => 
          _buildFeatureItem(Icons.check_circle, feature)
        ).toList(),
      );
    } else {
      // Tablet & Desktop layout - horizontal row
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: features.map((feature) => 
          Flexible(
            child: _buildFeatureItem(Icons.check_circle, feature),
          )
        ).toList(),
      );
    }
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 16,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroImage(BuildContext context, ScreenSize screenSize) {
    // Determine image dimensions based on screen size
    final imageSize = _getImageSize(screenSize);
    
    return Container(
      width: imageSize.width,
      height: imageSize.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withAlpha(76), // ~30% opacity
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Hero Image with fallback
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: _buildHeroImageContent(screenSize),
          ),
          
          // Image overlay with text
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF000000).withAlpha(153), // ~60% opacity
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    currentLanguage == 'zh' 
                        ? '今日特色：蜜汁叉烧' 
                        : "Today's Special: Honey Char Siu",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: _getOverlayFontSize(screenSize),
                      fontWeight: FontWeight.w600,
                      fontFamily: AppConstants.secondaryFont,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    currentLanguage == 'zh' 
                        ? '传统秘制配方' 
                        : 'Traditional Secret Recipe',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: _getOverlaySubtitleSize(screenSize),
                      fontFamily: AppConstants.primaryFont,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          // Badge for special offer
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(AppConstants.secondaryColorValue),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                currentLanguage == 'zh' ? '限时优惠' : 'Limited Time',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroImageContent(ScreenSize screenSize) {
    // Try to load actual image, fallback to placeholder
    return Image.asset(
      _getHeroImagePath(screenSize),
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return _buildImagePlaceholder(screenSize);
      },
    );
  }

  String _getHeroImagePath(ScreenSize screenSize) {
    return switch (screenSize) {
      ScreenSize.mobile => 'assets/images/hero/hero_dish_mobile.png',
      ScreenSize.tablet => 'assets/images/hero/hero_dish2.png',
      ScreenSize.desktop => 'assets/images/hero/hero_dish.png',
    };
  }

  Size _getImageSize(ScreenSize screenSize) {
    return switch (screenSize) {
      ScreenSize.mobile => const Size(280, 200),
      ScreenSize.tablet => const Size(350, 250),
      ScreenSize.desktop => const Size(400, 300),
    };
  }

  double _getOverlayFontSize(ScreenSize screenSize) {
    return switch (screenSize) {
      ScreenSize.mobile => 12,
      ScreenSize.tablet => 14,
      ScreenSize.desktop => 16,
    };
  }

  double _getOverlaySubtitleSize(ScreenSize screenSize) {
    return switch (screenSize) {
      ScreenSize.mobile => 10,
      ScreenSize.tablet => 12,
      ScreenSize.desktop => 14,
    };
  }

  Widget _buildImagePlaceholder(ScreenSize screenSize) {
    final iconSize = switch (screenSize) {
      ScreenSize.mobile => 40.0,
      ScreenSize.tablet => 50.0,
      ScreenSize.desktop => 60.0,
    };

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFFFFFFFF).withAlpha(25), // ~10% opacity
        border: Border.all(color: const Color(0xFFFFFFFF).withAlpha(76)), // ~30% opacity
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.food_bank,
              size: iconSize,
              color: Colors.white,
            ),
            const SizedBox(height: 8),
            Text(
              'Canton Connect',
              style: TextStyle(
                color: Colors.white,
                fontSize: iconSize / 2.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
