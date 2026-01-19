import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/routing/app_router.dart';

/// アプリケーションのルートウィジェット
///
/// Material 3 ベースのテーマを適用し、
/// go_router によるルーティングを使用する。
/// ダークモード固定でアプリ全体をレンダリングする。
class ShelfieApp extends ConsumerWidget {
  const ShelfieApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Shelfie',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
