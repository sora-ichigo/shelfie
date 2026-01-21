import 'package:ferry/ferry.dart';
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
RegistrationRepository registrationRepository(RegistrationRepositoryRef ref) {
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
    final request = GRegisterUserReq(
      (b) => b
        ..vars.input = GRegisterUserInput(
          (i) => i
            ..email = email
            ..password = password,
        ).toBuilder(),
    );

    try {
      final response = await client.request(request).first;

      if (response.hasErrors) {
        final errorMessage = response.graphqlErrors?.first.message ??
            'ユーザー登録に失敗しました';
        return left(UnknownError(errorMessage));
      }

      final result = response.data?.registerUser;
      if (result == null) {
        return left(const UnknownError('レスポンスが空です'));
      }

      if (result
          is GRegisterUserData_registerUser__asMutationRegisterUserSuccess) {
        final userData = result.data;
        return right(
          RegisteredUser(
            id: userData.id ?? 0,
            email: userData.email ?? '',
            createdAt: userData.createdAt,
          ),
        );
      }

      if (result is GRegisterUserData_registerUser__asAuthError) {
        return left(_mapAuthError(result));
      }

      return left(const UnknownError('予期しないレスポンス形式です'));
    } catch (e) {
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
