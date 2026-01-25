import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/features/book_search/domain/search_history_entry.dart';

part 'search_history_repository.g.dart';

/// 検索履歴用 Hive Box の名前
const String searchHistoryBoxName = 'search_history';

/// 検索履歴の最大保持件数
const int maxSearchHistoryCount = 20;

/// 検索履歴リポジトリのインターフェース
abstract interface class SearchHistoryRepositoryInterface {
  /// 全ての検索履歴を新しい順で取得
  Future<List<SearchHistoryEntry>> getAll();

  /// 検索履歴を追加（重複時は更新、20件超過時は古いものを削除）
  Future<void> add(SearchHistoryEntry entry);

  /// 指定したクエリの履歴を削除
  Future<void> remove(String query);

  /// 全履歴を削除
  Future<void> clear();
}

/// 検索履歴リポジトリの実装
///
/// Hive Box を使用して検索履歴を永続化する。
/// - 最大20件の履歴を保持
/// - 重複するクエリは日時を更新
/// - 取得時は新しい順でソート
class SearchHistoryRepository implements SearchHistoryRepositoryInterface {
  SearchHistoryRepository(this._box);

  final Box<Map<dynamic, dynamic>> _box;

  @override
  Future<List<SearchHistoryEntry>> getAll() async {
    final entries = <SearchHistoryEntry>[];

    for (final key in _box.keys) {
      final value = _box.get(key);
      if (value != null) {
        final json = Map<String, dynamic>.from(value);
        entries.add(SearchHistoryEntry.fromJson(json));
      }
    }

    entries.sort((a, b) => b.searchedAt.compareTo(a.searchedAt));
    return entries;
  }

  @override
  Future<void> add(SearchHistoryEntry entry) async {
    await _box.put(entry.query, entry.toJson());

    if (_box.length > maxSearchHistoryCount) {
      await _removeOldestEntries();
    }
  }

  @override
  Future<void> remove(String query) async {
    await _box.delete(query);
  }

  @override
  Future<void> clear() async {
    await _box.clear();
  }

  Future<void> _removeOldestEntries() async {
    final entries = await getAll();

    if (entries.length > maxSearchHistoryCount) {
      final entriesToRemove =
          entries.sublist(maxSearchHistoryCount);
      for (final entry in entriesToRemove) {
        await _box.delete(entry.query);
      }
    }
  }
}

/// 検索履歴リポジトリの Provider
@Riverpod(keepAlive: true)
SearchHistoryRepository searchHistoryRepository(
  SearchHistoryRepositoryRef ref,
) {
  final box = Hive.box<Map<dynamic, dynamic>>(searchHistoryBoxName);
  return SearchHistoryRepository(box);
}
