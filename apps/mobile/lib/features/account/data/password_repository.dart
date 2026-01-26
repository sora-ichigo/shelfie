import 'dart:async';
import 'dart:io';

import 'package:ferry/ferry.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart';
import 'package:shelfie/core/network/ferry_client.dart';
import 'package:shelfie/features/account/data/__generated__/change_password.data.gql.dart';
import 'package:shelfie/features/account/data/__generated__/change_password.req.gql.dart';
import 'package:shelfie/features/account/data/__generated__/send_password_reset_email.data.gql.dart';
import 'package:shelfie/features/account/data/__generated__/send_password_reset_email.req.gql.dart';

part 'password_repository.g.dart';

class PasswordChangeResult {
  const PasswordChangeResult({
    required this.idToken,
    required this.refreshToken,
  });

  final String idToken;
  final String refreshToken;
}

@riverpod
PasswordRepository passwordRepository(Ref ref) {
  final client = ref.watch(ferryClientProvider);
  return PasswordRepository(client: client);
}

class PasswordRepository {
  const PasswordRepository({required this.client});

  final Client client;

  Future<Either<Failure, PasswordChangeResult>> changePassword({
    required String email,
    required String currentPassword,
    required String newPassword,
  }) async {
    debugPrint('[PasswordRepository] changePassword called for: $email');

    final request = GChangePasswordReq(
      (b) => b
        ..vars.input.email = email
        ..vars.input.currentPassword = currentPassword
        ..vars.input.newPassword = newPassword,
    );

    try {
      final response = await client.request(request).first;
      return _handleChangePasswordResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      debugPrint('[PasswordRepository] Exception: $e');
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Unit>> sendPasswordResetEmail({
    required String email,
  }) async {
    debugPrint('[PasswordRepository] sendPasswordResetEmail called for: $email');

    final request = GSendPasswordResetEmailReq(
      (b) => b..vars.input.email = email,
    );

    try {
      final response = await client.request(request).first;
      return _handleSendPasswordResetEmailResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      debugPrint('[PasswordRepository] Exception: $e');
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Either<Failure, PasswordChangeResult> _handleChangePasswordResponse(
    OperationResponse<GChangePasswordData, dynamic> response,
  ) {
    if (response.hasErrors) {
      final errorMessage =
          response.graphqlErrors?.first.message ?? 'パスワード変更に失敗しました';
      return left(ServerFailure(message: errorMessage, code: 'GRAPHQL_ERROR'));
    }

    final result = response.data?.changePassword;
    if (result == null) {
      return left(
        const ServerFailure(message: 'レスポンスが空です', code: 'NULL_RESPONSE'),
      );
    }

    if (result
        is GChangePasswordData_changePassword__asMutationChangePasswordSuccess) {
      final data = result.data;
      return right(
        PasswordChangeResult(
          idToken: data.idToken,
          refreshToken: data.refreshToken,
        ),
      );
    }

    if (result is GChangePasswordData_changePassword__asAuthError) {
      return left(_mapAuthError(result));
    }

    return left(
      const ServerFailure(
        message: 'Unexpected response type',
        code: 'UNEXPECTED_TYPE',
      ),
    );
  }

  Either<Failure, Unit> _handleSendPasswordResetEmailResponse(
    OperationResponse<GSendPasswordResetEmailData, dynamic> response,
  ) {
    if (response.hasErrors) {
      final errorMessage =
          response.graphqlErrors?.first.message ?? 'リセットメール送信に失敗しました';
      return left(ServerFailure(message: errorMessage, code: 'GRAPHQL_ERROR'));
    }

    final result = response.data?.sendPasswordResetEmail;
    if (result == null) {
      return left(
        const ServerFailure(message: 'レスポンスが空です', code: 'NULL_RESPONSE'),
      );
    }

    if (result
        is GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess) {
      return right(unit);
    }

    if (result
        is GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError) {
      return left(_mapPasswordResetAuthError(result));
    }

    return left(
      const ServerFailure(
        message: 'Unexpected response type',
        code: 'UNEXPECTED_TYPE',
      ),
    );
  }

  Failure _mapAuthError(
    GChangePasswordData_changePassword__asAuthError error,
  ) {
    final message = error.message ?? 'エラーが発生しました';
    return switch (error.code) {
      GAuthErrorCode.INVALID_CREDENTIALS =>
        AuthFailure(message: message),
      GAuthErrorCode.WEAK_PASSWORD =>
        ValidationFailure(message: message, fieldErrors: {'newPassword': message}),
      GAuthErrorCode.NETWORK_ERROR =>
        NetworkFailure(message: message),
      _ => ServerFailure(message: message, code: error.code?.name ?? 'UNKNOWN'),
    };
  }

  Failure _mapPasswordResetAuthError(
    GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError error,
  ) {
    final message = error.message ?? 'エラーが発生しました';
    return switch (error.code) {
      GAuthErrorCode.USER_NOT_FOUND =>
        NotFoundFailure(message: message),
      GAuthErrorCode.INVALID_EMAIL =>
        ValidationFailure(message: message, fieldErrors: {'email': message}),
      GAuthErrorCode.NETWORK_ERROR =>
        NetworkFailure(message: message),
      _ => ServerFailure(message: message, code: error.code?.name ?? 'UNKNOWN'),
    };
  }
}
