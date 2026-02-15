import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shelfie/core/auth/auth_state.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/icon_tap_area.dart';
import 'package:shelfie/features/account/application/account_notifier.dart';
import 'package:shelfie/features/account/application/profile_books_notifier.dart';
import 'package:shelfie/features/account/application/reading_status_counts_notifier.dart';
import 'package:shelfie/features/account/domain/user_profile.dart';
import 'package:shelfie/features/account/presentation/widgets/no_book_lists_message.dart';
import 'package:shelfie/features/account/presentation/widgets/profile_content_view.dart';
import 'package:shelfie/features/account/presentation/widgets/profile_header.dart';
import 'package:shelfie/features/account/presentation/widgets/profile_share_bottom_sheet.dart';
import 'package:shelfie/features/account/presentation/widgets/reading_status_chips.dart';
import 'package:shelfie/features/book_list/application/book_list_notifier.dart';
import 'package:shelfie/features/book_list/application/book_list_state.dart';
import 'package:shelfie/features/book_list/presentation/widgets/create_book_list_modal.dart';
import 'package:shelfie/features/book_shelf/application/sort_option_notifier.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/book_quick_actions_modal.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/search_filter_bar.dart';
import 'package:shelfie/features/follow/application/follow_counts_notifier.dart';
import 'package:shelfie/routing/app_router.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
      data: _buildProfileView,
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
              color: appColors.textSecondaryLegacy,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'ログインするとプロフィールが表示されます',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: appColors.textSecondaryLegacy,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileView(UserProfile profile) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;
    final booksState = ref.watch(profileBooksNotifierProvider);
    final followCounts = ref.watch(followCountsNotifierProvider(profile.id));
    final bookListState = ref.watch(bookListNotifierProvider);

    if (bookListState is BookListInitial) {
      Future.microtask(() {
        if (mounted) {
          ref.read(bookListNotifierProvider.notifier).loadLists();
        }
      });
    }

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
      body: ProfileContentView(
        onRefresh: () => _onRefresh(profile),
        tabController: _tabController,
        header: ProfileHeader(
          name: profile.name,
          avatarUrl: profile.avatarUrl,
          handle: profile.handle,
          bio: profile.bio,
          instagramHandle: profile.instagramHandle,
          bookCount: profile.bookCount,
          followingCount: followCounts.valueOrNull?.followingCount ?? 0,
          followerCount: followCounts.valueOrNull?.followerCount ?? 0,
          onFollowingTap: () => context.push(
            AppRoutes.followList(
              userId: profile.id,
              type: 'following',
            ),
          ),
          onFollowersTap: () => context.push(
            AppRoutes.followList(
              userId: profile.id,
              type: 'followers',
            ),
          ),
          actionButtons: _buildEditShareButtons(appColors, theme, profile),
        ),
        books: booksState.books,
        isBooksLoading: booksState.isLoading,
        isBooksLoadingMore: booksState.isLoadingMore,
        hasMoreBooks: booksState.hasMore,
        onLoadMoreBooks: () {
          final state = ref.read(profileBooksNotifierProvider);
          if (state.hasMore && !state.isLoadingMore) {
            ref.read(profileBooksNotifierProvider.notifier).loadMore();
          }
        },
        onBookTap: _onBookTap,
        onBookLongPress: _onBookLongPress,
        filterBar: Padding(
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
        bookLists: bookListState is BookListLoaded ? bookListState.lists : [],
        isBookListsLoading:
            bookListState is BookListInitial || bookListState is BookListLoading,
        isBookListsEmpty:
            bookListState is BookListLoaded && bookListState.lists.isEmpty,
        isBookListsError: bookListState is BookListError,
        emptyBookListWidget: NoBookListsMessage(
          onCreateListPressed: _onCreateBookList,
        ),
        bookListActionBar: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.xxs,
            horizontal: AppSpacing.md,
          ),
          child: Row(
            children: [
              const Spacer(),
              IconTapArea(
                icon: Icons.add,
                color: appColors.textSecondaryLegacy,
                semanticLabel: 'リストを作成',
                onTap: _onCreateBookList,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh(UserProfile profile) async {
    ref.invalidate(accountNotifierProvider);
    ref.invalidate(followCountsNotifierProvider(profile.id));
    await Future.wait([
      ref.read(profileBooksNotifierProvider.notifier).refresh(),
      ref.read(readingStatusCountsNotifierProvider.notifier).refresh(),
      ref.read(bookListNotifierProvider.notifier).refreshSilently(),
      ref.read(accountNotifierProvider.future),
    ]);
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

  Widget _buildEditShareButtons(
    AppColors appColors,
    ThemeData theme,
    UserProfile profile,
  ) {
    return Row(
      children: [
        Expanded(
          child: FilledButton(
            onPressed: () => context.push(AppRoutes.accountEdit),
            style: FilledButton.styleFrom(
              backgroundColor: appColors.surfaceElevatedLegacy,
              foregroundColor: appColors.textPrimaryLegacy,
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
              'プロフィールを編集',
              style: theme.textTheme.labelMedium,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: FilledButton(
            onPressed: profile.shareUrl != null
                ? () => showProfileShareBottomSheet(
                      context: context,
                      shareUrl: profile.shareUrl!,
                    )
                : null,
            style: FilledButton.styleFrom(
              backgroundColor: appColors.surfaceElevatedLegacy,
              foregroundColor: appColors.textPrimaryLegacy,
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
        ),
      ],
    );
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
