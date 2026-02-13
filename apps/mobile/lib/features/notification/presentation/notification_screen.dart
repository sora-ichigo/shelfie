import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/utils/time_ago.dart';
import 'package:shelfie/core/widgets/user_avatar.dart';
import 'package:shelfie/features/follow/domain/follow_status_type.dart';
import 'package:shelfie/features/notification/application/notification_list_notifier.dart';
import 'package:shelfie/features/notification/domain/notification_model.dart';
import 'package:shelfie/features/notification/domain/notification_type.dart';

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
    await notifier.markAsRead();
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
            return _buildEmptyState(theme, appColors);
          }
          return _buildNotificationList(
            notifications,
            theme,
            appColors,
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
    ThemeData theme,
    AppColors appColors,
  ) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return _NotificationTile(
          notification: notification,
          onApprove: () {},
          onReject: () {},
        );
      },
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({
    required this.notification,
    this.onApprove,
    this.onReject,
  });

  final NotificationModel notification;
  final VoidCallback? onApprove;
  final VoidCallback? onReject;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return Container(
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
    );
  }

  List<Widget> _buildActionButtons(ThemeData theme, AppColors appColors) {
    return switch (notification.followStatus) {
      FollowStatusType.pendingReceived => [
        const SizedBox(width: AppSpacing.xs),
        TextButton(
          onPressed: onApprove,
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
            '承認',
            style: theme.textTheme.labelLarge?.copyWith(
              color: appColors.textPrimary,
            ),
          ),
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
        _DisabledButton(label: 'フォロー中', theme: theme, appColors: appColors),
      ],
      FollowStatusType.none => [
        const SizedBox(width: AppSpacing.xs),
        TextButton(
          onPressed: () {},
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
            notification.type == NotificationType.followRequestReceived
                ? 'フォローバック'
                : 'フォロー',
            style: theme.textTheme.labelLarge?.copyWith(
              color: appColors.textPrimary,
            ),
          ),
        ),
      ],
      FollowStatusType.pendingSent => [
        const SizedBox(width: AppSpacing.xs),
        _DisabledButton(
          label: 'リクエスト済み',
          theme: theme,
          appColors: appColors,
        ),
      ],
    };
  }

  String _notificationText(NotificationType type) {
    return switch (type) {
      NotificationType.followRequestReceived =>
        ' からフォローリクエストがありました。',
      NotificationType.followRequestApproved => ' があなたをフォローしました。',
    };
  }
}

class _DisabledButton extends StatelessWidget {
  const _DisabledButton({
    required this.label,
    required this.theme,
    required this.appColors,
  });

  final String label;
  final ThemeData theme;
  final AppColors appColors;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: null,
      style: TextButton.styleFrom(
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
          color: appColors.textSecondary,
        ),
      ),
    );
  }
}
