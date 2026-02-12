import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/account/presentation/widgets/profile_header.dart';
import 'package:shelfie/features/account/presentation/widgets/profile_tab_bar.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';
import 'package:shelfie/features/book_list/presentation/widgets/book_list_card.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/follow/application/follow_request_notifier.dart';
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

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  ProfileTab _selectedTab = ProfileTab.bookShelf;
  final _scrollController = ScrollController();
  bool _bookListLoaded = false;

  int get _userId => widget.profile.user.id;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(followRequestNotifierProvider(_userId).notifier)
          .setStatus(widget.profile.followStatus);
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
      final booksState =
          ref.read(userProfileBooksNotifierProvider(_userId));
      if (booksState.canLoadMore) {
        ref.read(userProfileBooksNotifierProvider(_userId).notifier).loadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;
    final followState = ref.watch(
        followRequestNotifierProvider(_userId));
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
      body: CustomScrollView(
        controller: isFollowing ? _scrollController : null,
        slivers: [
          SliverToBoxAdapter(
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
          SliverPersistentHeader(
            pinned: true,
            delegate: _TabBarDelegate(
              child: ProfileTabBar(
                selectedTab: _selectedTab,
                onTabChanged: (tab) {
                  setState(() => _selectedTab = tab);
                  if (isFollowing &&
                      tab == ProfileTab.bookList &&
                      !_bookListLoaded) {
                    _bookListLoaded = true;
                    ref
                        .read(userProfileBookListsNotifierProvider(_userId)
                            .notifier)
                        .loadLists();
                  }
                },
              ),
              backgroundColor: theme.scaffoldBackgroundColor,
            ),
          ),
          if (!isFollowing)
            _buildNotFollowingPlaceholder(appColors, theme)
          else if (_selectedTab == ProfileTab.bookShelf)
            ..._buildBookShelfSlivers(appColors, theme)
          else
            ..._buildBookListSlivers(appColors, theme),
        ],
      ),
    );
  }

  Widget _buildNotFollowingPlaceholder(AppColors appColors, ThemeData theme) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _selectedTab == ProfileTab.bookShelf
                  ? Icons.grid_view_rounded
                  : Icons.library_books_rounded,
              size: 64,
              color: appColors.textSecondary,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'フォローすると見られます',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: appColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildBookShelfSlivers(AppColors appColors, ThemeData theme) {
    final booksState =
        ref.watch(userProfileBooksNotifierProvider(_userId));

    if (booksState.isLoading) {
      return [
        const SliverFillRemaining(
          child: Center(child: CircularProgressIndicator()),
        ),
      ];
    }

    if (booksState.error != null) {
      return [
        SliverFillRemaining(
          child: Center(
            child: Text(
              'エラーが発生しました',
              style: TextStyle(color: appColors.textSecondary),
            ),
          ),
        ),
      ];
    }

    if (booksState.books.isEmpty) {
      return [
        SliverFillRemaining(
          child: Center(
            child: Text(
              'まだ本が登録されていません',
              style: TextStyle(color: appColors.textSecondary),
            ),
          ),
        ),
      ];
    }

    return [
      SliverPadding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.58,
            crossAxisSpacing: AppSpacing.xl,
            mainAxisSpacing: AppSpacing.md,
          ),
          delegate: SliverChildBuilderDelegate((context, index) {
            final book = booksState.books[index];
            return _UserProfileBookCard(
              book: book,
              onTap: () => context.push(
                AppRoutes.bookDetail(
                  bookId: book.externalId,
                  source: book.source,
                ),
              ),
            );
          }, childCount: booksState.books.length),
        ),
      ),
      if (booksState.isLoadingMore)
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
    ];
  }

  List<Widget> _buildBookListSlivers(AppColors appColors, ThemeData theme) {
    final bookListsState =
        ref.watch(userProfileBookListsNotifierProvider(_userId));

    if (bookListsState.isLoading) {
      return [
        const SliverFillRemaining(
          child: Center(child: CircularProgressIndicator()),
        ),
      ];
    }

    if (bookListsState.error != null) {
      return [
        SliverFillRemaining(
          child: Center(
            child: Text(
              'エラーが発生しました',
              style: TextStyle(color: appColors.textSecondary),
            ),
          ),
        ),
      ];
    }

    if (bookListsState.lists.isEmpty) {
      return [
        SliverFillRemaining(
          child: Center(
            child: Text(
              'まだブックリストがありません',
              style: TextStyle(color: appColors.textSecondary),
            ),
          ),
        ),
      ];
    }

    return [
      SliverPadding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppSpacing.xl,
            mainAxisSpacing: AppSpacing.md,
            childAspectRatio: 0.85,
          ),
          delegate: SliverChildBuilderDelegate((context, index) {
            final list = bookListsState.lists[index];
            return _UserProfileBookListGridItem(
              summary: list,
              onTap: () => context.push(
                AppRoutes.bookListDetail(listId: list.id),
              ),
            );
          }, childCount: bookListsState.lists.length),
        ),
      ),
    ];
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

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  _TabBarDelegate({required this.child, required this.backgroundColor});

  final Widget child;
  final Color backgroundColor;

  @override
  double get minExtent => 56;

  @override
  double get maxExtent => 56;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ColoredBox(color: backgroundColor, child: child);
  }

  @override
  bool shouldRebuild(_TabBarDelegate oldDelegate) =>
      child != oldDelegate.child ||
      backgroundColor != oldDelegate.backgroundColor;
}

class _UserProfileBookCard extends StatelessWidget {
  const _UserProfileBookCard({
    required this.book,
    required this.onTap,
  });

  final ShelfBookItem book;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: book.hasCoverImage
            ? CachedNetworkImage(
                imageUrl: book.coverImageUrl!,
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (context, url) => _buildPlaceholder(appColors),
                errorWidget: (context, url, error) =>
                    _buildPlaceholder(appColors),
              )
            : _buildPlaceholder(appColors),
      ),
    );
  }

  Widget _buildPlaceholder(AppColors appColors) {
    return ColoredBox(
      color: appColors.surfaceElevated,
      child: Center(
        child: Icon(Icons.book, size: 32, color: appColors.textSecondary),
      ),
    );
  }
}

class _UserProfileBookListGridItem extends StatelessWidget {
  const _UserProfileBookListGridItem({
    required this.summary,
    required this.onTap,
  });

  final BookListSummary summary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: summary.coverImages.isEmpty
                  ? ColoredBox(
                      color: appColors.surface,
                      child: Center(
                        child: Icon(
                          Icons.collections_bookmark,
                          size: 32,
                          color: appColors.textSecondary,
                        ),
                      ),
                    )
                  : CoverCollage(coverImages: summary.coverImages),
            ),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            summary.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
