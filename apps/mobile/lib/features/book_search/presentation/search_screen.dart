import 'dart:async';

import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/empty_state.dart';
import 'package:shelfie/core/widgets/error_view.dart';
import 'package:shelfie/core/widgets/loading_indicator.dart';
import 'package:shelfie/core/widgets/screen_header.dart';
import 'package:shelfie/features/account/application/account_notifier.dart';
import 'package:shelfie/features/book_detail/presentation/widgets/reading_status_modal.dart';
import 'package:shelfie/features/book_search/application/book_search_notifier.dart';
import 'package:shelfie/features/book_search/application/book_search_state.dart';
import 'package:shelfie/features/book_search/application/recent_books_notifier.dart';
import 'package:shelfie/features/book_search/application/search_history_notifier.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart';
import 'package:shelfie/features/book_search/domain/recent_book_entry.dart';
import 'package:shelfie/features/book_search/presentation/widgets/book_list_item.dart';
import 'package:shelfie/features/book_search/presentation/widgets/isbn_scan_result_dialog.dart';
import 'package:shelfie/features/book_search/presentation/widgets/recent_book_quick_actions_modal.dart';
import 'package:shelfie/features/book_search/presentation/widgets/recent_books_section.dart';
import 'package:shelfie/features/book_search/presentation/widgets/search_bar_widget.dart';
import 'package:shelfie/features/book_search/presentation/widgets/search_history_section.dart';
import 'package:shelfie/routing/app_router.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();
  final _addingBooks = <String>{};
  final _removingBooks = <String>{};
  bool _isSearchFieldFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void deactivate() {
    ref.read(navBarHiddenProvider.notifier).state = false;
    super.deactivate();
  }

  @override
  void dispose() {
    _focusNode
      ..removeListener(_onFocusChange)
      ..dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isSearchFieldFocused = _focusNode.hasFocus;
    });
    ref.read(navBarHiddenProvider.notifier).state = _focusNode.hasFocus;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bookSearchNotifierProvider);
    final searchHistoryAsync = ref.watch(searchHistoryNotifierProvider);
    final accountAsync = ref.watch(accountNotifierProvider);
    final avatarUrl = accountAsync.valueOrNull?.avatarUrl;

    ref.listen<BookSearchState>(
      bookSearchNotifierProvider,
      (previous, next) {
        if (next is BookSearchError) {
          AdaptiveSnackBar.show(
            context,
            message: next.failure.userMessage,
            type: AdaptiveSnackBarType.error,
          );
        }
      },
    );

    final isSearchActive = _isSearchFieldFocused || state is! BookSearchInitial;
    final showSearchHistory = _isSearchFieldFocused && state is BookSearchInitial;

    return GestureDetector(
      onTap: _dismissOverlay,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedSize(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: isSearchActive
                    ? const SizedBox.shrink()
                    : ScreenHeader(
                        title: '検索',
                        onProfileTap: () => context.push(AppRoutes.account),
                        avatarUrl: avatarUrl,
                        isAvatarLoading: accountAsync.isLoading,
                      ),
              ),
              Padding(
                padding: AppSpacing.vertical(AppSpacing.sm),
                child: SearchBarWidget(
                  controller: _searchController,
                  focusNode: _focusNode,
                  onChanged: _onSearchChanged,
                  onSubmitted: _onSearchSubmitted,
                  onScanPressed: _onScanPressed,
                  showCancelButton: isSearchActive,
                  onCancelPressed: _onCancel,
                  hintText: 'タイトル、著者名、タグ',
                ),
              ),
              Expanded(
                child: showSearchHistory
                    ? _buildSearchInputMode(searchHistoryAsync.valueOrNull ?? [])
                    : _buildBody(state),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchInputMode(List<dynamic> entries) {
    final currentQuery = _searchController.text;
    final filteredEntries = ref
        .read(searchHistoryNotifierProvider.notifier)
        .getFilteredHistory(currentQuery);

    return SearchHistorySection(
      key: const ValueKey('search_history_section'),
      entries: filteredEntries,
      onHistorySelected: _onHistorySelected,
      onHistoryDeleted: _onHistoryDeleted,
      onClearAll: _onClearAllHistory,
    );
  }

  Widget _buildBody(BookSearchState state) {
    return switch (state) {
      BookSearchInitial() => _buildInitialState(),
      BookSearchLoading() => const LoadingIndicator(fullScreen: true),
      BookSearchSuccess(:final books, :final hasMore) => _buildSuccessList(
          books,
          hasMore: hasMore,
          isLoadingMore: false,
        ),
      BookSearchEmpty(:final query) => EmptyState(
          icon: Icons.search_off,
          title: '検索結果がありません',
          message: '「$query」に一致する書籍が見つかりませんでした。',
        ),
      BookSearchError(:final failure) => ErrorView(
          failure: failure,
          onRetry: _onRetry,
          retryButtonText: '再試行',
        ),
      BookSearchLoadingMore(:final books) => _buildSuccessList(
          books,
          hasMore: true,
          isLoadingMore: true,
        ),
    };
  }

  Widget _buildInitialState() {
    final recentBooksAsync = ref.watch(recentBooksNotifierProvider);

    return recentBooksAsync.when(
      data: (recentBooks) {
        if (recentBooks.isEmpty) {
          return const SizedBox.shrink();
        }

        final bottomInset = MediaQuery.of(context).padding.bottom +
            kBottomNavigationBarHeight;

        return Align(
          key: const ValueKey('recent_books_section'),
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: bottomInset),
            child: RecentBooksSection(
              books: recentBooks,
              onBookTap: (book) => context.push(
                AppRoutes.bookDetail(
                  bookId: book.bookId,
                  source: book.source != null
                      ? BookSource.values.byName(book.source!)
                      : null,
                ),
              ),
              onBookLongPress: _onRecentBookLongPress,
            ),
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  void _onRecentBookLongPress(RecentBookEntry book) {
    showRecentBookQuickActionsModal(
      context: context,
      book: book,
      onAddToShelf: () => _onRecentBookAddToShelf(book),
      onRemoveFromShelf: () => _onRecentBookRemoveFromShelf(book),
    );
  }

  Future<void> _onRecentBookAddToShelf(RecentBookEntry book) async {
    if (_addingBooks.contains(book.bookId)) return;

    final addResult = await showAddToShelfModal(context: context);
    if (addResult == null || !mounted) return;

    setState(() {
      _addingBooks.add(book.bookId);
    });

    final result = await ref.read(shelfStateProvider.notifier).addToShelf(
          externalId: book.bookId,
          title: book.title,
          authors: book.authors,
          coverImageUrl: book.coverImageUrl,
          readingStatus: addResult.status,
        );

    if (!mounted) return;

    setState(() {
      _addingBooks.remove(book.bookId);
    });

    result.fold(
      (failure) {
        AdaptiveSnackBar.show(
          context,
          message: failure.userMessage,
          type: AdaptiveSnackBarType.error,
        );
      },
      (_) {
        if (addResult.rating != null) {
          unawaited(
            ref.read(shelfStateProvider.notifier).updateRatingWithApi(
                  externalId: book.bookId,
                  rating: addResult.rating!,
                ),
          );
        }
        AdaptiveSnackBar.show(
          context,
          message: '「${addResult.status.displayName}」で登録しました',
          type: AdaptiveSnackBarType.success,
        );
      },
    );
  }

  Future<void> _onRecentBookRemoveFromShelf(RecentBookEntry book) async {
    final shelfEntry = ref.read(shelfStateProvider)[book.bookId];
    if (shelfEntry == null) return;

    if (_removingBooks.contains(book.bookId)) return;

    setState(() {
      _removingBooks.add(book.bookId);
    });

    final result = await ref.read(shelfStateProvider.notifier).removeFromShelf(
          externalId: book.bookId,
          userBookId: shelfEntry.userBookId,
        );

    if (!mounted) return;

    setState(() {
      _removingBooks.remove(book.bookId);
    });

    result.fold(
      (failure) {
        AdaptiveSnackBar.show(
          context,
          message: failure.userMessage,
          type: AdaptiveSnackBarType.error,
        );
      },
      (_) {
        AdaptiveSnackBar.show(
          context,
          message: 'マイライブラリから削除しました',
          type: AdaptiveSnackBarType.success,
        );
      },
    );
  }

  Widget _buildSuccessList(
    List<Book> books, {
    required bool hasMore,
    required bool isLoadingMore,
  }) {
    final shelfState = ref.watch(shelfStateProvider);

    final bottomInset =
        MediaQuery.of(context).padding.bottom + kBottomNavigationBarHeight;

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          final metrics = notification.metrics;
          if (metrics.pixels >= metrics.maxScrollExtent - 200 && hasMore) {
            _loadMore();
          }
        }
        return false;
      },
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: bottomInset),
        itemCount: books.length + (isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == books.length) {
            return const Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final book = books[index];
          final shelfEntry = shelfState[book.id];
          final userBookId = shelfEntry?.userBookId;
          final bookWithShelfState = book.copyWith(
            userBookId: userBookId,
            clearUserBookId: userBookId == null,
          );

          return BookListItem(
            book: bookWithShelfState,
            onTap: () => _onBookTap(bookWithShelfState),
            onAddPressed: () => _onAddToShelf(bookWithShelfState),
            onRemovePressed: () => _onRemoveFromShelf(bookWithShelfState),
            isAddingToShelf: _addingBooks.contains(book.id),
            isRemovingFromShelf: _removingBooks.contains(book.id),
          );
        },
      ),
    );
  }

  void _dismissOverlay() {
    _focusNode.unfocus();
  }

  void _onCancel() {
    ref.read(bookSearchNotifierProvider.notifier).reset();
    _searchController.clear();
    _focusNode.unfocus();
  }

  void _onSearchChanged(String query) {
    setState(() {});
    ref.read(bookSearchNotifierProvider.notifier).searchBooksWithDebounce(query);
  }

  void _onSearchSubmitted(String query) {
    if (query.isEmpty) return;
    _focusNode.unfocus();
    ref.read(bookSearchNotifierProvider.notifier).searchBooks(query);
    ref.read(searchHistoryNotifierProvider.notifier).addHistory(query);
  }

  void _onHistorySelected(String query) {
    _searchController.text = query;
    _focusNode.unfocus();
    ref.read(bookSearchNotifierProvider.notifier).searchBooks(query);
  }

  void _onHistoryDeleted(String query) {
    ref.read(searchHistoryNotifierProvider.notifier).removeHistory(query);
  }

  void _onClearAllHistory() {
    ref.read(searchHistoryNotifierProvider.notifier).clearAll();
  }

  Future<void> _onScanPressed() async {
    final isbn = await context.push<String>(AppRoutes.isbnScan);

    if (isbn != null && mounted) {
      await ISBNScanResultDialog.show(context, isbn);
    }
  }

  void _onRetry() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      ref.read(bookSearchNotifierProvider.notifier).searchBooks(query);
    }
  }

  void _loadMore() {
    ref.read(bookSearchNotifierProvider.notifier).loadMore();
  }

  void _onBookTap(Book book) {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      ref.read(searchHistoryNotifierProvider.notifier).addHistory(query);
    }
    context.push(AppRoutes.bookDetail(bookId: book.id, source: book.source));
  }

  Future<void> _onAddToShelf(Book book) async {
    if (_addingBooks.contains(book.id)) return;

    final addResult = await showAddToShelfModal(context: context);
    if (addResult == null || !mounted) return;

    setState(() {
      _addingBooks.add(book.id);
    });

    final result = await ref
        .read(bookSearchNotifierProvider.notifier)
        .addToShelf(book, readingStatus: addResult.status);

    if (!mounted) return;

    setState(() {
      _addingBooks.remove(book.id);
    });

    result.fold(
      (failure) {
        AdaptiveSnackBar.show(
          context,
          message: failure.userMessage,
          type: AdaptiveSnackBarType.error,
        );
      },
      (_) {
        if (addResult.rating != null) {
          unawaited(
            ref.read(shelfStateProvider.notifier).updateRatingWithApi(
                  externalId: book.id,
                  rating: addResult.rating!,
                ),
          );
        }
        AdaptiveSnackBar.show(
          context,
          message: '「${addResult.status.displayName}」で登録しました',
          type: AdaptiveSnackBarType.success,
        );
      },
    );
  }

  Future<void> _onRemoveFromShelf(Book book) async {
    if (_removingBooks.contains(book.id)) return;

    setState(() {
      _removingBooks.add(book.id);
    });

    final result = await ref
        .read(bookSearchNotifierProvider.notifier)
        .removeFromShelf(book);

    if (!mounted) return;

    setState(() {
      _removingBooks.remove(book.id);
    });

    result.fold(
      (failure) {
        AdaptiveSnackBar.show(
          context,
          message: failure.userMessage,
          type: AdaptiveSnackBarType.error,
        );
      },
      (_) {
        AdaptiveSnackBar.show(
          context,
          message: 'マイライブラリから削除しました',
          type: AdaptiveSnackBarType.success,
        );
      },
    );
  }
}
