import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

class WelcomeLogo extends StatelessWidget {
  const WelcomeLogo({
    super.key,
    this.logoSize = 100.0,
  });

  final double logoSize;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _LogoIcon(
          size: logoSize,
          primaryColor: colors?.brandPrimary ?? const Color(0xFF4FD1C5),
          accentColor: colors?.brandAccent ?? const Color(0xFFF6C94A),
        ),
        Text(
          'Shelfie',
          style: GoogleFonts.poppins(
            fontSize: 56,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.0,
            height: 1.2,
            color: colors?.textPrimary ?? Colors.white,
          ),
        ),
        SizedBox(height: AppSpacing.xs),
        Text(
          '読書家のための本棚',
          style: GoogleFonts.notoSansJp(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
            height: 1.5,
            color: colors?.textSecondary ?? const Color(0xFFA0A0A0),
          ),
        ),
      ],
    );
  }
}

class _LogoIcon extends StatelessWidget {
  const _LogoIcon({
    required this.size,
    required this.primaryColor,
    required this.accentColor,
  });

  final double size;
  final Color primaryColor;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size * 1.2,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(
            Icons.auto_stories_outlined,
            size: size,
            color: primaryColor,
          ),
          Positioned(
            right: -size * 0.05,
            top: -size * 0.1,
            child: Icon(
              Icons.auto_awesome,
              size: size * 0.35,
              color: accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
