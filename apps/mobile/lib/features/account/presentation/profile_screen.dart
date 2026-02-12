import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shelfie/core/auth/auth_state.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/icon_tap_area.dart';
import 'package:shelfie/features/account/application/account_notifier.dart';
import 'package:shelfie/features/account/application/profile_books_notifier.dart';
import 'package:shelfie/features/account/application/profile_books_state.dart';
import 'package:shelfie/features/account/application/reading_status_counts_notifier.dart';
import 'package:shelfie/features/account/domain/user_profile.dart';
import 'package:shelfie/features/account/presentation/widgets/no_book_lists_message.dart';
import 'package:shelfie/features/account/presentation/widgets/profile_book_card.dart';
import 'package:shelfie/features/account/presentation/widgets/profile_header.dart';
import 'package:shelfie/features/account/presentation/widgets/profile_tab_bar.dart';
import 'package:shelfie/features/account/presentation/widgets/reading_status_chips.dart';
import 'package:shelfie/features/book_list/application/book_list_notifier.dart';
import 'package:shelfie/features/book_list/application/book_list_state.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';
import 'package:shelfie/features/book_list/presentation/widgets/book_list_card.dart';
import 'package:shelfie/features/book_list/presentation/widgets/create_book_list_modal.dart';
import 'package:shelfie/features/book_shelf/application/sort_option_notifier.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/book_quick_actions_modal.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/search_filter_bar.dart';
import 'package:shelfie/routing/app_router.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  ProfileTab _selectedTab = ProfileTab.bookShelf;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final booksState = ref.read(profileBooksNotifierProvider);
      if (booksState.hasMore && !booksState.isLoadingMore) {
        ref.read(profileBooksNotifierProvider.notifier).loadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isGuest = ref.watch(authStateProvider.select((s) => s.isGuest));
    if (isGuest) return _buildGuestView(context);

    final accountAsync = ref.watch(accountNotifierProvider);

    return accountAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, _) =>
          Scaffold(body: Center(child: Text('エラーが発生しました: $error'))),
      data: (profile) => _buildProfileView(context, profile),
    );
  }

  Widget _buildGuestView(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.person_outline,
              size: 64,
              color: appColors.textSecondary,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'ログインするとプロフィールが表示されます',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: appColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileView(BuildContext context, UserProfile profile) {
    final theme = Theme.of(context);
    final booksState = ref.watch(profileBooksNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          profile.handle ?? profile.name ?? '',
          style: theme.textTheme.titleMedium,
        ),
        centerTitle: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push(AppRoutes.account),
          ),
        ],
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: ProfileHeader(
              profile: profile,
              onEditProfile: () => context.push(AppRoutes.accountEdit),
              onShareProfile: () {},
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _TabBarDelegate(
              child: ProfileTabBar(
                selectedTab: _selectedTab,
                onTabChanged: (tab) => setState(() => _selectedTab = tab),
              ),
              backgroundColor: theme.scaffoldBackgroundColor,
            ),
          ),
          if (_selectedTab == ProfileTab.bookShelf)
            ..._buildBookShelfSlivers(booksState)
          else
            ..._buildBookListSlivers(),
        ],
      ),
    );
  }

  List<Widget> _buildBookShelfSlivers(ProfileBooksState booksState) {
    final appColors = Theme.of(context).extension<AppColors>()!;

    return [
      SliverPersistentHeader(
        pinned: true,
        delegate: _FilterBarDelegate(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppSpacing.xxs,
              horizontal: AppSpacing.md,
            ),
            child: Row(
              children: [
                Expanded(
                  child: ReadingStatusChips(
                    selectedFilter: booksState.selectedFilter,
                    counts: ref.watch(readingStatusCountsNotifierProvider),
                    onFilterChanged: (filter) {
                      ref
                          .read(profileBooksNotifierProvider.notifier)
                          .setFilter(filter);
                    },
                  ),
                ),
                SearchFilterBar(
                  sortOption: ref.watch(sortOptionNotifierProvider),
                  onSortChanged: (option) async {
                    await ref
                        .read(sortOptionNotifierProvider.notifier)
                        .update(option);
                    ref.invalidate(profileBooksNotifierProvider);
                  },
                  onBookTap: _onBookTap,
                  onBookLongPress: _onBookLongPress,
                ),
              ],
            ),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
      if (booksState.isLoading)
        const SliverFillRemaining(
          child: Center(child: CircularProgressIndicator()),
        )
      else if (booksState.books.isEmpty)
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
              if (index >= booksState.books.length) return null;
              final book = booksState.books[index];
              return ProfileBookCard(
                book: book,
                onTap: () => _onBookTap(book),
                onLongPress: () => _onBookLongPress(book),
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
      ],
    ];
  }

  List<Widget> _buildBookListSlivers() {
    final appColors = Theme.of(context).extension<AppColors>()!;
    final bookListState = ref.watch(bookListNotifierProvider);

    if (bookListState is BookListInitial) {
      Future.microtask(() {
        if (mounted) {
          ref.read(bookListNotifierProvider.notifier).loadLists();
        }
      });
    }

    final actionBar = SliverPersistentHeader(
      pinned: true,
      delegate: _FilterBarDelegate(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.xxs,
            horizontal: AppSpacing.md,
          ),
          child: Row(
            children: [
              const Spacer(),
              IconTapArea(
                icon: Icons.add,
                color: appColors.textSecondary,
                semanticLabel: 'リストを作成',
                onTap: _onCreateBookList,
              ),
            ],
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
    );

    return switch (bookListState) {
      BookListInitial() || BookListLoading() => [
        const SliverFillRemaining(
          child: Center(child: CircularProgressIndicator()),
        ),
      ],
      BookListError() => [
        SliverFillRemaining(
          child: Center(
            child: Text(
              'エラーが発生しました',
              style: TextStyle(color: appColors.textSecondary),
            ),
          ),
        ),
      ],
      BookListLoaded(lists: final lists) when lists.isEmpty => [
        SliverFillRemaining(
          child: NoBookListsMessage(
            onCreateListPressed: _onCreateBookList,
          ),
        ),
      ],
      BookListLoaded(lists: final lists) => [
        actionBar,
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
              final list = lists[index];
              return _BookListGridItem(
                summary: list,
                onTap: () =>
                    context.push(AppRoutes.bookListDetail(listId: list.id)),
              );
            }, childCount: lists.length),
          ),
        ),
      ],
    };
  }

  Future<void> _onCreateBookList() async {
    final bookListState = ref.read(bookListNotifierProvider);
    final existingCount =
        bookListState is BookListLoaded ? bookListState.lists.length : 0;
    final bookList = await showCreateBookListModal(
      context: context,
      existingCount: existingCount,
    );
    if (bookList != null && mounted) {
      await context.push(AppRoutes.bookListDetail(listId: bookList.id));
    }
  }

  void _onBookTap(ShelfBookItem book) {
    context.push(
      AppRoutes.bookDetail(bookId: book.externalId, source: book.source),
    );
  }

  void _onBookLongPress(ShelfBookItem book) {
    final shelfEntry = ref.read(shelfStateProvider)[book.externalId];
    if (shelfEntry == null) return;

    showBookQuickActionsModal(
      context: context,
      ref: ref,
      book: book,
      shelfEntry: shelfEntry,
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
  const _BookListGridItem({required this.summary, required this.onTap});

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
