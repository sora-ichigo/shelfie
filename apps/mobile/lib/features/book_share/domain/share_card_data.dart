import 'package:freezed_annotation/freezed_annotation.dart';

part 'share_card_data.freezed.dart';

/// カード描画に必要なデータを集約した型
///
/// BookDetail と ShelfEntry から必要な情報を抽出し、
/// カード Widget の描画に必要なデータのみを保持する。
@freezed
class ShareCardData with _$ShareCardData {
  const factory ShareCardData({
    /// 書籍タイトル
    required String title,

    /// 著者名リスト
    required List<String> authors,

    /// 表紙画像 URL（null の場合はプレースホルダー）
    String? thumbnailUrl,

    /// ユーザー名
    String? userName,

    /// ユーザーアバター URL
    String? avatarUrl,

    /// 星評価（1-5、null は未設定）
    int? rating,

    /// 読了日
    DateTime? completedAt,

    /// 読書メモ
    String? note,
  }) = _ShareCardData;
}
