import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/user_avatar.dart';
import 'package:shelfie/features/account/domain/user_profile.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    required this.profile,
    super.key,
  });

  final UserProfile profile;

  String _formatReadingStart(int? year, int? month) {
    if (year == null) return '-';
    if (month == null) return '$year';
    return '$year/$month';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colors?.surface,
        borderRadius: BorderRadius.circular(AppSpacing.md),
      ),
      child: Column(
        children: [
          Row(
            children: [
              UserAvatar(
                avatarUrl: profile.avatarUrl,
                radius: 32,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile.name ?? '未設定',
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      profile.email,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colors?.foregroundMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Divider(
            color: colors?.foregroundMuted.withOpacity(0.2),
            height: 1,
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _StatItem(
                value: '${profile.bookCount}',
                label: '累計冊数',
                colors: colors,
                theme: theme,
              ),
              _StatItem(
                value: _formatReadingStart(
                  profile.readingStartYear,
                  profile.readingStartMonth,
                ),
                label: '読書開始',
                colors: colors,
                theme: theme,
              ),
            ],
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
    required this.colors,
    required this.theme,
  });

  final String value;
  final String label;
  final AppColors? colors;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
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
            color: colors?.foregroundMuted,
          ),
        ),
      ],
    );
  }
}
