import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/features/book_search/data/search_history_repository.dart';
import 'package:shelfie/features/book_search/domain/search_history_entry.dart';

part 'search_history_notifier.g.dart';

/// 検索履歴の状態管理 Notifier
///
/// 検索履歴リストの状態管理とビジネスロジックを提供する。
/// - 履歴追加、削除、全削除
/// - 入力クエリに部分一致する履歴のフィルタリング
/// - Repository 層への処理委譲
@riverpod
class SearchHistoryNotifier extends _$SearchHistoryNotifier {
  @override
  Future<List<SearchHistoryEntry>> build() async {
    final repository = ref.watch(searchHistoryRepositoryProvider);
    return repository.getAll();
  }

  /// 検索履歴を追加する
  ///
  /// 空文字や空白のみのクエリは無視する。
  /// 追加後に状態を更新する。
  Future<void> addHistory(String query) async {
    if (query.trim().isEmpty) {
      return;
    }

    final repository = ref.read(searchHistoryRepositoryProvider);
    final entry = SearchHistoryEntry(
      query: query,
      searchedAt: DateTime.now(),
    );

    await repository.add(entry);
    ref.invalidateSelf();
    await future;
  }

  /// 指定したクエリの履歴を削除する
  Future<void> removeHistory(String query) async {
    final repository = ref.read(searchHistoryRepositoryProvider);
    await repository.remove(query);
    ref.invalidateSelf();
    await future;
  }

  /// 全履歴を削除する
  Future<void> clearAll() async {
    final repository = ref.read(searchHistoryRepositoryProvider);
    await repository.clear();
    ref.invalidateSelf();
    await future;
  }

  /// クエリに部分一致する履歴を取得する
  ///
  /// 大文字小文字を区別せずにフィルタリングする。
  /// 空クエリの場合は全履歴を返す。
  /// 結果は新しい順でソートされている。
  List<SearchHistoryEntry> getFilteredHistory(String query) {
    final currentState = state.valueOrNull;
    if (currentState == null) {
      return [];
    }

    if (query.isEmpty) {
      return currentState;
    }

    final lowerQuery = query.toLowerCase();
    return currentState
        .where((entry) => entry.query.toLowerCase().contains(lowerQuery))
        .toList();
  }
}
