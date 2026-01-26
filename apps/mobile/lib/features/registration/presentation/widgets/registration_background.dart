import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';

class RegistrationBackground extends StatelessWidget {
  const RegistrationBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>();
    final accentColor = colors?.accent ?? const Color(0xFF4FD1C5);
    final backgroundColor = colors?.background ?? const Color(0xFF0A0A0A);

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
