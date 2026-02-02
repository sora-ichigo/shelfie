import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/user_avatar.dart';

class ScreenHeader extends StatelessWidget {
  const ScreenHeader({
    required this.title,
    this.onProfileTap,
    this.avatarUrl,
    this.isAvatarLoading = false,
    this.showAvatar = true,
    super.key,
  });

  static const _avatarRadius = 20.0;

  final String title;
  final VoidCallback? onProfileTap;
  final String? avatarUrl;
  final bool isAvatarLoading;
  final bool showAvatar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSpacing.xs,
        right: AppSpacing.xs,
        top: AppSpacing.sm,
        bottom: AppSpacing.sm,
      ),
      child: Row(
        children: [
          SizedBox(width: showAvatar ? _avatarRadius * 2 : 0),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          if (showAvatar)
            Semantics(
              button: true,
              label: 'プロフィール',
              child: InkResponse(
                onTap: onProfileTap,
                radius: 28,
                child: UserAvatar(
                  avatarUrl: avatarUrl,
                  radius: _avatarRadius,
                  isLoading: isAvatarLoading,
                ),
              ),
            )
          else
            SizedBox(width: 0),
        ],
      ),
    );
  }
}
