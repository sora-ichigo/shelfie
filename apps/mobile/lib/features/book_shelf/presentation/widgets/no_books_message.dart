import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

class NoBooksMessage extends StatelessWidget {
  const NoBooksMessage({super.key});

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
              Icons.auto_stories_outlined,
              size: 64,
              color: appColors.textSecondary,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              '「さがす」タブから本を追加してみましょう',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: appColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
