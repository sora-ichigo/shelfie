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

  /// リソースが見つからないエラー
  ///
  /// 書籍やユーザーデータなど、要求されたリソースが
  /// 存在しない場合のエラーを表す。
  const factory Failure.notFound({
    required String message,
  }) = NotFoundFailure;

  /// 権限エラー
  ///
  /// ユーザーが許可されていない操作を実行しようとした場合のエラーを表す。
  /// 他ユーザーのデータを更新しようとした場合などが該当する。
  const factory Failure.forbidden({
    required String message,
  }) = ForbiddenFailure;

  /// 重複書籍エラー
  ///
  /// 既に本棚に追加済みの書籍を再度追加しようとした場合のエラーを表す。
  const factory Failure.duplicateBook({
    required String message,
  }) = DuplicateBookFailure;

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
        notFound: (msg) => 'お探しの情報が見つかりませんでした',
        forbidden: (msg) => 'この操作は許可されていません',
        duplicateBook: (msg) => 'この書籍は既に本棚に追加されています',
      );
}
