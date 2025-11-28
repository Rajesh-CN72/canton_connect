import 'package:flutter/material.dart';

class SecondaryIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon; // Keep as Widget
  final Color? color;
  final double? size; // Rename to 'size' to match your usage
  final String? tooltip;

  const SecondaryIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.color,
    this.size,
    this.tooltip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: icon, // Use the widget directly
      color: color ?? Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
      iconSize: size, // Map 'size' to 'iconSize'
      tooltip: tooltip,
      splashRadius: 20,
    );
  }
}
