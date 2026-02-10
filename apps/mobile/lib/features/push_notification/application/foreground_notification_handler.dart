import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ForegroundNotificationHandler {
  ForegroundNotificationHandler({
    required FlutterLocalNotificationsPlugin localNotifications,
  }) : _localNotifications = localNotifications;

  final FlutterLocalNotificationsPlugin _localNotifications;
  StreamSubscription<RemoteMessage>? _subscription;

  static const _channelId = 'high_importance_channel';
  static const _channelName = 'High Importance Notifications';

  void handleForegroundMessage(Stream<RemoteMessage> onMessage) {
    _subscription?.cancel();
    _subscription = onMessage.listen(_onMessage);
  }

  void _onMessage(RemoteMessage message) {
    final notification = message.notification;
    if (notification == null) return;

    const androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      importance: Importance.high,
      priority: Priority.high,
    );
    const notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      notificationDetails,
      payload: message.data['route'] as String?,
    );
  }

  void dispose() {
    _subscription?.cancel();
    _subscription = null;
  }
}
