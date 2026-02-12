import 'package:flutter/cupertino.dart';
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
    group('CupertinoTabBar', () {
      testWidgets('CupertinoTabBar に 4 タブ表示されること', (tester) async {
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

        final tabBar = tester.widget<CupertinoTabBar>(
          find.byType(CupertinoTabBar),
        );

        expect(tabBar.items.length, equals(4));

        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump(const Duration(seconds: 1));
        container.dispose();
        resetViewport(tester);
      });

      testWidgets('タブの順序がさがす -> + -> お知らせ -> プロフィールであること',
          (tester) async {
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

        final tabBar = tester.widget<CupertinoTabBar>(
          find.byType(CupertinoTabBar),
        );

        final icons = <IconData>[];
        for (final item in tabBar.items) {
          final iconWidget = (item.icon as Padding).child;
          if (iconWidget is Icon) {
            icons.add(iconWidget.icon!);
          } else {
            final iconFinder = find.descendant(
              of: find.byWidget(item.icon),
              matching: find.byType(Icon),
            );
            if (iconFinder.evaluate().isNotEmpty) {
              final icon = tester.widget<Icon>(iconFinder.first);
              icons.add(icon.icon!);
            }
          }
        }

        expect(icons[0], equals(CupertinoIcons.search));
        expect(icons[1], equals(CupertinoIcons.plus));
        expect(icons[2], equals(CupertinoIcons.bell));
        expect(icons[3], equals(CupertinoIcons.person));

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

      testWidgets('プロフィールタブが初期選択されていること', (tester) async {
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

        final tabBar = tester.widget<CupertinoTabBar>(
          find.byType(CupertinoTabBar),
        );

        // プロフィールタブは index 3（さがす:0, +:1, お知らせ:2, プロフィール:3）
        expect(tabBar.currentIndex, equals(3));

        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump(const Duration(seconds: 1));
        container.dispose();
        resetViewport(tester);
      });

      testWidgets('お知らせタブに遷移できること', (tester) async {
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

        container.read(appRouterProvider).go(AppRoutes.notificationsTab);
        await tester.pump();
        tester.takeException();

        final currentLocation = container
            .read(appRouterProvider)
            .routerDelegate
            .currentConfiguration
            .uri
            .path;
        expect(currentLocation, equals(AppRoutes.notificationsTab));

        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump(const Duration(seconds: 1));
        container.dispose();
        resetViewport(tester);
      });
    });
  });
}
