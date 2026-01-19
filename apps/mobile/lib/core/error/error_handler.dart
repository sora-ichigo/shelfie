import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:shelfie/core/error/failure.dart';

/// ログ出力用インターフェース
///
/// 構造化ログを出力するための抽象クラス。
/// 本番環境では Firebase Crashlytics と連携し、
/// 開発環境ではコンソールに出力する。
abstract class Logger {
  void info(String message, {Object? error, StackTrace? stackTrace});
  void warning(String message, {Object? error, StackTrace? stackTrace});
  void error(String message, {Object? error, StackTrace? stackTrace});
}

/// Crashlytics 報告用インターフェース
///
/// Firebase Crashlytics への報告を抽象化したインターフェース。
/// テスト時にはモックに置き換えることができる。
abstract class CrashlyticsReporter {
  Future<void> recordError(Object error, StackTrace? stackTrace);
  Future<void> recordFlutterError(FlutterErrorDetails details);
}

/// グローバルエラーハンドラ
///
/// アプリケーション全体のエラーを一元管理し、
/// 適切なログ出力と Crashlytics への報告を行う。
///
/// 使用方法:
/// ```dart
/// final errorHandler = ErrorHandler(
///   logger: ConsoleLogger(),
///   crashlyticsReporter: FirebaseCrashlyticsReporter(),
///   isProduction: kReleaseMode,
/// );
/// errorHandler.initialize();
/// ```
class ErrorHandler {
  ErrorHandler({
    required this.logger,
    required this.crashlyticsReporter,
    required this.isProduction,
  });

  final Logger logger;
  final CrashlyticsReporter crashlyticsReporter;
  final bool isProduction;

  /// FlutterError.onError と PlatformDispatcher.instance.onError を設定
  ///
  /// アプリ起動時に一度だけ呼び出す。
  /// main.dart の runZonedGuarded 内で初期化することを推奨。
  void initialize() {
    FlutterError.onError = handleFlutterError;

    PlatformDispatcher.instance.onError = (error, stack) {
      handleError(error, stack);
      return true;
    };
  }

  /// Failure タイプに応じた構造化ログ出力と Crashlytics 報告
  ///
  /// 各 Failure タイプに応じて適切なログレベルで出力する:
  /// - NetworkFailure: warning
  /// - ServerFailure: error
  /// - AuthFailure: warning
  /// - ValidationFailure: info
  /// - UnexpectedFailure: error + Crashlytics 報告（本番環境のみ）
  void handleFailure(Failure failure) {
    failure.when(
      network: (msg) {
        logger.warning(
          'Network failure: $msg',
          error: failure,
        );
      },
      server: (msg, code, statusCode) {
        logger.error(
          'Server failure: [$code] $msg (status: $statusCode)',
          error: failure,
        );
      },
      auth: (msg) {
        logger.warning(
          'Auth failure: $msg',
          error: failure,
        );
      },
      validation: (msg, fieldErrors) {
        logger.info(
          'Validation failure: $msg, fields: $fieldErrors',
          error: failure,
        );
      },
      unexpected: (msg, stackTrace) {
        logger.error(
          'Unexpected failure: $msg',
          error: failure,
          stackTrace: stackTrace,
        );
        if (isProduction) {
          crashlyticsReporter.recordError(msg, stackTrace);
        }
      },
    );
  }

  /// 未処理のエラーをハンドリング
  ///
  /// PlatformDispatcher.instance.onError から呼び出される。
  void handleError(Object error, StackTrace stackTrace) {
    logger.error(
      'Unhandled error: $error',
      error: error,
      stackTrace: stackTrace,
    );

    if (isProduction) {
      crashlyticsReporter.recordError(error, stackTrace);
    }
  }

  /// Flutter フレームワークのエラーをハンドリング
  ///
  /// FlutterError.onError から呼び出される。
  void handleFlutterError(FlutterErrorDetails details) {
    logger.error(
      'Flutter error in ${details.library}: ${details.context}',
      error: details.exception,
      stackTrace: details.stack,
    );

    if (isProduction) {
      crashlyticsReporter.recordFlutterError(details);
    }
  }

  /// 例外を Failure タイプに分類
  ///
  /// 未知の例外を適切な Failure サブタイプに変換する。
  /// Repository 層などで例外をキャッチする際に使用する。
  static Failure classifyException(Object exception, [StackTrace? stackTrace]) {
    if (exception is SocketException) {
      return NetworkFailure(message: exception.message);
    }

    if (exception is TimeoutException) {
      return const NetworkFailure(message: 'Request timed out');
    }

    if (exception is FormatException) {
      return ValidationFailure(message: exception.message);
    }

    if (exception.toString().contains('SocketException')) {
      return const NetworkFailure(message: 'Connection refused');
    }

    if (exception.toString().contains('TimeoutException')) {
      return const NetworkFailure(message: 'Request timed out');
    }

    return UnexpectedFailure(
      message: exception.toString(),
      stackTrace: stackTrace,
    );
  }
}

/// コンソール出力用の Logger 実装
///
/// 開発環境で使用するシンプルなログ出力クラス。
class ConsoleLogger implements Logger {
  @override
  void info(String message, {Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      debugPrint('[INFO] $message');
    }
  }

  @override
  void warning(String message, {Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      debugPrint('[WARN] $message');
      if (stackTrace != null) {
        debugPrint(stackTrace.toString());
      }
    }
  }

  @override
  void error(String message, {Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      debugPrint('[ERROR] $message');
      if (error != null) {
        debugPrint('Error: $error');
      }
      if (stackTrace != null) {
        debugPrint(stackTrace.toString());
      }
    }
  }
}

/// Crashlytics 無効化用のダミー実装
///
/// Crashlytics を使用しない環境（開発環境やテスト）で使用する。
class NoOpCrashlyticsReporter implements CrashlyticsReporter {
  @override
  Future<void> recordError(Object error, StackTrace? stackTrace) async {}

  @override
  Future<void> recordFlutterError(FlutterErrorDetails details) async {}
}
