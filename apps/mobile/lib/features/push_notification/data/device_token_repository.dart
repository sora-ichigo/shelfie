import 'dart:async';
import 'dart:io';

import 'package:ferry/ferry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/network/ferry_client.dart';
import 'package:shelfie/features/push_notification/data/__generated__/register_device_token.req.gql.dart';
import 'package:shelfie/features/push_notification/data/__generated__/unregister_device_token.req.gql.dart';

part 'device_token_repository.g.dart';

@riverpod
DeviceTokenRepository deviceTokenRepository(Ref ref) {
  final client = ref.watch(ferryClientProvider);
  return FerryDeviceTokenRepository(client: client);
}

abstract class DeviceTokenRepository {
  Future<Either<Failure, void>> registerToken({
    required String token,
    required String platform,
  });

  Future<Either<Failure, void>> unregisterToken({
    required String token,
  });
}

class FerryDeviceTokenRepository implements DeviceTokenRepository {
  const FerryDeviceTokenRepository({required this.client});

  final Client client;

  @override
  Future<Either<Failure, void>> registerToken({
    required String token,
    required String platform,
  }) async {
    try {
      final request = GRegisterDeviceTokenReq(
        (b) => b
          ..vars.input.token = token
          ..vars.input.platform = platform,
      );
      final response = await client.request(request).first;
      if (response.hasErrors) {
        final errorMessage = response.graphqlErrors?.firstOrNull?.message ??
            'Failed to register device token';
        return left(
          ServerFailure(message: errorMessage, code: 'GRAPHQL_ERROR'),
        );
      }
      return right(null);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> unregisterToken({
    required String token,
  }) async {
    try {
      final request = GUnregisterDeviceTokenReq(
        (b) => b..vars.input.token = token,
      );
      final response = await client.request(request).first;
      if (response.hasErrors) {
        final errorMessage = response.graphqlErrors?.firstOrNull?.message ??
            'Failed to unregister device token';
        return left(
          ServerFailure(message: errorMessage, code: 'GRAPHQL_ERROR'),
        );
      }
      return right(null);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }
}
