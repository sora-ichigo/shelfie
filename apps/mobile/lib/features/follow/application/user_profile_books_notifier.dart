import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/features/book_shelf/data/book_shelf_repository.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';

part 'user_profile_books_notifier.g.dart';

class UserProfileBooksState {
  const UserProfileBooksState({
    this.books = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = false,
    this.totalCount = 0,
    this.error,
  });

  final List<ShelfBookItem> books;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final int totalCount;
  final Failure? error;

  bool get canLoadMore => hasMore && !isLoadingMore;

  UserProfileBooksState copyWith({
    List<ShelfBookItem>? books,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    int? totalCount,
    Failure? error,
  }) {
    return UserProfileBooksState(
      books: books ?? this.books,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      totalCount: totalCount ?? this.totalCount,
      error: error,
    );
  }
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

  Future<void> _fetchBooks({bool isLoadMore = false}) async {
    final repository = ref.read(bookShelfRepositoryProvider);

    final result = await repository.getUserShelf(
      userId: userId,
      limit: _pageSize,
      offset: _currentOffset,
    );

    result.fold(
      (failure) {
        state = UserProfileBooksState(error: failure);
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
        );
      },
    );
  }
}
