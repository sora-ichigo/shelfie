import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
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
import 'package:shelfie/features/book_shelf/application/book_shelf_notifier.dart';
import 'package:shelfie/features/book_shelf/data/book_shelf_settings_repository.dart';

import 'package:shelfie/features/book_shelf/domain/sort_option.dart';
import 'package:shelfie/routing/app_router.dart';

import '../../helpers/test_helpers.dart';

class MockBookShelfSettingsRepository extends Mock
    implements BookShelfSettingsRepository {
  @override
  SortOption getSortOption() => SortOption.defaultOption;
}

void main() {
  group('ShelfieApp', () {
    group('Task 9.1: ShelfieApp widget integration', () {
      testWidgets('AdaptiveApp.router を使用していること', (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            child: const ShelfieApp(),
          ),
        );

        // AdaptiveApp が使用されていることを確認
        expect(find.byType(AdaptiveApp), findsOneWidget);

        // 内部的に MaterialApp.router が構築されていること（テスト環境は非 iOS）
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

        // テスト環境では AdaptiveApp 内部で MaterialApp が使用される
        final materialApp = tester.widget<MaterialApp>(
          find.byType(MaterialApp),
        );

        // ダークモードのテーマが適用されていることを確認
        // AdaptiveApp は darkTheme に materialDarkTheme を設定する
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

        // MaterialApp の darkTheme に AppColors 拡張が含まれていることを確認
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

        final adaptiveApp = tester.widget<AdaptiveApp>(
          find.byType(AdaptiveApp),
        );

        expect(adaptiveApp.title, equals('Shelfie'));
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
        expect(find.byType(AdaptiveApp), findsOneWidget);
      });

      testWidgets('themeMode が dark に設定されていること', (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            child: const ShelfieApp(),
          ),
        );

        final adaptiveApp = tester.widget<AdaptiveApp>(
          find.byType(AdaptiveApp),
        );

        expect(adaptiveApp.themeMode, equals(ThemeMode.dark));
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

        final mockSettingsRepository = MockBookShelfSettingsRepository();

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              secureStorageServiceProvider.overrideWithValue(mockStorage),
              sessionValidatorProvider.overrideWithValue(mockSessionValidator),
              bookShelfSettingsRepositoryProvider
                  .overrideWithValue(mockSettingsRepository),
              bookShelfNotifierProvider
                  .overrideWith(() => MockBookShelfNotifier()),
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
        await tester.pumpAndSettle();

        expect(find.text('読書家のための本棚'), findsNothing);
        expect(find.text('ライブラリ'), findsAtLeast(1));
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

      // AdaptiveApp が存在することを確認
      expect(find.byType(AdaptiveApp), findsOneWidget);

      // 内部の MaterialApp で Router が存在することを確認
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.routerConfig, isNotNull);

      // テーマが正しく適用されていることを確認
      expect(materialApp.darkTheme?.useMaterial3, isTrue);
      expect(materialApp.darkTheme?.brightness, Brightness.dark);

      // AppColors 拡張が存在することを確認
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
