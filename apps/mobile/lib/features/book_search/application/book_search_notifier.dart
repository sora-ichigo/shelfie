import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_search/application/book_search_state.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart';

part 'book_search_notifier.g.dart';

@riverpod
class BookSearchNotifier extends _$BookSearchNotifier {
  Timer? _debounceTimer;
  int _searchRequestId = 0;
  static const _debounceDuration = Duration(milliseconds: 300);
  static const _pageSize = 10;

  @override
  BookSearchState build() {
    ref.onDispose(() {
      _debounceTimer?.cancel();
    });
    return const BookSearchState.initial();
  }

  void searchBooksWithDebounce(String query) {
    _debounceTimer?.cancel();

    if (query.isEmpty) {
      state = const BookSearchState.initial();
      return;
    }

    _debounceTimer = Timer(_debounceDuration, () {
      searchBooks(query);
    });
  }

  Future<void> searchBooks(String query) async {
    if (query.isEmpty) {
      return;
    }

    final requestId = ++_searchRequestId;
    state = const BookSearchState.loading();

    final repository = ref.read(bookSearchRepositoryProvider);
    final result = await repository.searchBooks(
      query: query,
      limit: _pageSize,
      offset: 0,
    );

    if (requestId != _searchRequestId) return;

    switch (result) {
      case Left(:final value):
        state = BookSearchState.error(failure: value);
      case Right(:final value):
        if (value.items.isEmpty) {
          state = BookSearchState.empty(query: query);
        } else {
          state = BookSearchState.success(
            books: value.items,
            totalCount: value.totalCount,
            hasMore: value.hasMore,
            currentQuery: query,
            currentOffset: 0,
          );
        }
    }
  }

  Future<void> searchByISBN(String isbn) async {
    state = const BookSearchState.loading();

    final repository = ref.read(bookSearchRepositoryProvider);
    final result = await repository.searchBookByISBN(isbn: isbn);

    switch (result) {
      case Left(:final value):
        state = BookSearchState.error(failure: value);
      case Right(:final value):
        if (value == null) {
          state = BookSearchState.empty(query: isbn);
        } else {
          state = BookSearchState.success(
            books: [value],
            totalCount: 1,
            hasMore: false,
            currentQuery: isbn,
            currentOffset: 0,
          );
        }
    }
  }

  Future<Either<Failure, UserBook>> addToShelf(
    Book book, {
    ReadingStatus readingStatus = ReadingStatus.interested,
  }) async {
    return ref.read(shelfStateProvider.notifier).addToShelf(
      externalId: book.id,
      title: book.title,
      authors: book.authors,
      publisher: book.publisher,
      publishedDate: book.publishedDate,
      isbn: book.isbn,
      coverImageUrl: book.coverImageUrl,
      source: book.source,
      readingStatus: readingStatus,
    );
  }

  Future<Either<Failure, bool>> removeFromShelf(Book book) async {
    final userBookId = book.userBookId ??
        ref.read(shelfStateProvider.notifier).getUserBookId(book.id);

    if (userBookId == null) {
      return left(
        const ServerFailure(message: 'Book is not in shelf', code: 'NOT_IN_SHELF'),
      );
    }

    return ref.read(shelfStateProvider.notifier).removeFromShelf(
      externalId: book.id,
      userBookId: userBookId,
    );
  }

  Future<void> loadMore() async {
    final currentState = state;

    if (currentState is! BookSearchSuccess) {
      return;
    }

    if (!currentState.hasMore) {
      return;
    }

    final newOffset = currentState.currentOffset + _pageSize;

    state = BookSearchState.loadingMore(
      books: currentState.books,
      totalCount: currentState.totalCount,
      currentQuery: currentState.currentQuery,
      currentOffset: currentState.currentOffset,
    );

    final repository = ref.read(bookSearchRepositoryProvider);
    final result = await repository.searchBooks(
      query: currentState.currentQuery,
      limit: _pageSize,
      offset: newOffset,
    );

    switch (result) {
      case Left(:final value):
        state = BookSearchState.success(
          books: currentState.books,
          totalCount: currentState.totalCount,
          hasMore: currentState.hasMore,
          currentQuery: currentState.currentQuery,
          currentOffset: currentState.currentOffset,
        );
        state = BookSearchState.error(failure: value);
      case Right(:final value):
        final existingIsbns = <String>{
          for (final b in currentState.books)
            if (b.isbn != null) b.isbn!,
        };
        final newItems = value.items.where(
          (b) => b.isbn == null || !existingIsbns.contains(b.isbn),
        );
        state = BookSearchState.success(
          books: [...currentState.books, ...newItems],
          totalCount: value.totalCount,
          hasMore: value.hasMore,
          currentQuery: currentState.currentQuery,
          currentOffset: newOffset,
        );
    }
  }

  void reset() {
    _debounceTimer?.cancel();
    state = const BookSearchState.initial();
  }
}
