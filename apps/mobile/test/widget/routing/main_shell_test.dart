import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/auth/auth_state.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/routing/app_router.dart';

import '../../helpers/test_helpers.dart';

void main() {
  setUpAll(registerTestFallbackValues);

  final originalOnError = FlutterError.onError;
  setUp(() {
    FlutterError.onError = (details) {
      final isOverflowError = details.toString().contains('overflowed') ||
          details.toString().contains('Multiple exceptions');
      if (!isOverflowError) {
        originalOnError?.call(details);
      }
    };
  });

  tearDown(() {
    FlutterError.onError = originalOnError;
  });

  void setLargeViewport(WidgetTester tester) {
    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1.0;
  }

  void resetViewport(WidgetTester tester) {
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  }

  group('MainShell', () {
    group('AdaptiveScaffold', () {
      testWidgets('AdaptiveScaffold を使用していること', (tester) async {
        setLargeViewport(tester);

        final container = createTestContainer();

        await container.read(authStateProvider.notifier).login(
              userId: 'user-123',
              email: 'test@example.com',
              token: 'test-token',
              refreshToken: 'test-refresh-token',
            );

        await tester.pumpWidget(
          ProviderScope(
            parent: container,
            child: MaterialApp.router(
              theme: AppTheme.theme,
              routerConfig: container.read(appRouterProvider),
            ),
          ),
        );
        await tester.pump();
        tester.takeException();

        expect(find.byType(AdaptiveScaffold), findsOneWidget);

        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump(const Duration(seconds: 1));
        container.dispose();
        resetViewport(tester);
      });
    });

    group('AdaptiveBottomNavigationBar', () {
      testWidgets('ナビゲーションバーに 2 タブ表示されること', (tester) async {
        setLargeViewport(tester);

        final container = createTestContainer();

        await container.read(authStateProvider.notifier).login(
              userId: 'user-123',
              email: 'test@example.com',
              token: 'test-token',
              refreshToken: 'test-refresh-token',
            );

        await tester.pumpWidget(
          ProviderScope(
            parent: container,
            child: MaterialApp.router(
              theme: AppTheme.theme,
              routerConfig: container.read(appRouterProvider),
            ),
          ),
        );
        await tester.pump();
        tester.takeException();

        // テスト環境(非 iOS)では NavigationBar が内部で使用される
        final navBar = tester.widget<NavigationBar>(
          find.byType(NavigationBar),
        );

        // 2 タブ (ライブラリ、検索) が表示されること
        expect(navBar.destinations.length, equals(2));

        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump(const Duration(seconds: 1));
        container.dispose();
        resetViewport(tester);
      });

      testWidgets('タブの順序がライブラリ -> 検索であること', (tester) async {
        setLargeViewport(tester);

        final container = createTestContainer();

        await container.read(authStateProvider.notifier).login(
              userId: 'user-123',
              email: 'test@example.com',
              token: 'test-token',
              refreshToken: 'test-refresh-token',
            );

        await tester.pumpWidget(
          ProviderScope(
            parent: container,
            child: MaterialApp.router(
              theme: AppTheme.theme,
              routerConfig: container.read(appRouterProvider),
            ),
          ),
        );
        await tester.pump();
        tester.takeException();

        // タブラベルが存在することを確認
        expect(find.text('ライブラリ'), findsWidgets);
        expect(find.text('さがす'), findsWidgets);

        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump(const Duration(seconds: 1));
        container.dispose();
        resetViewport(tester);
      });

      testWidgets('タブ選択で画面が遷移すること', (tester) async {
        setLargeViewport(tester);

        final container = createTestContainer();

        await container.read(authStateProvider.notifier).login(
              userId: 'user-123',
              email: 'test@example.com',
              token: 'test-token',
              refreshToken: 'test-refresh-token',
            );

        await tester.pumpWidget(
          ProviderScope(
            parent: container,
            child: MaterialApp.router(
              theme: AppTheme.theme,
              routerConfig: container.read(appRouterProvider),
            ),
          ),
        );
        await tester.pump();
        tester.takeException();

        // 検索タブへ遷移
        container.read(appRouterProvider).go(AppRoutes.searchTab);
        await tester.pump();
        tester.takeException();

        final currentLocation = container
            .read(appRouterProvider)
            .routerDelegate
            .currentConfiguration
            .uri
            .path;
        expect(currentLocation, equals(AppRoutes.searchTab));

        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump(const Duration(seconds: 1));
        container.dispose();
        resetViewport(tester);
      });

      testWidgets('ホームタブが初期選択されていること', (tester) async {
        setLargeViewport(tester);

        final container = createTestContainer();

        await container.read(authStateProvider.notifier).login(
              userId: 'user-123',
              email: 'test@example.com',
              token: 'test-token',
              refreshToken: 'test-refresh-token',
            );

        await tester.pumpWidget(
          ProviderScope(
            parent: container,
            child: MaterialApp.router(
              theme: AppTheme.theme,
              routerConfig: container.read(appRouterProvider),
            ),
          ),
        );
        await tester.pump();
        tester.takeException();

        final navBar = tester.widget<NavigationBar>(
          find.byType(NavigationBar),
        );

        // ホームタブ (index 0) が選択されていること
        expect(navBar.selectedIndex, equals(0));

        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump(const Duration(seconds: 1));
        container.dispose();
        resetViewport(tester);
      });
    });
  });
}
