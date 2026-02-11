import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/user_avatar.dart';
import 'package:shelfie/features/account/domain/user_profile.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    required this.profile,
    super.key,
  });

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>();

    return Column(
      children: [
        UserAvatar(
          avatarUrl: profile.avatarUrl,
          radius: 40,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          profile.name ?? '未設定',
          style: theme.textTheme.titleLarge,
        ),
        if (profile.username != null) ...[
          const SizedBox(height: AppSpacing.xxs),
          Text(
            profile.username!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors?.textSecondary,
            ),
          ),
        ],
      ],
    );
  }
}
