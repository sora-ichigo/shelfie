import 'package:ferry/ferry.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gql_exec/gql_exec.dart' as gql;
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/features/account/data/__generated__/get_my_profile.data.gql.dart';
import 'package:shelfie/features/account/data/__generated__/get_my_profile.req.gql.dart';
import 'package:shelfie/features/account/data/__generated__/get_my_profile.var.gql.dart';
import 'package:shelfie/features/account/data/__generated__/get_upload_credentials.data.gql.dart';
import 'package:shelfie/features/account/data/__generated__/get_upload_credentials.req.gql.dart';
import 'package:shelfie/features/account/data/__generated__/get_upload_credentials.var.gql.dart';
import 'package:shelfie/features/account/data/__generated__/update_profile.data.gql.dart';
import 'package:shelfie/features/account/data/__generated__/update_profile.req.gql.dart';
import 'package:shelfie/features/account/data/__generated__/update_profile.var.gql.dart';
import 'package:shelfie/features/account/data/account_repository.dart';

class MockClient extends Mock implements Client {}

void main() {
  late MockClient mockClient;
  late AccountRepository repository;

  setUp(() {
    mockClient = MockClient();
    repository = AccountRepository(client: mockClient);
  });

  setUpAll(() {
    registerFallbackValue(GGetMyProfileReq());
    registerFallbackValue(
      GUpdateProfileReq((b) => b..vars.input.name = 'test'),
    );
    registerFallbackValue(GGetUploadCredentialsReq());
  });

  group('AccountRepository', () {
    group('getMyProfile', () {
      test('returns UserProfile when API returns User', () async {
        final data = GGetMyProfileData.fromJson({
          'me': {
            '__typename': 'User',
            'id': 1,
            'email': 'test@example.com',
            'name': 'Test User',
            'avatarUrl': 'https://example.com/avatar.png',
            'createdAt': '2024-01-01T00:00:00Z',
            'bookCount': 5,
            'readingCount': 1,
            'backlogCount': 2,
            'completedCount': 1,
            'interestedCount': 1,
          },
        });

        final response = OperationResponse<GGetMyProfileData, GGetMyProfileVars>(
          operationRequest: GGetMyProfileReq(),
          data: data,
        );

        when(() => mockClient.request(any<GGetMyProfileReq>()))
            .thenAnswer((_) => Stream.value(response));

        final result = await repository.getMyProfile();

        expect(result.isRight(), isTrue);
        final profile = result.getRight().toNullable()!;
        expect(profile.id, equals(1));
        expect(profile.email, equals('test@example.com'));
        expect(profile.name, equals('Test User'));
        expect(profile.avatarUrl, equals('https://example.com/avatar.png'));
      });

      test('returns AuthFailure when API returns AuthErrorResult', () async {
        final data = GGetMyProfileData.fromJson({
          'me': {
            '__typename': 'AuthErrorResult',
            'code': 'UNAUTHENTICATED',
            'message': '認証が必要です',
          },
        });

        final response = OperationResponse<GGetMyProfileData, GGetMyProfileVars>(
          operationRequest: GGetMyProfileReq(),
          data: data,
        );

        when(() => mockClient.request(any<GGetMyProfileReq>()))
            .thenAnswer((_) => Stream.value(response));

        final result = await repository.getMyProfile();

        expect(result.isLeft(), isTrue);
        expect(result.getLeft().toNullable(), isA<AuthFailure>());
      });

      test('returns ServerFailure when API returns GraphQL errors', () async {
        final response = OperationResponse<GGetMyProfileData, GGetMyProfileVars>(
          operationRequest: GGetMyProfileReq(),
          graphqlErrors: [
            const gql.GraphQLError(message: 'Server error'),
          ],
        );

        when(() => mockClient.request(any<GGetMyProfileReq>()))
            .thenAnswer((_) => Stream.value(response));

        final result = await repository.getMyProfile();

        expect(result.isLeft(), isTrue);
        expect(result.getLeft().toNullable(), isA<ServerFailure>());
      });

      test('uses NetworkOnly fetch policy to bypass cache', () async {
        final data = GGetMyProfileData.fromJson({
          'me': {
            '__typename': 'User',
            'id': 1,
            'email': 'test@example.com',
            'name': 'Test User',
            'avatarUrl': null,
            'createdAt': '2024-01-01T00:00:00Z',
            'bookCount': 5,
            'readingCount': 1,
            'backlogCount': 2,
            'completedCount': 1,
            'interestedCount': 1,
          },
        });

        final response = OperationResponse<GGetMyProfileData, GGetMyProfileVars>(
          operationRequest: GGetMyProfileReq(),
          data: data,
        );

        when(() => mockClient.request(any<GGetMyProfileReq>()))
            .thenAnswer((_) => Stream.value(response));

        await repository.getMyProfile();

        final captured = verify(
          () => mockClient.request(captureAny<GGetMyProfileReq>()),
        ).captured;
        final request = captured.first as GGetMyProfileReq;
        expect(request.fetchPolicy, FetchPolicy.NetworkOnly);
      });
    });

    group('updateProfile', () {
      test('returns UserProfile on success', () async {
        final data = GUpdateProfileData.fromJson({
          'updateProfile': {
            '__typename': 'MutationUpdateProfileSuccess',
            'data': {
              'id': 1,
              'email': 'test@example.com',
              'name': 'Updated Name',
              'avatarUrl': 'https://example.com/avatar.png',
              'createdAt': '2024-01-01T00:00:00Z',
              'bookCount': 10,
              'readingCount': 2,
              'backlogCount': 3,
              'completedCount': 4,
              'interestedCount': 1,
            },
          },
        });

        final response = OperationResponse<GUpdateProfileData, GUpdateProfileVars>(
          operationRequest: GUpdateProfileReq((b) => b..vars.input.name = 'Updated Name'),
          data: data,
        );

        when(() => mockClient.request(any<GUpdateProfileReq>()))
            .thenAnswer((_) => Stream.value(response));

        final result = await repository.updateProfile(name: 'Updated Name');

        expect(result.isRight(), isTrue);
        final profile = result.getRight().toNullable()!;
        expect(profile.name, equals('Updated Name'));
      });

      test('returns ValidationFailure on ValidationError', () async {
        final data = GUpdateProfileData.fromJson({
          'updateProfile': {
            '__typename': 'ValidationError',
            'code': 'VALIDATION_ERROR',
            'message': '名前は必須です',
            'field': 'name',
          },
        });

        final response = OperationResponse<GUpdateProfileData, GUpdateProfileVars>(
          operationRequest: GUpdateProfileReq((b) => b..vars.input.name = ''),
          data: data,
        );

        when(() => mockClient.request(any<GUpdateProfileReq>()))
            .thenAnswer((_) => Stream.value(response));

        final result = await repository.updateProfile(name: '');

        expect(result.isLeft(), isTrue);
        expect(result.getLeft().toNullable(), isA<ValidationFailure>());
      });
    });

    group('getUploadCredentials', () {
      test('returns UploadCredentials on success', () async {
        final data = GGetUploadCredentialsData.fromJson({
          'getUploadCredentials': {
            '__typename': 'QueryGetUploadCredentialsSuccess',
            'data': {
              'token': 'test-token-123',
              'signature': 'test-signature-456',
              'expire': 1706200000,
              'publicKey': 'public_test_key',
              'uploadEndpoint': 'https://upload.imagekit.io/api/v1/files/upload',
            },
          },
        });

        final response =
            OperationResponse<GGetUploadCredentialsData, GGetUploadCredentialsVars>(
          operationRequest: GGetUploadCredentialsReq(),
          data: data,
        );

        when(() => mockClient.request(any<GGetUploadCredentialsReq>()))
            .thenAnswer((_) => Stream.value(response));

        final result = await repository.getUploadCredentials();

        expect(result.isRight(), isTrue);
        final credentials = result.getRight().toNullable()!;
        expect(credentials.token, equals('test-token-123'));
        expect(credentials.signature, equals('test-signature-456'));
        expect(credentials.expire, equals(1706200000));
        expect(credentials.publicKey, equals('public_test_key'));
        expect(
          credentials.uploadEndpoint,
          equals('https://upload.imagekit.io/api/v1/files/upload'),
        );
      });

      test('returns ServerFailure on ImageUploadError', () async {
        final data = GGetUploadCredentialsData.fromJson({
          'getUploadCredentials': {
            '__typename': 'ImageUploadError',
            'code': 'CONFIGURATION_ERROR',
            'message': 'ImageKit is not configured',
          },
        });

        final response =
            OperationResponse<GGetUploadCredentialsData, GGetUploadCredentialsVars>(
          operationRequest: GGetUploadCredentialsReq(),
          data: data,
        );

        when(() => mockClient.request(any<GGetUploadCredentialsReq>()))
            .thenAnswer((_) => Stream.value(response));

        final result = await repository.getUploadCredentials();

        expect(result.isLeft(), isTrue);
        expect(result.getLeft().toNullable(), isA<ServerFailure>());
      });

      test('returns ServerFailure when response is null', () async {
        final data = GGetUploadCredentialsData.fromJson({
          'getUploadCredentials': null,
        });

        final response =
            OperationResponse<GGetUploadCredentialsData, GGetUploadCredentialsVars>(
          operationRequest: GGetUploadCredentialsReq(),
          data: data,
        );

        when(() => mockClient.request(any<GGetUploadCredentialsReq>()))
            .thenAnswer((_) => Stream.value(response));

        final result = await repository.getUploadCredentials();

        expect(result.isLeft(), isTrue);
        expect(result.getLeft().toNullable(), isA<ServerFailure>());
      });

      test('returns ServerFailure when API returns GraphQL errors', () async {
        final response =
            OperationResponse<GGetUploadCredentialsData, GGetUploadCredentialsVars>(
          operationRequest: GGetUploadCredentialsReq(),
          graphqlErrors: [
            const gql.GraphQLError(message: 'Unauthorized'),
          ],
        );

        when(() => mockClient.request(any<GGetUploadCredentialsReq>()))
            .thenAnswer((_) => Stream.value(response));

        final result = await repository.getUploadCredentials();

        expect(result.isLeft(), isTrue);
        expect(result.getLeft().toNullable(), isA<ServerFailure>());
      });
    });
  });
}
