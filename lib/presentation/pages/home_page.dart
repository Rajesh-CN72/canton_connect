import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:canton_connect/core/constants/app_constants.dart';
import 'package:canton_connect/core/providers/language_provider.dart';
import 'package:canton_connect/presentation/widgets/home/home_hero_section.dart';
import 'package:canton_connect/presentation/widgets/home/how_it_works_section.dart';
import 'package:canton_connect/presentation/widgets/home/problem_solve_section.dart';
import 'package:canton_connect/presentation/widgets/home/quality_assurance_section.dart';
import 'package:canton_connect/presentation/widgets/home/subscription_plans_section.dart';
import 'package:canton_connect/presentation/widgets/home/testimonials_section.dart';
import 'package:canton_connect/presentation/widgets/home/final_cta_section.dart';
import 'package:canton_connect/presentation/pages/subscription_page.dart'; // Add this import

class HomePage extends StatefulWidget {
  final Function(bool)? onScrollUpdate;
  
  const HomePage({
    super.key,
    this.onScrollUpdate,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = [
    GlobalKey(), // hero
    GlobalKey(), // problem
    GlobalKey(), // how it works
    GlobalKey(), // quality
    GlobalKey(), // testimonials
    GlobalKey(), // subscription
    GlobalKey(), // final cta
  ];

  bool _isScrolled = false;

  void _scrollToSection(int index) {
    final context = _sectionKeys[index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _handleScroll() {
    final newScrolledState = _scrollController.offset > 100;
    if (newScrolledState != _isScrolled) {
      setState(() {
        _isScrolled = newScrolledState;
      });
      // Notify parent about scroll state change
      widget.onScrollUpdate?.call(newScrolledState);
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isChinese = languageProvider.isChinese;
    final currentLanguage = isChinese ? 'zh' : 'en';

    return Scaffold(
      backgroundColor: const Color(AppConstants.backgroundColorValue),
      // NO APP BAR HERE - it's managed by main.dart
      body: _buildHomeContent(currentLanguage),
    );
  }

  Widget _buildHomeContent(String currentLanguage) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= AppConstants.desktopBreakpoint;
    final isTablet = screenWidth >= AppConstants.tabletBreakpoint && 
                    screenWidth < AppConstants.desktopBreakpoint;
    final isMobile = screenWidth < AppConstants.tabletBreakpoint;

    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          Container(
            key: _sectionKeys[0],
            child: HomeHeroSection(
              currentLanguage: currentLanguage,
              onGetStarted: () => _scrollToSection(5),
            ),
          ),
          Container(
            key: _sectionKeys[1],
            child: ProblemSolveSection(
              currentLanguage: currentLanguage,
            ),
          ),
          Container(
            key: _sectionKeys[2],
            child: HowItWorksSection(
              currentLanguage: currentLanguage,
            ),
          ),
          Container(
            key: _sectionKeys[3],
            child: QualityAssuranceSection(
              currentLanguage: currentLanguage,
            ),
          ),
          Container(
            key: _sectionKeys[4],
            child: TestimonialsSection(
              currentLanguage: currentLanguage,
            ),
          ),
          Container(
            key: _sectionKeys[5],
            child: SubscriptionPlansSection(
              currentLanguage: currentLanguage,
              // Remove the old onSubscribe parameter and use the new onViewAllPlans
              onViewAllPlans: () {
                // Navigate to the subscription page
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SubscriptionPage(
                      currentLanguage: currentLanguage,
                      isAdmin: false, // Set based on your auth logic
                    ),
                  ),
                );
              },
              // You can also set isAdmin if you have user authentication
              // isAdmin: true, // Set based on your user role
            ),
          ),
          Container(
            key: _sectionKeys[6],
            child: FinalCtaSection(
              currentLanguage: currentLanguage,
              onGetStarted: () => _scrollToSection(5),
              onContactUs: () {
                print('Contact us tapped');
              },
            ),
          ),
          if (isDesktop) _buildFooter(currentLanguage),
          if (isMobile || isTablet) const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildFooter(String currentLanguage) {
    return Container(
      color: const Color(AppConstants.accentColorValue),
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          if (currentLanguage == 'zh') ...[
            const Text(
              '粤味通 - 融合美味，连接心意',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: AppConstants.secondaryFont,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '正宗粤式家常菜，用心制作每一道菜品',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontFamily: AppConstants.secondaryFont,
              ),
              textAlign: TextAlign.center,
            ),
          ] else ...[
            const Text(
              'Canton Connect - Taste the Fusion, Feel the Connection',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: AppConstants.primaryFont,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Authentic Cantonese home cooking, made with care in every dish',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontFamily: AppConstants.primaryFont,
              ),
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: 24),
          const Divider(color: Colors.white54),
          const SizedBox(height: 16),
          Text(
            currentLanguage == 'zh' ? '© 2025 粤味通 版权所有' : '© 2025 Canton Connect. All rights reserved.',
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
