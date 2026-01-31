import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_shelf/application/status_section_state.dart';
import 'package:shelfie/features/book_shelf/data/book_shelf_repository.dart';

part 'status_section_notifier.g.dart';

GReadingStatus _toGReadingStatus(ReadingStatus status) {
  return switch (status) {
    ReadingStatus.reading => GReadingStatus.READING,
    ReadingStatus.backlog => GReadingStatus.BACKLOG,
    ReadingStatus.completed => GReadingStatus.COMPLETED,
    ReadingStatus.dropped => GReadingStatus.DROPPED,
  };
}

@riverpod
class StatusSectionNotifier extends _$StatusSectionNotifier {
  static const int _pageSize = 20;

  @override
  StatusSectionState build(ReadingStatus status) {
    return const StatusSectionState.initial();
  }

  Future<void> initialize() async {
    state = const StatusSectionState.loading();

    final repository = ref.read(bookShelfRepositoryProvider);
    final result = await repository.getMyShelf(
      readingStatus: _toGReadingStatus(status),
      limit: _pageSize,
      offset: 0,
    );

    result.fold(
      (failure) => state = StatusSectionState.error(failure: failure),
      (data) {
        _syncToShelfState(data.entries);
        state = StatusSectionState.loaded(
          books: data.items,
          totalCount: data.totalCount,
          hasMore: data.hasMore,
          isLoadingMore: false,
        );
      },
    );
  }

  Future<void> loadMore() async {
    final current = state;
    if (current is! StatusSectionLoaded) return;
    if (!current.hasMore || current.isLoadingMore) return;

    state = current.copyWith(isLoadingMore: true);

    final repository = ref.read(bookShelfRepositoryProvider);
    final result = await repository.getMyShelf(
      readingStatus: _toGReadingStatus(status),
      limit: _pageSize,
      offset: current.books.length,
    );

    result.fold(
      (failure) => state = current.copyWith(isLoadingMore: false),
      (data) {
        _syncToShelfState(data.entries);
        state = StatusSectionState.loaded(
          books: [...current.books, ...data.items],
          totalCount: data.totalCount,
          hasMore: data.hasMore,
          isLoadingMore: false,
        );
      },
    );
  }

  Future<void> refresh() async {
    final repository = ref.read(bookShelfRepositoryProvider);
    final result = await repository.getMyShelf(
      readingStatus: _toGReadingStatus(status),
      limit: _pageSize,
      offset: 0,
    );

    result.fold(
      (failure) => state = StatusSectionState.error(failure: failure),
      (data) {
        _syncToShelfState(data.entries);
        state = StatusSectionState.loaded(
          books: data.items,
          totalCount: data.totalCount,
          hasMore: data.hasMore,
          isLoadingMore: false,
        );
      },
    );
  }

  void removeBook(String externalId) {
    final current = state;
    if (current is! StatusSectionLoaded) return;

    final updatedBooks =
        current.books.where((b) => b.externalId != externalId).toList();
    state = current.copyWith(
      books: updatedBooks,
      totalCount: current.totalCount - 1,
    );
  }

  Future<void> retry() async {
    await initialize();
  }

  void _syncToShelfState(Map<String, ShelfEntry> entries) {
    final shelfNotifier = ref.read(shelfStateProvider.notifier);
    for (final entry in entries.entries) {
      shelfNotifier.registerEntry(entry.value);
    }
  }
}
