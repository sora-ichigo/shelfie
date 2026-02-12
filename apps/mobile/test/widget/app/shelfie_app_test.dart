import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/app/app.dart';
import 'package:shelfie/core/auth/auth_state.dart';
import 'package:shelfie/core/auth/session_validator.dart';
import 'package:shelfie/core/storage/secure_storage_service.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/routing/app_router.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('ShelfieApp', () {
    group('MaterialApp.router の統合', () {
      testWidgets('MaterialApp.router を使用していること', (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            child: const ShelfieApp(),
          ),
        );

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

        expect(materialApp.darkTheme?.brightness, equals(Brightness.dark));
        expect(materialApp.darkTheme?.useMaterial3, isTrue);
        expect(
          materialApp.darkTheme?.scaffoldBackgroundColor,
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

        expect(materialApp.routerConfig, isA<GoRouter>());
      });

      testWidgets('AppColors 拡張がテーマに含まれていること', (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            child: const ShelfieApp(),
          ),
        );
        await tester.pumpAndSettle();

        final materialApp = tester.widget<MaterialApp>(
          find.byType(MaterialApp),
        );
        final appColors = materialApp.darkTheme?.extension<AppColors>();

        expect(appColors, isNotNull);
        expect(appColors, equals(AppColors.dark));
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
        expect(const ShelfieApp(), isA<ConsumerWidget>());
      });

      testWidgets('ProviderScope 内で正しく動作すること', (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            child: const ShelfieApp(),
          ),
        );

        expect(find.byType(ShelfieApp), findsOneWidget);
        expect(find.byType(MaterialApp), findsOneWidget);
      });

      testWidgets('themeMode が dark に設定されていること', (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            child: const ShelfieApp(),
          ),
        );

        final materialApp = tester.widget<MaterialApp>(
          find.byType(MaterialApp),
        );

        expect(materialApp.themeMode, equals(ThemeMode.dark));
      });
    });

    group('選択的リビルドの最適化', () {
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

        expect(find.text('Custom Route'), findsOneWidget);
      });

      testWidgets('authStateProvider の変更で UI が更新されること', (tester) async {
        final mockStorage = MockSecureStorageService();
        when(() => mockStorage.saveAuthData(
              userId: any(named: 'userId'),
              email: any(named: 'email'),
              idToken: any(named: 'idToken'),
              refreshToken: any(named: 'refreshToken'),
            )).thenAnswer((_) async {});
        when(() => mockStorage.loadAuthData()).thenAnswer((_) async => null);
        when(() => mockStorage.saveGuestMode(isGuest: any(named: 'isGuest')))
            .thenAnswer((_) async {});
        when(() => mockStorage.loadGuestMode()).thenAnswer((_) async => false);
        when(() => mockStorage.clearGuestMode()).thenAnswer((_) async {});

        final mockSessionValidator = MockSessionValidator();
        when(() => mockSessionValidator.validate()).thenAnswer(
          (_) async => const SessionValid(userId: 1, email: 'test@example.com'),
        );

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              secureStorageServiceProvider.overrideWithValue(mockStorage),
              sessionValidatorProvider.overrideWithValue(mockSessionValidator),
            ],
            child: const ShelfieApp(),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Shelfie'), findsOneWidget);

        final container = ProviderScope.containerOf(
          tester.element(find.byType(ShelfieApp)),
        );
        await container.read(authStateProvider.notifier).login(
              userId: 'test-user',
              email: 'test@example.com',
              token: 'test-token',
              refreshToken: 'test-refresh-token',
            );
        await tester.pump();

        expect(find.text('読書家のための本棚'), findsNothing);

        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump(const Duration(seconds: 1));
      });
    });
  });

  group('Integration tests', () {
    testWidgets('全コンポーネントが統合されていること', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: const ShelfieApp(),
        ),
      );
      await tester.pumpAndSettle();

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.routerConfig, isNotNull);

      expect(materialApp.darkTheme?.useMaterial3, isTrue);
      expect(materialApp.darkTheme?.brightness, Brightness.dark);

      expect(materialApp.darkTheme?.extensions.values, isNotEmpty);
    });

    testWidgets('初期化順序が正しいこと', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: const ShelfieApp(),
        ),
      );

      final providerScope = tester.widget<ProviderScope>(
        find.byType(ProviderScope),
      );
      expect(providerScope.child, isA<ShelfieApp>());
    });
  });
}
