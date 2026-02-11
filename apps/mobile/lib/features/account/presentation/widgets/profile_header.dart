import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/user_avatar.dart';
import 'package:shelfie/features/account/domain/user_profile.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    required this.profile,
    required this.onEditProfile,
    required this.onShareProfile,
    super.key,
  });

  final UserProfile profile;
  final VoidCallback onEditProfile;
  final VoidCallback onShareProfile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                UserAvatar(avatarUrl: profile.avatarUrl, radius: 32),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.name ?? 'ユーザー',
                        style: theme.textTheme.titleMedium,
                      ),
                      if (profile.handle != null)
                        Text(
                          '@${profile.handle}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: appColors.textSecondary,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (profile.bio != null && profile.bio!.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                profile.bio!,
                style: theme.textTheme.bodyMedium,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
          if (profile.instagramHandle != null &&
              profile.instagramHandle!.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xs,
                  vertical: AppSpacing.xxs,
                ),
                decoration: BoxDecoration(
                  color: appColors.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ignore: avoid_direct_colors
                    SizedBox(
                      height: 16,
                      width: 16,
                      child: ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [
                            // ignore: avoid_direct_colors
                            Color(0xFFFDF497),
                            // ignore: avoid_direct_colors
                            Color(0xFFFD5949),
                            // ignore: avoid_direct_colors
                            Color(0xFFD6249F),
                            // ignore: avoid_direct_colors
                            Color(0xFF285AEB),
                          ],
                          stops: [0.0, 0.35, 0.55, 0.9],
                        ).createShader(bounds),
                        child: const FaIcon(
                          FontAwesomeIcons.instagram,
                          size: 16,
                          // ignore: avoid_direct_colors
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xxs),
                    Text(
                      '@${profile.instagramHandle}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: appColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          Row(
            children: [
              _StatItem(
                count: '${profile.bookCount}',
                label: '冊登録',
                theme: theme,
              ),
              const SizedBox(width: AppSpacing.md),
              _StatItem(
                count: '0',
                label: 'フォロー中',
                theme: theme,
                appColors: appColors,
              ),
              const SizedBox(width: AppSpacing.md),
              _StatItem(
                count: '0',
                label: 'フォロワー',
                theme: theme,
                appColors: appColors,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onEditProfile,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: appColors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('プロフィールを編集'),
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: OutlinedButton(
                  onPressed: onShareProfile,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: appColors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('プロフィールをシェア'),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.count,
    required this.label,
    required this.theme,
    this.appColors,
  });

  final String count;
  final String label;
  final ThemeData theme;
  final AppColors? appColors;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          count,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: AppSpacing.xxs),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: appColors?.textSecondary,
          ),
        ),
      ],
    );
  }
}
