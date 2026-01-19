import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

/// アプリケーション全体のテーマ定義
///
/// Material 3 ベースの ThemeData を生成し、
/// カスタム拡張（AppColors, AppTypography）を統合する。
///
/// 現在はダークモードのみをサポートする。
abstract final class AppTheme {
  /// アプリのプライマリカラーのシード
  static const seedColor = Color(0xFF6750A4);

  /// ダークモードの ThemeData を生成（デフォルト）
  static ThemeData dark() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      textTheme: AppTypography.textTheme,
      extensions: const [AppColors.dark],
    );
  }

  /// アプリのデフォルトテーマを返す（ダークモード）
  static ThemeData get theme => dark();
}
