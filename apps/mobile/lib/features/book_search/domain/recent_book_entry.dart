import 'package:freezed_annotation/freezed_annotation.dart';

part 'recent_book_entry.freezed.dart';
part 'recent_book_entry.g.dart';

/// 最近チェックした本のエントリを表すイミュータブルなデータモデル
///
/// ユーザーが本詳細画面で閲覧した書籍の情報と閲覧日時を保持する。
/// Hive Box に JSON 形式で永続化される。
@freezed
class RecentBookEntry with _$RecentBookEntry {
  const factory RecentBookEntry({
    /// 書籍 ID（外部 API の識別子）
    required String bookId,

    /// 書籍タイトル
    required String title,

    /// 著者リスト
    required List<String> authors,

    /// カバー画像 URL（取得できない場合は null）
    String? coverImageUrl,

    /// 閲覧した日時
    required DateTime viewedAt,
  }) = _RecentBookEntry;

  factory RecentBookEntry.fromJson(Map<String, dynamic> json) =>
      _$RecentBookEntryFromJson(json);
}
