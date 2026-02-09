import 'dart:async';
import 'dart:io' show Platform;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/features/push_notification/data/device_token_repository.dart';

part 'device_token_notifier.g.dart';

abstract class FirebaseMessagingWrapper {
  Future<String?> getToken();
  String getPlatform();
  Stream<String> get onTokenRefresh;
}

class FirebaseMessagingWrapperImpl implements FirebaseMessagingWrapper {
  FirebaseMessagingWrapperImpl(this._messaging);

  final FirebaseMessaging _messaging;

  @override
  Future<String?> getToken() => _messaging.getToken();

  @override
  String getPlatform() => Platform.isIOS ? 'ios' : 'android';

  @override
  Stream<String> get onTokenRefresh => _messaging.onTokenRefresh;
}

@Riverpod(keepAlive: true)
FirebaseMessagingWrapper firebaseMessagingWrapper(Ref ref) {
  return FirebaseMessagingWrapperImpl(FirebaseMessaging.instance);
}

enum DeviceTokenState {
  idle,
  registering,
  registered,
  error,
}

@Riverpod(keepAlive: true)
class DeviceTokenNotifier extends _$DeviceTokenNotifier {
  String? _currentToken;
  StreamSubscription<String>? _tokenRefreshSubscription;

  @override
  DeviceTokenState build() {
    ref.onDispose(() {
      _tokenRefreshSubscription?.cancel();
    });
    return DeviceTokenState.idle;
  }

  Future<void> syncToken() async {
    final messaging = ref.read(firebaseMessagingWrapperProvider);
    final repository = ref.read(deviceTokenRepositoryProvider);

    final token = await messaging.getToken();
    if (token == null) {
      debugPrint('[DeviceTokenNotifier] FCM token is null, skipping sync');
      return;
    }

    _currentToken = token;
    state = DeviceTokenState.registering;

    final platform = messaging.getPlatform();
    final result = await repository.registerToken(
      token: token,
      platform: platform,
    );

    result.fold(
      (failure) {
        debugPrint('[DeviceTokenNotifier] Failed to register token: $failure');
        state = DeviceTokenState.error;
      },
      (_) {
        state = DeviceTokenState.registered;
      },
    );

    _listenForTokenRefresh();
  }

  void _listenForTokenRefresh() {
    _tokenRefreshSubscription?.cancel();
    final messaging = ref.read(firebaseMessagingWrapperProvider);
    final repository = ref.read(deviceTokenRepositoryProvider);

    _tokenRefreshSubscription = messaging.onTokenRefresh.listen((newToken) {
      _currentToken = newToken;
      final platform = messaging.getPlatform();
      repository.registerToken(token: newToken, platform: platform);
    });
  }

  Future<void> unregisterCurrentToken() async {
    if (_currentToken == null) return;

    final repository = ref.read(deviceTokenRepositoryProvider);
    await repository.unregisterToken(token: _currentToken!);

    _tokenRefreshSubscription?.cancel();
    _tokenRefreshSubscription = null;
    _currentToken = null;
    state = DeviceTokenState.idle;
  }
}
