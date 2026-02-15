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
    final appColors = Theme.of(context).extension<AppColors>()!;

    return SizedBox.expand(
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
                  color: appColors.backgroundLegacy,
                );
              },
            ),
          ),
          ColoredBox(
            color: appColors.overlayLegacy.withOpacity(0.54),
          ),
        ],
      ),
    );
  }
}
