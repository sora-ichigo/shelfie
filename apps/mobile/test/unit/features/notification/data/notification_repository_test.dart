import 'dart:io';

import 'package:ferry/ferry.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gql_exec/gql_exec.dart' as gql;
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/features/notification/data/__generated__/mark_notifications_as_read.data.gql.dart';
import 'package:shelfie/features/notification/data/__generated__/mark_notifications_as_read.req.gql.dart';
import 'package:shelfie/features/notification/data/__generated__/mark_notifications_as_read.var.gql.dart';
import 'package:shelfie/features/notification/data/__generated__/notifications.data.gql.dart';
import 'package:shelfie/features/notification/data/__generated__/notifications.req.gql.dart';
import 'package:shelfie/features/notification/data/__generated__/notifications.var.gql.dart';
import 'package:shelfie/features/notification/data/__generated__/unread_notification_count.data.gql.dart';
import 'package:shelfie/features/notification/data/__generated__/unread_notification_count.req.gql.dart';
import 'package:shelfie/features/notification/data/__generated__/unread_notification_count.var.gql.dart';
import 'package:shelfie/features/notification/data/notification_repository.dart';
import 'package:shelfie/features/notification/domain/notification_type.dart';

class MockClient extends Mock implements Client {}

void main() {
  late MockClient mockClient;
  late NotificationRepository repository;

  setUp(() {
    mockClient = MockClient();
    repository = NotificationRepository(client: mockClient);
  });

  setUpAll(() {
    registerFallbackValue(GNotificationsReq());
    registerFallbackValue(GUnreadNotificationCountReq());
    registerFallbackValue(GMarkNotificationsAsReadReq());
  });

  group('NotificationRepository', () {
    group('getNotifications', () {
      test('returns List<NotificationModel> when API returns notifications',
          () async {
        final data = GNotificationsData.fromJson({
          'notifications': [
            {
              'id': 1,
              'sender': {
                '__typename': 'User',
                'id': 10,
                'name': 'Alice',
                'avatarUrl': 'https://example.com/alice.png',
                'handle': 'alice',
              },
              'type': 'FOLLOW_REQUEST_RECEIVED',
              'outgoingFollowStatus': 'NONE',
              'incomingFollowStatus': 'PENDING_RECEIVED',
              'followRequestId': 100,
              'isRead': false,
              'createdAt': '2024-06-01T12:00:00Z',
            },
            {
              'id': 2,
              'sender': {
                '__typename': 'User',
                'id': 20,
                'name': 'Bob',
                'avatarUrl': null,
                'handle': 'bob',
              },
              'type': 'FOLLOW_REQUEST_APPROVED',
              'outgoingFollowStatus': 'FOLLOWING',
              'incomingFollowStatus': 'NONE',
              'followRequestId': null,
              'isRead': true,
              'createdAt': '2024-06-02T12:00:00Z',
            },
          ],
        });

        final response =
            OperationResponse<GNotificationsData, GNotificationsVars>(
          operationRequest: GNotificationsReq(),
          data: data,
        );

        when(() => mockClient.request(any<GNotificationsReq>()))
            .thenAnswer((_) => Stream.value(response));

        final result = await repository.getNotifications();

        expect(result.isRight(), isTrue);
        final notifications = result.getRight().toNullable()!;
        expect(notifications.length, equals(2));

        final first = notifications[0];
        expect(first.id, equals(1));
        expect(first.sender.id, equals(10));
        expect(first.sender.name, equals('Alice'));
        expect(first.sender.avatarUrl, equals('https://example.com/alice.png'));
        expect(first.sender.handle, equals('alice'));
        expect(first.type, equals(NotificationType.followRequestReceived));
        expect(first.isRead, isFalse);

        final second = notifications[1];
        expect(second.id, equals(2));
        expect(second.sender.id, equals(20));
        expect(second.sender.name, equals('Bob'));
        expect(second.sender.avatarUrl, isNull);
        expect(second.sender.handle, equals('bob'));
        expect(second.type, equals(NotificationType.followRequestApproved));
        expect(second.isRead, isTrue);
      });

      test('returns empty list when no notifications', () async {
        final data = GNotificationsData.fromJson({
          'notifications': <dynamic>[],
        });

        final response =
            OperationResponse<GNotificationsData, GNotificationsVars>(
          operationRequest: GNotificationsReq(),
          data: data,
        );

        when(() => mockClient.request(any<GNotificationsReq>()))
            .thenAnswer((_) => Stream.value(response));

        final result = await repository.getNotifications();

        expect(result.isRight(), isTrue);
        final notifications = result.getRight().toNullable()!;
        expect(notifications, isEmpty);
      });

      test('passes cursor and limit to request', () async {
        final data = GNotificationsData.fromJson({
          'notifications': <dynamic>[],
        });

        final response =
            OperationResponse<GNotificationsData, GNotificationsVars>(
          operationRequest: GNotificationsReq(),
          data: data,
        );

        when(() => mockClient.request(any<GNotificationsReq>()))
            .thenAnswer((_) => Stream.value(response));

        await repository.getNotifications(cursor: 5, limit: 10);

        final captured = verify(
          () => mockClient.request(captureAny<GNotificationsReq>()),
        ).captured;
        final request = captured.first as GNotificationsReq;
        expect(request.vars.cursor, equals(5));
        expect(request.vars.limit, equals(10));
      });

      test('returns ServerFailure when API returns GraphQL errors', () async {
        final response =
            OperationResponse<GNotificationsData, GNotificationsVars>(
          operationRequest: GNotificationsReq(),
          graphqlErrors: [
            const gql.GraphQLError(message: 'Server error'),
          ],
        );

        when(() => mockClient.request(any<GNotificationsReq>()))
            .thenAnswer((_) => Stream.value(response));

        final result = await repository.getNotifications();

        expect(result.isLeft(), isTrue);
        expect(result.getLeft().toNullable(), isA<ServerFailure>());
      });

      test('returns NetworkFailure on SocketException', () async {
        when(() => mockClient.request(any<GNotificationsReq>()))
            .thenThrow(const SocketException('No internet'));

        final result = await repository.getNotifications();

        expect(result.isLeft(), isTrue);
        expect(result.getLeft().toNullable(), isA<NetworkFailure>());
      });

      test('returns ServerFailure when data is null', () async {
        final response =
            OperationResponse<GNotificationsData, GNotificationsVars>(
          operationRequest: GNotificationsReq(),
          data: null,
        );

        when(() => mockClient.request(any<GNotificationsReq>()))
            .thenAnswer((_) => Stream.value(response));

        final result = await repository.getNotifications();

        expect(result.isLeft(), isTrue);
        expect(result.getLeft().toNullable(), isA<ServerFailure>());
      });
    });

    group('getUnreadCount', () {
      test('returns correct count', () async {
        final data = GUnreadNotificationCountData.fromJson({
          'unreadNotificationCount': 5,
        });

        final response = OperationResponse<GUnreadNotificationCountData,
            GUnreadNotificationCountVars>(
          operationRequest: GUnreadNotificationCountReq(),
          data: data,
        );

        when(() => mockClient.request(any<GUnreadNotificationCountReq>()))
            .thenAnswer((_) => Stream.value(response));

        final result = await repository.getUnreadCount();

        expect(result.isRight(), isTrue);
        expect(result.getRight().toNullable(), equals(5));
      });

      test('returns zero when no unread notifications', () async {
        final data = GUnreadNotificationCountData.fromJson({
          'unreadNotificationCount': 0,
        });

        final response = OperationResponse<GUnreadNotificationCountData,
            GUnreadNotificationCountVars>(
          operationRequest: GUnreadNotificationCountReq(),
          data: data,
        );

        when(() => mockClient.request(any<GUnreadNotificationCountReq>()))
            .thenAnswer((_) => Stream.value(response));

        final result = await repository.getUnreadCount();

        expect(result.isRight(), isTrue);
        expect(result.getRight().toNullable(), equals(0));
      });

      test('returns ServerFailure when API returns GraphQL errors', () async {
        final response = OperationResponse<GUnreadNotificationCountData,
            GUnreadNotificationCountVars>(
          operationRequest: GUnreadNotificationCountReq(),
          graphqlErrors: [
            const gql.GraphQLError(message: 'Server error'),
          ],
        );

        when(() => mockClient.request(any<GUnreadNotificationCountReq>()))
            .thenAnswer((_) => Stream.value(response));

        final result = await repository.getUnreadCount();

        expect(result.isLeft(), isTrue);
        expect(result.getLeft().toNullable(), isA<ServerFailure>());
      });

      test('returns NetworkFailure on SocketException', () async {
        when(() => mockClient.request(any<GUnreadNotificationCountReq>()))
            .thenThrow(const SocketException('No internet'));

        final result = await repository.getUnreadCount();

        expect(result.isLeft(), isTrue);
        expect(result.getLeft().toNullable(), isA<NetworkFailure>());
      });

      test('returns ServerFailure when data is null', () async {
        final response = OperationResponse<GUnreadNotificationCountData,
            GUnreadNotificationCountVars>(
          operationRequest: GUnreadNotificationCountReq(),
          data: null,
        );

        when(() => mockClient.request(any<GUnreadNotificationCountReq>()))
            .thenAnswer((_) => Stream.value(response));

        final result = await repository.getUnreadCount();

        expect(result.isLeft(), isTrue);
        expect(result.getLeft().toNullable(), isA<ServerFailure>());
      });
    });

    group('markAllAsRead', () {
      test('returns right(null) on success', () async {
        final data = GMarkNotificationsAsReadData.fromJson({
          'markNotificationsAsRead': true,
        });

        final response = OperationResponse<GMarkNotificationsAsReadData,
            GMarkNotificationsAsReadVars>(
          operationRequest: GMarkNotificationsAsReadReq(),
          data: data,
        );

        when(() => mockClient.request(any<GMarkNotificationsAsReadReq>()))
            .thenAnswer((_) => Stream.value(response));

        final result = await repository.markAllAsRead();

        expect(result.isRight(), isTrue);
      });

      test('uses NetworkOnly fetch policy', () async {
        final data = GMarkNotificationsAsReadData.fromJson({
          'markNotificationsAsRead': true,
        });

        final response = OperationResponse<GMarkNotificationsAsReadData,
            GMarkNotificationsAsReadVars>(
          operationRequest: GMarkNotificationsAsReadReq(),
          data: data,
        );

        when(() => mockClient.request(any<GMarkNotificationsAsReadReq>()))
            .thenAnswer((_) => Stream.value(response));

        await repository.markAllAsRead();

        final captured = verify(
          () => mockClient.request(captureAny<GMarkNotificationsAsReadReq>()),
        ).captured;
        final request = captured.first as GMarkNotificationsAsReadReq;
        expect(request.fetchPolicy, FetchPolicy.NetworkOnly);
      });

      test('returns ServerFailure when markNotificationsAsRead is not true',
          () async {
        final data = GMarkNotificationsAsReadData.fromJson({
          'markNotificationsAsRead': false,
        });

        final response = OperationResponse<GMarkNotificationsAsReadData,
            GMarkNotificationsAsReadVars>(
          operationRequest: GMarkNotificationsAsReadReq(),
          data: data,
        );

        when(() => mockClient.request(any<GMarkNotificationsAsReadReq>()))
            .thenAnswer((_) => Stream.value(response));

        final result = await repository.markAllAsRead();

        expect(result.isLeft(), isTrue);
        expect(result.getLeft().toNullable(), isA<ServerFailure>());
      });

      test('returns ServerFailure when API returns GraphQL errors', () async {
        final response = OperationResponse<GMarkNotificationsAsReadData,
            GMarkNotificationsAsReadVars>(
          operationRequest: GMarkNotificationsAsReadReq(),
          graphqlErrors: [
            const gql.GraphQLError(message: 'Server error'),
          ],
        );

        when(() => mockClient.request(any<GMarkNotificationsAsReadReq>()))
            .thenAnswer((_) => Stream.value(response));

        final result = await repository.markAllAsRead();

        expect(result.isLeft(), isTrue);
        expect(result.getLeft().toNullable(), isA<ServerFailure>());
      });

      test('returns NetworkFailure on SocketException', () async {
        when(() => mockClient.request(any<GMarkNotificationsAsReadReq>()))
            .thenThrow(const SocketException('No internet'));

        final result = await repository.markAllAsRead();

        expect(result.isLeft(), isTrue);
        expect(result.getLeft().toNullable(), isA<NetworkFailure>());
      });

      test('returns ServerFailure when data is null', () async {
        final response = OperationResponse<GMarkNotificationsAsReadData,
            GMarkNotificationsAsReadVars>(
          operationRequest: GMarkNotificationsAsReadReq(),
          data: null,
        );

        when(() => mockClient.request(any<GMarkNotificationsAsReadReq>()))
            .thenAnswer((_) => Stream.value(response));

        final result = await repository.markAllAsRead();

        expect(result.isLeft(), isTrue);
        expect(result.getLeft().toNullable(), isA<ServerFailure>());
      });
    });
  });
}
