import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';

part 'status_section_state.freezed.dart';

@freezed
sealed class StatusSectionState with _$StatusSectionState {
  const factory StatusSectionState.initial() = StatusSectionInitial;

  const factory StatusSectionState.loading() = StatusSectionLoading;

  const factory StatusSectionState.loaded({
    required List<ShelfBookItem> books,
    required int totalCount,
    required bool hasMore,
    required bool isLoadingMore,
  }) = StatusSectionLoaded;

  const factory StatusSectionState.error({
    required Failure failure,
  }) = StatusSectionError;
}
