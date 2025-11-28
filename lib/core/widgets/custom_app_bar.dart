// lib/core/widgets/custom_app_bar.dart
import 'package:flutter/material.dart';
import 'package:canton_connect/core/constants/app_constants.dart';

enum AppBarActionType {
  search,
  cart,
  profile,
  subscription,
  language,
}

class AppBarAction {
  final AppBarActionType type;
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final int badgeCount;

  const AppBarAction({
    required this.type,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.badgeCount = 0,
  });
}

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool isScrolled;
  final List<AppBarAction> actions;
  final String currentLanguage;
  final Function(String) onLanguageChanged;
  final VoidCallback? onSubscriptionPlansTap;
  final VoidCallback? onTitleTap;

  const CustomAppBar({
    super.key,
    this.isScrolled = false,
    required this.actions,
    required this.currentLanguage,
    required this.onLanguageChanged,
    this.onSubscriptionPlansTap,
    this.onTitleTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  int _titleTapCount = 0;
  DateTime? _lastTitleTap;

  void _handleTitleTap() {
    final now = DateTime.now();
    
    if (_lastTitleTap != null && 
        now.difference(_lastTitleTap!) > const Duration(seconds: 2)) {
      _titleTapCount = 0;
    }
    
    _titleTapCount++;
    _lastTitleTap = now;
    
    if (_titleTapCount >= 5 && widget.onTitleTap != null) {
      _titleTapCount = 0;
      widget.onTitleTap!();
    }
  }

  String _getLanguageInitials(String languageCode) {
    switch (languageCode) {
      case 'zh':
        return '中';
      case 'en':
      default:
        return 'EN';
    }
  }

  String _getAppName() {
    return widget.currentLanguage == 'zh' 
        ? AppConstants.appNameZh 
        : AppConstants.appNameEn;
  }

  String _getSlogan() {
    return widget.currentLanguage == 'zh'
        ? AppConstants.sloganZh
        : AppConstants.sloganEn;
  }

  List<Widget> _buildDesktopActions() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= AppConstants.tabletBreakpoint && 
                    screenWidth < AppConstants.desktopBreakpoint;

    return [
      // Subscription Plans (Text Button) - only show on desktop
      if (!isTablet) 
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: TextButton(
            onPressed: widget.onSubscriptionPlansTap ?? () {},
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            ),
            child: Text(
              widget.currentLanguage == 'zh' ? '订阅计划' : 'Subscription Plans',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: AppConstants.secondaryFont,
              ),
            ),
          ),
        ),

      // Action buttons - only show essential ones
      ...widget.actions.where((action) => 
        action.type == AppBarActionType.cart || 
        action.type == AppBarActionType.profile ||
        action.type == AppBarActionType.language
      ).map(_buildActionButton),
    ];
  }

  List<Widget> _buildMobileActions() {
    return [
      PopupMenuButton<AppBarAction>(
        icon: const Icon(Icons.more_vert, color: Colors.white, size: 20),
        onSelected: (action) {
          // FIX: Handle language action separately for mobile
          if (action.type == AppBarActionType.language) {
            final newLanguage = widget.currentLanguage == 'en' ? 'zh' : 'en';
            widget.onLanguageChanged(newLanguage);
          } else {
            action.onPressed();
          }
        },
        itemBuilder: (context) {
          return widget.actions.map((action) {
            return PopupMenuItem<AppBarAction>(
              value: action,
              child: Row(
                children: [
                  if (action.type == AppBarActionType.language) ...[
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: const Color(AppConstants.primaryColorValue),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          _getLanguageInitials(widget.currentLanguage),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(widget.currentLanguage == 'zh' ? '切换语言' : 'Switch Language'),
                    const Spacer(),
                    Text(
                      widget.currentLanguage == 'zh' ? 'English' : '中文',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ] else ...[
                    Icon(
                      action.icon, 
                      color: const Color(AppConstants.accentColorValue), 
                      size: 18
                    ),
                    const SizedBox(width: 8),
                    Text(action.label),
                    if (action.badgeCount > 0) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          action.badgeCount > 99 ? '99+' : action.badgeCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ],
              ),
            );
          }).toList();
        },
      ),
    ];
  }

  Widget _buildActionButton(AppBarAction action) {
    final isLanguageButton = action.type == AppBarActionType.language;
    
    if (isLanguageButton) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              final newLanguage = widget.currentLanguage == 'en' ? 'zh' : 'en';
              widget.onLanguageChanged(newLanguage);
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0x4DFFFFFF),
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  _getLanguageInitials(widget.currentLanguage),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppConstants.secondaryFont,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return IconButton(
        icon: action.badgeCount > 0
            ? Badge(
                smallSize: 12,
                label: Text(
                  action.badgeCount > 99 ? '99+' : action.badgeCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Icon(action.icon, size: 20),
              )
            : Icon(action.icon, size: 20),
        onPressed: action.onPressed,
        tooltip: action.label,
        padding: const EdgeInsets.all(4),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < AppConstants.tabletBreakpoint;

    return AppBar(
      backgroundColor: const Color(AppConstants.primaryColorValue),
      foregroundColor: Colors.white,
      elevation: widget.isScrolled ? 4 : 0,
      title: widget.isScrolled
          ? GestureDetector(
              onTap: _handleTitleTap,
              child: Row(
                children: [
                  _buildLogo(24),
                  const SizedBox(width: 8),
                  Text(
                    _getAppName(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppConstants.primaryFont,
                    ),
                  ),
                ],
              ),
            )
          : null,
      flexibleSpace: !widget.isScrolled
          ? GestureDetector(
              onTap: _handleTitleTap,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(AppConstants.primaryColorValue),
                      Color(0xFF2ECC71),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 12 : 24,
                    ),
                    child: Row(
                      children: [
                        // Logo
                        _buildLogo(32),
                        const SizedBox(width: 12),
                        
                        // App Name and Slogan
                        Expanded(
                          child: _buildAppNameAndSlogan(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : null,
      actions: isMobile ? _buildMobileActions() : _buildDesktopActions(),
    );
  }

  Widget _buildAppNameAndSlogan() {
    return LayoutBuilder(
      builder: (context, constraints) {
        const availableHeight = 36.0;
        
        return SizedBox(
          height: availableHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _getAppName(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontFamily: AppConstants.primaryFont,
                    height: 1.0,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _getSlogan(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Color(0xE6FFFFFF),
                    fontFamily: AppConstants.secondaryFont,
                    height: 1.0,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLogo(double size) {
    return Image.asset(
      AppConstants.logoWhitePath,
      height: size,
      width: size,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(size / 4),
          ),
          child: Center(
            child: Text(
              _getAppName().substring(0, 1),
              style: TextStyle(
                color: const Color(AppConstants.primaryColorValue),
                fontWeight: FontWeight.bold,
                fontSize: size * 0.5,
              ),
            ),
          ),
        );
      },
    );
  }
}
