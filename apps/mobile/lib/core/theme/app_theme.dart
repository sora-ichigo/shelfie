import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_typography.dart';

/// アプリケーション全体のテーマ定義
///
/// Material 3 ベースの ThemeData を生成し、
/// カスタム拡張（AppColors, AppTypography）を統合する。
///
/// 現在はダークモードのみをサポートする。
abstract final class AppTheme {
  /// アプリのプライマリカラーのシード（ブランドプライマリカラー）
  static const seedColor = Color(0xFF4FD1C5);

  /// ダークモードの ThemeData を生成（デフォルト）
  static ThemeData dark() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
      surface: AppColors.dark.background,
      onSurface: Colors.white,
    );

    final textTheme = AppTypography.textTheme.apply(fontFamily: 'NotoSansJP');

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.dark.background,
      textTheme: textTheme,
      iconTheme: const IconThemeData(color: Colors.white),
      extensions: const [AppColors.dark],
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          side: const BorderSide(color: Colors.white, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: AppColors.dark.foregroundMuted,
        ),
        prefixIconColor: AppColors.dark.foregroundMuted,
        suffixIconColor: AppColors.dark.foregroundMuted,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(color: AppColors.dark.foregroundMuted),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(color: AppColors.dark.foregroundMuted),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(color: AppColors.dark.accent),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(color: colorScheme.error),
        ),
      ),
    );
  }

  /// アプリのデフォルトテーマを返す（ダークモード）
  static ThemeData get theme => dark();

  /// Cupertino ダークテーマを返す
  static CupertinoThemeData get cupertinoTheme => CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.white,
        scaffoldBackgroundColor: AppColors.dark.background,
      );
}
