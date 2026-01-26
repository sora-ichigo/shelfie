import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart'
    show BookSource;

part 'book_detail.freezed.dart';

/// 書籍の詳細情報を表すエンティティ
///
/// Google Books API から取得した書籍情報を保持する。
/// 読書記録（本棚状態）は ShelfState で管理される。
@freezed
class BookDetail with _$BookDetail {
  const factory BookDetail({
    /// 書籍 ID（Google Books ID）
    required String id,

    /// タイトル
    required String title,

    /// 著者リスト
    required List<String> authors,

    /// ソース（rakuten or google）
    @Default(BookSource.rakuten) BookSource source,

    /// 出版社
    String? publisher,

    /// 発売日
    String? publishedDate,

    /// ページ数
    int? pageCount,

    /// カテゴリ（ジャンル）リスト
    List<String>? categories,

    /// 書籍の説明文
    String? description,

    /// ISBN
    String? isbn,

    /// 表紙画像 URL
    String? thumbnailUrl,

    /// Amazon URL
    String? amazonUrl,

    /// 楽天ブックス URL
    String? rakutenBooksUrl,
  }) = _BookDetail;
}
