import 'package:flutter/material.dart';

/// アプリケーション全体のカスタムカラースキーム
///
/// Material 3 の ColorScheme を補完するセマンティックカラーを定義する。
/// ThemeExtension を継承することで、ThemeData に統合し、
/// Theme.of(context).extension<AppColors>() でアクセスできる。
///
/// 現在はダークモードのみをサポートする。
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.success,
    required this.warning,
    required this.info,
    required this.onSuccess,
    required this.onWarning,
    required this.onInfo,
    required this.brandPrimary,
    required this.brandAccent,
    required this.brandBackground,
    required this.surfacePrimary,
    required this.surfaceElevated,
    required this.surfaceOverlay,
    required this.surfaceModal,
    required this.selectionHighlight,
    required this.ratingActive,
    required this.actionGradientStart,
    required this.actionGradientEnd,
    required this.textPrimary,
    required this.textSecondary,
    required this.textLink,
  });

  /// 成功状態を表すカラー
  final Color success;

  /// 警告状態を表すカラー
  final Color warning;

  /// 情報を表すカラー
  final Color info;

  /// success カラー上のコンテンツカラー
  final Color onSuccess;

  /// warning カラー上のコンテンツカラー
  final Color onWarning;

  /// info カラー上のコンテンツカラー
  final Color onInfo;

  /// ブランドプライマリカラー（ターコイズ）
  final Color brandPrimary;

  /// ブランドアクセントカラー（ゴールド/星）
  final Color brandAccent;

  /// ブランド背景カラー
  final Color brandBackground;

  /// プライマリサーフェスカラー
  final Color surfacePrimary;

  /// 浮き上がったサーフェスカラー
  final Color surfaceElevated;

  /// オーバーレイサーフェスカラー
  final Color surfaceOverlay;

  /// モーダル/シート背景色（ダークティール）
  final Color surfaceModal;

  /// 選択状態のハイライトカラー（ディープティール）
  final Color selectionHighlight;

  /// 星評価のアクティブカラー（ゴールド）
  final Color ratingActive;

  /// アクションボタン用グラデーション開始色
  final Color actionGradientStart;

  /// アクションボタン用グラデーション終了色
  final Color actionGradientEnd;

  /// アクションボタン用グラデーション
  LinearGradient get actionGradient => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [actionGradientStart, actionGradientEnd],
      );

  /// プライマリテキストカラー
  final Color textPrimary;

  /// セカンダリテキストカラー
  final Color textSecondary;

  /// リンクテキストカラー
  final Color textLink;

  /// プライマリカラー（ターコイズ）- 直接アクセス用
  static const Color primary = Color(0xFF4FD1C5);

  /// プライマリライトカラー - グラデーション用
  static const Color primaryLight = Color(0xFF81E6D9);

  /// アクションボタン用グラデーション開始色（非推奨: インスタンスフィールドを使用）
  @Deprecated('Use instance field actionGradientStart instead')
  static const Color staticActionGradientStart = Color(0xFF00BC7D);

  /// アクションボタン用グラデーション終了色（非推奨: インスタンスフィールドを使用）
  @Deprecated('Use instance field actionGradientEnd instead')
  static const Color staticActionGradientEnd = Color(0xFF009689);

  /// アクションボタン用グラデーション（非推奨: インスタンスの actionGradient getter を使用）
  @Deprecated('Use instance getter actionGradient instead')
  static const LinearGradient staticActionGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [staticActionGradientStart, staticActionGradientEnd],
  );

  /// モーダル/シート背景色（非推奨: インスタンスフィールドを使用）
  @Deprecated('Use instance field surfaceModal instead')
  static const Color staticSurfaceModal = Color(0xFF1A2E2E);

  /// 選択状態のハイライトカラー（非推奨: インスタンスフィールドを使用）
  @Deprecated('Use instance field selectionHighlight instead')
  static const Color staticSelectionHighlight = Color(0xFF009789);

  /// ダークモード用のカラースキーム（デフォルト）
  static const dark = AppColors(
    success: Color(0xFF81C784),
    warning: Color(0xFFFFD54F),
    info: Color(0xFF64B5F6),
    onSuccess: Color(0xFF000000),
    onWarning: Color(0xFF000000),
    onInfo: Color(0xFF000000),
    brandPrimary: Color(0xFF4FD1C5),
    brandAccent: Color(0xFFF6C94A),
    brandBackground: Color(0xFF0A0A0A),
    surfacePrimary: Color(0xFF0A0A0A),
    surfaceElevated: Color(0xFF1A1A1A),
    surfaceOverlay: Color(0x4D000000),
    surfaceModal: Color(0xFF1A2E2E),
    selectionHighlight: Color(0xFF009789),
    ratingActive: Color(0xFFFFD54F),
    actionGradientStart: Color(0xFF00BC7D),
    actionGradientEnd: Color(0xFF009689),
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xFFA0A0A0),
    textLink: Color(0xFFFFFFFF),
  );

  @override
  AppColors copyWith({
    Color? success,
    Color? warning,
    Color? info,
    Color? onSuccess,
    Color? onWarning,
    Color? onInfo,
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
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      onSuccess: onSuccess ?? this.onSuccess,
      onWarning: onWarning ?? this.onWarning,
      onInfo: onInfo ?? this.onInfo,
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
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
      onInfo: Color.lerp(onInfo, other.onInfo, t)!,
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
