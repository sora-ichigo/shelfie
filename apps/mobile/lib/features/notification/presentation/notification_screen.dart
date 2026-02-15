import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shelfie/core/state/follow_state_notifier.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/utils/time_ago.dart';
import 'package:shelfie/core/widgets/user_avatar.dart';
import 'package:shelfie/features/follow/domain/follow_status_type.dart';
import 'package:shelfie/features/notification/application/notification_list_notifier.dart';
import 'package:shelfie/features/notification/domain/notification_model.dart';
import 'package:shelfie/features/notification/domain/notification_type.dart';
import 'package:shelfie/routing/app_router.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() =>
      _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final notifier = ref.read(notificationListNotifierProvider.notifier);
    await notifier.loadInitial();
    if (!mounted) return;
    final state = ref.read(notificationListNotifierProvider);
    state.whenData(_registerFollowStates);
    await notifier.markAsRead();
  }

  void _registerFollowStates(List<NotificationModel> notifications) {
    final followState = ref.read(followStateProvider);
    final notifier = ref.read(followStateProvider.notifier);

    for (final notification in notifications) {
      final userId = notification.sender.id;
      final existing = followState[userId];

      if (existing != null) {
        if (notification.type == NotificationType.followRequestReceived &&
            notification.incomingFollowStatus == FollowStatusType.pendingReceived &&
            existing.incoming == FollowStatusType.none) {
          notifier.registerStatus(
            userId: userId,
            outgoing: existing.outgoing,
            incoming: FollowStatusType.pendingReceived,
          );
        }
        continue;
      }

      notifier.registerStatus(
        userId: userId,
        outgoing: notification.outgoingFollowStatus,
        incoming: notification.incomingFollowStatus,
      );
    }
  }

  Future<void> _onRefresh() async {
    final notifier = ref.read(notificationListNotifierProvider.notifier);
    await notifier.refresh();
    if (!mounted) return;
    final state = ref.read(notificationListNotifierProvider);
    state.whenData(_registerFollowStates);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final notifier = ref.read(notificationListNotifierProvider.notifier);
      if (notifier.hasMore && !notifier.isLoadingMore) {
        notifier.loadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;
    final notificationState = ref.watch(notificationListNotifierProvider);
    final followState = ref.watch(followStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'お知らせ',
          style: theme.textTheme.titleMedium,
        ),
        centerTitle: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: notificationState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: appColors.textSecondary,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'エラーが発生しました',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: appColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              ElevatedButton(
                onPressed: _loadData,
                child: const Text('再試行'),
              ),
            ],
          ),
        ),
        data: (notifications) {
          if (notifications.isEmpty) {
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: _buildEmptyState(theme, appColors),
                  ),
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: _buildNotificationList(
              notifications,
              followState,
              theme,
              appColors,
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme, AppColors appColors) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            CupertinoIcons.bell,
            size: 64,
            color: appColors.textSecondary,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'お知らせはまだありません',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: appColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationList(
    List<NotificationModel> notifications,
    Map<int, FollowDirectionalStatus> followState,
    ThemeData theme,
    AppColors appColors,
  ) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        final status = followState[notification.sender.id];
        final displayStatus = _deriveDisplayStatus(
          status ??
              (
                outgoing: notification.outgoingFollowStatus,
                incoming: notification.incomingFollowStatus,
              ),
        );

        return _NotificationTile(
          notification: notification,
          displayStatus: displayStatus,
          onApprove: notification.followRequestId != null
              ? () => ref.read(followStateProvider.notifier).approveRequest(
                    userId: notification.sender.id,
                    requestId: notification.followRequestId!,
                  )
              : null,
          onReject: notification.followRequestId != null
              ? () => ref.read(followStateProvider.notifier).rejectRequest(
                    userId: notification.sender.id,
                    requestId: notification.followRequestId!,
                  )
              : null,
          onFollow: () => ref
              .read(followStateProvider.notifier)
              .sendFollowRequest(userId: notification.sender.id),
          onUnfollow: () => ref
              .read(followStateProvider.notifier)
              .unfollow(userId: notification.sender.id),
          onCancelRequest: () => ref
              .read(followStateProvider.notifier)
              .cancelFollowRequest(userId: notification.sender.id),
        );
      },
    );
  }

  static FollowStatusType _deriveDisplayStatus(FollowDirectionalStatus status) {
    if (status.incoming == FollowStatusType.pendingReceived) {
      return FollowStatusType.pendingReceived;
    }
    if (status.outgoing == FollowStatusType.following) {
      return FollowStatusType.following;
    }
    if (status.outgoing == FollowStatusType.pendingSent) {
      return FollowStatusType.pendingSent;
    }
    if (status.incoming == FollowStatusType.following) {
      return FollowStatusType.followedBy;
    }
    return FollowStatusType.none;
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({
    required this.notification,
    required this.displayStatus,
    this.onApprove,
    this.onReject,
    this.onFollow,
    this.onUnfollow,
    this.onCancelRequest,
  });

  final NotificationModel notification;
  final FollowStatusType displayStatus;
  final VoidCallback? onApprove;
  final VoidCallback? onReject;
  final VoidCallback? onFollow;
  final VoidCallback? onUnfollow;
  final VoidCallback? onCancelRequest;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return GestureDetector(
      onTap: () {
        final handle = notification.sender.handle;
        if (handle != null) {
          context.push(AppRoutes.userProfile(handle: handle));
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: notification.isRead ? null : appColors.surface,
        ),
        child: Row(
          children: [
            UserAvatar(
              avatarUrl: notification.sender.avatarUrl,
              radius: 18,
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Text.rich(
                TextSpan(
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: appColors.textPrimary,
                  ),
                  children: [
                    TextSpan(
                      text: notification.sender.name ??
                          notification.sender.handle ??
                          '',
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    TextSpan(text: _notificationText(notification.type)),
                    TextSpan(
                      text: formatTimeAgo(notification.createdAt),
                      style: TextStyle(color: appColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ),
            ..._buildActionButtons(theme, appColors),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildActionButtons(ThemeData theme, AppColors appColors) {
    return switch (notification.type) {
      NotificationType.followRequestReceived =>
        _buildFollowRequestReceivedButtons(theme, appColors),
      NotificationType.followRequestApproved =>
        _buildFollowRequestApprovedButtons(theme, appColors),
    };
  }

  List<Widget> _buildFollowRequestReceivedButtons(
    ThemeData theme,
    AppColors appColors,
  ) {
    return switch (displayStatus) {
      FollowStatusType.pendingReceived => [
        const SizedBox(width: AppSpacing.xs),
        _PrimaryButton(
          label: '承認',
          onPressed: onApprove,
          appColors: appColors,
          theme: theme,
        ),
        const SizedBox(width: AppSpacing.xs),
        TextButton(
          onPressed: onReject,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              vertical: AppSpacing.xxs,
              horizontal: AppSpacing.md,
            ),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            '削除',
            style: theme.textTheme.labelLarge?.copyWith(
              color: appColors.textPrimary,
            ),
          ),
        ),
      ],
      FollowStatusType.following => [
        const SizedBox(width: AppSpacing.xs),
        _SecondaryButton(
          label: 'フォロー中',
          onPressed: onUnfollow,
          appColors: appColors,
          theme: theme,
        ),
      ],
      FollowStatusType.followedBy => [
        const SizedBox(width: AppSpacing.xs),
        _PrimaryButton(
          label: 'フォローバック',
          onPressed: onFollow,
          appColors: appColors,
          theme: theme,
        ),
      ],
      FollowStatusType.none ||
      FollowStatusType.pendingSent => [],
    };
  }

  List<Widget> _buildFollowRequestApprovedButtons(
    ThemeData theme,
    AppColors appColors,
  ) {
    return switch (displayStatus) {
      FollowStatusType.following => [
        const SizedBox(width: AppSpacing.xs),
        _SecondaryButton(
          label: 'フォロー中',
          onPressed: onUnfollow,
          appColors: appColors,
          theme: theme,
        ),
      ],
      FollowStatusType.none ||
      FollowStatusType.followedBy => [
        const SizedBox(width: AppSpacing.xs),
        _PrimaryButton(
          label: 'フォロー',
          onPressed: onFollow,
          appColors: appColors,
          theme: theme,
        ),
      ],
      FollowStatusType.pendingSent => [
        const SizedBox(width: AppSpacing.xs),
        _SecondaryButton(
          label: 'リクエスト済み',
          onPressed: onCancelRequest,
          appColors: appColors,
          theme: theme,
        ),
      ],
      FollowStatusType.pendingReceived => [],
    };
  }

  String _notificationText(NotificationType type) {
    return switch (type) {
      NotificationType.followRequestReceived =>
        ' からフォローリクエストがありました。',
      NotificationType.followRequestApproved =>
        ' がフォローリクエストを承認しました。',
    };
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.label,
    required this.onPressed,
    required this.appColors,
    required this.theme,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppColors appColors;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: appColors.primary,
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.xxs,
          horizontal: AppSpacing.md,
        ),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.xs),
        ),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelLarge?.copyWith(
          color: appColors.textPrimary,
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  const _SecondaryButton({
    required this.label,
    required this.onPressed,
    required this.appColors,
    required this.theme,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppColors appColors;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: appColors.surface,
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.xxs,
          horizontal: AppSpacing.md,
        ),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.xs),
        ),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelLarge?.copyWith(
          color: appColors.textPrimary,
        ),
      ),
    );
  }
}
