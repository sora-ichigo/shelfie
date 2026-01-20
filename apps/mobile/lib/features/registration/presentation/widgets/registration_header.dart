import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

class RegistrationHeader extends StatelessWidget {
  const RegistrationHeader({
    required this.onBackPressed,
    super.key,
  });

  final VoidCallback onBackPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onBackPressed,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.arrow_back,
                color: colors?.textPrimary ?? Colors.white,
                size: 20,
              ),
              const SizedBox(width: AppSpacing.xxs),
              Text(
                '戻る',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors?.textPrimary ?? Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: colors?.brandPrimary ?? const Color(0xFF4FD1C5),
                child: Icon(
                  Icons.email_outlined,
                  size: 40,
                  color: colors?.brandBackground ?? const Color(0xFF0A0A0A),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                '新規登録',
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: colors?.textPrimary ?? Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'アカウントを作成して始めましょう',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors?.textSecondary ?? const Color(0xFFA0A0A0),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
