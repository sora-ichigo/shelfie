import 'dart:async';
import 'dart:io';

import 'package:ferry/ferry.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/repository/base_repository.dart';

class MockClient extends Mock implements Client {}

class MockOperationRequest extends Mock implements OperationRequest<String, Map<String, dynamic>> {}

class FakeOperationRequest extends Fake implements OperationRequest<String, Map<String, dynamic>> {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeOperationRequest());
  });

  group('BaseRepository', () {
    late MockClient mockClient;
    late TestRepository repository;

    setUp(() {
      mockClient = MockClient();
      repository = TestRepository(mockClient);
    });

    group('executeQuery', () {
      test('成功時は Right(data) を返すこと', () async {
        const testData = 'test-data';
        final request = MockOperationRequest();

        when(() => mockClient.request(any<OperationRequest<String, Map<String, dynamic>>>()))
            .thenAnswer((_) => Stream.value(
                  OperationResponse<String, Map<String, dynamic>>(
                    operationRequest: request,
                    data: testData,
                  ),
                ));

        final result = await repository.testExecuteQuery(request);

        expect(result.isRight(), isTrue);
        expect(result.getOrElse((_) => ''), equals(testData));
      });

      test('GraphQL エラー時は Left(ServerFailure) を返すこと', () async {
        final request = MockOperationRequest();
        final graphqlError = GraphQLError(message: 'Test GraphQL Error');

        when(() => mockClient.request(any<OperationRequest<String, Map<String, dynamic>>>()))
            .thenAnswer((_) => Stream.value(
                  OperationResponse<String, Map<String, dynamic>>(
                    operationRequest: request,
                    graphqlErrors: [graphqlError],
                  ),
                ));

        final result = await repository.testExecuteQuery(request);

        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect((failure as ServerFailure).message, contains('Test GraphQL Error'));
          },
          (_) => fail('Expected Left'),
        );
      });

      test('データが null の場合は Left(ServerFailure) を返すこと', () async {
        final request = MockOperationRequest();

        when(() => mockClient.request(any<OperationRequest<String, Map<String, dynamic>>>()))
            .thenAnswer((_) => Stream.value(
                  OperationResponse<String, Map<String, dynamic>>(
                    operationRequest: request,
                  ),
                ));

        final result = await repository.testExecuteQuery(request);

        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect((failure as ServerFailure).code, equals('NO_DATA'));
          },
          (_) => fail('Expected Left'),
        );
      });

      test('SocketException 時は Left(NetworkFailure) を返すこと', () async {
        final request = MockOperationRequest();

        when(() => mockClient.request(any<OperationRequest<String, Map<String, dynamic>>>()))
            .thenAnswer((_) => Stream.error(const SocketException('No internet')));

        final result = await repository.testExecuteQuery(request);

        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) => expect(failure, isA<NetworkFailure>()),
          (_) => fail('Expected Left'),
        );
      });

      test('TimeoutException 時は Left(NetworkFailure) を返すこと', () async {
        final request = MockOperationRequest();

        when(() => mockClient.request(any<OperationRequest<String, Map<String, dynamic>>>()))
            .thenAnswer((_) => Stream.error(TimeoutException('Request timeout')));

        final result = await repository.testExecuteQuery(request);

        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) {
            expect(failure, isA<NetworkFailure>());
            expect((failure as NetworkFailure).message, contains('timeout'));
          },
          (_) => fail('Expected Left'),
        );
      });

      test('その他の例外時は Left(UnexpectedFailure) を返すこと', () async {
        final request = MockOperationRequest();

        when(() => mockClient.request(any<OperationRequest<String, Map<String, dynamic>>>()))
            .thenAnswer((_) => Stream.error(Exception('Unknown error')));

        final result = await repository.testExecuteQuery(request);

        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) => expect(failure, isA<UnexpectedFailure>()),
          (_) => fail('Expected Left'),
        );
      });
    });

    group('executeMutation', () {
      test('成功時は Right(data) を返すこと', () async {
        const testData = 'mutation-result';
        final request = MockOperationRequest();

        when(() => mockClient.request(any<OperationRequest<String, Map<String, dynamic>>>()))
            .thenAnswer((_) => Stream.value(
                  OperationResponse<String, Map<String, dynamic>>(
                    operationRequest: request,
                    data: testData,
                  ),
                ));

        final result = await repository.testExecuteMutation(request);

        expect(result.isRight(), isTrue);
        expect(result.getOrElse((_) => ''), equals(testData));
      });

      test('GraphQL エラー時は Left(ServerFailure) を返すこと', () async {
        final request = MockOperationRequest();
        final graphqlError = GraphQLError(message: 'Mutation Error');

        when(() => mockClient.request(any<OperationRequest<String, Map<String, dynamic>>>()))
            .thenAnswer((_) => Stream.value(
                  OperationResponse<String, Map<String, dynamic>>(
                    operationRequest: request,
                    graphqlErrors: [graphqlError],
                  ),
                ));

        final result = await repository.testExecuteMutation(request);

        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) => expect(failure, isA<ServerFailure>()),
          (_) => fail('Expected Left'),
        );
      });
    });

    group('executeQueryWithRetry', () {
      test('リトライ回数を超えた場合はエラーを返すこと', () async {
        final request = MockOperationRequest();
        var callCount = 0;

        when(() => mockClient.request(any<OperationRequest<String, Map<String, dynamic>>>()))
            .thenAnswer((_) {
          callCount++;
          return Stream.error(const SocketException('No internet'));
        });

        final result = await repository.testExecuteQueryWithRetry(request, maxRetries: 3);

        expect(result.isLeft(), isTrue);
        expect(callCount, equals(3));
      });

      test('リトライ中に成功した場合は Right を返すこと', () async {
        final request = MockOperationRequest();
        var callCount = 0;

        when(() => mockClient.request(any<OperationRequest<String, Map<String, dynamic>>>()))
            .thenAnswer((_) {
          callCount++;
          if (callCount < 2) {
            return Stream.error(const SocketException('No internet'));
          }
          return Stream.value(
            OperationResponse<String, Map<String, dynamic>>(
              operationRequest: request,
              data: 'success',
            ),
          );
        });

        final result = await repository.testExecuteQueryWithRetry(request, maxRetries: 3);

        expect(result.isRight(), isTrue);
        expect(callCount, equals(2));
      });

      test('リトライ対象外のエラーはリトライせずに返すこと', () async {
        final request = MockOperationRequest();
        var callCount = 0;

        when(() => mockClient.request(any<OperationRequest<String, Map<String, dynamic>>>()))
            .thenAnswer((_) {
          callCount++;
          return Stream.value(
            OperationResponse<String, Map<String, dynamic>>(
              operationRequest: request,
              graphqlErrors: [GraphQLError(message: 'Business Error')],
            ),
          );
        });

        final result = await repository.testExecuteQueryWithRetry(request, maxRetries: 3);

        expect(result.isLeft(), isTrue);
        expect(callCount, equals(1)); // リトライなし
      });
    });

    group('ローディング状態管理', () {
      test('ローディング状態を取得できること', () {
        expect(repository.isLoading, isFalse);
      });

      test('クエリ実行中はローディング状態が true になること', () async {
        final request = MockOperationRequest();
        final completer = Completer<OperationResponse<String, Map<String, dynamic>>>();

        when(() => mockClient.request(any<OperationRequest<String, Map<String, dynamic>>>()))
            .thenAnswer((_) => completer.future.asStream());

        final future = repository.testExecuteQueryWithLoading(request);

        // クエリ実行中
        expect(repository.isLoading, isTrue);

        // クエリ完了
        completer.complete(
          OperationResponse<String, Map<String, dynamic>>(
            operationRequest: request,
            data: 'data',
          ),
        );

        await future;

        expect(repository.isLoading, isFalse);
      });
    });
  });
}

/// テスト用の具体的な Repository 実装
class TestRepository extends BaseRepository {
  TestRepository(super.client);

  Future<Either<Failure, String>> testExecuteQuery(
    OperationRequest<String, Map<String, dynamic>> request,
  ) {
    return executeQuery<String, Map<String, dynamic>>(request);
  }

  Future<Either<Failure, String>> testExecuteMutation(
    OperationRequest<String, Map<String, dynamic>> request,
  ) {
    return executeMutation<String, Map<String, dynamic>>(request);
  }

  Future<Either<Failure, String>> testExecuteQueryWithRetry(
    OperationRequest<String, Map<String, dynamic>> request, {
    int maxRetries = 3,
  }) {
    return executeQueryWithRetry<String, Map<String, dynamic>>(
      request,
      maxRetries: maxRetries,
    );
  }

  Future<Either<Failure, String>> testExecuteQueryWithLoading(
    OperationRequest<String, Map<String, dynamic>> request,
  ) {
    return executeQueryWithLoading<String, Map<String, dynamic>>(request);
  }
}
