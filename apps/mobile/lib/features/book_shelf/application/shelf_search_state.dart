import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';

part 'shelf_search_state.freezed.dart';

@freezed
sealed class ShelfSearchState with _$ShelfSearchState {
  const factory ShelfSearchState.initial() = ShelfSearchInitial;
  const factory ShelfSearchState.loading() = ShelfSearchLoading;
  const factory ShelfSearchState.loaded({
    required List<ShelfBookItem> books,
    required bool hasMore,
    required bool isLoadingMore,
    required int totalCount,
  }) = ShelfSearchLoaded;
  const factory ShelfSearchState.error({
    required Failure failure,
  }) = ShelfSearchError;
}

extension ShelfSearchLoadedX on ShelfSearchLoaded {
  bool get isEmpty => books.isEmpty;
  bool get canLoadMore => hasMore && !isLoadingMore;
}
