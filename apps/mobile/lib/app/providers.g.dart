// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$loggerHash() => r'52f51d53fd0db377a19db2df1de6f8f57a8e3d0b';

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
///
/// Copied from [logger].
@ProviderFor(logger)
final loggerProvider = Provider<Logger>.internal(
  logger,
  name: r'loggerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$loggerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LoggerRef = ProviderRef<Logger>;
String _$crashlyticsReporterHash() =>
    r'5ce83ff520bf1f3dabf9051ae65fe431d40fd9c1';

/// Crashlytics Reporter Provider
///
/// エラー報告用の Provider。
/// Firebase Crashlytics が利用可能な場合はそれを使用し、
/// それ以外の場合は NoOp 実装を使用する。
///
/// 本番環境でのエラー報告に使用される。
///
/// Copied from [crashlyticsReporter].
@ProviderFor(crashlyticsReporter)
final crashlyticsReporterProvider = Provider<CrashlyticsReporter>.internal(
  crashlyticsReporter,
  name: r'crashlyticsReporterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$crashlyticsReporterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CrashlyticsReporterRef = ProviderRef<CrashlyticsReporter>;
String _$isProductionHash() => r'cac0d3a43af1fdc29412f2e3c2c6d1ab6febcc9b';

/// Is Production Provider
///
/// 現在の実行環境が本番環境かどうかを返す Provider。
/// kReleaseMode を使用してビルドモードを判定する。
///
/// テスト時にはこの Provider をオーバーライドして
/// 本番環境の動作をシミュレートできる。
///
/// Copied from [isProduction].
@ProviderFor(isProduction)
final isProductionProvider = Provider<bool>.internal(
  isProduction,
  name: r'isProductionProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isProductionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsProductionRef = ProviderRef<bool>;
String _$errorHandlerHash() => r'b8e00438b033944b1360526459647063977699fd';

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
///
/// Copied from [errorHandler].
@ProviderFor(errorHandler)
final errorHandlerProvider = Provider<ErrorHandler>.internal(
  errorHandler,
  name: r'errorHandlerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$errorHandlerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ErrorHandlerRef = ProviderRef<ErrorHandler>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
