import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';

class WelcomeBackground extends StatelessWidget {
  const WelcomeBackground({
    super.key,
    this.opacity = 0.6,
  });

  final double opacity;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>();

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: opacity,
            child: Image.asset(
              'assets/images/welcome_background.jpg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return ColoredBox(
                  color: colors?.brandBackground ?? const Color(0xFF0A0A0A),
                );
              },
            ),
          ),
          ColoredBox(
            color: colors?.surfaceOverlay ?? const Color(0x99000000),
          ),
        ],
      ),
    );
  }
}
