import 'dart:async';
import 'dart:io';

import 'package:ferry/ferry.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/network/ferry_client.dart';
import 'package:shelfie/features/account/data/__generated__/get_my_profile.data.gql.dart';
import 'package:shelfie/features/account/data/__generated__/get_my_profile.req.gql.dart';
import 'package:shelfie/features/account/data/__generated__/get_upload_credentials.data.gql.dart';
import 'package:shelfie/features/account/data/__generated__/get_upload_credentials.req.gql.dart';
import 'package:shelfie/features/account/data/__generated__/update_profile.data.gql.dart';
import 'package:shelfie/features/account/data/__generated__/update_profile.req.gql.dart';
import 'package:shelfie/features/account/domain/upload_credentials.dart';
import 'package:shelfie/features/account/domain/user_profile.dart';

part 'account_repository.g.dart';

@riverpod
AccountRepository accountRepository(AccountRepositoryRef ref) {
  final client = ref.watch(ferryClientProvider);
  return AccountRepository(client: client);
}

class AccountRepository {
  const AccountRepository({required this.client});

  final Client client;

  Future<Either<Failure, UserProfile>> getMyProfile() async {
    final request = GGetMyProfileReq();

    try {
      final response = await client.request(request).first;
      return _handleGetMyProfileResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, UserProfile>> updateProfile({
    required String name,
    String? avatarUrl,
  }) async {
    final request = GUpdateProfileReq(
      (b) => b..vars.input.name = name,
    );

    try {
      final response = await client.request(request).first;
      return _handleUpdateProfileResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, UploadCredentials>> getUploadCredentials() async {
    final request = GGetUploadCredentialsReq();

    try {
      final response = await client.request(request).first;
      return _handleGetUploadCredentialsResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Either<Failure, UploadCredentials> _handleGetUploadCredentialsResponse(
    OperationResponse<GGetUploadCredentialsData, dynamic> response,
  ) {
    if (response.hasErrors) {
      final error = response.graphqlErrors?.firstOrNull;
      final errorMessage = error?.message ?? 'Failed to get upload credentials';
      return left(ServerFailure(message: errorMessage, code: 'GRAPHQL_ERROR'));
    }

    final data = response.data;
    if (data == null) {
      return left(
        const ServerFailure(
          message: 'No data received',
          code: 'NO_DATA',
        ),
      );
    }

    final result = data.getUploadCredentials;
    if (result == null) {
      return left(
        const ServerFailure(
          message: 'Upload credentials response is null',
          code: 'NULL_RESPONSE',
        ),
      );
    }

    if (result
        is GGetUploadCredentialsData_getUploadCredentials__asImageUploadError) {
      return left(
        ServerFailure(
          message: result.message ?? 'Image upload service error',
          code: result.code ?? 'IMAGE_UPLOAD_ERROR',
        ),
      );
    }

    if (result
        is GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess) {
      final credentials = result.data;
      return right(
        UploadCredentials(
          token: credentials.token ?? '',
          signature: credentials.signature ?? '',
          expire: credentials.expire ?? 0,
          publicKey: credentials.publicKey ?? '',
          uploadEndpoint: credentials.uploadEndpoint ?? '',
        ),
      );
    }

    return left(
      const ServerFailure(
        message: 'Unexpected response type',
        code: 'UNEXPECTED_TYPE',
      ),
    );
  }

  Either<Failure, UserProfile> _handleGetMyProfileResponse(
    OperationResponse<GGetMyProfileData, dynamic> response,
  ) {
    if (response.hasErrors) {
      final error = response.graphqlErrors?.firstOrNull;
      final errorMessage = error?.message ?? 'Failed to fetch profile';
      return left(ServerFailure(message: errorMessage, code: 'GRAPHQL_ERROR'));
    }

    final data = response.data;
    if (data == null) {
      return left(
        const ServerFailure(
          message: 'No data received',
          code: 'NO_DATA',
        ),
      );
    }

    final me = data.me;

    if (me is GGetMyProfileData_me__asAuthErrorResult) {
      return left(
        AuthFailure(message: me.message ?? '認証エラーが発生しました'),
      );
    }

    if (me is GGetMyProfileData_me__asUser) {
      return right(_mapToUserProfile(me));
    }

    return left(
      const ServerFailure(
        message: 'Unexpected response type',
        code: 'UNEXPECTED_TYPE',
      ),
    );
  }

  Either<Failure, UserProfile> _handleUpdateProfileResponse(
    OperationResponse<GUpdateProfileData, dynamic> response,
  ) {
    if (response.hasErrors) {
      final error = response.graphqlErrors?.firstOrNull;
      final errorMessage = error?.message ?? 'Failed to update profile';
      return left(ServerFailure(message: errorMessage, code: 'GRAPHQL_ERROR'));
    }

    final data = response.data;
    if (data == null) {
      return left(
        const ServerFailure(
          message: 'No data received',
          code: 'NO_DATA',
        ),
      );
    }

    final result = data.updateProfile;

    if (result is GUpdateProfileData_updateProfile__asValidationError) {
      return left(
        ValidationFailure(
          message: result.message ?? 'バリデーションエラーが発生しました',
          fieldErrors: result.field != null
              ? {result.field!: result.message ?? 'Invalid value'}
              : null,
        ),
      );
    }

    if (result is GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess) {
      return right(_mapUpdateProfileToUserProfile(result.data));
    }

    return left(
      const ServerFailure(
        message: 'Unexpected response type',
        code: 'UNEXPECTED_TYPE',
      ),
    );
  }

  UserProfile _mapToUserProfile(GGetMyProfileData_me__asUser user) {
    final createdAt = user.createdAt ?? DateTime.now();
    return UserProfile(
      id: user.id ?? 0,
      email: user.email ?? '',
      name: user.name,
      avatarUrl: user.avatarUrl,
      username: user.name != null ? '@${user.name}' : null,
      bookCount: user.bookCount,
      readingStartYear: createdAt.year,
      readingStartMonth: createdAt.month,
      createdAt: createdAt,
    );
  }

  UserProfile _mapUpdateProfileToUserProfile(
    GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data user,
  ) {
    final createdAt = user.createdAt ?? DateTime.now();
    return UserProfile(
      id: user.id ?? 0,
      email: user.email ?? '',
      name: user.name,
      avatarUrl: user.avatarUrl,
      username: user.name != null ? '@${user.name}' : null,
      bookCount: user.bookCount,
      readingStartYear: createdAt.year,
      readingStartMonth: createdAt.month,
      createdAt: createdAt,
    );
  }
}
