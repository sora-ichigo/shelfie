import 'dart:async';
import 'dart:io';

import 'package:ferry/ferry.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shelfie/core/error/failure.dart';

/// リポジトリ基底クラス
///
/// GraphQL 操作の実行とエラーハンドリングを提供する抽象クラス。
/// 各機能の Repository はこのクラスを継承して実装する。
///
/// 特徴:
/// - Either<Failure, T> を返す型安全なエラーハンドリング
/// - ネットワークエラー、GraphQL エラー、タイムアウトの自動分類
/// - リトライ機能
/// - ローディング状態の管理
///
/// 使用例:
/// ```dart
/// class BookRepository extends BaseRepository {
///   BookRepository(super.client);
///
///   Future<Either<Failure, Book>> getBook(String id) {
///     return executeQuery(GGetBookReq((b) => b..vars.id = id));
///   }
/// }
/// ```
abstract class BaseRepository {
  BaseRepository(this._client);

  final Client _client;

  bool _isLoading = false;

  /// 現在のローディング状態
  bool get isLoading => _isLoading;

  /// GraphQL クエリを実行する
  ///
  /// 成功時は Right(data) を返し、失敗時は Left(Failure) を返す。
  /// キャッシュポリシーは FerryClient のデフォルト設定に従う。
  Future<Either<Failure, TData>> executeQuery<TData, TVars>(
    OperationRequest<TData, TVars> request,
  ) async {
    try {
      final response = await _client.request(request).first;
      return _handleResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  /// GraphQL ミューテーションを実行する
  ///
  /// ミューテーションはネットワーク優先（NetworkOnly）で実行される。
  /// 成功時は Right(data) を返し、失敗時は Left(Failure) を返す。
  Future<Either<Failure, TData>> executeMutation<TData, TVars>(
    OperationRequest<TData, TVars> request,
  ) async {
    try {
      final response = await _client.request(request).first;
      return _handleResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  /// リトライ付きでクエリを実行する
  ///
  /// ネットワークエラーとタイムアウトの場合のみリトライを行う。
  /// GraphQL エラーやその他のエラーはリトライしない。
  ///
  /// [maxRetries] 最大リトライ回数（デフォルト: 3）
  /// [retryDelay] リトライ間隔（デフォルト: 1秒）
  Future<Either<Failure, TData>> executeQueryWithRetry<TData, TVars>(
    OperationRequest<TData, TVars> request, {
    int maxRetries = 3,
    Duration retryDelay = const Duration(seconds: 1),
  }) async {
    var attempts = 0;
    Either<Failure, TData>? lastResult;

    while (attempts < maxRetries) {
      attempts++;

      try {
        final response = await _client.request(request).first;
        final result = _handleResponse<TData, TVars>(response);

        // GraphQL エラーはリトライ対象外
        if (result.isLeft()) {
          final failure = result.getLeft().toNullable();
          if (failure is! NetworkFailure) {
            return result;
          }
        }

        // 成功した場合は即座に返す
        if (result.isRight()) {
          return result;
        }

        lastResult = result;
      } on SocketException {
        lastResult = left(
          const NetworkFailure(message: 'No internet connection'),
        );
      } on TimeoutException {
        lastResult = left(
          const NetworkFailure(message: 'Request timeout'),
        );
      } catch (e) {
        // その他のエラーはリトライしない
        return left(UnexpectedFailure(message: e.toString()));
      }

      // 最後の試行でなければ待機
      if (attempts < maxRetries) {
        await Future<void>.delayed(retryDelay);
      }
    }

    return lastResult ?? left(
      const NetworkFailure(message: 'Max retries exceeded'),
    );
  }

  /// ローディング状態を管理しながらクエリを実行する
  ///
  /// クエリ実行中は [isLoading] が true になる。
  /// UI でローディングインジケータを表示する際に使用する。
  Future<Either<Failure, TData>> executeQueryWithLoading<TData, TVars>(
    OperationRequest<TData, TVars> request,
  ) async {
    _isLoading = true;
    try {
      return await executeQuery(request);
    } finally {
      _isLoading = false;
    }
  }

  /// レスポンスを処理して Either に変換する
  Either<Failure, TData> _handleResponse<TData, TVars>(
    OperationResponse<TData, TVars> response,
  ) {
    // GraphQL エラーのチェック
    if (response.hasErrors) {
      final errorMessage = response.graphqlErrors?.firstOrNull?.message ??
          'Unknown GraphQL error';
      return left(
        ServerFailure(
          message: errorMessage,
          code: 'GRAPHQL_ERROR',
        ),
      );
    }

    // データの存在チェック
    if (response.data == null) {
      return left(
        const ServerFailure(
          message: 'No data received',
          code: 'NO_DATA',
        ),
      );
    }

    return right(response.data as TData);
  }
}
