import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';

part 'user_book.freezed.dart';

/// ユーザーの読書記録を表すエンティティ
///
/// 本棚に追加された書籍に関する読書状態、読了日、メモなどを保持する。
@freezed
class UserBook with _$UserBook {
  const UserBook._();

  const factory UserBook({
    /// 読書記録の ID
    required int id,

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
  }) = _UserBook;

  /// メモが存在するかどうか
  ///
  /// note が null でなく、空白文字以外の内容がある場合に true を返す。
  bool get hasNote => note != null && note!.trim().isNotEmpty;

  /// 読了済みかどうか
  bool get isCompleted => readingStatus == ReadingStatus.completed;
}
