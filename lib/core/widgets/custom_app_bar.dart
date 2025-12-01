import 'package:flutter/material.dart';
import 'package:canton_connect/core/constants/app_constants.dart';

enum AppBarActionType {
  search,
  cart,
  profile,
  subscription,
  language,
  logout,
  notifications,
  settings,
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
  final bool isAdmin;

  const CustomAppBar({
    super.key,
    this.isScrolled = false,
    required this.actions,
    required this.currentLanguage,
    required this.onLanguageChanged,
    this.onSubscriptionPlansTap,
    this.onTitleTap,
    this.isAdmin = false,
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
      // Subscription Plans (Text Button) - only show on desktop and not for admin
      if (!isTablet && !widget.isAdmin) 
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

      // Action buttons
      ...widget.actions.map(_buildActionButton),
    ];
  }

  List<Widget> _buildMobileActions() {
    return [
      PopupMenuButton<AppBarAction>(
        icon: const Icon(Icons.more_vert, color: Colors.white, size: 20),
        onSelected: (action) {
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
                      color: action.type == AppBarActionType.logout 
                          ? Colors.red 
                          : const Color(AppConstants.accentColorValue), 
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
    final isLogoutButton = action.type == AppBarActionType.logout;
    
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
    } else if (isLogoutButton) {
      // Special styling for logout button
      return IconButton(
        icon: Icon(action.icon, size: 20, color: Colors.red.shade200),
        onPressed: action.onPressed,
        tooltip: action.label,
        padding: const EdgeInsets.all(4),
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
      backgroundColor: widget.isAdmin 
          ? const Color(0xFF1a237e) 
          : const Color(AppConstants.primaryColorValue),
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
                    widget.isAdmin ? 'Admin Dashboard' : _getAppName(),
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
      flexibleSpace: !widget.isScrolled && !widget.isAdmin
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
    try {
      return Image.asset(
        AppConstants.logoWhitePath,
        height: size,
        width: size,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return _buildFallbackLogo(size);
        },
      );
    } catch (e) {
      return _buildFallbackLogo(size);
    }
  }

  Widget _buildFallbackLogo(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size / 4),
      ),
      child: Center(
        child: Text(
          _getAppName().isNotEmpty ? _getAppName().substring(0, 1) : 'C',
          style: TextStyle(
            color: const Color(AppConstants.primaryColorValue),
            fontWeight: FontWeight.bold,
            fontSize: size * 0.5,
          ),
        ),
      ),
    );
  }
}

// Admin-specific App Bar
class AdminAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final String currentLanguage;
  final Function(String) onLanguageChanged;

  const AdminAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBackButton = false,
    this.onBackPressed,
    required this.currentLanguage,
    required this.onLanguageChanged,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      backgroundColor: const Color(0xFF1a237e),
      foregroundColor: Colors.white,
      elevation: 4,
      // FIXED: Added const keyword to the Color constructor
      shadowColor: const Color.fromRGBO(0, 0, 0, 0.3),
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
            )
          : null,
      actions: [
        // Language Switcher for Admin
        _buildLanguageSwitcher(),
        
        // Additional actions
        ...?actions,
      ],
    );
  }

  Widget _buildLanguageSwitcher() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: DropdownButton<String>(
        value: currentLanguage,
        dropdownColor: const Color(0xFF1a237e),
        underline: const SizedBox(),
        icon: const Icon(Icons.translate, color: Colors.white),
        items: [
          DropdownMenuItem(
            value: 'en',
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Center(
                    child: Text(
                      'EN',
                      style: TextStyle(
                        color: Color(0xFF1a237e),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Text('English', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          DropdownMenuItem(
            value: 'zh',
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Center(
                    child: Text(
                      '中',
                      style: TextStyle(
                        color: Color(0xFF1a237e),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Text('中文', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
        onChanged: (String? newLanguage) {
          if (newLanguage != null) {
            onLanguageChanged(newLanguage);
          }
        },
      ),
    );
  }
}
