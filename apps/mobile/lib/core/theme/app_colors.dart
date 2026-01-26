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
/// - **Background**: 画面の最も深い背景
/// - **Surface**: コンテナ、カード等の背景
/// - **Foreground**: テキストやアイコン
/// - **Accent**: インタラクティブ要素、ブランドカラー
/// - **Feedback**: success, warning, error, info
///
/// 現在はダークモードのみをサポートする。
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.background,
    required this.surface,
    required this.surfaceHigh,
    required this.overlay,
    required this.foreground,
    required this.foregroundMuted,
    required this.accent,
    required this.accentSecondary,
    required this.onAccent,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
  });

  // ===========================================================================
  // Primitive Colors（基盤カラー）
  // 直接使用せず、セマンティックカラーにマップして使用する
  // ===========================================================================

  static const Color _teal400 = Color(0xFF4FD1C5);
  static const Color _teal800 = Color(0xFF1A2E2E);
  static const Color _gold400 = Color(0xFFF6C94A);
  static const Color _gold300 = Color(0xFFFFD54F);
  static const Color _green300 = Color(0xFF81C784);
  static const Color _blue300 = Color(0xFF64B5F6);
  static const Color _red400 = Color(0xFFEF5350);
  static const Color _neutral900 = Color(0xFF0A0A0A);
  static const Color _neutral800 = Color(0xFF1A1A1A);
  static const Color _neutral500 = Color(0xFFA0A0A0);
  static const Color _white = Color(0xFFFFFFFF);
  static const Color _blackOverlay = Color(0x4D000000);

  // ===========================================================================
  // Semantic Colors（意味的カラー）
  // ===========================================================================

  /// 画面の最も深い背景色
  final Color background;

  /// カード、コンテナ等の背景色
  final Color surface;

  /// 浮き上がった要素（モーダル、シート等）の背景色
  final Color surfaceHigh;

  /// オーバーレイ（スクリム、背景暗転）の色
  final Color overlay;

  /// メインのテキスト・アイコン色
  final Color foreground;

  /// 補助的なテキスト・アイコン色（secondary、placeholder等）
  final Color foregroundMuted;

  /// プライマリアクセントカラー（CTA、リンク、ブランドカラー）
  final Color accent;

  /// セカンダリアクセントカラー（星評価、ハイライト等）
  final Color accentSecondary;

  /// アクセントカラー上のテキスト色
  final Color onAccent;

  /// 成功状態を表すカラー
  final Color success;

  /// 警告状態を表すカラー
  final Color warning;

  /// エラー状態を表すカラー
  final Color error;

  /// 情報を表すカラー
  final Color info;

  /// ダークモード用のカラースキーム（デフォルト）
  static const dark = AppColors(
    background: _neutral900,
    surface: _neutral800,
    surfaceHigh: _teal800,
    overlay: _blackOverlay,
    foreground: _white,
    foregroundMuted: _neutral500,
    accent: _teal400,
    accentSecondary: _gold400,
    onAccent: _neutral900,
    success: _green300,
    warning: _gold300,
    error: _red400,
    info: _blue300,
  );

  @override
  AppColors copyWith({
    Color? background,
    Color? surface,
    Color? surfaceHigh,
    Color? overlay,
    Color? foreground,
    Color? foregroundMuted,
    Color? accent,
    Color? accentSecondary,
    Color? onAccent,
    Color? success,
    Color? warning,
    Color? error,
    Color? info,
  }) {
    return AppColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceHigh: surfaceHigh ?? this.surfaceHigh,
      overlay: overlay ?? this.overlay,
      foreground: foreground ?? this.foreground,
      foregroundMuted: foregroundMuted ?? this.foregroundMuted,
      accent: accent ?? this.accent,
      accentSecondary: accentSecondary ?? this.accentSecondary,
      onAccent: onAccent ?? this.onAccent,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      info: info ?? this.info,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceHigh: Color.lerp(surfaceHigh, other.surfaceHigh, t)!,
      overlay: Color.lerp(overlay, other.overlay, t)!,
      foreground: Color.lerp(foreground, other.foreground, t)!,
      foregroundMuted: Color.lerp(foregroundMuted, other.foregroundMuted, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentSecondary: Color.lerp(accentSecondary, other.accentSecondary, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
      info: Color.lerp(info, other.info, t)!,
    );
  }
}
