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

  /// ダークモード用のカラースキーム（デフォルト）
  static const dark = AppColors(
    success: Color(0xFF81C784),
    warning: Color(0xFFFFD54F),
    info: Color(0xFF64B5F6),
    onSuccess: Color(0xFF000000),
    onWarning: Color(0xFF000000),
    onInfo: Color(0xFF000000),
  );

  @override
  AppColors copyWith({
    Color? success,
    Color? warning,
    Color? info,
    Color? onSuccess,
    Color? onWarning,
    Color? onInfo,
  }) {
    return AppColors(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      onSuccess: onSuccess ?? this.onSuccess,
      onWarning: onWarning ?? this.onWarning,
      onInfo: onInfo ?? this.onInfo,
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
    );
  }
}
