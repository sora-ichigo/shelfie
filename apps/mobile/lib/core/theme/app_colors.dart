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
    // Semantic colors (新しい設計)
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
    // Legacy colors (後方互換性のため維持、段階的に廃止)
    @Deprecated('Use accent instead') required this.brandPrimary,
    @Deprecated('Use accentSecondary instead') required this.brandAccent,
    @Deprecated('Use background instead') required this.brandBackground,
    @Deprecated('Use background instead') required this.surfacePrimary,
    @Deprecated('Use surface instead') required this.surfaceElevated,
    @Deprecated('Use overlay instead') required this.surfaceOverlay,
    @Deprecated('Use surfaceHigh instead') required this.surfaceModal,
    @Deprecated('Use accent or define component-specific color instead')
    required this.selectionHighlight,
    @Deprecated('Use accentSecondary instead') required this.ratingActive,
    @Deprecated('Define gradient in component or use accent colors')
    required this.actionGradientStart,
    @Deprecated('Define gradient in component or use accent colors')
    required this.actionGradientEnd,
    @Deprecated('Use foreground instead') required this.textPrimary,
    @Deprecated('Use foregroundMuted instead') required this.textSecondary,
    @Deprecated('Use accent instead') required this.textLink,
  });

  // ===========================================================================
  // Primitive Colors（基盤カラー）
  // 直接使用せず、セマンティックカラーにマップして使用する
  // ===========================================================================

  static const Color _teal400 = Color(0xFF4FD1C5);
  static const Color _teal600 = Color(0xFF009789);
  static const Color _teal700 = Color(0xFF009689);
  static const Color _teal800 = Color(0xFF1A2E2E);
  static const Color _gold400 = Color(0xFFF6C94A);
  static const Color _gold300 = Color(0xFFFFD54F);
  static const Color _green400 = Color(0xFF00BC7D);
  static const Color _green300 = Color(0xFF81C784);
  static const Color _blue300 = Color(0xFF64B5F6);
  static const Color _red400 = Color(0xFFEF5350);
  static const Color _neutral900 = Color(0xFF0A0A0A);
  static const Color _neutral800 = Color(0xFF1A1A1A);
  static const Color _neutral500 = Color(0xFFA0A0A0);
  static const Color _white = Color(0xFFFFFFFF);
  static const Color _blackOverlay = Color(0x4D000000);

  // ===========================================================================
  // Semantic Colors（意味的カラー）- 新しい設計
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

  // ===========================================================================
  // Legacy Colors（後方互換性）
  // 新しいセマンティックカラーへの移行を推奨
  // ===========================================================================

  /// ブランドプライマリカラー（ターコイズ）
  @Deprecated('Use accent instead')
  final Color brandPrimary;

  /// ブランドアクセントカラー（ゴールド/星）
  @Deprecated('Use accentSecondary instead')
  final Color brandAccent;

  /// ブランド背景カラー
  @Deprecated('Use background instead')
  final Color brandBackground;

  /// プライマリサーフェスカラー
  @Deprecated('Use background instead')
  final Color surfacePrimary;

  /// 浮き上がったサーフェスカラー
  @Deprecated('Use surface instead')
  final Color surfaceElevated;

  /// オーバーレイサーフェスカラー
  @Deprecated('Use overlay instead')
  final Color surfaceOverlay;

  /// モーダル/シート背景色（ダークティール）
  @Deprecated('Use surfaceHigh instead')
  final Color surfaceModal;

  /// 選択状態のハイライトカラー（ディープティール）
  @Deprecated('Use accent or define component-specific color instead')
  final Color selectionHighlight;

  /// 星評価のアクティブカラー（ゴールド）
  @Deprecated('Use accentSecondary instead')
  final Color ratingActive;

  /// アクションボタン用グラデーション開始色
  @Deprecated('Define gradient in component or use accent colors')
  final Color actionGradientStart;

  /// アクションボタン用グラデーション終了色
  @Deprecated('Define gradient in component or use accent colors')
  final Color actionGradientEnd;

  /// アクションボタン用グラデーション
  @Deprecated('Define gradient in component')
  LinearGradient get actionGradient => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [actionGradientStart, actionGradientEnd],
      );

  /// プライマリテキストカラー
  @Deprecated('Use foreground instead')
  final Color textPrimary;

  /// セカンダリテキストカラー
  @Deprecated('Use foregroundMuted instead')
  final Color textSecondary;

  /// リンクテキストカラー
  @Deprecated('Use accent instead')
  final Color textLink;

  /// プライマリカラー（ターコイズ）- 直接アクセス用
  @Deprecated('Use accent from instance instead')
  static const Color primary = _teal400;

  /// ダークモード用のカラースキーム（デフォルト）
  static const dark = AppColors(
    // Semantic colors
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
    // Legacy colors (セマンティックカラーと同じ値を参照)
    brandPrimary: _teal400,
    brandAccent: _gold400,
    brandBackground: _neutral900,
    surfacePrimary: _neutral900,
    surfaceElevated: _neutral800,
    surfaceOverlay: _blackOverlay,
    surfaceModal: _teal800,
    selectionHighlight: _teal600,
    ratingActive: _gold300,
    actionGradientStart: _green400,
    actionGradientEnd: _teal700,
    textPrimary: _white,
    textSecondary: _neutral500,
    textLink: _white,
  );

  @override
  AppColors copyWith({
    // Semantic colors
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
    // Legacy colors
    Color? brandPrimary,
    Color? brandAccent,
    Color? brandBackground,
    Color? surfacePrimary,
    Color? surfaceElevated,
    Color? surfaceOverlay,
    Color? surfaceModal,
    Color? selectionHighlight,
    Color? ratingActive,
    Color? actionGradientStart,
    Color? actionGradientEnd,
    Color? textPrimary,
    Color? textSecondary,
    Color? textLink,
  }) {
    return AppColors(
      // Semantic colors
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
      // Legacy colors
      brandPrimary: brandPrimary ?? this.brandPrimary,
      brandAccent: brandAccent ?? this.brandAccent,
      brandBackground: brandBackground ?? this.brandBackground,
      surfacePrimary: surfacePrimary ?? this.surfacePrimary,
      surfaceElevated: surfaceElevated ?? this.surfaceElevated,
      surfaceOverlay: surfaceOverlay ?? this.surfaceOverlay,
      surfaceModal: surfaceModal ?? this.surfaceModal,
      selectionHighlight: selectionHighlight ?? this.selectionHighlight,
      ratingActive: ratingActive ?? this.ratingActive,
      actionGradientStart: actionGradientStart ?? this.actionGradientStart,
      actionGradientEnd: actionGradientEnd ?? this.actionGradientEnd,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textLink: textLink ?? this.textLink,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      // Semantic colors
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
      // Legacy colors
      brandPrimary: Color.lerp(brandPrimary, other.brandPrimary, t)!,
      brandAccent: Color.lerp(brandAccent, other.brandAccent, t)!,
      brandBackground: Color.lerp(brandBackground, other.brandBackground, t)!,
      surfacePrimary: Color.lerp(surfacePrimary, other.surfacePrimary, t)!,
      surfaceElevated: Color.lerp(surfaceElevated, other.surfaceElevated, t)!,
      surfaceOverlay: Color.lerp(surfaceOverlay, other.surfaceOverlay, t)!,
      surfaceModal: Color.lerp(surfaceModal, other.surfaceModal, t)!,
      selectionHighlight:
          Color.lerp(selectionHighlight, other.selectionHighlight, t)!,
      ratingActive: Color.lerp(ratingActive, other.ratingActive, t)!,
      actionGradientStart:
          Color.lerp(actionGradientStart, other.actionGradientStart, t)!,
      actionGradientEnd:
          Color.lerp(actionGradientEnd, other.actionGradientEnd, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textLink: Color.lerp(textLink, other.textLink, t)!,
    );
  }
}
