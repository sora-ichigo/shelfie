import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/core/storage/secure_storage_service.dart';
import 'package:shelfie/features/push_notification/application/device_token_notifier.dart';

part 'auth_state.g.dart';

@immutable
class AuthStateData {
  const AuthStateData({
    this.isAuthenticated = false,
    this.isGuest = false,
    this.userId,
    this.email,
    this.token,
    this.refreshToken,
  });

  const AuthStateData.initial()
      : isAuthenticated = false,
        isGuest = false,
        userId = null,
        email = null,
        token = null,
        refreshToken = null;

  final bool isAuthenticated;
  final bool isGuest;
  final String? userId;
  final String? email;
  final String? token;
  final String? refreshToken;

  AuthStateData copyWith({
    bool? isAuthenticated,
    bool? isGuest,
    String? userId,
    String? email,
    String? token,
    String? refreshToken,
  }) {
    return AuthStateData(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isGuest: isGuest ?? this.isGuest,
      userId: userId ?? this.userId,
      email: email ?? this.email,
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthStateData &&
        other.isAuthenticated == isAuthenticated &&
        other.isGuest == isGuest &&
        other.userId == userId &&
        other.email == email &&
        other.token == token &&
        other.refreshToken == refreshToken;
  }

  @override
  int get hashCode =>
      Object.hash(isAuthenticated, isGuest, userId, email, token, refreshToken);
}

@Riverpod(keepAlive: true)
class AuthState extends _$AuthState {
  @override
  AuthStateData build() {
    return const AuthStateData.initial();
  }

  Future<void> enterGuestMode() async {
    state = const AuthStateData(isGuest: true);

    final storage = ref.read(secureStorageServiceProvider);
    await storage.saveGuestMode(isGuest: true);
  }

  Future<void> login({
    required String userId,
    required String email,
    required String token,
    required String refreshToken,
  }) async {
    state = AuthStateData(
      isAuthenticated: true,
      userId: userId,
      email: email,
      token: token,
      refreshToken: refreshToken,
    );

    final storage = ref.read(secureStorageServiceProvider);
    await storage.clearGuestMode();
    await storage.saveAuthData(
      userId: userId,
      email: email,
      idToken: token,
      refreshToken: refreshToken,
    );

    try {
      await ref.read(deviceTokenNotifierProvider.notifier).syncToken();
    } catch (e, stackTrace) {
      debugPrint('[AuthState] Device token sync failed: $e');
      Sentry.captureException(e, stackTrace: stackTrace);
    }
  }

  Future<void> updateTokens({
    required String token,
    required String refreshToken,
  }) async {
    state = state.copyWith(
      token: token,
      refreshToken: refreshToken,
    );

    final storage = ref.read(secureStorageServiceProvider);
    await storage.updateTokens(
      idToken: token,
      refreshToken: refreshToken,
    );
  }

  Future<void> logout() async {
    try {
      await ref
          .read(deviceTokenNotifierProvider.notifier)
          .unregisterCurrentToken();
    } catch (_) {
      // ログアウト処理は継続する
    }

    state = const AuthStateData.initial();

    final storage = ref.read(secureStorageServiceProvider);
    await storage.clearAuthData();
    await storage.clearGuestMode();
    ref.read(shelfStateProvider.notifier).clear();
  }

  Future<bool> restoreSession() async {
    final storage = ref.read(secureStorageServiceProvider);
    final authData = await storage.loadAuthData();

    if (authData != null) {
      state = AuthStateData(
        isAuthenticated: true,
        userId: authData.userId,
        email: authData.email,
        token: authData.idToken,
        refreshToken: authData.refreshToken,
      );

      try {
        await ref.read(deviceTokenNotifierProvider.notifier).syncToken();
      } catch (e, stackTrace) {
        debugPrint('[AuthState] Device token sync failed: $e');
        Sentry.captureException(e, stackTrace: stackTrace);
      }

      return true;
    }

    final isGuest = await storage.loadGuestMode();
    if (isGuest) {
      state = const AuthStateData(isGuest: true);
      return true;
    }

    return false;
  }
}
