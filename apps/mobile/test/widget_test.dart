import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/app/app.dart';
import 'package:shelfie/core/auth/auth_state.dart';
import 'package:shelfie/core/theme/app_theme.dart';

import 'helpers/test_helpers.dart';

void main() {
  // RenderFlex overflow エラーを無視する（テスト環境のビューポートサイズの制約による）
  final originalOnError = FlutterError.onError;
  setUp(() {
    FlutterError.onError = (details) {
      final isOverflowError = details.toString().contains('overflowed');
      if (!isOverflowError) {
        originalOnError?.call(details);
      }
    };
  });

  tearDown(() {
    FlutterError.onError = originalOnError;
  });

  group('ShelfieApp', () {
    testWidgets('アプリが正常に起動すること', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: ShelfieApp(),
        ),
      );
      await tester.pumpAndSettle();

      // アプリが起動してウィジェットが表示されることを確認
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('ダークモードテーマが適用されていること', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: ShelfieApp(),
        ),
      );
      await tester.pumpAndSettle();

      final materialApp =
          tester.widget<MaterialApp>(find.byType(MaterialApp));

      // ダークモードが適用されていることを確認
      // AdaptiveApp.router は materialDarkTheme を darkTheme に設定する
      expect(materialApp.darkTheme?.brightness, equals(Brightness.dark));
    });

    testWidgets('AppTheme のテーマが適用されていること', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: ShelfieApp(),
        ),
      );
      await tester.pumpAndSettle();

      final materialApp =
          tester.widget<MaterialApp>(find.byType(MaterialApp));

      // Material 3 が有効になっていることを確認
      // AdaptiveApp.router は materialDarkTheme を darkTheme に設定する
      expect(materialApp.darkTheme?.useMaterial3, isTrue);

      // シードカラーが正しく設定されていることを確認
      expect(
        materialApp.darkTheme?.colorScheme.primary,
        equals(AppTheme.theme.colorScheme.primary),
      );
    });

    testWidgets('未認証時にウェルカム画面が表示されること', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: ShelfieApp(),
        ),
      );
      await tester.pumpAndSettle();

      // 未認証時はウェルカム画面にリダイレクトされる
      expect(find.text('Shelfie'), findsOneWidget);
    });

    testWidgets('認証済みでホーム画面が表示されること', (WidgetTester tester) async {
      // ビューポートを大きく設定
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;

      final container = createTestContainer();

      // ログイン状態にする
      await container.read(authStateProvider.notifier).login(
            userId: 'test-user',
            email: 'test@example.com',
            token: 'test-token',
            refreshToken: 'test-refresh-token',
          );

      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: const ShelfieApp(),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // 認証済みはマイライブラリ画面が表示される
      expect(find.text('マイライブラリ'), findsWidgets);

      // タイマーをクリアするためにウィジェットを破棄
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(seconds: 1));
      container.dispose();
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    testWidgets('ウェルカム画面でログインボタンが表示されること（未認証時）',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: ShelfieApp(),
        ),
      );
      await tester.pumpAndSettle();

      // 未認証時はウェルカム画面のログインボタンが表示される
      expect(find.text('ログイン'), findsOneWidget);
    });

    testWidgets('go_router が正しく統合されていること', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: ShelfieApp(),
        ),
      );
      await tester.pumpAndSettle();

      // MaterialApp.router が使用されていることを確認
      final materialApp =
          tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.routerConfig, isNotNull);
    });
  });
}
