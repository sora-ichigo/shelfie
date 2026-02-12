import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/utils/time_ago.dart';
import 'package:shelfie/core/widgets/user_avatar.dart';
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
        return _NotificationTile(
          notification: notifications[index],
        );
      },
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.notification});

  final NotificationModel notification;

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
        border: Border(
          bottom: BorderSide(color: appColors.border, width: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAvatar(
            avatarUrl: notification.sender.avatarUrl,
            radius: 20,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    style: theme.textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: notification.sender.name ?? notification.sender.handle ?? '',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text: 'さんが${_notificationText(notification.type)}',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  formatTimeAgo(notification.createdAt),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: appColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          _NotificationTypeIcon(type: notification.type),
        ],
      ),
    );
  }

  String _notificationText(NotificationType type) {
    return switch (type) {
      NotificationType.followRequestReceived => 'フォローリクエストが届きました',
      NotificationType.followRequestApproved => 'フォローリクエストを承認しました',
    };
  }
}

class _NotificationTypeIcon extends StatelessWidget {
  const _NotificationTypeIcon({required this.type});

  final NotificationType type;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    final (icon, color) = switch (type) {
      NotificationType.followRequestReceived => (
        CupertinoIcons.person_add,
        appColors.primary,
      ),
      NotificationType.followRequestApproved => (
        CupertinoIcons.checkmark_circle,
        appColors.success,
      ),
    };

    return Icon(icon, size: 20, color: color);
  }
}
