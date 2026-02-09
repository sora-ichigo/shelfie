import 'package:flutter/material.dart';

/// アプリケーション全体のカスタムカラースキーム
///
/// Material 3 の ColorScheme を補完するセマンティックカラーを定義する。
/// ThemeExtension を継承することで、ThemeData に統合し、
/// Theme.of(context).extension<AppColors>() でアクセスできる。
///
/// ## カラー設計の原則
///
/// 1. **Primitive Colors（基盤カラー）**: 生の色値。private static const で定義。
/// 2. **Semantic Colors（意味的カラー）**: 用途に基づいた名前。UIで直接使用する。
///
/// ## セマンティックカラーの分類
///
/// - **Background / Surface 系**: background, surface, surfaceElevated
/// - **Text 系**: textPrimary, textSecondary
/// - **Interactive 系**: primary, primaryPressed
/// - **Utility 系**: border, inactive
/// - **Feedback 系**: star, destructive, success, warning, info
///
/// 現在はダークモードのみをサポートする。
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.primary,
    required this.primaryPressed,
    required this.background,
    required this.surface,
    required this.surfaceElevated,
    required this.border,
    required this.inactive,
    required this.textPrimary,
    required this.textSecondary,
    required this.star,
    required this.destructive,
    required this.success,
    required this.warning,
    required this.info,
    required this.overlay,
  });

  // ===========================================================================
  // Primitive Colors（基盤カラー）
  // 直接使用せず、セマンティックカラーにマップして使用する
  // ===========================================================================

  static const Color _primary = Color(0xFF2B9E8F);
  static const Color _primaryPressed = Color(0xFF238275);
  static const Color _background = Color(0xFF121212);
  static const Color _surface = Color(0xFF1E1E1E);
  static const Color _surfaceElevated = Color(0xFF2A2A2A);
  static const Color _border = Color(0xFF333333);
  static const Color _inactive = Color(0xFF666666);
  static const Color _textPrimary = Color(0xFFFFFFFF);
  static const Color _textSecondary = Color(0xFFB0B0B0);
  static const Color _star = Color(0xFFFFD60A);
  static const Color _destructive = Color(0xFFCF4F4A);
  static const Color _success = Color(0xFF4CAF7D);
  static const Color _warning = Color(0xFFE5A940);
  static const Color _info = Color(0xFF5B9BD5);
  static const Color _overlay = Color(0xFF000000);

  // ===========================================================================
  // Semantic Colors（意味的カラー）
  // ===========================================================================

  /// プライマリカラー（選択中タブ、アクティブチップ、CTAボタン）
  final Color primary;

  /// ボタンのタップ時のプライマリカラー
  final Color primaryPressed;

  /// 画面の基本背景色
  final Color background;

  /// カード、チップ、入力欄の背景色
  final Color surface;

  /// モーダル、ボトムシート内の要素の背景色
  final Color surfaceElevated;

  /// 区切り線、ボタン枠線
  final Color border;

  /// 空の星、ハンドル、無効化アイコン
  final Color inactive;

  /// メインのテキスト・アイコン色
  final Color textPrimary;

  /// 補助テキスト、著者名、プレースホルダー
  final Color textSecondary;

  /// レーティングの星
  final Color star;

  /// 削除ボタン、エラー
  final Color destructive;

  /// 成功状態を表すカラー
  final Color success;

  /// 警告状態を表すカラー
  final Color warning;

  /// 情報を表すカラー
  final Color info;

  /// 半透明オーバーレイの基底色（`.withOpacity()` と組み合わせて使用）
  final Color overlay;

  /// ダークモード用のカラースキーム（デフォルト）
  static const dark = AppColors(
    primary: _primary,
    primaryPressed: _primaryPressed,
    background: _background,
    surface: _surface,
    surfaceElevated: _surfaceElevated,
    border: _border,
    inactive: _inactive,
    textPrimary: _textPrimary,
    textSecondary: _textSecondary,
    star: _star,
    destructive: _destructive,
    success: _success,
    warning: _warning,
    info: _info,
    overlay: _overlay,
  );

  @override
  AppColors copyWith({
    Color? primary,
    Color? primaryPressed,
    Color? background,
    Color? surface,
    Color? surfaceElevated,
    Color? border,
    Color? inactive,
    Color? textPrimary,
    Color? textSecondary,
    Color? star,
    Color? destructive,
    Color? success,
    Color? warning,
    Color? info,
    Color? overlay,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      primaryPressed: primaryPressed ?? this.primaryPressed,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceElevated: surfaceElevated ?? this.surfaceElevated,
      border: border ?? this.border,
      inactive: inactive ?? this.inactive,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      star: star ?? this.star,
      destructive: destructive ?? this.destructive,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      overlay: overlay ?? this.overlay,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primary: Color.lerp(primary, other.primary, t)!,
      primaryPressed: Color.lerp(primaryPressed, other.primaryPressed, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceElevated: Color.lerp(surfaceElevated, other.surfaceElevated, t)!,
      border: Color.lerp(border, other.border, t)!,
      inactive: Color.lerp(inactive, other.inactive, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      star: Color.lerp(star, other.star, t)!,
      destructive: Color.lerp(destructive, other.destructive, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
      overlay: Color.lerp(overlay, other.overlay, t)!,
    );
  }
}
