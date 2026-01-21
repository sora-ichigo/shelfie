import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';

class LoginBackground extends StatelessWidget {
  const LoginBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>();
    final brandPrimary = colors?.brandPrimary ?? const Color(0xFF4FD1C5);
    final brandBackground = colors?.brandBackground ?? const Color(0xFF0A0A0A);

    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.0,
            colors: [
              Color.lerp(brandPrimary, brandBackground, 0.75)!,
              brandBackground,
            ],
            stops: const [0.0, 0.5],
          ),
        ),
      ),
    );
  }
}
