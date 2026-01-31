import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/user_avatar.dart';

class ScreenHeader extends StatelessWidget {
  const ScreenHeader({
    required this.title,
    required this.onProfileTap,
    this.avatarUrl,
    this.isAvatarLoading = false,
    super.key,
  });

  static const _avatarRadius = 20.0;

  final String title;
  final VoidCallback onProfileTap;
  final String? avatarUrl;
  final bool isAvatarLoading;

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
          SizedBox(width: _avatarRadius * 2),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'NotoSansJP',
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
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
          ),
        ],
      ),
    );
  }
}
