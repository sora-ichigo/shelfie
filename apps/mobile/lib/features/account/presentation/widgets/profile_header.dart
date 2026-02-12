import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/user_avatar.dart';
import 'package:shelfie/features/account/domain/user_profile.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    required this.profile,
    required this.onEditProfile,
    required this.onShareProfile,
    this.followingCount = 0,
    this.followerCount = 0,
    this.onFollowingTap,
    this.onFollowersTap,
    super.key,
  });

  final UserProfile profile;
  final VoidCallback onEditProfile;
  final VoidCallback onShareProfile;
  final int followingCount;
  final int followerCount;
  final VoidCallback? onFollowingTap;
  final VoidCallback? onFollowersTap;

  Future<void> _openInstagramProfile(String handle) async {
    final appUri = Uri.parse('instagram://user?username=$handle');
    if (await canLaunchUrl(appUri)) {
      await launchUrl(appUri, mode: LaunchMode.externalApplication);
    } else {
      await launchUrl(
        Uri.parse('https://www.instagram.com/$handle'),
        mode: LaunchMode.externalApplication,
      );
    }
  }

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
              child: GestureDetector(
                onTap: () => _openInstagramProfile(profile.instagramHandle!),
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
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              // ignore: avoid_direct_colors
                              Color(0xFFFFD735),
                              // ignore: avoid_direct_colors
                              Color(0xFFFF5D21),
                              // ignore: avoid_direct_colors
                              Color(0xFFFF30C4),
                              // ignore: avoid_direct_colors
                              Color(0xFF741AFA),
                            ],
                            stops: [0.0, 0.35, 0.65, 1.0],
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
            ),
          ],
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                _StatItem(
                  count: '${profile.bookCount}',
                  label: '冊登録',
                  theme: theme,
                  appColors: appColors,
                ),
                const SizedBox(width: AppSpacing.xs),
                GestureDetector(
                  onTap: onFollowingTap,
                  child: _StatItem(
                    count: '$followingCount',
                    label: 'フォロー中',
                    theme: theme,
                    appColors: appColors,
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                GestureDetector(
                  onTap: onFollowersTap,
                  child: _StatItem(
                    count: '$followerCount',
                    label: 'フォロワー',
                    theme: theme,
                    appColors: appColors,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: onEditProfile,
                    style: FilledButton.styleFrom(
                      backgroundColor: appColors.surfaceElevated,
                      foregroundColor: appColors.textPrimary,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'プロフィールを編集',
                      style: theme.textTheme.labelMedium,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: FilledButton(
                    onPressed: onShareProfile,
                    style: FilledButton.styleFrom(
                      backgroundColor: appColors.surfaceElevated,
                      foregroundColor: appColors.textPrimary,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'プロフィールをシェア',
                      style: theme.textTheme.labelMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
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
        Text('$count ', style: theme.textTheme.labelMedium),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: appColors?.textSecondary,
          ),
        ),
      ],
    );
  }
}
