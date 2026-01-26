import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
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
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.arrow_back, size: 20),
              SizedBox(width: AppSpacing.xxs),
              Text('戻る'),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: colors?.accent,
                child: Icon(
                  Icons.lock_outline,
                  size: 40,
                  color: colors?.background,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'ログイン',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'おかえりなさい',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors?.foregroundMuted,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
