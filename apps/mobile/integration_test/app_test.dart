/// インテグレーションテスト
///
/// アプリの起動、認証フロー、エラーリカバリをテストする。
/// flutter test integration_test/app_test.dart で実行。
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shelfie/app/app.dart';
import 'package:shelfie/routing/app_router.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Integration Tests', () {
    group('App Startup', () {
      testWidgets('app launches and displays initial screen', (tester) async {
        await tester.pumpWidget(
          const ProviderScope(child: ShelfieApp()),
        );

        await tester.pumpAndSettle();

        expect(find.byType(MaterialApp), findsOneWidget);
      });

      testWidgets(
        'unauthenticated user is redirected to login screen',
        (tester) async {
          await tester.pumpWidget(
            const ProviderScope(child: ShelfieApp()),
          );

          await tester.pumpAndSettle();

          expect(find.textContaining('Login'), findsWidgets);
        },
      );
    });

    group('Authentication Flow', () {
      testWidgets('login flow navigates to home screen', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        await tester.pumpWidget(
          ProviderScope(
            parent: container,
            child: const ShelfieApp(),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.textContaining('Login'), findsWidgets);

        container.read(authStateProvider.notifier).login(
              userId: 'test-user',
              token: 'test-token',
            );

        await tester.pumpAndSettle();

        expect(find.textContaining('Home'), findsWidgets);
      });

      testWidgets('logout returns to login screen', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

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

        expect(find.textContaining('Home'), findsWidgets);

        container.read(authStateProvider.notifier).logout();

        await tester.pumpAndSettle();

        expect(find.textContaining('Login'), findsWidgets);
      });
    });

    group('Navigation', () {
      testWidgets('tab navigation works correctly', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

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

        expect(find.byType(NavigationBar), findsOneWidget);

        await tester.tap(find.byIcon(Icons.search_outlined));
        await tester.pumpAndSettle();

        expect(find.textContaining('Search'), findsWidgets);

        await tester.tap(find.byIcon(Icons.person_outline));
        await tester.pumpAndSettle();

        expect(find.textContaining('Profile'), findsWidgets);

        await tester.tap(find.byIcon(Icons.home_outlined));
        await tester.pumpAndSettle();

        expect(find.textContaining('Home'), findsWidgets);
      });

      testWidgets('deep link navigation works', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

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

        container.read(appRouterProvider).go('/books/test-book-123');
        await tester.pumpAndSettle();

        expect(find.textContaining('test-book-123'), findsWidgets);
      });
    });

    group('Error Recovery', () {
      testWidgets('invalid route redirects to error page', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        await tester.pumpWidget(
          ProviderScope(
            parent: container,
            child: const ShelfieApp(),
          ),
        );

        await tester.pumpAndSettle();

        container.read(appRouterProvider).go('/invalid/path/that/does/not/exist');
        await tester.pumpAndSettle();

        final currentLocation = container
            .read(appRouterProvider)
            .routerDelegate
            .currentConfiguration
            .uri
            .path;

        expect(
          currentLocation == '/error' || currentLocation == '/auth/login',
          isTrue,
        );
      });

      testWidgets('error page has go home button', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

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

        container.read(appRouterProvider).go('/error');
        await tester.pumpAndSettle();

        expect(find.textContaining('not found'), findsWidgets);
        expect(find.textContaining('Home'), findsWidgets);

        await tester.tap(find.widgetWithText(ElevatedButton, 'Go Home'));
        await tester.pumpAndSettle();

        final currentLocation = container
            .read(appRouterProvider)
            .routerDelegate
            .currentConfiguration
            .uri
            .path;

        expect(currentLocation, equals('/'));
      });
    });

    group('Theme', () {
      testWidgets('app uses dark theme', (tester) async {
        await tester.pumpWidget(
          const ProviderScope(child: ShelfieApp()),
        );

        await tester.pumpAndSettle();

        final scaffold = find.byType(Scaffold);
        expect(scaffold, findsWidgets);

        final context = tester.element(scaffold.first);
        final theme = Theme.of(context);

        expect(theme.brightness, equals(Brightness.dark));
      });
    });
  });
}
