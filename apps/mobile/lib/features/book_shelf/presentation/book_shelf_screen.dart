import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/screen_header.dart';
import 'package:shelfie/features/account/application/account_notifier.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_list/application/book_list_notifier.dart';
import 'package:shelfie/features/book_list/application/book_list_state.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';
import 'package:shelfie/features/book_search/presentation/widgets/isbn_scan_result_dialog.dart';
import 'package:shelfie/features/book_shelf/application/sort_option_notifier.dart';
import 'package:shelfie/features/book_shelf/application/status_section_notifier.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/book_shelf/domain/sort_option.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/add_book_bottom_sheet.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/book_quick_actions_modal.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/library_filter_tabs.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/library_lists_tab.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/search_filter_bar.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/status_section_list.dart';
import 'package:shelfie/routing/app_router.dart';

class BookShelfScreen extends ConsumerStatefulWidget {
  const BookShelfScreen({super.key});

  @override
  ConsumerState<BookShelfScreen> createState() => _BookShelfScreenState();
}

class _BookShelfScreenState extends ConsumerState<BookShelfScreen> {
  LibraryFilterTab _selectedTab = LibraryFilterTab.books;

  static const _headerHeight = AppSpacing.sm + 40.0 + AppSpacing.sm;
  static const _filterTabHeight = AppSpacing.xxs * 2 + 40.0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      for (final status in ReadingStatus.values) {
        ref
            .read(statusSectionNotifierProvider(status).notifier)
            .initialize();
      }
      ref.read(bookListNotifierProvider.notifier).loadLists();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookListState = ref.watch(bookListNotifierProvider);
    final accountAsync = ref.watch(accountNotifierProvider);

    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            pinned: true,
            toolbarHeight: 0,
            expandedHeight: _headerHeight + _filterTabHeight,
            backgroundColor:
                Theme.of(context).scaffoldBackgroundColor,
            surfaceTintColor: Colors.transparent,
            scrolledUnderElevation: 0,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                final topPadding =
                    MediaQuery.of(context).padding.top;
                final headerSpace =
                    (constraints.maxHeight -
                            topPadding -
                            _filterTabHeight)
                        .clamp(0.0, _headerHeight);
                final opacity =
                    (2 * headerSpace / _headerHeight - 1)
                        .clamp(0.0, 1.0);
                return Column(
                  children: [
                    SizedBox(height: topPadding),
                    Opacity(
                      opacity: opacity,
                      child: SizedBox(
                        height: headerSpace,
                        child: ScreenHeader(
                          title: 'ライブラリ',
                          onProfileTap: () =>
                              context.push(AppRoutes.account),
                          avatarUrl:
                              accountAsync.valueOrNull?.avatarUrl,
                          isAvatarLoading: accountAsync.isLoading,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            bottom: PreferredSize(
              preferredSize:
                  const Size.fromHeight(_filterTabHeight),
              child: ColoredBox(
                color:
                    Theme.of(context).scaffoldBackgroundColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.xxs,
                  ),
                  child: Row(
                    children: [
                      LibraryFilterTabs(
                        selectedTab: _selectedTab,
                        onTabChanged: _onTabChanged,
                      ),
                      if (_selectedTab == LibraryFilterTab.books) ...[
                        const Spacer(),
                        SearchFilterBar(
                          sortOption: ref.watch(sortOptionNotifierProvider),
                          onSortChanged: _onSortChanged,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ];
      },
      body: _buildContent(bookListState),
    );
  }

  void _onTabChanged(LibraryFilterTab tab) {
    setState(() {
      _selectedTab = tab;
    });
    if (tab == LibraryFilterTab.books) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        for (final status in ReadingStatus.values) {
          ref
              .read(statusSectionNotifierProvider(status).notifier)
              .initialize();
        }
      });
    }
  }

  Future<void> _onSortChanged(SortOption option) async {
    await ref.read(sortOptionNotifierProvider.notifier).update(option);
    for (final status in ReadingStatus.values) {
      await ref.read(statusSectionNotifierProvider(status).notifier).initialize();
    }
  }

  Widget _buildContent(BookListState bookListState) {
    final lists = bookListState is BookListLoaded
        ? bookListState.lists
        : <BookListSummary>[];

    final shelfState = ref.watch(shelfStateProvider);
    final hasBooks = shelfState.isNotEmpty;

    return switch (_selectedTab) {
      LibraryFilterTab.books => StatusSectionList(
          onBookTap: _onBookTap,
          onBookLongPress: _onBookLongPress,
          onAddBookPressed: _showAddBookSheet,
        ),
      LibraryFilterTab.lists => _buildListsTab(lists, hasBooks),
    };
  }

  Widget _buildListsTab(List<BookListSummary> lists, bool hasBooks) {
    return LibraryListsTab(
      lists: lists,
      hasBooks: hasBooks,
      onListTap: _onListTap,
      onCreateTap: () {
        context.push(AppRoutes.bookListCreate);
      },
    );
  }

  void _showAddBookSheet() {
    showAddBookBottomSheet(
      context: context,
      onKeywordSearch: _onKeywordSearch,
      onBarcodeScan: _onBarcodeScan,
    );
  }

  void _onKeywordSearch() {
    ref.read(searchAutoFocusProvider.notifier).state = true;
    context.go(AppRoutes.searchTab);
  }

  Future<void> _onBarcodeScan() async {
    final isbn = await context.push<String>(AppRoutes.isbnScan);
    if (isbn != null && mounted) {
      await ISBNScanResultDialog.show(context, isbn);
    }
  }

  void _onBookTap(ShelfBookItem book) {
    context.push(
        AppRoutes.bookDetail(bookId: book.externalId, source: book.source));
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

  void _onListTap(BookListSummary list) {
    context.push(AppRoutes.bookListDetail(listId: list.id));
  }
}
