import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

class WelcomeLogo extends StatelessWidget {
  const WelcomeLogo({
    super.key,
    this.logoSize = 90.0,
  });

  final double logoSize;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/icons/app_icon.png',
          width: logoSize,
          height: logoSize,
        ),
        Text(
          'Shelfie',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 64,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.0,
            height: 1.2,
            color: colors?.foreground ?? Colors.white,
          ),
        ),
        SizedBox(height: AppSpacing.xs),
        Text(
          '読書家のための本棚',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: colors?.foregroundMuted ?? const Color(0xFFA0A0A0),
              ),
        ),
      ],
    );
  }
}
