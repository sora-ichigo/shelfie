import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      surface: const Color(0xFF0A0A0A),
      onSurface: Colors.white,
    );

    final textTheme = GoogleFonts.interTextTheme(AppTypography.textTheme);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: const Color(0xFF0A0A0A),
      textTheme: textTheme,
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
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.dark.brandBackground,
        selectedItemColor: AppColors.dark.textPrimary,
        unselectedItemColor: AppColors.dark.textSecondary,
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontSize: 14),
        selectedIconTheme: const IconThemeData(size: 32),
        unselectedIconTheme: const IconThemeData(size: 32),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: AppColors.dark.textSecondary,
        ),
        prefixIconColor: AppColors.dark.textSecondary,
        suffixIconColor: AppColors.dark.textSecondary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(color: AppColors.dark.textSecondary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(color: AppColors.dark.textSecondary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(color: AppColors.dark.brandPrimary),
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
}
