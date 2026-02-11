import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';

part 'profile_books_state.freezed.dart';

@freezed
class ProfileBooksState with _$ProfileBooksState {
  const factory ProfileBooksState({
    @Default([]) List<ShelfBookItem> books,
    @Default(null) ReadingStatus? selectedFilter,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasMore,
    @Default(0) int totalCount,
    @Default(null) String? error,
  }) = _ProfileBooksState;
}
