import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/features/book_search/data/recent_books_repository.dart';
import 'package:shelfie/features/book_search/domain/recent_book_entry.dart';

part 'recent_books_notifier.g.dart';

/// 最近チェックした本の状態管理 Notifier
///
/// 閲覧履歴リストの状態管理とビジネスロジックを提供する。
/// - 履歴追加、削除、全削除
/// - Repository 層への処理委譲
@riverpod
class RecentBooksNotifier extends _$RecentBooksNotifier {
  @override
  Future<List<RecentBookEntry>> build() async {
    final repository = ref.watch(recentBooksRepositoryProvider);
    return repository.getAll();
  }

  /// 閲覧履歴を追加する
  ///
  /// 必須フィールド（bookId, title, authors）の存在確認を行い、
  /// 不正な場合は無視する。追加後に状態を更新する。
  Future<void> addRecentBook({
    required String bookId,
    required String title,
    required List<String> authors,
    String? coverImageUrl,
  }) async {
    if (bookId.isEmpty || title.isEmpty || authors.isEmpty) {
      return;
    }

    final repository = ref.read(recentBooksRepositoryProvider);
    final entry = RecentBookEntry(
      bookId: bookId,
      title: title,
      authors: authors,
      coverImageUrl: coverImageUrl,
      viewedAt: DateTime.now(),
    );

    await repository.add(entry);
    ref.invalidateSelf();
    await future;
  }

  /// 指定した書籍IDの履歴を削除する
  Future<void> removeBook(String bookId) async {
    final repository = ref.read(recentBooksRepositoryProvider);
    await repository.remove(bookId);
    ref.invalidateSelf();
    await future;
  }

  /// 全履歴を削除する
  Future<void> clearAll() async {
    final repository = ref.read(recentBooksRepositoryProvider);
    await repository.clear();
    ref.invalidateSelf();
    await future;
  }
}
