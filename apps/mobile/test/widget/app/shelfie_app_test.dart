import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shelfie/app/app.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/routing/app_router.dart';

void main() {
  group('ShelfieApp', () {
    group('Task 9.1: ShelfieApp widget integration', () {
      testWidgets('MaterialApp.router を使用していること', (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            child: const ShelfieApp(),
          ),
        );

        // MaterialApp.router が使用されていることを確認
        final materialApp = tester.widget<MaterialApp>(
          find.byType(MaterialApp),
        );
        expect(materialApp.routerConfig, isNotNull);
      });

      testWidgets('AppTheme.theme（ダークモード）が適用されていること', (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            child: const ShelfieApp(),
          ),
        );

        final materialApp = tester.widget<MaterialApp>(
          find.byType(MaterialApp),
        );

        // ダークモードのテーマが適用されていることを確認
        expect(materialApp.theme?.brightness, equals(Brightness.dark));
        expect(materialApp.theme?.useMaterial3, isTrue);
        expect(
          materialApp.theme?.scaffoldBackgroundColor,
          equals(AppTheme.theme.scaffoldBackgroundColor),
        );
      });

      testWidgets('AppRouter が統合されていること', (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            child: const ShelfieApp(),
          ),
        );

        final materialApp = tester.widget<MaterialApp>(
          find.byType(MaterialApp),
        );

        // GoRouter が設定されていることを確認
        expect(materialApp.routerConfig, isA<GoRouter>());
      });

      testWidgets('AppColors 拡張がテーマに含まれていること', (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            child: const ShelfieApp(),
          ),
        );
        await tester.pumpAndSettle();

        // MaterialApp のテーマに AppColors 拡張が含まれていることを確認
        final materialApp = tester.widget<MaterialApp>(
          find.byType(MaterialApp),
        );
        final appColors = materialApp.theme?.extension<AppColors>();

        expect(appColors, isNotNull);
        expect(appColors, equals(AppColors.dark));
      });

      testWidgets('debugShowCheckedModeBanner が false であること', (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            child: const ShelfieApp(),
          ),
        );

        final materialApp = tester.widget<MaterialApp>(
          find.byType(MaterialApp),
        );

        expect(materialApp.debugShowCheckedModeBanner, isFalse);
      });

      testWidgets('アプリのタイトルが "Shelfie" であること', (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            child: const ShelfieApp(),
          ),
        );

        final materialApp = tester.widget<MaterialApp>(
          find.byType(MaterialApp),
        );

        expect(materialApp.title, equals('Shelfie'));
      });

      testWidgets('ConsumerWidget として実装されていること', (tester) async {
        // ShelfieApp が ConsumerWidget を継承していることを確認
        expect(const ShelfieApp(), isA<ConsumerWidget>());
      });

      testWidgets('ProviderScope 内で正しく動作すること', (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            child: const ShelfieApp(),
          ),
        );

        // エラーなくビルドされることを確認
        expect(find.byType(ShelfieApp), findsOneWidget);
        expect(find.byType(MaterialApp), findsOneWidget);
      });
    });

    group('Task 9.2: Selective rebuild optimization', () {
      testWidgets('ShelfieApp は appRouterProvider を watch していること', (tester) async {
        var watchCount = 0;
        final testRouter = GoRouter(
          initialLocation: '/',
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const Scaffold(
                body: Center(child: Text('Test')),
              ),
            ),
          ],
        );

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              appRouterProvider.overrideWith((ref) {
                watchCount++;
                return testRouter;
              }),
            ],
            child: const ShelfieApp(),
          ),
        );

        // Provider が 1 回だけ watch されることを確認
        expect(watchCount, equals(1));
      });

      testWidgets('Provider オーバーライドで異なるルーターを使用できること', (tester) async {
        final customRouter = GoRouter(
          initialLocation: '/custom',
          routes: [
            GoRoute(
              path: '/custom',
              builder: (context, state) => const Scaffold(
                body: Center(child: Text('Custom Route')),
              ),
            ),
          ],
        );

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              appRouterProvider.overrideWith((ref) => customRouter),
            ],
            child: const ShelfieApp(),
          ),
        );
        await tester.pumpAndSettle();

        // カスタムルーターの画面が表示されることを確認
        expect(find.text('Custom Route'), findsOneWidget);
      });

      testWidgets('authStateProvider の変更で UI が更新されること', (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            child: const ShelfieApp(),
          ),
        );
        await tester.pumpAndSettle();

        // 初期状態（未認証）ではウェルカム画面が表示される
        expect(find.text('Shelfie'), findsOneWidget);

        // 認証状態を変更
        final container = ProviderScope.containerOf(
          tester.element(find.byType(ShelfieApp)),
        );
        container.read(authStateNotifierProvider.notifier).login(
              userId: 'test-user',
              token: 'test-token',
            );
        await tester.pumpAndSettle();

        // 認証後はホーム画面が表示される（ウェルカム画面が消える）
        expect(find.text('読書家のための本棚'), findsNothing);
        // ホームタブのコンテンツが表示される
        expect(find.byType(NavigationBar), findsOneWidget);
      });
    });
  });

  group('Integration tests', () {
    testWidgets('1-8 の全コンポーネントが統合されていること', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: const ShelfieApp(),
        ),
      );
      await tester.pumpAndSettle();

      // MaterialApp が存在することを確認（テーマ統合）
      expect(find.byType(MaterialApp), findsOneWidget);

      // Router が存在することを確認（ルーティング統合）
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.routerConfig, isNotNull);

      // テーマが正しく適用されていることを確認
      expect(materialApp.theme?.useMaterial3, isTrue);
      expect(materialApp.theme?.brightness, Brightness.dark);

      // AppColors 拡張が存在することを確認
      expect(materialApp.theme?.extensions.values, isNotEmpty);
    });

    testWidgets('初期化順序が正しいこと', (tester) async {
      // ProviderScope が最外層であることを確認
      await tester.pumpWidget(
        ProviderScope(
          child: const ShelfieApp(),
        ),
      );

      // ProviderScope が存在し、ShelfieApp がその中にあることを確認
      final providerScope = tester.widget<ProviderScope>(
        find.byType(ProviderScope),
      );
      expect(providerScope.child, isA<ShelfieApp>());
    });
  });
}
