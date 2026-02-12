import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';

part 'shelf_entry.freezed.dart';

/// 本棚エントリを表すエンティティ（SSOT）
///
/// 本棚に追加された書籍の読書状態を一元管理する。
/// ShelfState の値として使用される。
@freezed
class ShelfEntry with _$ShelfEntry {
  const ShelfEntry._();

  const factory ShelfEntry({
    /// 読書記録の ID（userBookId）
    required int userBookId,

    /// 外部 ID（Google Books ID など）
    required String externalId,

    /// 読書状態
    required ReadingStatus readingStatus,

    /// 本棚に追加した日時
    required DateTime addedAt,

    /// 読書開始日（readingStatus が reading に変更された初回のみ設定）
    DateTime? startedAt,

    /// 読了日（readingStatus が completed の場合のみ設定）
    DateTime? completedAt,

    /// 読書メモ
    String? note,

    /// メモの最終更新日時
    DateTime? noteUpdatedAt,

    /// 評価（1-5）
    int? rating,

    /// 感想
    String? thoughts,

    /// 感想の最終更新日時
    DateTime? thoughtsUpdatedAt,
  }) = _ShelfEntry;

  /// メモが存在するかどうか
  bool get hasNote => note != null && note!.trim().isNotEmpty;

  /// 感想が存在するかどうか
  bool get hasThoughts => thoughts != null && thoughts!.trim().isNotEmpty;

  /// 読了済みかどうか
  bool get isCompleted => readingStatus == ReadingStatus.completed;
}
