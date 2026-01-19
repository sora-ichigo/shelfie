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

  /// プライマリテキストカラー
  final Color textPrimary;

  /// セカンダリテキストカラー
  final Color textSecondary;

  /// リンクテキストカラー
  final Color textLink;

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
    surfaceOverlay: Color(0x99000000),
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
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textLink: Color.lerp(textLink, other.textLink, t)!,
    );
  }
}
