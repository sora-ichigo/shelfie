import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationTapHandler {
  NotificationTapHandler({
    required FirebaseMessaging messaging,
    required void Function(String route) onNavigate,
  })  : _messaging = messaging,
        _onNavigate = onNavigate;

  final FirebaseMessaging _messaging;
  final void Function(String route) _onNavigate;
  StreamSubscription<RemoteMessage>? _subscription;

  void setupFCMHandlers({
    required Stream<RemoteMessage> onMessageOpenedApp,
  }) {
    _messaging.getInitialMessage().then(_handleMessage);
    _subscription?.cancel();
    _subscription = onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage? message) {
    if (message == null) return;
    final route = message.data['route'] as String?;
    if (route == null || route.isEmpty) return;
    _onNavigate(route);
  }

  void onLocalNotificationTap(NotificationResponse response) {
    final payload = response.payload;
    if (payload == null || payload.isEmpty) return;
    _onNavigate(payload);
  }

  void dispose() {
    _subscription?.cancel();
    _subscription = null;
  }
}
