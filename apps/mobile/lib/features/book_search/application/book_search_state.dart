import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart';

part 'book_search_state.freezed.dart';

@freezed
sealed class BookSearchState with _$BookSearchState {
  const factory BookSearchState.initial() = BookSearchInitial;

  const factory BookSearchState.loading() = BookSearchLoading;

  const factory BookSearchState.success({
    required List<Book> books,
    required int totalCount,
    required bool hasMore,
    required String currentQuery,
    required int currentOffset,
  }) = BookSearchSuccess;

  const factory BookSearchState.empty({
    required String query,
  }) = BookSearchEmpty;

  const factory BookSearchState.error({
    required Failure failure,
  }) = BookSearchError;

  const factory BookSearchState.loadingMore({
    required List<Book> books,
    required int totalCount,
    required String currentQuery,
    required int currentOffset,
  }) = BookSearchLoadingMore;
}
