import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/features/book_shelf/application/book_shelf_state.dart';
import 'package:shelfie/features/book_shelf/data/book_shelf_repository.dart';
import 'package:shelfie/features/book_shelf/domain/group_option.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/book_shelf/domain/sort_option.dart';

part 'book_shelf_notifier.g.dart';

/// 本棚画面の状態管理 Notifier
///
/// サーバーサイドでのソート・ページネーション、
/// クライアント側でのグループ化を担当する。
@riverpod
class BookShelfNotifier extends _$BookShelfNotifier {
  static const int _pageSize = 20;

  SortOption _sortOption = SortOption.defaultOption;
  GroupOption _groupOption = GroupOption.defaultOption;
  int _currentOffset = 0;
  List<ShelfBookItem> _allBooks = [];

  @override
  BookShelfState build() {
    return const BookShelfState.initial();
  }

  /// 初期化 - 本棚データを取得
  Future<void> initialize() async {
    state = const BookShelfState.loading();
    _currentOffset = 0;
    _allBooks = [];

    await _fetchBooks();
  }

  /// ソートオプションを設定
  Future<void> setSortOption(SortOption option) async {
    _sortOption = option;
    _currentOffset = 0;
    _allBooks = [];
    state = const BookShelfState.loading();

    await _fetchBooks();
  }

  /// グループ化オプションを設定（クライアント側のみ）
  void setGroupOption(GroupOption option) {
    if (state is! BookShelfLoaded) return;

    _groupOption = option;
    final currentState = state as BookShelfLoaded;

    state = currentState.copyWith(
      groupOption: option,
      groupedBooks: _groupBooks(currentState.books, option),
    );
  }

  /// 次のページを取得（無限スクロール用）
  Future<void> loadMore() async {
    if (state is! BookShelfLoaded) return;

    final currentState = state as BookShelfLoaded;
    if (!currentState.canLoadMore) return;

    state = currentState.copyWith(isLoadingMore: true);

    _currentOffset += _pageSize;
    await _fetchBooks(isLoadMore: true);
  }

  /// データを再取得（最初のページから）
  Future<void> refresh() async {
    _currentOffset = 0;
    _allBooks = [];
    state = const BookShelfState.loading();

    await _fetchBooks();
  }

  Future<void> _fetchBooks({bool isLoadMore = false}) async {
    final repository = ref.read(bookShelfRepositoryProvider);

    final result = await repository.getMyShelf(
      sortBy: _sortOption.sortField,
      sortOrder: _sortOption.sortOrder,
      limit: _pageSize,
      offset: _currentOffset,
    );

    result.fold(
      (failure) {
        state = BookShelfState.error(failure: failure);
      },
      (myShelfResult) {
        if (isLoadMore) {
          _allBooks = [..._allBooks, ...myShelfResult.items];
        } else {
          _allBooks = myShelfResult.items;
        }

        // ShelfState（SSOT）に状態情報を同期
        _syncToShelfState(myShelfResult.entries);

        state = BookShelfState.loaded(
          books: _allBooks,
          sortOption: _sortOption,
          groupOption: _groupOption,
          groupedBooks: _groupBooks(_allBooks, _groupOption),
          hasMore: myShelfResult.hasMore,
          isLoadingMore: false,
          totalCount: myShelfResult.totalCount,
        );
      },
    );
  }

  /// ShelfState（SSOT）にデータを同期
  void _syncToShelfState(Map<String, ShelfEntry> entries) {
    final shelfNotifier = ref.read(shelfStateProvider.notifier);
    for (final entry in entries.values) {
      shelfNotifier.registerEntry(entry);
    }
  }

  /// クライアント側でのグルーピング
  Map<String, List<ShelfBookItem>> _groupBooks(
    List<ShelfBookItem> books,
    GroupOption option,
  ) {
    if (option == GroupOption.none) {
      return {};
    }

    // shelfStateProvider から状態情報を取得
    final shelfState = ref.read(shelfStateProvider);
    final grouped = <String, List<ShelfBookItem>>{};

    for (final book in books) {
      final String key;
      switch (option) {
        case GroupOption.none:
          continue;
        case GroupOption.byStatus:
          final entry = shelfState[book.externalId];
          key = entry?.readingStatus.displayName ?? '不明';
        case GroupOption.byAuthor:
          key = book.primaryAuthor.isEmpty ? '著者不明' : book.primaryAuthor;
      }

      grouped.putIfAbsent(key, () => []).add(book);
    }

    return grouped;
  }
}
