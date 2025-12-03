import 'package:flutter/material.dart';
import 'package:canton_connect/core/constants/app_colors.dart';
import 'package:canton_connect/core/constants/app_constants.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;
  final String currentLanguage;
  final int cartItemCount;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    this.onTap,
    required this.currentLanguage,
    this.cartItemCount = 0,
  });

  String _getLocalizedLabel(String english, String chinese) {
    return currentLanguage == 'zh' ? chinese : english;
  }

  bool _isMobile(double screenWidth) {
    return screenWidth < AppConstants.tabletBreakpoint;
  }

  bool _isTablet(double screenWidth) {
    return screenWidth >= AppConstants.tabletBreakpoint && 
           screenWidth < AppConstants.desktopBreakpoint;
  }

  bool _isDesktop(double screenWidth) {
    return screenWidth >= AppConstants.desktopBreakpoint;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = _isMobile(screenWidth);
    final isTablet = _isTablet(screenWidth);
    final isDesktop = _isDesktop(screenWidth);

    // Responsive sizing based on breakpoints
    double iconSize = isMobile ? 22 : (isTablet ? 24 : 26);
    double labelFontSize = isMobile ? 11 : (isTablet ? 12 : 13);
    double verticalPadding = isMobile ? 12 : (isTablet ? 14 : 16);
    double horizontalPadding = isMobile ? 8 : (isTablet ? 12 : 16);
    double borderRadius = isMobile ? 25 : (isTablet ? 28 : 30);
    double badgeSize = isMobile ? 16 : (isTablet ? 18 : 20);
    double badgeFontSize = isMobile ? 8 : (isTablet ? 9 : 10);

    // For desktop, we might want to show a navigation rail instead
    if (isDesktop && screenWidth >= AppConstants.largeDesktopBreakpoint) {
      // Extra large desktop adjustments
      iconSize = 28;
      labelFontSize = 14;
      verticalPadding = 18;
      horizontalPadding = 20;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.15),
            blurRadius: isMobile ? 15 : 20,
            offset: const Offset(0, -4),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, 
            vertical: verticalPadding
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavBarItem(
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: _getLocalizedLabel('Home', '首页'),
                isActive: currentIndex == 0,
                onTap: () => onTap?.call(0),
                iconSize: iconSize,
                labelFontSize: labelFontSize,
              ),
              _NavBarItem(
                icon: Icons.restaurant_menu_outlined,
                activeIcon: Icons.restaurant_menu,
                label: _getLocalizedLabel('Menu', '菜单'),
                isActive: currentIndex == 1,
                onTap: () => onTap?.call(1),
                iconSize: iconSize,
                labelFontSize: labelFontSize,
              ),
              _CartNavBarItem(
                icon: Icons.shopping_bag_outlined,
                activeIcon: Icons.shopping_bag,
                label: _getLocalizedLabel('Order', '订单'),
                isActive: currentIndex == 2,
                onTap: () => onTap?.call(2),
                itemCount: cartItemCount,
                iconSize: iconSize,
                labelFontSize: labelFontSize,
                badgeSize: badgeSize,
                badgeFontSize: badgeFontSize,
              ),
              _NavBarItem(
                icon: Icons.person_outlined,
                activeIcon: Icons.person,
                label: _getLocalizedLabel('Account', '我的'),
                isActive: currentIndex == 3,
                onTap: () => onTap?.call(3),
                iconSize: iconSize,
                labelFontSize: labelFontSize,
              ),
              _NavBarItem(
                icon: Icons.subscriptions_outlined,
                activeIcon: Icons.subscriptions,
                label: _getLocalizedLabel('Subscription', '订阅'),
                isActive: currentIndex == 4,
                onTap: () => onTap?.call(4),
                iconSize: iconSize,
                labelFontSize: labelFontSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;
  final double iconSize;
  final double labelFontSize;

  const _NavBarItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    this.onTap,
    required this.iconSize,
    required this.labelFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isActive 
                          ? const Color(0x2627AE60)
                          : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isActive ? activeIcon : icon,
                      color: isActive 
                          ? AppColors.primary 
                          : AppColors.textSecondary,
                      size: iconSize,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: labelFontSize,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  color: isActive 
                      ? AppColors.primary 
                      : AppColors.textSecondary,
                  fontFamily: AppConstants.primaryFont,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CartNavBarItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;
  final int itemCount;
  final double iconSize;
  final double labelFontSize;
  final double badgeSize;
  final double badgeFontSize;

  const _CartNavBarItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    this.onTap,
    required this.itemCount,
    required this.iconSize,
    required this.labelFontSize,
    this.badgeSize = 16,
    this.badgeFontSize = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isActive 
                          ? const Color(0x2627AE60)
                          : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isActive ? activeIcon : icon,
                      color: isActive 
                          ? AppColors.primary 
                          : AppColors.textSecondary,
                      size: iconSize,
                    ),
                  ),
                  if (itemCount > 0)
                    Positioned(
                      top: -2,
                      right: -2,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        constraints: BoxConstraints(
                          minWidth: badgeSize,
                          minHeight: badgeSize,
                        ),
                        decoration: const BoxDecoration(
                          color: AppColors.accent,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          itemCount > 9 ? '9+' : itemCount.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: badgeFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: labelFontSize,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  color: isActive 
                      ? AppColors.primary 
                      : AppColors.textSecondary,
                  fontFamily: AppConstants.primaryFont,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
