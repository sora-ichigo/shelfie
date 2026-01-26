import 'package:ferry/ferry.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gql_exec/gql_exec.dart' as gql;
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/features/account/data/__generated__/change_password.data.gql.dart';
import 'package:shelfie/features/account/data/__generated__/change_password.req.gql.dart';
import 'package:shelfie/features/account/data/__generated__/change_password.var.gql.dart';
import 'package:shelfie/features/account/data/__generated__/send_password_reset_email.data.gql.dart';
import 'package:shelfie/features/account/data/__generated__/send_password_reset_email.req.gql.dart';
import 'package:shelfie/features/account/data/__generated__/send_password_reset_email.var.gql.dart';
import 'package:shelfie/features/account/data/password_repository.dart';

class MockClient extends Mock implements Client {}

void main() {
  late MockClient mockClient;
  late PasswordRepository repository;

  setUp(() {
    mockClient = MockClient();
    repository = PasswordRepository(client: mockClient);
  });

  setUpAll(() {
    registerFallbackValue(
      GChangePasswordReq(
        (b) => b
          ..vars.input.email = 'test@example.com'
          ..vars.input.currentPassword = 'oldPassword123'
          ..vars.input.newPassword = 'newPassword123',
      ),
    );
    registerFallbackValue(
      GSendPasswordResetEmailReq(
        (b) => b..vars.input.email = 'test@example.com',
      ),
    );
  });

  group('PasswordRepository', () {
    group('changePassword', () {
      test('成功時に PasswordChangeResult を返す', () async {
        final data = GChangePasswordData.fromJson({
          'changePassword': {
            '__typename': 'MutationChangePasswordSuccess',
            'data': {
              'idToken': 'new-id-token',
              'refreshToken': 'new-refresh-token',
            },
          },
        });

        final response =
            OperationResponse<GChangePasswordData, GChangePasswordVars>(
          operationRequest: GChangePasswordReq(
            (b) => b
              ..vars.input.email = 'test@example.com'
              ..vars.input.currentPassword = 'oldPassword123'
              ..vars.input.newPassword = 'newPassword123',
          ),
          data: data,
        );

        when(() => mockClient.request(any<GChangePasswordReq>()))
            .thenAnswer((_) => Stream.value(response));

        final result = await repository.changePassword(
          email: 'test@example.com',
          currentPassword: 'oldPassword123',
          newPassword: 'newPassword123',
        );

        expect(result.isRight(), isTrue);
        final changeResult = result.getRight().toNullable()!;
        expect(changeResult.idToken, equals('new-id-token'));
        expect(changeResult.refreshToken, equals('new-refresh-token'));
      });

      test('現在のパスワードが間違っている場合、AuthFailure を返す', () async {
        final data = GChangePasswordData.fromJson({
          'changePassword': {
            '__typename': 'AuthError',
            'code': 'INVALID_CREDENTIALS',
            'message': '現在のパスワードが正しくありません',
            'field': 'currentPassword',
            'retryable': false,
          },
        });

        final response =
            OperationResponse<GChangePasswordData, GChangePasswordVars>(
          operationRequest: GChangePasswordReq(
            (b) => b
              ..vars.input.email = 'test@example.com'
              ..vars.input.currentPassword = 'wrongPassword'
              ..vars.input.newPassword = 'newPassword123',
          ),
          data: data,
        );

        when(() => mockClient.request(any<GChangePasswordReq>()))
            .thenAnswer((_) => Stream.value(response));

        final result = await repository.changePassword(
          email: 'test@example.com',
          currentPassword: 'wrongPassword',
          newPassword: 'newPassword123',
        );

        expect(result.isLeft(), isTrue);
        expect(result.getLeft().toNullable(), isA<AuthFailure>());
      });

      test('新しいパスワードが弱い場合、ValidationFailure を返す', () async {
        final data = GChangePasswordData.fromJson({
          'changePassword': {
            '__typename': 'AuthError',
            'code': 'WEAK_PASSWORD',
            'message': '新しいパスワードが弱すぎます',
            'field': 'newPassword',
            'retryable': false,
          },
        });

        final response =
            OperationResponse<GChangePasswordData, GChangePasswordVars>(
          operationRequest: GChangePasswordReq(
            (b) => b
              ..vars.input.email = 'test@example.com'
              ..vars.input.currentPassword = 'oldPassword123'
              ..vars.input.newPassword = 'weak',
          ),
          data: data,
        );

        when(() => mockClient.request(any<GChangePasswordReq>()))
            .thenAnswer((_) => Stream.value(response));

        final result = await repository.changePassword(
          email: 'test@example.com',
          currentPassword: 'oldPassword123',
          newPassword: 'weak',
        );

        expect(result.isLeft(), isTrue);
        expect(result.getLeft().toNullable(), isA<ValidationFailure>());
      });

      test('ネットワークエラーの場合、NetworkFailure を返す', () async {
        final data = GChangePasswordData.fromJson({
          'changePassword': {
            '__typename': 'AuthError',
            'code': 'NETWORK_ERROR',
            'message': 'ネットワークエラーが発生しました',
            'retryable': true,
          },
        });

        final response =
            OperationResponse<GChangePasswordData, GChangePasswordVars>(
          operationRequest: GChangePasswordReq(
            (b) => b
              ..vars.input.email = 'test@example.com'
              ..vars.input.currentPassword = 'oldPassword123'
              ..vars.input.newPassword = 'newPassword123',
          ),
          data: data,
        );

        when(() => mockClient.request(any<GChangePasswordReq>()))
            .thenAnswer((_) => Stream.value(response));

        final result = await repository.changePassword(
          email: 'test@example.com',
          currentPassword: 'oldPassword123',
          newPassword: 'newPassword123',
        );

        expect(result.isLeft(), isTrue);
        expect(result.getLeft().toNullable(), isA<NetworkFailure>());
      });

      test('GraphQL エラーの場合、ServerFailure を返す', () async {
        final response =
            OperationResponse<GChangePasswordData, GChangePasswordVars>(
          operationRequest: GChangePasswordReq(
            (b) => b
              ..vars.input.email = 'test@example.com'
              ..vars.input.currentPassword = 'oldPassword123'
              ..vars.input.newPassword = 'newPassword123',
          ),
          graphqlErrors: [
            const gql.GraphQLError(message: 'Server error'),
          ],
        );

        when(() => mockClient.request(any<GChangePasswordReq>()))
            .thenAnswer((_) => Stream.value(response));

        final result = await repository.changePassword(
          email: 'test@example.com',
          currentPassword: 'oldPassword123',
          newPassword: 'newPassword123',
        );

        expect(result.isLeft(), isTrue);
        expect(result.getLeft().toNullable(), isA<ServerFailure>());
      });
    });

    group('sendPasswordResetEmail', () {
      test('成功時に Right(unit) を返す', () async {
        final data = GSendPasswordResetEmailData.fromJson({
          'sendPasswordResetEmail': {
            '__typename': 'MutationSendPasswordResetEmailSuccess',
            'data': {
              'success': true,
            },
          },
        });

        final response = OperationResponse<GSendPasswordResetEmailData,
            GSendPasswordResetEmailVars>(
          operationRequest: GSendPasswordResetEmailReq(
            (b) => b..vars.input.email = 'test@example.com',
          ),
          data: data,
        );

        when(() => mockClient.request(any<GSendPasswordResetEmailReq>()))
            .thenAnswer((_) => Stream.value(response));

        final result = await repository.sendPasswordResetEmail(
          email: 'test@example.com',
        );

        expect(result.isRight(), isTrue);
      });

      test('ユーザーが見つからない場合、NotFoundFailure を返す', () async {
        final data = GSendPasswordResetEmailData.fromJson({
          'sendPasswordResetEmail': {
            '__typename': 'AuthError',
            'code': 'USER_NOT_FOUND',
            'message': 'このメールアドレスは登録されていません',
            'field': 'email',
            'retryable': false,
          },
        });

        final response = OperationResponse<GSendPasswordResetEmailData,
            GSendPasswordResetEmailVars>(
          operationRequest: GSendPasswordResetEmailReq(
            (b) => b..vars.input.email = 'unknown@example.com',
          ),
          data: data,
        );

        when(() => mockClient.request(any<GSendPasswordResetEmailReq>()))
            .thenAnswer((_) => Stream.value(response));

        final result = await repository.sendPasswordResetEmail(
          email: 'unknown@example.com',
        );

        expect(result.isLeft(), isTrue);
        expect(result.getLeft().toNullable(), isA<NotFoundFailure>());
      });

      test('メールアドレスの形式が不正な場合、ValidationFailure を返す', () async {
        final data = GSendPasswordResetEmailData.fromJson({
          'sendPasswordResetEmail': {
            '__typename': 'AuthError',
            'code': 'INVALID_EMAIL',
            'message': 'メールアドレスの形式が正しくありません',
            'field': 'email',
            'retryable': false,
          },
        });

        final response = OperationResponse<GSendPasswordResetEmailData,
            GSendPasswordResetEmailVars>(
          operationRequest: GSendPasswordResetEmailReq(
            (b) => b..vars.input.email = 'invalid-email',
          ),
          data: data,
        );

        when(() => mockClient.request(any<GSendPasswordResetEmailReq>()))
            .thenAnswer((_) => Stream.value(response));

        final result = await repository.sendPasswordResetEmail(
          email: 'invalid-email',
        );

        expect(result.isLeft(), isTrue);
        expect(result.getLeft().toNullable(), isA<ValidationFailure>());
      });

      test('ネットワークエラーの場合、NetworkFailure を返す', () async {
        final data = GSendPasswordResetEmailData.fromJson({
          'sendPasswordResetEmail': {
            '__typename': 'AuthError',
            'code': 'NETWORK_ERROR',
            'message': 'ネットワークエラーが発生しました',
            'retryable': true,
          },
        });

        final response = OperationResponse<GSendPasswordResetEmailData,
            GSendPasswordResetEmailVars>(
          operationRequest: GSendPasswordResetEmailReq(
            (b) => b..vars.input.email = 'test@example.com',
          ),
          data: data,
        );

        when(() => mockClient.request(any<GSendPasswordResetEmailReq>()))
            .thenAnswer((_) => Stream.value(response));

        final result = await repository.sendPasswordResetEmail(
          email: 'test@example.com',
        );

        expect(result.isLeft(), isTrue);
        expect(result.getLeft().toNullable(), isA<NetworkFailure>());
      });

      test('GraphQL エラーの場合、ServerFailure を返す', () async {
        final response = OperationResponse<GSendPasswordResetEmailData,
            GSendPasswordResetEmailVars>(
          operationRequest: GSendPasswordResetEmailReq(
            (b) => b..vars.input.email = 'test@example.com',
          ),
          graphqlErrors: [
            const gql.GraphQLError(message: 'Server error'),
          ],
        );

        when(() => mockClient.request(any<GSendPasswordResetEmailReq>()))
            .thenAnswer((_) => Stream.value(response));

        final result = await repository.sendPasswordResetEmail(
          email: 'test@example.com',
        );

        expect(result.isLeft(), isTrue);
        expect(result.getLeft().toNullable(), isA<ServerFailure>());
      });
    });
  });
}
