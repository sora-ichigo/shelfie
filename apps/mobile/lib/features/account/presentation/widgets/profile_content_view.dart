import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/account/presentation/widgets/profile_book_card.dart';
import 'package:shelfie/features/account/presentation/widgets/profile_tab_bar.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';
import 'package:shelfie/features/book_list/presentation/widgets/book_list_card.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/routing/app_router.dart';

class ProfileContentView extends StatelessWidget {
  const ProfileContentView({
    required this.tabController,
    required this.header,
    required this.books,
    required this.isBooksLoading,
    required this.isBooksLoadingMore,
    required this.hasMoreBooks,
    required this.onLoadMoreBooks,
    required this.onBookTap,
    this.bookLists = const [],
    this.isBookListsLoading = false,
    this.isBookListsEmpty = false,
    this.isBookListsError = false,
    this.filterBar,
    this.bookListActionBar,
    this.emptyBookListWidget,
    this.onBookLongPress,
    this.showNotFollowingPlaceholder = false,
    this.onRefresh,
    super.key,
  });

  final TabController tabController;
  final Widget header;
  final List<ShelfBookItem> books;
  final bool isBooksLoading;
  final bool isBooksLoadingMore;
  final bool hasMoreBooks;
  final VoidCallback onLoadMoreBooks;
  final ValueChanged<ShelfBookItem> onBookTap;
  final List<BookListSummary> bookLists;
  final bool isBookListsLoading;
  final bool isBookListsEmpty;
  final bool isBookListsError;
  final Widget? filterBar;
  final Widget? bookListActionBar;
  final Widget? emptyBookListWidget;
  final ValueChanged<ShelfBookItem>? onBookLongPress;
  final bool showNotFollowingPlaceholder;
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final nestedScrollView = NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverToBoxAdapter(child: header),
        SliverPersistentHeader(
          pinned: true,
          delegate: _TabBarDelegate(
            child: ListenableBuilder(
              listenable: tabController.animation!,
              builder: (context, _) => ProfileTabBar(
                selectedTab: ProfileTab
                    .values[tabController.animation!.value.round()],
                onTabChanged: (tab) => tabController.animateTo(tab.index),
              ),
            ),
            backgroundColor: theme.scaffoldBackgroundColor,
          ),
        ),
      ],
      body: showNotFollowingPlaceholder
          ? _buildNotFollowingPlaceholder(context)
          : TabBarView(
              controller: tabController,
              children: [
                _buildBookShelfTab(context),
                _buildBookListTab(context),
              ],
            ),
    );

    if (onRefresh != null) {
      return RefreshIndicator(
        onRefresh: onRefresh!,
        child: nestedScrollView,
      );
    }

    return nestedScrollView;
  }

  Widget _buildNotFollowingPlaceholder(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return TabBarView(
      controller: tabController,
      children: [
        _buildPlaceholderContent(
          appColors,
          theme,
          Icons.grid_view_rounded,
        ),
        _buildPlaceholderContent(
          appColors,
          theme,
          Icons.library_books_rounded,
        ),
      ],
    );
  }

  Widget _buildPlaceholderContent(
    AppColors appColors,
    ThemeData theme,
    IconData icon,
  ) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 64, color: appColors.textSecondary),
          const SizedBox(height: AppSpacing.md),
          Text(
            'フォローすると見られます',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: appColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookShelfTab(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels >=
            notification.metrics.maxScrollExtent - 200) {
          if (hasMoreBooks && !isBooksLoadingMore) {
            onLoadMoreBooks();
          }
        }
        return false;
      },
      child: CustomScrollView(
        key: const PageStorageKey('bookShelf'),
        slivers: _buildBookShelfSlivers(context),
      ),
    );
  }

  List<Widget> _buildBookShelfSlivers(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;

    return [
      if (filterBar != null)
        SliverPersistentHeader(
          pinned: true,
          delegate: _FilterBarDelegate(
            child: filterBar!,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
        )
      else
        const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.sm)),
      if (isBooksLoading)
        const SliverFillRemaining(
          child: Center(child: CircularProgressIndicator()),
        )
      else if (books.isEmpty)
        SliverFillRemaining(
          child: Center(
            child: Text(
              'まだ本が登録されていません',
              style: TextStyle(color: appColors.textSecondary),
            ),
          ),
        )
      else ...[
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.58,
              crossAxisSpacing: AppSpacing.xl,
              mainAxisSpacing: AppSpacing.md,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              if (index >= books.length) return null;
              final book = books[index];
              return ProfileBookCard(
                book: book,
                onTap: () => onBookTap(book),
                onLongPress: onBookLongPress != null
                    ? () => onBookLongPress!(book)
                    : null,
              );
            }, childCount: books.length),
          ),
        ),
        if (isBooksLoadingMore)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
      ],
    ];
  }

  Widget _buildBookListTab(BuildContext context) {
    return CustomScrollView(
      key: const PageStorageKey('bookList'),
      slivers: _buildBookListSlivers(context),
    );
  }

  List<Widget> _buildBookListSlivers(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;

    if (isBookListsLoading) {
      return [
        const SliverFillRemaining(
          child: Center(child: CircularProgressIndicator()),
        ),
      ];
    }

    if (isBookListsError) {
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

    if (isBookListsEmpty && emptyBookListWidget != null) {
      return [
        SliverFillRemaining(child: emptyBookListWidget),
      ];
    }

    if (bookLists.isEmpty) {
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
      if (bookListActionBar != null)
        SliverPersistentHeader(
          pinned: true,
          delegate: _FilterBarDelegate(
            child: bookListActionBar!,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
        )
      else
        const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.sm)),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppSpacing.xl,
            mainAxisSpacing: AppSpacing.md,
            childAspectRatio: 0.85,
          ),
          delegate: SliverChildBuilderDelegate((context, index) {
            final list = bookLists[index];
            return _BookListGridItem(summary: list);
          }, childCount: bookLists.length),
        ),
      ),
    ];
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

class _FilterBarDelegate extends SliverPersistentHeaderDelegate {
  _FilterBarDelegate({required this.child, required this.backgroundColor});

  final Widget child;
  final Color backgroundColor;

  @override
  double get minExtent => 48;

  @override
  double get maxExtent => 48;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ColoredBox(
      color: backgroundColor,
      child: Align(child: child),
    );
  }

  @override
  bool shouldRebuild(_FilterBarDelegate oldDelegate) =>
      child != oldDelegate.child ||
      backgroundColor != oldDelegate.backgroundColor;
}

class _BookListGridItem extends StatelessWidget {
  const _BookListGridItem({required this.summary});

  final BookListSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return GestureDetector(
      onTap: () => context.push(AppRoutes.bookListDetail(listId: summary.id)),
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
