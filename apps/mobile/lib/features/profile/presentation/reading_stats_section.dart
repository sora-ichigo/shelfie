import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/account/domain/user_profile.dart';

class ReadingStatsSection extends StatelessWidget {
  const ReadingStatsSection({
    required this.profile,
    super.key,
  });

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: colors?.surface,
        borderRadius: BorderRadius.circular(AppSpacing.md),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _StatItem(
            value: '${profile.completedCount}',
            label: '読了',
            theme: theme,
            colors: colors,
          ),
          _StatItem(
            value: '${profile.readingCount}',
            label: '読書中',
            theme: theme,
            colors: colors,
          ),
          _StatItem(
            value: '${profile.backlogCount}',
            label: '積読',
            theme: theme,
            colors: colors,
          ),
          _StatItem(
            value: '${profile.interestedCount}',
            label: '気になる',
            theme: theme,
            colors: colors,
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.value,
    required this.label,
    required this.theme,
    required this.colors,
  });

  final String value;
  final String label;
  final ThemeData theme;
  final AppColors? colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colors?.textSecondary,
          ),
        ),
      ],
    );
  }
}
