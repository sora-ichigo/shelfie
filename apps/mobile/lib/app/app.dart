import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/routing/app_router.dart';

/// アプリケーションのルートウィジェット
///
/// MaterialApp.router を使用し、go_router によるルーティングとダークモード固定でレンダリングする。
class ShelfieApp extends ConsumerWidget {
  const ShelfieApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Shelfie',
      themeMode: ThemeMode.dark,
      darkTheme: AppTheme.theme,
      theme: AppTheme.theme,
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
