import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/core/state/shelf_version.dart';
import 'package:shelfie/features/account/application/profile_books_state.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_shelf/application/sort_option_notifier.dart';
import 'package:shelfie/features/book_shelf/data/book_shelf_repository.dart';

part 'profile_books_notifier.g.dart';

const _pageSize = 30;

GReadingStatus _toGReadingStatus(ReadingStatus status) {
  return switch (status) {
    ReadingStatus.reading => GReadingStatus.READING,
    ReadingStatus.backlog => GReadingStatus.BACKLOG,
    ReadingStatus.completed => GReadingStatus.COMPLETED,
    ReadingStatus.interested => GReadingStatus.INTERESTED,
  };
}

@riverpod
class ProfileBooksNotifier extends _$ProfileBooksNotifier {
  ProfileBooksState? _cachedState;

  void _emit(ProfileBooksState newState) {
    _cachedState = newState;
    state = newState;
  }

  @override
  ProfileBooksState build() {
    ref.watch(shelfVersionProvider);

    final cached = _cachedState;
    if (cached != null) {
      Future.microtask(refresh);
      return cached;
    }

    Future.microtask(_loadBooks);
    return const ProfileBooksState(isLoading: true);
  }

  Future<void> _loadBooks() async {
    final repository = ref.read(bookShelfRepositoryProvider);
    final sortOption = ref.read(sortOptionNotifierProvider);
    final filter = state.selectedFilter;

    _emit(state.copyWith(isLoading: true, error: null));

    final result = await repository.getMyShelf(
      readingStatus: filter != null ? _toGReadingStatus(filter) : null,
      sortBy: sortOption.sortField,
      sortOrder: sortOption.sortOrder,
      limit: _pageSize,
      offset: 0,
    );

    result.fold(
      (failure) => _emit(state.copyWith(
        isLoading: false,
        error: failure.message,
      )),
      (data) {
        final shelfNotifier = ref.read(shelfStateProvider.notifier);
        for (final entry in data.entries.entries) {
          shelfNotifier.registerEntry(entry.value);
        }

        _emit(state.copyWith(
          books: data.items,
          totalCount: data.totalCount,
          hasMore: data.hasMore,
          isLoading: false,
        ));
      },
    );
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;

    _emit(state.copyWith(isLoadingMore: true));

    final repository = ref.read(bookShelfRepositoryProvider);
    final sortOption = ref.read(sortOptionNotifierProvider);
    final filter = state.selectedFilter;

    final result = await repository.getMyShelf(
      readingStatus: filter != null ? _toGReadingStatus(filter) : null,
      sortBy: sortOption.sortField,
      sortOrder: sortOption.sortOrder,
      limit: _pageSize,
      offset: state.books.length,
    );

    result.fold(
      (failure) => _emit(state.copyWith(isLoadingMore: false)),
      (data) {
        final shelfNotifier = ref.read(shelfStateProvider.notifier);
        for (final entry in data.entries.entries) {
          shelfNotifier.registerEntry(entry.value);
        }

        _emit(state.copyWith(
          books: [...state.books, ...data.items],
          hasMore: data.hasMore,
          isLoadingMore: false,
        ));
      },
    );
  }

  Future<void> refresh() async {
    final repository = ref.read(bookShelfRepositoryProvider);
    final sortOption = ref.read(sortOptionNotifierProvider);
    final filter = state.selectedFilter;

    final result = await repository.getMyShelf(
      readingStatus: filter != null ? _toGReadingStatus(filter) : null,
      sortBy: sortOption.sortField,
      sortOrder: sortOption.sortOrder,
      limit: _pageSize,
      offset: 0,
    );

    result.fold(
      (failure) => _emit(state.copyWith(error: failure.message)),
      (data) {
        final shelfNotifier = ref.read(shelfStateProvider.notifier);
        for (final entry in data.entries.entries) {
          shelfNotifier.registerEntry(entry.value);
        }

        _emit(state.copyWith(
          books: data.items,
          totalCount: data.totalCount,
          hasMore: data.hasMore,
        ));
      },
    );
  }

  Future<void> setFilter(ReadingStatus? filter) async {
    if (state.selectedFilter == filter) return;
    _emit(state.copyWith(selectedFilter: filter, books: []));
    await _loadBooks();
  }
}
