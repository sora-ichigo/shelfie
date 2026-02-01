import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/routing/app_router.dart';

/// アプリケーションのルートウィジェット
///
/// AdaptiveApp.router を使用してプラットフォーム適応型 UI 基盤を提供する。
/// go_router によるルーティングを使用し、ダークモード固定でレンダリングする。
///
/// ## 統合コンポーネント
///
/// - [appRouterProvider]: go_router によるルーティング
/// - [AppTheme]: Material 3 / Cupertino ベースのダークモードテーマ
/// - [AdaptiveApp.router]: プラットフォーム適応型 UI 基盤
/// - ProviderScope: main.dart で設定済み
///
/// ## プラットフォーム適応
///
/// - iOS 26+: Liquid Glass デザイン
/// - iOS 26 未満: Cupertino フォールバック
/// - Android: Material Design
///
/// ## 選択的リビルドの最適化
///
/// このウィジェットは ConsumerWidget を継承し、
/// ref.watch を使用して必要な Provider のみを監視する。
class ShelfieApp extends ConsumerWidget {
  const ShelfieApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return AdaptiveApp.router(
      title: 'Shelfie',
      themeMode: ThemeMode.dark,
      materialDarkTheme: AppTheme.theme,
      cupertinoDarkTheme: AppTheme.cupertinoTheme,
      builder: (context, child) {
        return ScaffoldMessenger(
          child: Theme(data: AppTheme.theme, child: child!),
        );
      },
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ja')],
      routerConfig: router,
    );
  }
}
