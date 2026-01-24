import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/features/book_search/domain/recent_book_entry.dart';

part 'recent_books_repository.g.dart';

/// 最近チェックした本用 Hive Box の名前
const String recentBooksBoxName = 'recent_books';

/// 最近チェックした本の最大保持件数
const int maxRecentBooksCount = 10;

/// 最近チェックした本リポジトリのインターフェース
abstract interface class RecentBooksRepositoryInterface {
  /// 全ての閲覧履歴を新しい順で取得
  Future<List<RecentBookEntry>> getAll();

  /// 閲覧履歴を追加（重複時は更新、10件超過時は古いものを削除）
  Future<void> add(RecentBookEntry entry);

  /// 指定した書籍 ID の履歴を削除
  Future<void> remove(String bookId);

  /// 全履歴を削除
  Future<void> clear();
}

/// 最近チェックした本リポジトリの実装
///
/// Hive Box を使用して閲覧履歴を永続化する。
/// - 最大10件の履歴を保持
/// - 重複する書籍IDは日時を更新
/// - 取得時は新しい順でソート
class RecentBooksRepository implements RecentBooksRepositoryInterface {
  RecentBooksRepository(this._box);

  final Box<Map<dynamic, dynamic>> _box;

  @override
  Future<List<RecentBookEntry>> getAll() async {
    final entries = <RecentBookEntry>[];

    for (final key in _box.keys) {
      final value = _box.get(key);
      if (value != null) {
        final json = Map<String, dynamic>.from(value);
        entries.add(RecentBookEntry.fromJson(json));
      }
    }

    entries.sort((a, b) => b.viewedAt.compareTo(a.viewedAt));
    return entries;
  }

  @override
  Future<void> add(RecentBookEntry entry) async {
    await _box.put(entry.bookId, entry.toJson());

    if (_box.length > maxRecentBooksCount) {
      await _removeOldestEntries();
    }
  }

  @override
  Future<void> remove(String bookId) async {
    await _box.delete(bookId);
  }

  @override
  Future<void> clear() async {
    await _box.clear();
  }

  Future<void> _removeOldestEntries() async {
    final entries = await getAll();

    if (entries.length > maxRecentBooksCount) {
      final entriesToRemove = entries.sublist(maxRecentBooksCount);
      for (final entry in entriesToRemove) {
        await _box.delete(entry.bookId);
      }
    }
  }
}

/// 最近チェックした本リポジトリの Provider
@Riverpod(keepAlive: true)
RecentBooksRepository recentBooksRepository(
  RecentBooksRepositoryRef ref,
) {
  final box = Hive.box<Map<dynamic, dynamic>>(recentBooksBoxName);
  return RecentBooksRepository(box);
}
