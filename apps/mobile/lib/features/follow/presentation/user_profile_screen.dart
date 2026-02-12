import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/account/presentation/widgets/profile_header.dart';
import 'package:shelfie/features/follow/application/follow_request_notifier.dart';
import 'package:shelfie/features/follow/domain/follow_status_type.dart';
import 'package:shelfie/features/follow/domain/user_profile_model.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({
    required this.profile,
    this.onFollowingTap,
    this.onFollowersTap,
    super.key,
  });

  final UserProfileModel profile;
  final VoidCallback? onFollowingTap;
  final VoidCallback? onFollowersTap;

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(followRequestNotifierProvider(widget.profile.user.id).notifier)
          .setStatus(widget.profile.followStatus);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;
    final followState = ref.watch(
        followRequestNotifierProvider(widget.profile.user.id));
    final currentStatus = followState.valueOrNull ?? widget.profile.followStatus;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.profile.user.handle ?? widget.profile.user.name ?? '',
          style: theme.textTheme.titleMedium,
        ),
        centerTitle: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.md),
            ProfileHeader(
              name: widget.profile.user.name,
              avatarUrl: widget.profile.user.avatarUrl,
              handle: widget.profile.user.handle,
              bio: widget.profile.bio,
              instagramHandle: widget.profile.instagramHandle,
              bookCount: widget.profile.bookCount ?? 0,
              followingCount: widget.profile.followCounts.followingCount,
              followerCount: widget.profile.followCounts.followerCount,
              onFollowingTap: widget.onFollowingTap,
              onFollowersTap: widget.onFollowersTap,
              actionButtons: widget.profile.isOwnProfile
                  ? null
                  : _buildActionButton(appColors, theme, currentStatus),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
      AppColors appColors, ThemeData theme, FollowStatusType status) {
    final shareButton = Expanded(
      child: FilledButton(
        onPressed: () {},
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
    );

    final followButton = switch (status) {
      FollowStatusType.none => Expanded(
          child: FilledButton(
            onPressed: () => ref
                .read(followRequestNotifierProvider(widget.profile.user.id)
                    .notifier)
                .sendFollowRequest(),
            style: FilledButton.styleFrom(
              backgroundColor: appColors.primary,
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
            child: Text('フォロー', style: theme.textTheme.labelMedium),
          ),
        ),
      FollowStatusType.pendingSent => Expanded(
          child: FilledButton(
            onPressed: () => ref
                .read(followRequestNotifierProvider(widget.profile.user.id)
                    .notifier)
                .cancelFollowRequest(),
            style: FilledButton.styleFrom(
              backgroundColor: appColors.surfaceElevated,
              foregroundColor: appColors.textSecondary,
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
            child: Text('リクエスト送信済み', style: theme.textTheme.labelMedium),
          ),
        ),
      FollowStatusType.following => Expanded(
          child: OutlinedButton(
            onPressed: () => ref
                .read(followRequestNotifierProvider(widget.profile.user.id)
                    .notifier)
                .unfollow(),
            style: OutlinedButton.styleFrom(
              foregroundColor: appColors.destructive,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              side: BorderSide(color: appColors.destructive),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('フォロー解除', style: theme.textTheme.labelMedium),
          ),
        ),
      FollowStatusType.pendingReceived => const SizedBox.shrink(),
    };

    return Row(
      children: [
        followButton,
        const SizedBox(width: AppSpacing.xs),
        shareButton,
      ],
    );
  }
}
