import 'package:flutter/material.dart';
import 'package:canton_connect/core/constants/app_constants.dart';

class MenuHeaderSection extends StatelessWidget {
  final String currentLanguage;
  final VoidCallback onSearchTap;
  final bool isCompact;

  const MenuHeaderSection({
    super.key,
    required this.currentLanguage,
    required this.onSearchTap,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: isCompact 
          ? const EdgeInsets.symmetric(horizontal: 16, vertical: 4)
          : const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min, // Important: Use min to avoid overflow
        children: [
          if (!isCompact) // Only show welcome text in non-compact mode
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                currentLanguage == 'zh' ? '欢迎来到我们的菜单' : 'Welcome to Our Menu',
                style: TextStyle(
                  fontSize: isCompact ? 14 : 18, // Reduced font size
                  fontWeight: FontWeight.bold,
                  color: const Color(AppConstants.primaryColorValue),
                  fontFamily: AppConstants.primaryFont,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          
          // Search Bar - Further reduced for compact mode
          GestureDetector(
            onTap: onSearchTap,
            child: Container(
              height: isCompact ? 36 : 44, // Reduced height
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(20),
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.grey.shade500,
                    size: isCompact ? 18 : 20, // Reduced icon size
                  ),
                  const SizedBox(width: 8), // Reduced spacing
                  Expanded(
                    child: Text(
                      currentLanguage == 'zh' ? '搜索菜单...' : 'Search menu...',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: isCompact ? 13 : 14, // Reduced font size
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

