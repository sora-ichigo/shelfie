import 'package:ferry/ferry.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/auth/__generated__/me.data.gql.dart';
import 'package:shelfie/core/auth/__generated__/me.req.gql.dart';
import 'package:shelfie/core/network/ferry_client.dart';

part 'session_validator.g.dart';

/// セッション検証結果
sealed class SessionValidationResult {
  const SessionValidationResult();
}

/// セッションが有効
class SessionValid extends SessionValidationResult {
  const SessionValid({required this.userId, required this.email});
  final int userId;
  final String email;
}

/// セッションが無効（認証エラー）
class SessionInvalid extends SessionValidationResult {
  const SessionInvalid({this.errorCode, this.message});
  final String? errorCode;
  final String? message;
}

/// セッション検証に失敗（ネットワークエラーなど）
class SessionValidationFailed extends SessionValidationResult {
  const SessionValidationFailed({this.message});
  final String? message;
}

/// セッション検証サービス
///
/// me クエリを呼び出してセッションが有効かどうかを検証する。
@riverpod
SessionValidator sessionValidator(Ref ref) {
  final client = ref.watch(ferryClientProvider);
  return SessionValidator(client);
}

class SessionValidator {
  const SessionValidator(this._client);

  final Client _client;

  /// セッションを検証する
  ///
  /// me クエリを呼び出してセッションが有効かどうかを確認する。
  /// - セッションが有効な場合: [SessionValid] を返す
  /// - セッションが無効な場合: [SessionInvalid] を返す
  /// - ネットワークエラーなど: [SessionValidationFailed] を返す
  Future<SessionValidationResult> validate() async {
    try {
      final request = GGetMeReq();
      final response = await _client
          .request(request)
          .firstWhere((r) => !r.loading && r.data != null || r.hasErrors);

      if (response.hasErrors) {
        final error = response.graphqlErrors?.firstOrNull;
        final errorMessage = error?.message;
        final errorCode = error?.extensions?['code'] as String?;

        debugPrint('[SessionValidator] GraphQL error: $errorMessage, code: $errorCode');

        // 認証エラーの場合のみSessionInvalidを返す
        if (errorCode == 'UNAUTHENTICATED') {
          return SessionInvalid(errorCode: errorCode, message: errorMessage);
        }

        // その他のGraphQLエラーはネットワーク問題として扱う
        return SessionValidationFailed(message: errorMessage);
      }

      final me = response.data?.me;
      if (me == null) {
        debugPrint('[SessionValidator] No user data returned');
        return const SessionInvalid(message: 'No user data returned');
      }

      if (me is GGetMeData_me__asUser) {
        final userId = me.id;
        final email = me.email;
        if (userId != null && email != null) {
          return SessionValid(userId: userId, email: email);
        }
        debugPrint('[SessionValidator] User data incomplete: id=$userId, email=$email');
        return const SessionInvalid(message: 'User data incomplete');
      }

      if (me is GGetMeData_me__asAuthErrorResult) {
        debugPrint('[SessionValidator] Auth error: ${me.code?.name} - ${me.message}');
        return SessionInvalid(
          errorCode: me.code?.name,
          message: me.message,
        );
      }

      debugPrint('[SessionValidator] Unknown response type: ${me.runtimeType}');
      return const SessionInvalid(message: 'Unknown response type');
    } catch (e) {
      debugPrint('[SessionValidator] Exception: $e');
      return SessionValidationFailed(message: e.toString());
    }
  }
}
