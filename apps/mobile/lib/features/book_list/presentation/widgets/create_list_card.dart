import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

class CreateListCard extends StatelessWidget {
  const CreateListCard({
    required this.onCreateTap,
    super.key,
  });

  final VoidCallback onCreateTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xl,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: appColors.primary,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              boxShadow: [
                BoxShadow(
                  color: appColors.primary.withValues(alpha: 0.4),
                  blurRadius: 16,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(
              Icons.add,
              color: appColors.textPrimary,
              size: 32,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            '最初のリストを作成',
            style: theme.textTheme.titleMedium?.copyWith(
              color: appColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '本を整理して、\nあなただけのリストを作りましょう',
            style: theme.textTheme.bodySmall?.copyWith(
              color: appColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          FilledButton(
            onPressed: onCreateTap,
            style: FilledButton.styleFrom(
              backgroundColor: appColors.textPrimary,
              foregroundColor: appColors.background,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.full),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.sm,
              ),
            ),
            child: const Text('リストを作成'),
          ),
        ],
      ),
    );
  }
}
