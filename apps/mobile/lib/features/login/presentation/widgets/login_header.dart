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
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onBackPressed,
            customBorder: const CircleBorder(),
            child: const Padding(
              padding: EdgeInsets.all(AppSpacing.xs),
              child: Icon(Icons.arrow_back_ios_new),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: colors?.primaryLegacy,
                child: Icon(
                  Icons.lock_outline,
                  size: 40,
                  color: colors?.backgroundLegacy,
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
                  color: colors?.textSecondaryLegacy,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
