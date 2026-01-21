// テストユーティリティとヘルパー関数

import 'package:ferry/ferry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/error_handler.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/core/auth/auth_state.dart';
import 'package:shelfie/routing/app_router.dart';

/// テスト用 ProviderContainer を作成するヘルパー
///
/// オーバーライドを指定してテスト用のコンテナを生成する。
/// 使用後は必ず dispose すること。
///
/// 使用例:
/// ```dart
/// final container = createTestContainer(
///   overrides: [loggerProvider.overrideWithValue(MockLogger())],
/// );
/// addTearDown(container.dispose);
/// ```
ProviderContainer createTestContainer({
  List<Override> overrides = const [],
  ProviderContainer? parent,
}) {
  return ProviderContainer(
    overrides: overrides,
    parent: parent,
  );
}

/// テスト用ウィジェットをラップするヘルパー
///
/// MaterialApp と ProviderScope でウィジェットをラップする。
/// テーマは AppTheme.theme を適用する。
///
/// 使用例:
/// ```dart
/// await tester.pumpWidget(
///   buildTestWidget(child: const LoadingIndicator()),
/// );
/// ```
Widget buildTestWidget({
  required Widget child,
  List<Override> overrides = const [],
  ThemeData? theme,
}) {
  return ProviderScope(
    overrides: overrides,
    child: MaterialApp(
      theme: theme ?? AppTheme.theme,
      home: Scaffold(body: child),
    ),
  );
}

/// テスト用ウィジェットをラップするヘルパー（ProviderContainer 指定版）
///
/// 既存の ProviderContainer を使用してウィジェットをラップする。
Widget buildTestWidgetWithContainer({
  required Widget child,
  required ProviderContainer container,
  ThemeData? theme,
}) {
  return ProviderScope(
    parent: container,
    child: MaterialApp(
      theme: theme ?? AppTheme.theme,
      home: Scaffold(body: child),
    ),
  );
}

/// ルーター付きテストウィジェットを構築するヘルパー
///
/// go_router を使用するテストで使用する。
Widget buildTestWidgetWithRouter({
  List<Override> overrides = const [],
  ProviderContainer? container,
  ThemeData? theme,
}) {
  final testContainer = container ??
      createTestContainer(
        overrides: overrides,
      );

  return ProviderScope(
    parent: testContainer,
    child: MaterialApp.router(
      theme: theme ?? AppTheme.theme,
      routerConfig: testContainer.read(appRouterProvider),
    ),
  );
}

/// Mock クラス定義
///
/// テストで使用するモッククラス群。
/// mocktail を使用してモックを生成する。

/// Ferry Client モック
class MockClient extends Mock implements Client {}

/// Logger モック
class MockLogger extends Mock implements Logger {}

/// CrashlyticsReporter モック
class MockCrashlyticsReporter extends Mock implements CrashlyticsReporter {}

/// OperationRequest フェイク
class FakeOperationRequest<TData, TVars> extends Fake
    implements OperationRequest<TData, TVars> {}

/// Failure フィクスチャ
///
/// テストで使用する Failure インスタンスのコレクション。
abstract class TestFailures {
  /// ネットワークエラー
  static const network = NetworkFailure(message: 'Test network error');

  /// サーバーエラー
  static const server = ServerFailure(
    message: 'Test server error',
    code: 'TEST_ERR',
    statusCode: 500,
  );

  /// 認証エラー
  static const auth = AuthFailure(message: 'Test auth error');

  /// バリデーションエラー
  static const validation = ValidationFailure(
    message: 'Test validation error',
    fieldErrors: {'email': 'Invalid email'},
  );

  /// 予期しないエラー
  static const unexpected = UnexpectedFailure(message: 'Test unexpected error');
}

/// AuthState フィクスチャ
abstract class TestAuthStates {
  /// 未認証状態
  static const unauthenticated = AuthStateData();

  /// 認証済み状態
  static const authenticated = AuthStateData(
    isAuthenticated: true,
    userId: 'test-user-id',
    email: 'test@example.com',
    token: 'test-token',
    refreshToken: 'test-refresh-token',
  );
}

/// registerFallbackValue の一括登録
///
/// テストの setUpAll で呼び出して、モック用の fallback 値を登録する。
///
/// 使用例:
/// ```dart
/// setUpAll(() {
///   registerTestFallbackValues();
/// });
/// ```
void registerTestFallbackValues() {
  registerFallbackValue(FakeOperationRequest<String, Map<String, dynamic>>());
  registerFallbackValue(const NetworkFailure(message: 'fallback'));
}
