import 'package:flutter/material.dart';

class IconTapArea extends StatelessWidget {
  const IconTapArea({
    required this.icon,
    required this.onTap,
    this.color,
    this.size = 40,
    this.iconSize = 24,
    this.semanticLabel,
    super.key,
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color? color;
  final double size;
  final double iconSize;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox(
          width: size,
          height: size,
          child: Center(
            child: Icon(icon, size: iconSize, color: color),
          ),
        ),
      ),
    );
  }
}
