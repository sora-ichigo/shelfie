import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/routing/app_router.dart';

/// アプリケーションのルートウィジェット
///
/// Material 3 ベースのテーマを適用し、
/// go_router によるルーティングを使用する。
/// ダークモード固定でアプリ全体をレンダリングする。
///
/// ## 統合コンポーネント
///
/// - [appRouterProvider]: go_router によるルーティング（タスク 1-8 で実装）
/// - [AppTheme]: Material 3 ベースのダークモードテーマ
/// - ProviderScope: main.dart で設定済み
///
/// ## 選択的リビルドの最適化（タスク 9.2）
///
/// このウィジェットは ConsumerWidget を継承し、
/// ref.watch を使用して必要な Provider のみを監視する。
///
/// 子ウィジェットで選択的リビルドを実現するには、
/// select を使用して特定のフィールドのみを監視する:
///
/// ```dart
/// // Bad: 全体を監視（不要なリビルドが発生）
/// final user = ref.watch(userProvider);
///
/// // Good: 必要なフィールドのみを監視
/// final name = ref.watch(userProvider.select((s) => s.name));
/// ```
///
/// 複数のフィールドが必要な場合は、Record を使用:
///
/// ```dart
/// final (name, email) = ref.watch(
///   userProvider.select((s) => (s.name, s.email)),
/// );
/// ```
class ShelfieApp extends ConsumerWidget {
  const ShelfieApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // appRouterProvider のみを監視
    // ルーターの状態変更時のみリビルドされる
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Shelfie',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
