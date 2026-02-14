import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/features/book_shelf/application/shelf_search_state.dart';
import 'package:shelfie/features/book_shelf/application/sort_option_notifier.dart';
import 'package:shelfie/features/book_shelf/data/book_shelf_repository.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/follow/application/user_profile_sort_option_notifier.dart';

part 'shelf_search_notifier.g.dart';

@riverpod
class ShelfSearchNotifier extends _$ShelfSearchNotifier {
  static const int _pageSize = 10;

  int _currentOffset = 0;
  List<ShelfBookItem> _allBooks = [];
  String? _currentQuery;

  @override
  ShelfSearchState build({int? userId}) {
    return const ShelfSearchState.initial();
  }

  Future<void> search(String query) async {
    if (query.isEmpty) {
      _currentQuery = null;
      _currentOffset = 0;
      _allBooks = [];
      state = const ShelfSearchState.initial();
      return;
    }

    _currentQuery = query;
    _currentOffset = 0;
    _allBooks = [];
    state = const ShelfSearchState.loading();

    await _fetchBooks();
  }

  Future<void> loadMore() async {
    if (state is! ShelfSearchLoaded) return;

    final currentState = state as ShelfSearchLoaded;
    if (!currentState.canLoadMore) return;

    state = currentState.copyWith(isLoadingMore: true);

    _currentOffset += _pageSize;
    await _fetchBooks(isLoadMore: true);
  }

  Future<void> _fetchBooks({bool isLoadMore = false}) async {
    final repository = ref.read(bookShelfRepositoryProvider);

    final result = userId != null
        ? await repository.getUserShelf(
            userId: userId!,
            query: _currentQuery,
            sortBy: ref.read(userProfileSortOptionNotifierProvider(userId!)).sortField,
            sortOrder: ref.read(userProfileSortOptionNotifierProvider(userId!)).sortOrder,
            limit: _pageSize,
            offset: _currentOffset,
          )
        : await repository.getMyShelf(
            query: _currentQuery,
            sortBy: ref.read(sortOptionNotifierProvider).sortField,
            sortOrder: ref.read(sortOptionNotifierProvider).sortOrder,
            limit: _pageSize,
            offset: _currentOffset,
          );

    result.fold(
      (failure) {
        state = ShelfSearchState.error(failure: failure);
      },
      (myShelfResult) {
        if (isLoadMore) {
          _allBooks = [..._allBooks, ...myShelfResult.items];
        } else {
          _allBooks = myShelfResult.items;
        }

        if (userId == null) {
          _syncToShelfState(myShelfResult.entries);
        }

        state = ShelfSearchState.loaded(
          books: _allBooks,
          hasMore: myShelfResult.hasMore,
          isLoadingMore: false,
          totalCount: myShelfResult.totalCount,
        );
      },
    );
  }

  void _syncToShelfState(Map<String, ShelfEntry> entries) {
    final shelfNotifier = ref.read(shelfStateProvider.notifier);
    for (final entry in entries.values) {
      shelfNotifier.registerEntry(entry);
    }
  }
}
