import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/user_avatar.dart';
import 'package:shelfie/features/follow/application/follow_request_list_notifier.dart';
import 'package:shelfie/features/follow/domain/follow_request_model.dart';

class FollowRequestListScreen extends ConsumerStatefulWidget {
  const FollowRequestListScreen({super.key});

  @override
  ConsumerState<FollowRequestListScreen> createState() =>
      _FollowRequestListScreenState();
}

class _FollowRequestListScreenState
    extends ConsumerState<FollowRequestListScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(followRequestListNotifierProvider.notifier).loadInitial();
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
      final notifier = ref.read(followRequestListNotifierProvider.notifier);
      if (notifier.hasMore && !notifier.isLoadingMore) {
        notifier.loadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(followRequestListNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'フォローリクエスト',
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
        data: (requests) => requests.isEmpty
            ? _buildEmpty(context)
            : _buildList(context, requests),
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
                .read(followRequestListNotifierProvider.notifier)
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
        'フォローリクエストはありません',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: appColors.textSecondary,
            ),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<FollowRequestModel> requests) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: requests.length,
      itemBuilder: (context, index) =>
          _FollowRequestItem(request: requests[index]),
    );
  }
}

class _FollowRequestItem extends ConsumerWidget {
  const _FollowRequestItem({required this.request});

  final FollowRequestModel request;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      child: Row(
        children: [
          UserAvatar(avatarUrl: request.sender.avatarUrl, radius: 24),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  request.sender.name ?? 'ユーザー',
                  style: theme.textTheme.bodyMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (request.sender.handle != null)
                  Text(
                    '@${request.sender.handle}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: appColors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          FilledButton(
            onPressed: () => ref
                .read(followRequestListNotifierProvider.notifier)
                .approve(request.id),
            style: FilledButton.styleFrom(
              backgroundColor: appColors.primary,
              foregroundColor: appColors.textPrimary,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('承認', style: theme.textTheme.labelMedium),
          ),
          const SizedBox(width: AppSpacing.xs),
          OutlinedButton(
            onPressed: () => ref
                .read(followRequestListNotifierProvider.notifier)
                .reject(request.id),
            style: OutlinedButton.styleFrom(
              foregroundColor: appColors.textSecondary,
              side: BorderSide(color: appColors.border),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('拒否', style: theme.textTheme.labelMedium),
          ),
        ],
      ),
    );
  }
}
