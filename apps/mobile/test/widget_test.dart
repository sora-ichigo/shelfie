import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/app/app.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/routing/app_router.dart';

void main() {
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
      expect(materialApp.theme?.brightness, equals(Brightness.dark));
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
      expect(materialApp.theme?.useMaterial3, isTrue);

      // シードカラーが正しく設定されていることを確認
      expect(
        materialApp.theme?.colorScheme.primary,
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
      final container = ProviderContainer();
      addTearDown(container.dispose);

      // ログイン状態にする
      container.read(authStateProvider.notifier).login(
            userId: 'test-user',
            token: 'test-token',
          );

      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: const ShelfieApp(),
        ),
      );
      await tester.pumpAndSettle();

      // 認証済みはホーム画面が表示される
      // NavigationBar のラベルとコンテンツの両方に 'Home' があるので、複数見つかることを確認
      expect(find.text('Home'), findsWidgets);
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
