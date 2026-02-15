import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';

class LoginBackground extends StatelessWidget {
  const LoginBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    final accentColor = appColors.primaryLegacy;
    final backgroundColor = appColors.backgroundLegacy;

    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.0,
            colors: [
              Color.lerp(accentColor, backgroundColor, 0.75)!,
              backgroundColor,
            ],
            stops: const [0.0, 0.5],
          ),
        ),
      ),
    );
  }
}
