import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/state/shelf_version.dart';
import 'package:shelfie/features/book_search/domain/author_count.dart';
import 'package:shelfie/features/book_shelf/data/book_shelf_repository.dart';

part 'shelf_authors_notifier.g.dart';

/// 本棚の著者を冊数順で提供するプロバイダー
///
/// 本棚データから著者を抽出し、冊数が多い順にソートして返す。
/// 本棚の変更（shelfVersion）を監視して自動更新する。
@Riverpod(keepAlive: true)
class ShelfAuthors extends _$ShelfAuthors {
  static const int _fetchLimit = 200;

  @override
  Future<List<AuthorCount>> build() async {
    ref.listen(shelfVersionProvider, (prev, next) {
      if (prev != null && prev != next) {
        ref.invalidateSelf();
      }
    });

    final repository = ref.read(bookShelfRepositoryProvider);
    final result = await repository.getMyShelf(limit: _fetchLimit);

    return result.fold(
      (_) => [],
      (myShelfResult) => extractAuthorsFromShelf(myShelfResult.items),
    );
  }
}
