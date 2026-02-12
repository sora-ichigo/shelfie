import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/user_avatar.dart';
import 'package:shelfie/features/follow/application/follow_list_notifier.dart';
import 'package:shelfie/features/follow/domain/follow_list_type.dart';
import 'package:shelfie/features/follow/domain/user_summary.dart';

class FollowListScreen extends ConsumerStatefulWidget {
  const FollowListScreen({
    required this.userId,
    required this.listType,
    this.onUserTap,
    super.key,
  });

  final int userId;
  final FollowListType listType;
  final void Function(UserSummary user)? onUserTap;

  @override
  ConsumerState<FollowListScreen> createState() => _FollowListScreenState();
}

class _FollowListScreenState extends ConsumerState<FollowListScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(followListNotifierProvider(widget.userId, widget.listType)
              .notifier)
          .loadInitial();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final notifier = ref.read(
          followListNotifierProvider(widget.userId, widget.listType).notifier);
      if (notifier.hasMore && !notifier.isLoadingMore) {
        notifier.loadMore();
      }
    }
  }

  String get _title => switch (widget.listType) {
        FollowListType.following => 'フォロー中',
        FollowListType.followers => 'フォロワー',
      };

  String get _emptyMessage => switch (widget.listType) {
        FollowListType.following => 'フォロー中のユーザーはいません',
        FollowListType.followers => 'フォロワーのユーザーはいません',
      };

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(
        followListNotifierProvider(widget.userId, widget.listType));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: state.when(
        loading: () =>
            const Center(child: CircularProgressIndicator()),
        error: (_, __) => _buildError(context),
        data: (users) =>
            users.isEmpty ? _buildEmpty(context) : _buildList(context, users),
      ),
    );
  }

  Widget _buildError(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, size: 48, color: appColors.textSecondary),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'エラーが発生しました',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: appColors.textSecondary,
                ),
          ),
          const SizedBox(height: AppSpacing.md),
          TextButton(
            onPressed: () => ref
                .read(followListNotifierProvider(
                        widget.userId, widget.listType)
                    .notifier)
                .loadInitial(),
            child: const Text('再読み込み'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Center(
      child: Text(
        _emptyMessage,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: appColors.textSecondary,
            ),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<UserSummary> users) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: users.length,
      itemBuilder: (context, index) => _UserListItem(
        user: users[index],
        onTap: widget.onUserTap != null
            ? () => widget.onUserTap!(users[index])
            : null,
      ),
    );
  }
}

class _UserListItem extends StatelessWidget {
  const _UserListItem({required this.user, this.onTap});

  final UserSummary user;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          children: [
            UserAvatar(avatarUrl: user.avatarUrl, radius: 24),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name ?? 'ユーザー',
                    style: theme.textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (user.handle != null)
                    Text(
                      '@${user.handle}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: appColors.textSecondary,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
