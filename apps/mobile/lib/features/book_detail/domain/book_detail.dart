import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shelfie/features/book_detail/domain/user_book.dart';

part 'book_detail.freezed.dart';

/// 書籍の詳細情報を表すエンティティ
///
/// Google Books API から取得した書籍情報と、ユーザーの読書記録を保持する。
@freezed
class BookDetail with _$BookDetail {
  const BookDetail._();

  const factory BookDetail({
    /// 書籍 ID（Google Books ID）
    required String id,

    /// タイトル
    required String title,

    /// 著者リスト
    required List<String> authors,

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

    /// Google Books 情報ページ URL
    String? infoLink,

    /// ユーザーの読書記録（本棚に追加されている場合）
    UserBook? userBook,
  }) = _BookDetail;

  /// 本棚に追加済みかどうか
  bool get isInShelf => userBook != null;
}
