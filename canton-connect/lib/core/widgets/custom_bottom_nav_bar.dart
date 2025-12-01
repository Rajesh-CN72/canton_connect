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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            // FIXED: Replaced withOpacity with Color.fromRGBO
            color: Color.fromRGBO(0, 0, 0, 0.15),
            blurRadius: 15,
            offset: Offset(0, -4),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavBarItem(
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: _getLocalizedLabel('Home', '首页'),
                isActive: currentIndex == 0,
                onTap: () => onTap?.call(0),
              ),
              _NavBarItem(
                icon: Icons.restaurant_menu_outlined,
                activeIcon: Icons.restaurant_menu,
                label: _getLocalizedLabel('Menu', '菜单'),
                isActive: currentIndex == 1,
                onTap: () => onTap?.call(1),
              ),
              _NavBarItem(
                icon: Icons.health_and_safety_outlined,
                activeIcon: Icons.health_and_safety,
                label: _getLocalizedLabel('Health', '健康理念'),
                isActive: currentIndex == 2,
                onTap: () => onTap?.call(2),
              ),
              _CartNavBarItem(
                icon: Icons.shopping_bag_outlined,
                activeIcon: Icons.shopping_bag,
                label: _getLocalizedLabel('Order', '订单'),
                isActive: currentIndex == 3,
                onTap: () => onTap?.call(3),
                itemCount: cartItemCount,
              ),
              _NavBarItem(
                icon: Icons.person_outlined,
                activeIcon: Icons.person,
                label: _getLocalizedLabel('Account', '我的'),
                isActive: currentIndex == 4,
                onTap: () => onTap?.call(4),
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

  const _NavBarItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    this.onTap,
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
                      // FIXED: Replaced withOpacity with pre-computed color
                      color: isActive 
                          ? const Color(0x2627AE60) // AppColors.primary.withAlpha(38) - 15% opacity
                          : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isActive ? activeIcon : icon,
                      color: isActive 
                          ? AppColors.primary 
                          : AppColors.textSecondary,
                      size: 22,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 11,
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

  const _CartNavBarItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    this.onTap,
    required this.itemCount,
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
                      // FIXED: Replaced withOpacity with pre-computed color
                      color: isActive 
                          ? const Color(0x2627AE60) // AppColors.primary.withAlpha(38) - 15% opacity
                          : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isActive ? activeIcon : icon,
                      color: isActive 
                          ? AppColors.primary 
                          : AppColors.textSecondary,
                      size: 22,
                    ),
                  ),
                  if (itemCount > 0)
                    Positioned(
                      top: -2,
                      right: -2,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        decoration: const BoxDecoration(
                          color: AppColors.accent,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          itemCount > 9 ? '9+' : itemCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
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
                  fontSize: 11,
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
