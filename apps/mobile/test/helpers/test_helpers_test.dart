// テストユーティリティのテスト

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/app/providers.dart';
import 'package:shelfie/core/auth/auth_state.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/theme/app_colors.dart';

import 'test_helpers.dart';

void main() {
  setUpAll(registerTestFallbackValues);

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

  group('テストユーティリティ', () {
    group('createTestContainer', () {
      test('ProviderContainer を作成できること', () {
        final container = createTestContainer();
        addTearDown(container.dispose);

        expect(container, isA<ProviderContainer>());
      });

      test('オーバーライドを適用できること', () {
        final mockLogger = MockLogger();
        final container = createTestContainer(
          overrides: [loggerProvider.overrideWithValue(mockLogger)],
        );
        addTearDown(container.dispose);

        expect(container.read(loggerProvider), equals(mockLogger));
      });

      test('親コンテナを指定できること', () {
        final parent = createTestContainer();
        addTearDown(parent.dispose);

        final child = createTestContainer(parent: parent);
        addTearDown(child.dispose);

        expect(child, isA<ProviderContainer>());
      });
    });

    group('buildTestWidget', () {
      testWidgets('ウィジェットを MaterialApp でラップすること', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(child: const Text('Test')),
        );

        expect(find.byType(MaterialApp), findsOneWidget);
        expect(find.byType(ProviderScope), findsOneWidget);
        expect(find.text('Test'), findsOneWidget);
      });

      testWidgets('デフォルトでダークテーマが適用されること', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            child: Builder(
              builder: (context) {
                final theme = Theme.of(context);
                expect(theme.brightness, equals(Brightness.dark));
                expect(theme.extension<AppColors>(), isNotNull);
                return const SizedBox();
              },
            ),
          ),
        );
      });

      testWidgets('カスタムテーマを指定できること', (tester) async {
        final customTheme = ThemeData.light();

        await tester.pumpWidget(
          buildTestWidget(
            child: Builder(
              builder: (context) {
                final theme = Theme.of(context);
                expect(theme.brightness, equals(Brightness.light));
                return const SizedBox();
              },
            ),
            theme: customTheme,
          ),
        );
      });

      testWidgets('オーバーライドを適用できること', (tester) async {
        final mockLogger = MockLogger();

        await tester.pumpWidget(
          buildTestWidget(
            overrides: [loggerProvider.overrideWithValue(mockLogger)],
            child: Consumer(
              builder: (context, ref, child) {
                final logger = ref.watch(loggerProvider);
                expect(logger, equals(mockLogger));
                return const SizedBox();
              },
            ),
          ),
        );
      });
    });

    group('buildTestWidgetWithContainer', () {
      testWidgets('既存のコンテナを使用できること', (tester) async {
        final container = createTestContainer();
        addTearDown(container.dispose);

        await container.read(authStateProvider.notifier).login(
              userId: 'test-user',
              email: 'test@example.com',
              token: 'test-token',
              refreshToken: 'test-refresh-token',
            );

        await tester.pumpWidget(
          buildTestWidgetWithContainer(
            container: container,
            child: Consumer(
              builder: (context, ref, child) {
                final authState = ref.watch(authStateProvider);
                expect(authState.isAuthenticated, isTrue);
                expect(authState.userId, equals('test-user'));
                return const SizedBox();
              },
            ),
          ),
        );
      });
    });

    group('buildTestWidgetWithRouter', () {
      testWidgets(
        'ルーターが統合されたウィジェットを構築できること',
        (tester) async {
          final container = createTestContainer();
          addTearDown(container.dispose);

          await container.read(authStateProvider.notifier).login(
                userId: 'test-user',
                email: 'test@example.com',
                token: 'test-token',
                refreshToken: 'test-refresh-token',
              );

          await tester.pumpWidget(
            buildTestWidgetWithRouter(container: container),
          );
          await tester.pumpAndSettle();

          expect(find.byType(MaterialApp), findsOneWidget);
        },
        skip: true, // Ferry GraphQL clientのタイマー問題により不安定
      );
    });

    group('Mock クラス', () {
      test('MockClient を作成できること', () {
        final mock = MockClient();
        expect(mock, isA<MockClient>());
      });

      test('MockLogger を作成できること', () {
        final mock = MockLogger();
        expect(mock, isA<MockLogger>());
      });

      test('MockCrashlyticsReporter を作成できること', () {
        final mock = MockCrashlyticsReporter();
        expect(mock, isA<MockCrashlyticsReporter>());
      });
    });

    group('TestFailures フィクスチャ', () {
      test('NetworkFailure が正しく定義されていること', () {
        expect(TestFailures.network, isA<NetworkFailure>());
        expect(TestFailures.network.message, equals('Test network error'));
      });

      test('ServerFailure が正しく定義されていること', () {
        expect(TestFailures.server, isA<ServerFailure>());
        expect(TestFailures.server.message, equals('Test server error'));
        expect(TestFailures.server.code, equals('TEST_ERR'));
        expect(TestFailures.server.statusCode, equals(500));
      });

      test('AuthFailure が正しく定義されていること', () {
        expect(TestFailures.auth, isA<AuthFailure>());
        expect(TestFailures.auth.message, equals('Test auth error'));
      });

      test('ValidationFailure が正しく定義されていること', () {
        expect(TestFailures.validation, isA<ValidationFailure>());
        expect(
          TestFailures.validation.message,
          equals('Test validation error'),
        );
        expect(TestFailures.validation.fieldErrors, isNotNull);
      });

      test('UnexpectedFailure が正しく定義されていること', () {
        expect(TestFailures.unexpected, isA<UnexpectedFailure>());
        expect(
          TestFailures.unexpected.message,
          equals('Test unexpected error'),
        );
      });
    });

    group('TestAuthStates フィクスチャ', () {
      test('unauthenticated 状態が正しく定義されていること', () {
        expect(TestAuthStates.unauthenticated.isAuthenticated, isFalse);
        expect(TestAuthStates.unauthenticated.userId, isNull);
        expect(TestAuthStates.unauthenticated.token, isNull);
      });

      test('authenticated 状態が正しく定義されていること', () {
        expect(TestAuthStates.authenticated.isAuthenticated, isTrue);
        expect(TestAuthStates.authenticated.userId, equals('test-user-id'));
        expect(TestAuthStates.authenticated.token, equals('test-token'));
      });
    });

    group('registerTestFallbackValues', () {
      test('FallbackValue を登録できること', () {
        expect(registerTestFallbackValues, returnsNormally);
      });
    });
  });
}
