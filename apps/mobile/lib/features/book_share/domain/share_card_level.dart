/// 読了カードのレベルを表す enum
///
/// プログレッシブデザインの3段階カードに対応する。
/// ユーザーのデータ状態に応じて利用可能なレベルが変わる。
enum ShareCardLevel {
  /// シンプル: 表紙 + タイトル + 著者名 + Shelfie ロゴ
  simple,

  /// プロフィール付き: シンプル + ユーザーアイコン + 星評価 + 読了日
  profile,

  /// 感想共有: プロフィール付き + 読書メモ
  review;

  String get displayName {
    switch (this) {
      case ShareCardLevel.simple:
        return 'シンプル';
      case ShareCardLevel.profile:
        return 'プロフィール付き';
      case ShareCardLevel.review:
        return '感想共有';
    }
  }
}
