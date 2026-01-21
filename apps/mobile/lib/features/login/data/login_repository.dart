import 'package:ferry/ferry.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart';
import 'package:shelfie/core/network/ferry_client.dart';
import 'package:shelfie/features/login/data/__generated__/login_user.data.gql.dart';
import 'package:shelfie/features/login/data/__generated__/login_user.req.gql.dart';

part 'login_repository.g.dart';

sealed class LoginError {
  const LoginError();
}

class InvalidCredentialsError extends LoginError {
  const InvalidCredentialsError(this.message);
  final String message;
}

class UserNotFoundError extends LoginError {
  const UserNotFoundError(this.message);
  final String message;
}

class NetworkError extends LoginError {
  const NetworkError(this.message);
  final String message;
}

class UnknownError extends LoginError {
  const UnknownError(this.message);
  final String message;
}

class LoggedInUser {
  const LoggedInUser({
    required this.id,
    required this.email,
    required this.idToken,
    this.createdAt,
  });

  final int id;
  final String email;
  final String idToken;
  final DateTime? createdAt;
}

@riverpod
LoginRepository loginRepository(LoginRepositoryRef ref) {
  final client = ref.watch(ferryClientProvider);
  return LoginRepository(client: client);
}

class LoginRepository {
  const LoginRepository({required this.client});

  final Client client;

  Future<Either<LoginError, LoggedInUser>> login({
    required String email,
    required String password,
  }) async {
    debugPrint('[LoginRepository] login called with email: $email');

    final request = GLoginUserReq(
      (b) => b
        ..vars.input = GLoginUserInput(
          (i) => i
            ..email = email
            ..password = password,
        ).toBuilder(),
    );

    try {
      debugPrint('[LoginRepository] Sending GraphQL request...');
      final response = await client.request(request).first;
      debugPrint('[LoginRepository] Response received');
      debugPrint('[LoginRepository] hasErrors: ${response.hasErrors}');
      debugPrint('[LoginRepository] linkException: ${response.linkException}');
      debugPrint('[LoginRepository] graphqlErrors: ${response.graphqlErrors}');
      debugPrint('[LoginRepository] response.data: ${response.data}');

      if (response.hasErrors) {
        debugPrint('[LoginRepository] Error details:');
        debugPrint(
          '  - graphqlErrors: ${response.graphqlErrors?.map((e) => '${e.message} (${e.extensions})').toList()}',
        );
        debugPrint('  - linkException: ${response.linkException}');
        final errorMessage =
            response.graphqlErrors?.first.message ?? 'ログインに失敗しました';
        return left(UnknownError(errorMessage));
      }

      final result = response.data?.loginUser;
      debugPrint('[LoginRepository] result type: ${result.runtimeType}');
      if (result == null) {
        debugPrint('[LoginRepository] Result is null');
        return left(const UnknownError('レスポンスが空です'));
      }

      if (result is GLoginUserData_loginUser__asMutationLoginUserSuccess) {
        final loginData = result.data;
        final userData = loginData.user;
        debugPrint(
          '[LoginRepository] Login successful! userId: ${userData.id}',
        );
        return right(
          LoggedInUser(
            id: userData.id ?? 0,
            email: userData.email ?? '',
            idToken: loginData.idToken,
            createdAt: userData.createdAt,
          ),
        );
      }

      if (result is GLoginUserData_loginUser__asAuthError) {
        debugPrint(
          '[LoginRepository] AuthError received: code=${result.code}, message=${result.message}',
        );
        return left(_mapAuthError(result));
      }

      debugPrint(
        '[LoginRepository] Unexpected response type: ${result.runtimeType}',
      );
      return left(const UnknownError('予期しないレスポンス形式です'));
    } catch (e, stackTrace) {
      debugPrint('[LoginRepository] Exception caught: $e');
      debugPrint('[LoginRepository] StackTrace: $stackTrace');
      return left(UnknownError(e.toString()));
    }
  }

  LoginError _mapAuthError(GLoginUserData_loginUser__asAuthError error) {
    final message = error.message ?? 'エラーが発生しました';
    return switch (error.code) {
      GAuthErrorCode.INVALID_CREDENTIALS => InvalidCredentialsError(message),
      GAuthErrorCode.USER_NOT_FOUND => UserNotFoundError(message),
      GAuthErrorCode.NETWORK_ERROR => NetworkError(message),
      _ => UnknownError(message),
    };
  }
}
