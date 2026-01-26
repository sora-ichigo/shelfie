import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart'
    show BookSource;

part 'shelf_book_item.freezed.dart';

/// 本棚画面表示用の書籍モデル
///
/// 書籍の基本情報のみを保持する表示用モデル。
/// 読書状態（readingStatus, rating 等）は shelfStateProvider から取得する。
/// イミュータブルで、freezed によるコード生成を使用。
@freezed
class ShelfBookItem with _$ShelfBookItem {
  const ShelfBookItem._();

  const factory ShelfBookItem({
    /// ユーザーの本棚エントリID
    required int userBookId,

    /// 外部ID（楽天ブックスID など）
    required String externalId,

    /// 書籍タイトル
    required String title,

    /// 著者リスト
    required List<String> authors,

    /// 書籍のソース（rakuten or google）
    @Default(BookSource.rakuten) BookSource source,

    /// 本棚への追加日時
    required DateTime addedAt,

    /// 表紙画像のURL
    String? coverImageUrl,
  }) = _ShelfBookItem;

  /// 最初の著者を取得
  ///
  /// グループ化「著者別」で使用。
  /// 著者がいない場合は空文字列を返す。
  String get primaryAuthor => authors.isNotEmpty ? authors.first : '';

  /// 著者の表示用文字列を取得
  ///
  /// 複数著者の場合はカンマ区切りで結合。
  String get authorsDisplay => authors.join(', ');

  /// 表紙画像があるかどうか
  bool get hasCoverImage =>
      coverImageUrl != null && coverImageUrl!.isNotEmpty;
}
