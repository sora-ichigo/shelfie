import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/error_view.dart';
import 'package:shelfie/core/widgets/loading_indicator.dart';
import 'package:shelfie/core/widgets/screen_header.dart';
import 'package:shelfie/features/account/application/account_notifier.dart';
import 'package:shelfie/features/book_list/application/book_list_notifier.dart';
import 'package:shelfie/features/book_list/application/book_list_state.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';
import 'package:shelfie/features/book_shelf/application/book_shelf_notifier.dart';
import 'package:shelfie/features/book_shelf/application/book_shelf_state.dart';
import 'package:shelfie/features/book_shelf/domain/group_option.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/book_shelf/domain/sort_option.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/book_quick_actions_modal.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/library_books_tab.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/library_filter_tabs.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/library_lists_tab.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/search_filter_bar.dart';
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
      ref.read(bookShelfNotifierProvider.notifier).initialize();
      ref.read(bookListNotifierProvider.notifier).loadLists();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookShelfState = ref.watch(bookShelfNotifierProvider);
    final bookListState = ref.watch(bookListNotifierProvider);
    final accountAsync = ref.watch(accountNotifierProvider);

    ref.listen(
      shelfStateProvider,
      (previous, next) {
        if (previous == null) return;
        final currentState = ref.read(bookShelfNotifierProvider);
        if (currentState is! BookShelfLoaded) return;

        if (next.length > previous.length) {
          ref.read(bookShelfNotifierProvider.notifier).refresh();
        } else {
          ref.read(bookShelfNotifierProvider.notifier).regroupBooks();
        }
      },
    );

    final loaded = bookShelfState is BookShelfLoaded ? bookShelfState : null;

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
                      const Spacer(),
                      Visibility(
                        visible:
                            _selectedTab ==
                            LibraryFilterTab.books,
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        child: SearchFilterBar(
                          sortOption:
                              loaded?.sortOption ??
                              SortOption.defaultOption,
                          groupOption:
                              loaded?.groupOption ??
                              GroupOption.defaultOption,
                          onSortChanged: (option) {
                            ref
                                .read(
                                  bookShelfNotifierProvider
                                      .notifier,
                                )
                                .setSortOption(option);
                          },
                          onGroupChanged: (option) {
                            ref
                                .read(
                                  bookShelfNotifierProvider
                                      .notifier,
                                )
                                .setGroupOption(option);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ];
      },
      body: _buildContent(bookShelfState, bookListState),
    );
  }

  void _onTabChanged(LibraryFilterTab tab) {
    setState(() {
      _selectedTab = tab;
    });
  }

  Widget _buildContent(
      BookShelfState bookShelfState, BookListState bookListState) {
    final isLoading = bookShelfState is BookShelfInitial ||
        bookShelfState is BookShelfLoading ||
        bookListState is BookListInitial ||
        bookListState is BookListLoading;

    if (isLoading) {
      return const LoadingIndicator(fullScreen: true);
    }

    if (bookShelfState is BookShelfError) {
      return ErrorView(
        failure: bookShelfState.failure,
        onRetry: () => ref.read(bookShelfNotifierProvider.notifier).refresh(),
        retryButtonText: 'リトライ',
      );
    }

    if (bookListState is BookListError) {
      return ErrorView(
        failure: bookListState.failure,
        onRetry: () => ref.read(bookListNotifierProvider.notifier).refresh(),
        retryButtonText: 'リトライ',
      );
    }

    if (bookShelfState is! BookShelfLoaded) {
      return const LoadingIndicator(fullScreen: true);
    }

    final lists = bookListState is BookListLoaded
        ? bookListState.lists
        : <BookListSummary>[];

    final shelfState = ref.watch(shelfStateProvider);
    final hasBooks = bookShelfState.books
        .any((book) => shelfState.containsKey(book.externalId));

    return switch (_selectedTab) {
      LibraryFilterTab.books => _buildBooksTab(bookShelfState),
      LibraryFilterTab.lists => _buildListsTab(lists, hasBooks),
    };
  }

  Widget _buildBooksTab(BookShelfLoaded bookShelfState) {
    final shelfState = ref.watch(shelfStateProvider);
    final filteredBooks = bookShelfState.books
        .where((book) => shelfState.containsKey(book.externalId))
        .toList();

    final filteredGroupedBooks = bookShelfState.isGrouped
        ? _filterGroupedBooks(bookShelfState.groupedBooks, shelfState)
        : bookShelfState.groupedBooks;

    return LibraryBooksTab(
      books: filteredBooks,
      groupedBooks: filteredGroupedBooks,
      groupOption: bookShelfState.groupOption,
      hasMore: bookShelfState.hasMore,
      isLoadingMore: bookShelfState.isLoadingMore,
      onBookTap: _onBookTap,
      onBookLongPress: _onBookLongPress,
      onLoadMore: () {
        ref.read(bookShelfNotifierProvider.notifier).loadMore();
      },
    );
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

  Map<String, List<ShelfBookItem>> _filterGroupedBooks(
    Map<String, List<ShelfBookItem>> groupedBooks,
    Map<String, dynamic> shelfState,
  ) {
    return groupedBooks.map((key, books) {
      final filtered = books
          .where((book) => shelfState.containsKey(book.externalId))
          .toList();
      return MapEntry(key, filtered);
    })
      ..removeWhere((key, books) => books.isEmpty);
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
