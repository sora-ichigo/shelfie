import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

class NoResultMessage extends StatelessWidget {
  const NoResultMessage({required this.query, super.key});

  final String query;

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
              Icons.search_off,
              size: 64,
              color: appColors.inactiveLegacy,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              '検索結果がありません',
              style: theme.textTheme.titleLarge?.copyWith(
                color: appColors.textPrimaryLegacy,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              '「$query」に一致する書籍が見つかりませんでした。',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: appColors.textSecondaryLegacy,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
