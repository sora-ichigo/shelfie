import 'package:flutter/material.dart';

/// アプリケーション全体のタイポグラフィ定義
///
/// Material 3 のタイポグラフィシステムに準拠したテキストスタイルを定義する。
/// 一貫したタイポグラフィを提供することで、デザインの統一性を保つ。
abstract final class AppTypography {
  // ===========================================================================
  // Display styles - ヒーローセクション、スプラッシュ画面など最も目立つテキスト
  // ===========================================================================

  /// 57px - 最大の見出し。ヒーローセクションやランディングページ用
  static const displayLarge = TextStyle(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
    height: 1.12,
  );

  /// 45px - 大きな見出し。セクションの主要タイトル用
  static const displayMedium = TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.16,
  );

  /// 36px - 中程度の見出し。重要なセクションタイトル用
  static const displaySmall = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.22,
  );

  // ===========================================================================
  // Headline styles - ページやセクションの見出し
  // ===========================================================================

  /// 32px - ページタイトル、主要な見出し
  static const headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.25,
  );

  /// 28px - セクション見出し
  static const headlineMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.29,
  );

  /// 24px - サブセクション見出し
  static const headlineSmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.33,
  );

  // ===========================================================================
  // Title styles - カード、リストアイテム、ダイアログのタイトル
  // ===========================================================================

  /// 22px - カードやダイアログのメインタイトル
  static const titleLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    height: 1.27,
  );

  /// 18px - リストアイテムのタイトル、小さなカードのタイトル
  static const titleMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.15,
    height: 1.50,
  );

  /// 14px - 補助的なタイトル、メタ情報
  static const titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.43,
  );

  // ===========================================================================
  // Body styles - 本文テキスト、説明文、段落
  // ===========================================================================

  /// 16px - メインの本文テキスト、説明文
  static const bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.50,
  );

  /// 14px - 標準の本文テキスト、リストの説明
  static const bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.43,
  );

  /// 12px - 補足テキスト、キャプション、利用規約など
  static const bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.33,
  );

  // ===========================================================================
  // Label styles - ボタン、タブ、チップ、フォームラベルなどのUI要素
  // ===========================================================================

  /// 16px - ボタン、タブ、ナビゲーションアイテム
  static const labelLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.43,
  );

  /// 12px - チップ、小さなボタン、バッジ
  static const labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.33,
  );

  /// 11px - 最小のラベル、ステータスインジケーター
  static const labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.45,
  );

  // ===========================================================================
  // Caption styles - 極小テキスト、補足情報
  // ===========================================================================

  /// 10px - 極小キャプション、著者名表示など
  static const captionSmall = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.40,
  );

  /// Material 3 TextTheme を生成
  static TextTheme get textTheme => const TextTheme(
        displayLarge: displayLarge,
        displayMedium: displayMedium,
        displaySmall: displaySmall,
        headlineLarge: headlineLarge,
        headlineMedium: headlineMedium,
        headlineSmall: headlineSmall,
        titleLarge: titleLarge,
        titleMedium: titleMedium,
        titleSmall: titleSmall,
        bodyLarge: bodyLarge,
        bodyMedium: bodyMedium,
        bodySmall: bodySmall,
        labelLarge: labelLarge,
        labelMedium: labelMedium,
        labelSmall: labelSmall,
      );
}
