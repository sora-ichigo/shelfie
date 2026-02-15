import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

class NoBookListsMessage extends StatelessWidget {
  const NoBookListsMessage({required this.onCreateListPressed, super.key});

  final VoidCallback onCreateListPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return Center(
      child: Padding(
        padding: AppSpacing.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.library_books_rounded,
              size: 64,
              color: appColors.textSecondaryLegacy,
            ),
            const SizedBox(height: AppSpacing.md),
            Text('リストを作成してみましょう', style: theme.textTheme.titleMedium),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'お気に入りの本をまとめて、\nリストを作りましょう',
              style: theme.textTheme.bodySmall?.copyWith(
                color: appColors.textSecondaryLegacy,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            FilledButton(
              onPressed: onCreateListPressed,
              style: FilledButton.styleFrom(
                backgroundColor: appColors.textPrimaryLegacy,
                foregroundColor: appColors.backgroundLegacy,
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
              child: Text(
                'リストを作成する',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: appColors.backgroundLegacy,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
