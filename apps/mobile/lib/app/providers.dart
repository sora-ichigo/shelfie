import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/error/error_handler.dart';

part 'providers.g.dart';

/// Logger Provider
///
/// アプリケーション全体で使用するログ出力用の Provider。
/// 開発環境では ConsoleLogger を使用し、本番環境では
/// 必要に応じてカスタム実装にオーバーライドできる。
///
/// 使い分けガイドライン:
/// - info: 一般的な情報（デバッグ目的）
/// - warning: 警告（処理は継続するが注意が必要）
/// - error: エラー（処理が失敗した）
@Riverpod(keepAlive: true)
Logger logger(Ref ref) {
  return ConsoleLogger();
}

/// Crashlytics Reporter Provider
///
/// エラー報告用の Provider。
/// 本番環境では Sentry を使用し、開発環境では NoOp 実装を使用する。
@Riverpod(keepAlive: true)
CrashlyticsReporter crashlyticsReporter(Ref ref) {
  if (kReleaseMode) {
    return SentryCrashlyticsReporter();
  }
  return NoOpCrashlyticsReporter();
}

/// Is Production Provider
///
/// 現在の実行環境が本番環境かどうかを返す Provider。
/// kReleaseMode を使用してビルドモードを判定する。
///
/// テスト時にはこの Provider をオーバーライドして
/// 本番環境の動作をシミュレートできる。
@Riverpod(keepAlive: true)
bool isProduction(Ref ref) {
  return kReleaseMode;
}

/// Error Handler Provider
///
/// アプリケーション全体のエラーハンドリングを担当する Provider。
/// Logger, CrashlyticsReporter, isProduction の各 Provider に依存する。
///
/// 使用方法:
/// ```dart
/// final errorHandler = ref.watch(errorHandlerProvider);
/// errorHandler.handleFailure(failure);
/// ```
///
/// StateNotifier vs AsyncNotifier の使い分け:
/// - StateNotifier: 同期的な状態変更（カウンター、フォーム状態など）
/// - AsyncNotifier: 非同期データ取得（API コール、データベースアクセスなど）
///
/// ErrorHandler は同期的な操作のみ行うため、通常の Provider として定義。
@Riverpod(keepAlive: true)
ErrorHandler errorHandler(Ref ref) {
  final log = ref.watch(loggerProvider);
  final crashlytics = ref.watch(crashlyticsReporterProvider);
  final isProd = ref.watch(isProductionProvider);

  return ErrorHandler(
    logger: log,
    crashlyticsReporter: crashlytics,
    isProduction: isProd,
  );
}
