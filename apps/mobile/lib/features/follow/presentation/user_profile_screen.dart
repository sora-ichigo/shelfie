import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shelfie/core/state/follow_state_notifier.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/account/presentation/widgets/profile_content_view.dart';
import 'package:shelfie/features/account/presentation/widgets/profile_header.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/follow/application/follow_counts_notifier.dart';
import 'package:shelfie/features/follow/application/user_profile_book_lists_notifier.dart';
import 'package:shelfie/features/follow/application/user_profile_books_notifier.dart';
import 'package:shelfie/features/follow/domain/follow_status_type.dart';
import 'package:shelfie/features/follow/domain/user_profile_model.dart';
import 'package:shelfie/routing/app_router.dart';

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

class _UserProfileScreenState extends ConsumerState<UserProfileScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  bool _bookListLoaded = false;

  int get _userId => widget.profile.user.id;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final existing = ref.read(followStateProvider)[_userId];
      if (existing == null) {
        ref.read(followStateProvider.notifier).registerStatus(
              userId: _userId,
              outgoing: widget.profile.outgoingFollowStatus,
              incoming: widget.profile.incomingFollowStatus,
            );
      }
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) return;
    final currentStatus =
        ref.read(followStateProvider)[_userId] ??
            (
              outgoing: widget.profile.outgoingFollowStatus,
              incoming: widget.profile.incomingFollowStatus,
            );
    final isFollowing = currentStatus.outgoing == FollowStatusType.following;

    if (isFollowing &&
        _tabController.index == 1 &&
        !_bookListLoaded) {
      _bookListLoaded = true;
      ref
          .read(userProfileBookListsNotifierProvider(_userId).notifier)
          .loadLists();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;
    final currentStatus =
        ref.watch(followStateProvider.select((s) => s[_userId])) ??
            (
              outgoing: widget.profile.outgoingFollowStatus,
              incoming: widget.profile.incomingFollowStatus,
            );
    final isFollowing = currentStatus.outgoing == FollowStatusType.following;
    final followCounts = ref.watch(followCountsNotifierProvider(_userId));

    final booksState =
        ref.watch(userProfileBooksNotifierProvider(_userId));
    final bookListsState =
        ref.watch(userProfileBookListsNotifierProvider(_userId));

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
      body: ProfileContentView(
        tabController: _tabController,
        header: Column(
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
              followingCount: followCounts.valueOrNull?.followingCount
                  ?? widget.profile.followCounts.followingCount,
              followerCount: followCounts.valueOrNull?.followerCount
                  ?? widget.profile.followCounts.followerCount,
              onFollowingTap: widget.onFollowingTap,
              onFollowersTap: widget.onFollowersTap,
              actionButtons: widget.profile.isOwnProfile
                  ? null
                  : _buildActionButton(appColors, theme, currentStatus),
            ),
          ],
        ),
        showNotFollowingPlaceholder: !isFollowing,
        books: booksState.books,
        isBooksLoading: booksState.isLoading,
        isBooksLoadingMore: booksState.isLoadingMore,
        hasMoreBooks: booksState.hasMore,
        onLoadMoreBooks: () {
          if (booksState.canLoadMore) {
            ref
                .read(userProfileBooksNotifierProvider(_userId).notifier)
                .loadMore();
          }
        },
        onBookTap: _onBookTap,
        bookLists: bookListsState.lists,
        isBookListsLoading: bookListsState.isLoading,
        isBookListsError: bookListsState.error != null,
      ),
    );
  }

  void _onBookTap(ShelfBookItem book) {
    context.push(
      AppRoutes.bookDetail(bookId: book.externalId, source: book.source),
    );
  }

  Widget _buildActionButton(
      AppColors appColors, ThemeData theme, FollowDirectionalStatus status) {
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

    final followButton = switch (status.outgoing) {
      FollowStatusType.none ||
      FollowStatusType.pendingReceived ||
      FollowStatusType.followedBy => Expanded(
          child: FilledButton(
            onPressed: () => ref
                .read(followStateProvider.notifier)
                .sendFollowRequest(userId: _userId),
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
            child: Text(
              status.incoming == FollowStatusType.following
                  ? 'フォローバック'
                  : 'フォロー',
              style: theme.textTheme.labelMedium,
            ),
          ),
        ),
      FollowStatusType.pendingSent => Expanded(
          child: FilledButton(
            onPressed: () => ref
                .read(followStateProvider.notifier)
                .cancelFollowRequest(userId: _userId),
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
                .read(followStateProvider.notifier)
                .unfollow(userId: _userId),
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
