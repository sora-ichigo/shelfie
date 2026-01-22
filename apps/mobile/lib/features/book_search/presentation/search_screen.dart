import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/empty_state.dart';
import 'package:shelfie/core/widgets/error_view.dart';
import 'package:shelfie/core/widgets/loading_indicator.dart';
import 'package:shelfie/core/widgets/screen_header.dart';
import 'package:shelfie/features/book_search/application/book_search_notifier.dart';
import 'package:shelfie/features/book_search/application/book_search_state.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart';
import 'package:shelfie/features/book_search/presentation/isbn_scan_screen.dart';
import 'package:shelfie/features/book_search/presentation/widgets/book_list_item.dart';
import 'package:shelfie/features/book_search/presentation/widgets/isbn_scan_result_dialog.dart';
import 'package:shelfie/features/book_search/presentation/widgets/search_bar_widget.dart';
import 'package:shelfie/routing/app_router.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _searchController = TextEditingController();
  final _addingBooks = <String>{};

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bookSearchNotifierProvider);

    ref.listen<BookSearchState>(
      bookSearchNotifierProvider,
      (previous, next) {
        if (next is BookSearchError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.failure.userMessage),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      },
    );

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenHeader(
            title: '検索',
            onProfileTap: () => context.push(AppRoutes.account),
          ),
          Padding(
            padding: AppSpacing.vertical(AppSpacing.sm),
            child: SearchBarWidget(
              controller: _searchController,
              onChanged: _onSearchChanged,
              onScanPressed: _onScanPressed,
            ),
          ),
          Expanded(
            child: _buildBody(state),
          ),
        ],
      ),
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
    return const EmptyState(
      icon: Icons.search,
      message: '書籍を検索してください',
    );
  }

  Widget _buildSuccessList(
    List<Book> books, {
    required bool hasMore,
    required bool isLoadingMore,
  }) {
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
        itemCount: books.length + (isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == books.length) {
            return const Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final book = books[index];
          return BookListItem(
            book: book,
            onAddPressed: () => _onAddToShelf(book),
            isAddingToShelf: _addingBooks.contains(book.id),
          );
        },
      ),
    );
  }

  void _onSearchChanged(String query) {
    ref.read(bookSearchNotifierProvider.notifier).searchBooksWithDebounce(query);
  }

  Future<void> _onScanPressed() async {
    final isbn = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => const ISBNScanScreen(),
      ),
    );

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

  Future<void> _onAddToShelf(Book book) async {
    if (_addingBooks.contains(book.id)) return;

    setState(() {
      _addingBooks.add(book.id);
    });

    final result =
        await ref.read(bookSearchNotifierProvider.notifier).addToShelf(book);

    if (!mounted) return;

    setState(() {
      _addingBooks.remove(book.id);
    });

    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.userMessage),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      },
      (userBook) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('「${book.title}」を本棚に追加しました'),
          ),
        );
      },
    );
  }
}
