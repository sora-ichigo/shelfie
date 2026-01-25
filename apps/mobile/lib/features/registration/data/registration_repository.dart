import 'package:ferry/ferry.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart';
import 'package:shelfie/core/network/ferry_client.dart';
import 'package:shelfie/features/registration/data/__generated__/register_user.data.gql.dart';
import 'package:shelfie/features/registration/data/__generated__/register_user.req.gql.dart';

part 'registration_repository.g.dart';

sealed class RegistrationError {
  const RegistrationError();
}

class EmailAlreadyExistsError extends RegistrationError {
  const EmailAlreadyExistsError(this.message);
  final String message;
}

class InvalidPasswordError extends RegistrationError {
  const InvalidPasswordError(this.message);
  final String message;
}

class NetworkError extends RegistrationError {
  const NetworkError(this.message);
  final String message;
}

class UnknownError extends RegistrationError {
  const UnknownError(this.message);
  final String message;
}

class RegisteredUser {
  const RegisteredUser({
    required this.id,
    required this.email,
    this.createdAt,
  });

  final int id;
  final String email;
  final DateTime? createdAt;
}

@riverpod
RegistrationRepository registrationRepository(Ref ref) {
  final client = ref.watch(ferryClientProvider);
  return RegistrationRepository(client: client);
}

class RegistrationRepository {
  const RegistrationRepository({required this.client});

  final Client client;

  Future<Either<RegistrationError, RegisteredUser>> registerUser({
    required String email,
    required String password,
  }) async {
    debugPrint('[RegistrationRepository] registerUser called with email: $email');

    final request = GRegisterUserReq(
      (b) => b
        ..vars.input = GRegisterUserInput(
          (i) => i
            ..email = email
            ..password = password,
        ).toBuilder(),
    );

    try {
      debugPrint('[RegistrationRepository] Sending GraphQL request...');
      final response = await client.request(request).first;
      debugPrint('[RegistrationRepository] Response received');
      debugPrint('[RegistrationRepository] hasErrors: ${response.hasErrors}');
      debugPrint('[RegistrationRepository] linkException: ${response.linkException}');
      debugPrint('[RegistrationRepository] graphqlErrors: ${response.graphqlErrors}');
      debugPrint('[RegistrationRepository] response.data: ${response.data}');
      debugPrint('[RegistrationRepository] response.data?.registerUser: ${response.data?.registerUser}');

      if (response.hasErrors) {
        debugPrint('[RegistrationRepository] Error details:');
        debugPrint('  - graphqlErrors: ${response.graphqlErrors?.map((e) => '${e.message} (${e.extensions})').toList()}');
        debugPrint('  - linkException: ${response.linkException}');
        final errorMessage = response.graphqlErrors?.first.message ??
            'ユーザー登録に失敗しました';
        return left(UnknownError(errorMessage));
      }

      final result = response.data?.registerUser;
      debugPrint('[RegistrationRepository] result type: ${result.runtimeType}');
      if (result == null) {
        debugPrint('[RegistrationRepository] Result is null');
        return left(const UnknownError('レスポンスが空です'));
      }

      if (result
          is GRegisterUserData_registerUser__asMutationRegisterUserSuccess) {
        final userData = result.data;
        debugPrint('[RegistrationRepository] Registration successful! userId: ${userData.id}');
        return right(
          RegisteredUser(
            id: userData.id ?? 0,
            email: userData.email ?? '',
            createdAt: userData.createdAt,
          ),
        );
      }

      if (result is GRegisterUserData_registerUser__asAuthError) {
        debugPrint('[RegistrationRepository] AuthError received: code=${result.code}, message=${result.message}');
        return left(_mapAuthError(result));
      }

      debugPrint('[RegistrationRepository] Unexpected response type: ${result.runtimeType}');
      return left(const UnknownError('予期しないレスポンス形式です'));
    } catch (e, stackTrace) {
      debugPrint('[RegistrationRepository] Exception caught: $e');
      debugPrint('[RegistrationRepository] StackTrace: $stackTrace');
      return left(UnknownError(e.toString()));
    }
  }

  RegistrationError _mapAuthError(
    GRegisterUserData_registerUser__asAuthError error,
  ) {
    final message = error.message ?? 'エラーが発生しました';
    return switch (error.code) {
      GAuthErrorCode.EMAIL_ALREADY_EXISTS => EmailAlreadyExistsError(message),
      GAuthErrorCode.INVALID_PASSWORD => InvalidPasswordError(message),
      GAuthErrorCode.NETWORK_ERROR => NetworkError(message),
      _ => UnknownError(message),
    };
  }
}
