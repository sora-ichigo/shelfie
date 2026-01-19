import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/theme/app_theme.dart';

/// アプリケーションのルートウィジェット
///
/// Material 3 ベースのテーマを適用し、
/// ダークモード固定でアプリ全体をレンダリングする。
///
/// 将来的には go_router を統合し、
/// MaterialApp.router を使用する予定。
class ShelfieApp extends ConsumerWidget {
  const ShelfieApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Shelfie',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      home: const _PlaceholderHome(),
    );
  }
}

/// プレースホルダーホーム画面
///
/// ルーティングシステムが実装されるまでの仮画面。
class _PlaceholderHome extends StatelessWidget {
  const _PlaceholderHome();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shelfie'),
      ),
      body: const Center(
        child: Text('Welcome to Shelfie'),
      ),
    );
  }
}
