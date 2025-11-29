import 'package:flutter/material.dart';

class SecondaryIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon; // Keep as Widget
  final Color? color;
  final double? size; // Rename to 'size' to match your usage
  final String? tooltip;

  const SecondaryIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.color,
    this.size,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: icon, // Use the widget directly
      color: color ?? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
      iconSize: size, // Map 'size' to 'iconSize'
      tooltip: tooltip,
      splashRadius: 20,
    );
  }
}
