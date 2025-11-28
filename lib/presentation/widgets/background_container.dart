// core/widgets/background_container.dart
import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  final String imagePath;
  final Widget child;
  final Color overlayColor;
  final BoxFit fit;

  const BackgroundContainer({
    super.key,
    required this.imagePath,
    required this.child,
    this.overlayColor = Colors.transparent,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: fit,
        ),
      ),
      child: Container(
        color: overlayColor,
        child: child,
      ),
    );
  }
}

// Usage examples:
class BackgroundTypes {
  static const String homeBackground = 'assets/images/background/home_background.jpg';
  static const String appBackground = 'assets/images/background/app_background.jpg';
  static const String ctaBackground = 'assets/images/background/cta_background.jpg';
  static const String generalBackground = 'assets/images/background/background.jpg';
}
