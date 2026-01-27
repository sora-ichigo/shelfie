import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';

part 'book_list_state.freezed.dart';

@freezed
sealed class BookListState with _$BookListState {
  const factory BookListState.initial() = BookListInitial;

  const factory BookListState.loading() = BookListLoading;

  const factory BookListState.loaded({
    required List<BookListSummary> lists,
    required int totalCount,
    required bool hasMore,
  }) = BookListLoaded;

  const factory BookListState.error({
    required Failure failure,
  }) = BookListError;
}

extension BookListLoadedX on BookListLoaded {
  bool get isEmpty => lists.isEmpty;
}

@freezed
sealed class BookListDetailState with _$BookListDetailState {
  const factory BookListDetailState.initial() = BookListDetailInitial;

  const factory BookListDetailState.loading() = BookListDetailLoading;

  const factory BookListDetailState.loaded({
    required BookListDetail list,
  }) = BookListDetailLoaded;

  const factory BookListDetailState.error({
    required Failure failure,
  }) = BookListDetailError;
}
