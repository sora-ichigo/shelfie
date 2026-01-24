import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_history_entry.freezed.dart';
part 'search_history_entry.g.dart';

/// 検索履歴エントリを表すイミュータブルなデータモデル
///
/// ユーザーが過去に実行した検索クエリと検索日時を保持する。
/// Hive Box に JSON 形式で永続化される。
@freezed
class SearchHistoryEntry with _$SearchHistoryEntry {
  const factory SearchHistoryEntry({
    /// 検索クエリ文字列
    required String query,

    /// 検索を実行した日時
    required DateTime searchedAt,
  }) = _SearchHistoryEntry;

  factory SearchHistoryEntry.fromJson(Map<String, dynamic> json) =>
      _$SearchHistoryEntryFromJson(json);
}
