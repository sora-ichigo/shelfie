import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/user_avatar.dart';
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
    final isFollowing = currentStatus == FollowStatusType.following;

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.md),
              _buildHeader(context, theme, appColors),
              if (isFollowing) ...[
                if (widget.profile.bio != null &&
                    widget.profile.bio!.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    widget.profile.bio!,
                    style: theme.textTheme.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: AppSpacing.sm),
                _buildStats(context, theme, appColors),
              ],
              if (!widget.profile.isOwnProfile) ...[
                const SizedBox(height: AppSpacing.md),
                _buildActionButton(context, theme, appColors, currentStatus),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
      BuildContext context, ThemeData theme, AppColors appColors) {
    return Row(
      children: [
        UserAvatar(
          avatarUrl: widget.profile.user.avatarUrl,
          radius: 40,
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.profile.user.name ?? 'ユーザー',
                style: theme.textTheme.titleMedium,
              ),
              if (widget.profile.user.handle != null)
                Text(
                  '@${widget.profile.user.handle}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: appColors.textSecondary,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStats(
      BuildContext context, ThemeData theme, AppColors appColors) {
    return Row(
      children: [
        GestureDetector(
          onTap: widget.onFollowingTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${widget.profile.followCounts.followingCount}',
                style: theme.textTheme.labelMedium,
              ),
              Text(
                ' フォロー中',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: appColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        GestureDetector(
          onTap: widget.onFollowersTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${widget.profile.followCounts.followerCount}',
                style: theme.textTheme.labelMedium,
              ),
              Text(
                ' フォロワー',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: appColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        if (widget.profile.bookCount != null) ...[
          const SizedBox(width: AppSpacing.md),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${widget.profile.bookCount}',
                style: theme.textTheme.labelMedium,
              ),
              Text(
                ' 冊登録',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: appColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, ThemeData theme,
      AppColors appColors, FollowStatusType status) {
    return switch (status) {
      FollowStatusType.none => SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: () => ref
                .read(followRequestNotifierProvider(widget.profile.user.id)
                    .notifier)
                .sendFollowRequest(),
            style: FilledButton.styleFrom(
              backgroundColor: appColors.primary,
              foregroundColor: appColors.textPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('フォローリクエストを送信'),
          ),
        ),
      FollowStatusType.pendingSent => SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: null,
            style: FilledButton.styleFrom(
              backgroundColor: appColors.surfaceElevated,
              foregroundColor: appColors.textSecondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('リクエスト送信済み'),
          ),
        ),
      FollowStatusType.following => SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => ref
                .read(followRequestNotifierProvider(widget.profile.user.id)
                    .notifier)
                .unfollow(),
            style: OutlinedButton.styleFrom(
              foregroundColor: appColors.destructive,
              side: BorderSide(color: appColors.destructive),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('フォロー解除'),
          ),
        ),
      FollowStatusType.pendingReceived => const SizedBox.shrink(),
    };
  }
}
