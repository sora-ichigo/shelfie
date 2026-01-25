import 'package:ferry/ferry.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:gql_exec/gql_exec.dart' as gql;
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/features/account/data/__generated__/get_my_profile.data.gql.dart';
import 'package:shelfie/features/account/data/__generated__/get_my_profile.req.gql.dart';
import 'package:shelfie/features/account/data/__generated__/get_my_profile.var.gql.dart';
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
  });
}
