import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/account/domain/user_profile.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    required this.profile,
    super.key,
  });

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors?.surfaceElevated ?? const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(AppSpacing.sm),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: colors?.brandPrimary ?? const Color(0xFF4FD1C5),
            backgroundImage:
                profile.avatarUrl != null ? NetworkImage(profile.avatarUrl!) : null,
            child: profile.avatarUrl == null
                ? Icon(
                    Icons.person,
                    size: 40,
                    color: colors?.brandBackground ?? const Color(0xFF0A0A0A),
                  )
                : null,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            profile.name ?? '未設定',
            style: theme.textTheme.titleLarge?.copyWith(
              color: colors?.textPrimary ?? Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (profile.username != null) ...[
            const SizedBox(height: AppSpacing.xxs),
            Text(
              profile.username!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors?.textSecondary ?? const Color(0xFFA0A0A0),
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _StatItem(
                label: '登録',
                value: '${profile.bookCount}冊',
                colors: colors,
                theme: theme,
              ),
              if (profile.readingStartYear != null) ...[
                const SizedBox(width: AppSpacing.xl),
                _StatItem(
                  label: '読書',
                  value: '${profile.readingStartYear}年から',
                  colors: colors,
                  theme: theme,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.label,
    required this.value,
    required this.colors,
    required this.theme,
  });

  final String label;
  final String value;
  final AppColors? colors;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colors?.textSecondary ?? const Color(0xFFA0A0A0),
          ),
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colors?.textPrimary ?? Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
