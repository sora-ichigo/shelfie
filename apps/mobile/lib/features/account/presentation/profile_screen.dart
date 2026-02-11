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

class _ProfileScreenState extends ConsumerState<ProfileScreen>
    with SingleTickerProviderStateMixin {
  ProfileTab _selectedTab = ProfileTab.bookShelf;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: ProfileTab.values.length, vsync: this);
    _tabController.addListener(_onTabIndexChanged);
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabIndexChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _onTabIndexChanged() {
    final tab = ProfileTab.values[_tabController.index];
    if (_selectedTab != tab) {
      setState(() => _selectedTab = tab);
    }
  }

  void _onTabChanged(ProfileTab tab) {
    _tabController.animateTo(tab.index);
  }

  @override
  Widget build(BuildContext context) {
    final isGuest = ref.watch(authStateProvider.select((s) => s.isGuest));
    if (isGuest) return _buildGuestView(context);

    final accountAsync = ref.watch(accountNotifierProvider);

    return accountAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        body: Center(child: Text('エラーが発生しました: $error')),
      ),
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
            Icon(Icons.person_outline, size: 64, color: appColors.textSecondary),
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
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              toolbarHeight: kToolbarHeight,
              expandedHeight: _calculateExpandedHeight(profile),
              backgroundColor: theme.scaffoldBackgroundColor,
              surfaceTintColor: Colors.transparent,
              scrolledUnderElevation: 0,
              title: Text(
                profile.username ?? profile.name ?? '',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings_outlined),
                  onPressed: () => context.push(AppRoutes.account),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: SafeArea(
                  child: Column(
                    children: [
                      const SizedBox(height: kToolbarHeight),
                      ProfileHeader(
                        profile: profile,
                        onEditProfile: () =>
                            context.push(AppRoutes.accountEdit),
                        onShareProfile: () {},
                      ),
                    ],
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(48),
                child: ColoredBox(
                  color: theme.scaffoldBackgroundColor,
                  child: ProfileTabBar(
                    selectedTab: _selectedTab,
                    onTabChanged: _onTabChanged,
                  ),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _BookShelfTab(
              booksState: booksState,
              onBookTap: _onBookTap,
              onBookLongPress: _onBookLongPress,
            ),
            _BookListTab(),
          ],
        ),
      ),
    );
  }

  double _calculateExpandedHeight(UserProfile profile) {
    var height = kToolbarHeight + 48.0;
    height += 16 + 80 + 12;
    if (profile.bio != null && profile.bio!.isNotEmpty) {
      height += 12 + 40;
    }
    if (profile.instagramHandle != null && profile.instagramHandle!.isNotEmpty) {
      height += 8 + 20;
    }
    return height + 24 + 12 + 40 + 8;
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

class _BookShelfTab extends ConsumerWidget {
  const _BookShelfTab({
    required this.booksState,
    required this.onBookTap,
    required this.onBookLongPress,
  });

  final ProfileBooksState booksState;
  final void Function(ShelfBookItem) onBookTap;
  final void Function(ShelfBookItem) onBookLongPress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = Theme.of(context).extension<AppColors>()!;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.xs),
              ReadingStatusChips(
                selectedFilter: booksState.selectedFilter,
                onFilterChanged: (filter) {
                  ref
                      .read(profileBooksNotifierProvider.notifier)
                      .setFilter(filter);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xxs,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SearchFilterBar(
                    sortOption: ref.watch(sortOptionNotifierProvider),
                    onSortChanged: (option) async {
                      await ref
                          .read(sortOptionNotifierProvider.notifier)
                          .update(option);
                      ref.invalidate(profileBooksNotifierProvider);
                    },
                  ),
                ),
              ),
            ],
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
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index >= booksState.books.length) return null;
                  final book = booksState.books[index];
                  return ProfileBookCard(
                    book: book,
                    onTap: () => onBookTap(book),
                    onLongPress: () => onBookLongPress(book),
                  );
                },
                childCount: booksState.books.length,
              ),
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
      ],
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
          Icon(Icons.construction_outlined,
              size: 48, color: appColors.textSecondary),
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
