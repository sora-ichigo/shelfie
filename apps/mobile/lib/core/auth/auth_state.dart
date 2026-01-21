import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state.g.dart';

@immutable
class AuthStateData {
  const AuthStateData({
    this.isAuthenticated = false,
    this.userId,
    this.email,
    this.token,
    this.refreshToken,
  });

  const AuthStateData.initial()
      : isAuthenticated = false,
        userId = null,
        email = null,
        token = null,
        refreshToken = null;

  final bool isAuthenticated;
  final String? userId;
  final String? email;
  final String? token;
  final String? refreshToken;

  AuthStateData copyWith({
    bool? isAuthenticated,
    String? userId,
    String? email,
    String? token,
    String? refreshToken,
  }) {
    return AuthStateData(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
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
        other.userId == userId &&
        other.email == email &&
        other.token == token &&
        other.refreshToken == refreshToken;
  }

  @override
  int get hashCode =>
      Object.hash(isAuthenticated, userId, email, token, refreshToken);
}

@Riverpod(keepAlive: true)
class AuthState extends _$AuthState {
  @override
  AuthStateData build() {
    return const AuthStateData.initial();
  }

  void login({
    required String userId,
    required String email,
    required String token,
    required String refreshToken,
  }) {
    state = AuthStateData(
      isAuthenticated: true,
      userId: userId,
      email: email,
      token: token,
      refreshToken: refreshToken,
    );
  }

  void updateTokens({
    required String token,
    required String refreshToken,
  }) {
    state = state.copyWith(
      token: token,
      refreshToken: refreshToken,
    );
  }

  void logout() {
    state = const AuthStateData.initial();
  }
}
