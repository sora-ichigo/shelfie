import 'dart:async';
import 'dart:io';

import 'package:ferry/ferry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart';
import 'package:shelfie/core/network/ferry_client.dart';
import 'package:shelfie/features/follow/domain/follow_status_type.dart';
import 'package:shelfie/features/follow/domain/user_summary.dart';
import 'package:shelfie/features/notification/data/__generated__/mark_notifications_as_read.data.gql.dart';
import 'package:shelfie/features/notification/data/__generated__/mark_notifications_as_read.req.gql.dart';
import 'package:shelfie/features/notification/data/__generated__/notifications.data.gql.dart';
import 'package:shelfie/features/notification/data/__generated__/notifications.req.gql.dart';
import 'package:shelfie/features/notification/data/__generated__/unread_notification_count.data.gql.dart';
import 'package:shelfie/features/notification/data/__generated__/unread_notification_count.req.gql.dart';
import 'package:shelfie/features/notification/domain/notification_model.dart';
import 'package:shelfie/features/notification/domain/notification_type.dart';

part 'notification_repository.g.dart';

@riverpod
NotificationRepository notificationRepository(Ref ref) {
  final client = ref.watch(ferryClientProvider);
  return NotificationRepository(client: client);
}

class NotificationRepository {
  const NotificationRepository({required this.client});

  final Client client;

  Future<Either<Failure, List<NotificationModel>>> getNotifications({
    int? cursor,
    int? limit,
  }) async {
    final request = GNotificationsReq(
      (b) => b
        ..vars.cursor = cursor
        ..vars.limit = limit,
    );

    try {
      final response = await client.request(request).first;
      return _handleNotificationsResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, int>> getUnreadCount() async {
    final request = GUnreadNotificationCountReq();

    try {
      final response = await client.request(request).first;
      return _handleUnreadCountResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, void>> markAllAsRead() async {
    final request = GMarkNotificationsAsReadReq(
      (b) => b..fetchPolicy = FetchPolicy.NetworkOnly,
    );

    try {
      final response = await client.request(request).first;
      return _handleMarkAllAsReadResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Either<Failure, List<NotificationModel>> _handleNotificationsResponse(
    OperationResponse<GNotificationsData, dynamic> response,
  ) {
    if (response.hasErrors) {
      final error = response.graphqlErrors?.firstOrNull;
      final errorMessage = error?.message ?? 'Failed to fetch notifications';
      return left(ServerFailure(message: errorMessage, code: 'GRAPHQL_ERROR'));
    }

    final data = response.data;
    if (data == null) {
      return left(
        const ServerFailure(message: 'No data received', code: 'NO_DATA'),
      );
    }

    final notifications = data.notifications.map(_mapToNotificationModel).toList();
    return right(notifications);
  }

  Either<Failure, int> _handleUnreadCountResponse(
    OperationResponse<GUnreadNotificationCountData, dynamic> response,
  ) {
    if (response.hasErrors) {
      final error = response.graphqlErrors?.firstOrNull;
      final errorMessage =
          error?.message ?? 'Failed to fetch unread notification count';
      return left(ServerFailure(message: errorMessage, code: 'GRAPHQL_ERROR'));
    }

    final data = response.data;
    if (data == null) {
      return left(
        const ServerFailure(message: 'No data received', code: 'NO_DATA'),
      );
    }

    return right(data.unreadNotificationCount);
  }

  Either<Failure, void> _handleMarkAllAsReadResponse(
    OperationResponse<GMarkNotificationsAsReadData, dynamic> response,
  ) {
    if (response.hasErrors) {
      final error = response.graphqlErrors?.firstOrNull;
      final errorMessage =
          error?.message ?? 'Failed to mark notifications as read';
      return left(ServerFailure(message: errorMessage, code: 'GRAPHQL_ERROR'));
    }

    final data = response.data;
    if (data == null) {
      return left(
        const ServerFailure(message: 'No data received', code: 'NO_DATA'),
      );
    }

    if (data.markNotificationsAsRead ?? false) {
      return right(null);
    }

    return left(
      const ServerFailure(
        message: 'Failed to mark notifications as read',
        code: 'MARK_READ_FAILED',
      ),
    );
  }

  NotificationModel _mapToNotificationModel(
    GNotificationsData_notifications notification,
  ) {
    return NotificationModel(
      id: notification.id,
      sender: UserSummary(
        id: notification.sender.id ?? 0,
        name: notification.sender.name,
        avatarUrl: notification.sender.avatarUrl,
        handle: notification.sender.handle,
      ),
      type: _mapNotificationType(notification.type),
      followStatus: _mapFollowStatus(notification.followStatus),
      followRequestId: notification.followRequestId,
      isRead: notification.isRead,
      createdAt: notification.createdAt,
    );
  }

  NotificationType _mapNotificationType(GNotificationType type) {
    return switch (type) {
      GNotificationType.FOLLOW_REQUEST_RECEIVED =>
        NotificationType.followRequestReceived,
      GNotificationType.FOLLOW_REQUEST_APPROVED =>
        NotificationType.followRequestApproved,
      _ => NotificationType.followRequestReceived,
    };
  }

  FollowStatusType _mapFollowStatus(GFollowStatus status) {
    return switch (status) {
      GFollowStatus.NONE => FollowStatusType.none,
      GFollowStatus.PENDING_SENT => FollowStatusType.pendingSent,
      GFollowStatus.PENDING_RECEIVED => FollowStatusType.pendingReceived,
      GFollowStatus.FOLLOWING => FollowStatusType.following,
      GFollowStatus.FOLLOWED_BY => FollowStatusType.followedBy,
      _ => FollowStatusType.none,
    };
  }
}
