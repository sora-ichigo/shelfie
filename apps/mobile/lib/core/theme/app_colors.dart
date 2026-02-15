import 'package:flutter/material.dart';

/// アプリケーション全体のカスタムカラースキーム
///
/// 新デザインシステムへの移行中のため、既存のセマンティックカラーは
/// Legacy サフィックス付きで定義されている。
/// 新しいカラートークンは別途追加予定。
///
/// Theme.of(context).extension<AppColors>() でアクセスできる。
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.primaryLegacy,
    required this.primaryPressedLegacy,
    required this.backgroundLegacy,
    required this.surfaceLegacy,
    required this.surfaceElevatedLegacy,
    required this.borderLegacy,
    required this.inactiveLegacy,
    required this.textPrimaryLegacy,
    required this.textSecondaryLegacy,
    required this.starLegacy,
    required this.destructiveLegacy,
    required this.successLegacy,
    required this.warningLegacy,
    required this.infoLegacy,
    required this.overlayLegacy,
  });

  // ===========================================================================
  // Primitive Colors（基盤カラー）
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
  // Legacy Semantic Colors
  // ===========================================================================

  final Color primaryLegacy;
  final Color primaryPressedLegacy;
  final Color backgroundLegacy;
  final Color surfaceLegacy;
  final Color surfaceElevatedLegacy;
  final Color borderLegacy;
  final Color inactiveLegacy;
  final Color textPrimaryLegacy;
  final Color textSecondaryLegacy;
  final Color starLegacy;
  final Color destructiveLegacy;
  final Color successLegacy;
  final Color warningLegacy;
  final Color infoLegacy;
  final Color overlayLegacy;

  static const dark = AppColors(
    primaryLegacy: _primary,
    primaryPressedLegacy: _primaryPressed,
    backgroundLegacy: _background,
    surfaceLegacy: _surface,
    surfaceElevatedLegacy: _surfaceElevated,
    borderLegacy: _border,
    inactiveLegacy: _inactive,
    textPrimaryLegacy: _textPrimary,
    textSecondaryLegacy: _textSecondary,
    starLegacy: _star,
    destructiveLegacy: _destructive,
    successLegacy: _success,
    warningLegacy: _warning,
    infoLegacy: _info,
    overlayLegacy: _overlay,
  );

  @override
  AppColors copyWith({
    Color? primaryLegacy,
    Color? primaryPressedLegacy,
    Color? backgroundLegacy,
    Color? surfaceLegacy,
    Color? surfaceElevatedLegacy,
    Color? borderLegacy,
    Color? inactiveLegacy,
    Color? textPrimaryLegacy,
    Color? textSecondaryLegacy,
    Color? starLegacy,
    Color? destructiveLegacy,
    Color? successLegacy,
    Color? warningLegacy,
    Color? infoLegacy,
    Color? overlayLegacy,
  }) {
    return AppColors(
      primaryLegacy: primaryLegacy ?? this.primaryLegacy,
      primaryPressedLegacy: primaryPressedLegacy ?? this.primaryPressedLegacy,
      backgroundLegacy: backgroundLegacy ?? this.backgroundLegacy,
      surfaceLegacy: surfaceLegacy ?? this.surfaceLegacy,
      surfaceElevatedLegacy:
          surfaceElevatedLegacy ?? this.surfaceElevatedLegacy,
      borderLegacy: borderLegacy ?? this.borderLegacy,
      inactiveLegacy: inactiveLegacy ?? this.inactiveLegacy,
      textPrimaryLegacy: textPrimaryLegacy ?? this.textPrimaryLegacy,
      textSecondaryLegacy: textSecondaryLegacy ?? this.textSecondaryLegacy,
      starLegacy: starLegacy ?? this.starLegacy,
      destructiveLegacy: destructiveLegacy ?? this.destructiveLegacy,
      successLegacy: successLegacy ?? this.successLegacy,
      warningLegacy: warningLegacy ?? this.warningLegacy,
      infoLegacy: infoLegacy ?? this.infoLegacy,
      overlayLegacy: overlayLegacy ?? this.overlayLegacy,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primaryLegacy: Color.lerp(primaryLegacy, other.primaryLegacy, t)!,
      primaryPressedLegacy:
          Color.lerp(primaryPressedLegacy, other.primaryPressedLegacy, t)!,
      backgroundLegacy:
          Color.lerp(backgroundLegacy, other.backgroundLegacy, t)!,
      surfaceLegacy: Color.lerp(surfaceLegacy, other.surfaceLegacy, t)!,
      surfaceElevatedLegacy:
          Color.lerp(surfaceElevatedLegacy, other.surfaceElevatedLegacy, t)!,
      borderLegacy: Color.lerp(borderLegacy, other.borderLegacy, t)!,
      inactiveLegacy: Color.lerp(inactiveLegacy, other.inactiveLegacy, t)!,
      textPrimaryLegacy:
          Color.lerp(textPrimaryLegacy, other.textPrimaryLegacy, t)!,
      textSecondaryLegacy:
          Color.lerp(textSecondaryLegacy, other.textSecondaryLegacy, t)!,
      starLegacy: Color.lerp(starLegacy, other.starLegacy, t)!,
      destructiveLegacy:
          Color.lerp(destructiveLegacy, other.destructiveLegacy, t)!,
      successLegacy: Color.lerp(successLegacy, other.successLegacy, t)!,
      warningLegacy: Color.lerp(warningLegacy, other.warningLegacy, t)!,
      infoLegacy: Color.lerp(infoLegacy, other.infoLegacy, t)!,
      overlayLegacy: Color.lerp(overlayLegacy, other.overlayLegacy, t)!,
    );
  }
}
