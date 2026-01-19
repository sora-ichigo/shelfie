import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

/// アプリケーション全体のエラー型階層
///
/// sealed class により exhaustive なパターンマッチングを強制し、
/// すべてのエラーケースが適切に処理されることを保証する。
@freezed
sealed class Failure with _$Failure {
  const Failure._();

  /// ネットワークエラー
  ///
  /// インターネット接続の問題やタイムアウトなど、
  /// ネットワーク関連のエラーを表す。
  const factory Failure.network({
    required String message,
  }) = NetworkFailure;

  /// サーバーエラー
  ///
  /// API サーバーからのエラーレスポンスを表す。
  /// GraphQL エラーや HTTP 5xx エラーなどが該当する。
  const factory Failure.server({
    required String message,
    required String code,
    int? statusCode,
  }) = ServerFailure;

  /// 認証エラー
  ///
  /// トークンの期限切れや無効な認証情報など、
  /// 認証関連のエラーを表す。
  const factory Failure.auth({
    required String message,
  }) = AuthFailure;

  /// バリデーションエラー
  ///
  /// ユーザー入力の検証エラーを表す。
  /// フィールドごとのエラーメッセージを保持できる。
  const factory Failure.validation({
    required String message,
    Map<String, String>? fieldErrors,
  }) = ValidationFailure;

  /// 予期しないエラー
  ///
  /// 上記のカテゴリに該当しない予期しないエラーを表す。
  /// デバッグ用にスタックトレースを保持できる。
  const factory Failure.unexpected({
    required String message,
    StackTrace? stackTrace,
  }) = UnexpectedFailure;

  /// ユーザー向けの表示メッセージ
  ///
  /// 各エラータイプに応じた、ユーザーフレンドリーなメッセージを返す。
  /// ValidationFailure の場合は、開発者が指定したメッセージをそのまま返す。
  String get userMessage => when(
        network: (msg) => 'ネットワーク接続を確認してください',
        server: (msg, code, statusCode) => 'サーバーエラーが発生しました',
        auth: (msg) => '再度ログインしてください',
        validation: (msg, fieldErrors) => msg,
        unexpected: (msg, stackTrace) => '予期しないエラーが発生しました',
      );
}
