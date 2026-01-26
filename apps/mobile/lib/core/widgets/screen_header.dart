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

  final String title;
  final VoidCallback onProfileTap;
  final String? avatarUrl;
  final bool isAvatarLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSpacing.md,
        right: AppSpacing.md,
        top: AppSpacing.md,
        bottom: AppSpacing.xs,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
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
                radius: 24,
                isLoading: isAvatarLoading,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
