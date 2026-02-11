import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shelfie/core/auth/auth_state.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/account/application/account_notifier.dart';
import 'package:shelfie/features/account/application/profile_books_notifier.dart';
import 'package:shelfie/features/account/application/profile_books_state.dart';
import 'package:shelfie/features/account/domain/user_profile.dart';
import 'package:shelfie/features/account/presentation/widgets/profile_book_card.dart';
import 'package:shelfie/features/account/presentation/widgets/profile_header.dart';
import 'package:shelfie/features/account/presentation/widgets/profile_tab_bar.dart';
import 'package:shelfie/features/account/presentation/widgets/reading_status_chips.dart';
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
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                ProfileHeader(
                  profile: profile,
                  onEditProfile: () => context.push(AppRoutes.accountEdit),
                  onShareProfile: () {},
                ),
                ProfileTabBar(
                  selectedTab: _selectedTab,
                  onTabChanged: (tab) => setState(() => _selectedTab = tab),
                ),
              ],
            ),
          ),
          if (_selectedTab == ProfileTab.bookShelf)
            ..._buildBookShelfSlivers(booksState)
          else
            SliverToBoxAdapter(child: _BookListTab()),
        ],
      ),
    );
  }

  List<Widget> _buildBookShelfSlivers(ProfileBooksState booksState) {
    final appColors = Theme.of(context).extension<AppColors>()!;

    return [
      SliverToBoxAdapter(
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
              ),
            ],
          ),
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
              crossAxisSpacing: AppSpacing.xs,
              mainAxisSpacing: AppSpacing.xs,
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
        if (booksState.hasMore)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Center(
                child: booksState.isLoadingMore
                    ? const CircularProgressIndicator()
                    : TextButton(
                        onPressed: () => ref
                            .read(profileBooksNotifierProvider.notifier)
                            .loadMore(),
                        child: const Text('もっと見る'),
                      ),
              ),
            ),
          ),
      ],
    ];
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

class _BookListTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.construction_outlined,
            size: 48,
            color: appColors.textSecondary,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'ブックリストは準備中です',
            style: TextStyle(color: appColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
