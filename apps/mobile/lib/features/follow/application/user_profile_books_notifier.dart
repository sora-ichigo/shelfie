import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_shelf/data/book_shelf_repository.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/follow/application/user_profile_sort_option_notifier.dart';

part 'user_profile_books_notifier.g.dart';

class UserProfileBooksState {
  const UserProfileBooksState({
    this.books = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = false,
    this.totalCount = 0,
    this.selectedFilter,
    this.error,
  });

  final List<ShelfBookItem> books;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final int totalCount;
  final ReadingStatus? selectedFilter;
  final Failure? error;

  bool get canLoadMore => hasMore && !isLoadingMore;

  UserProfileBooksState copyWith({
    List<ShelfBookItem>? books,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    int? totalCount,
    ReadingStatus? Function()? selectedFilter,
    Failure? error,
  }) {
    return UserProfileBooksState(
      books: books ?? this.books,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      totalCount: totalCount ?? this.totalCount,
      selectedFilter:
          selectedFilter != null ? selectedFilter() : this.selectedFilter,
      error: error,
    );
  }
}

GReadingStatus _toGReadingStatus(ReadingStatus status) {
  return switch (status) {
    ReadingStatus.reading => GReadingStatus.READING,
    ReadingStatus.backlog => GReadingStatus.BACKLOG,
    ReadingStatus.completed => GReadingStatus.COMPLETED,
    ReadingStatus.interested => GReadingStatus.INTERESTED,
  };
}

@riverpod
class UserProfileBooksNotifier extends _$UserProfileBooksNotifier {
  static const int _pageSize = 20;
  int _currentOffset = 0;
  List<ShelfBookItem> _allBooks = [];

  @override
  UserProfileBooksState build(int userId) {
    Future.microtask(_fetchBooks);
    return const UserProfileBooksState(isLoading: true);
  }

  Future<void> loadMore() async {
    if (!state.canLoadMore) return;

    state = state.copyWith(isLoadingMore: true);
    _currentOffset += _pageSize;
    await _fetchBooks(isLoadMore: true);
  }

  Future<void> setFilter(ReadingStatus? filter) async {
    if (state.selectedFilter == filter) return;
    _currentOffset = 0;
    _allBooks = [];
    state = state.copyWith(
      selectedFilter: () => filter,
      books: [],
    );
    await _fetchBooks();
  }

  Future<void> _fetchBooks({bool isLoadMore = false}) async {
    final repository = ref.read(bookShelfRepositoryProvider);
    final sortOption = ref.read(userProfileSortOptionNotifierProvider(userId));
    final filter = state.selectedFilter;

    if (!isLoadMore) {
      state = state.copyWith(isLoading: true);
    }

    final result = await repository.getUserShelf(
      userId: userId,
      readingStatus: filter != null ? _toGReadingStatus(filter) : null,
      sortBy: sortOption.sortField,
      sortOrder: sortOption.sortOrder,
      limit: _pageSize,
      offset: _currentOffset,
    );

    result.fold(
      (failure) {
        state = UserProfileBooksState(
          selectedFilter: state.selectedFilter,
          error: failure,
        );
      },
      (shelfResult) {
        if (isLoadMore) {
          _allBooks = [..._allBooks, ...shelfResult.items];
        } else {
          _allBooks = shelfResult.items;
        }

        state = UserProfileBooksState(
          books: _allBooks,
          hasMore: shelfResult.hasMore,
          totalCount: shelfResult.totalCount,
          selectedFilter: state.selectedFilter,
        );
      },
    );
  }
}
