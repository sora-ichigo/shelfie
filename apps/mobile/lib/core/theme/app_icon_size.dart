/// アプリケーション全体のアイコンサイズ定数
///
/// 一貫したデザインを提供するために、
/// 各コンテキストで使用するアイコンサイズを定義する。
abstract final class AppIconSize {
  /// 極小アイコン (12px) - 星評価（小）、インラインインジケーター
  static const double xs = 12;

  /// 小さいアイコン (16px) - インラインアイコン、テキスト横のアイコン
  static const double sm = 16;

  /// 中サイズアイコン (20px) - リストアイテム、ボタン内アイコン
  static const double md = 20;

  /// 基本サイズアイコン (24px) - デフォルトアイコンサイズ
  static const double base = 24;

  /// 大きいアイコン (32px) - ナビゲーション、強調アイコン
  static const double lg = 32;

  /// 特大アイコン (40px) - プレースホルダー、フィーチャーアイコン
  static const double xl = 40;

  /// 超特大アイコン (48px) - 星評価モーダル、アクションアイコン
  static const double xxl = 48;

  /// 最大アイコン (64px) - 空状態表示、ヒーローアイコン
  static const double xxxl = 64;
}
