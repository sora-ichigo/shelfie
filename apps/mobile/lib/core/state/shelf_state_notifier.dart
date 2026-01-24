import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart';

part 'shelf_state_notifier.g.dart';

/// ユーザーの本棚にある本の状態を管理する
/// externalId (Google Books ID) → userBookId のマッピングを保持
@Riverpod(keepAlive: true)
class ShelfState extends _$ShelfState {
  @override
  Map<String, int> build() {
    return {};
  }

  /// 本を本棚に追加（API呼び出し + 状態更新）
  Future<Either<Failure, UserBook>> addToShelf({
    required String externalId,
    required String title,
    required List<String> authors,
    String? publisher,
    String? publishedDate,
    String? isbn,
    String? coverImageUrl,
  }) async {
    final repository = ref.read(bookSearchRepositoryProvider);
    final result = await repository.addBookToShelf(
      externalId: externalId,
      title: title,
      authors: authors,
      publisher: publisher,
      publishedDate: publishedDate,
      isbn: isbn,
      coverImageUrl: coverImageUrl,
    );

    result.fold(
      (_) {},
      (userBook) => _addBook(externalId, userBook.id),
    );

    return result;
  }

  /// 本を本棚から削除（API呼び出し + 状態更新）
  Future<Either<Failure, bool>> removeFromShelf({
    required String externalId,
    required int userBookId,
  }) async {
    final repository = ref.read(bookSearchRepositoryProvider);
    final result = await repository.removeFromShelf(
      userBookId: userBookId,
    );

    result.fold(
      (_) {},
      (_) => _removeBook(externalId),
    );

    return result;
  }

  /// 本を本棚に追加したことを記録（内部用）
  void _addBook(String externalId, int userBookId) {
    state = {...state, externalId: userBookId};
  }

  /// 本を本棚から削除したことを記録（内部用）
  void _removeBook(String externalId) {
    state = Map.from(state)..remove(externalId);
  }

  /// 外部から状態を更新する（book_detail ロード時など）
  void registerBook(String externalId, int userBookId) {
    state = {...state, externalId: userBookId};
  }

  /// 本が本棚にあるかどうか
  bool isInShelf(String externalId) {
    return state.containsKey(externalId);
  }

  /// 本の userBookId を取得（本棚にない場合は null）
  int? getUserBookId(String externalId) {
    return state[externalId];
  }
}
