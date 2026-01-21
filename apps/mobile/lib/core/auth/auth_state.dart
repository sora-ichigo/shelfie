import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state.g.dart';

@Riverpod(keepAlive: true)
class AuthState extends _$AuthState {
  @override
  String? build() {
    return null;
  }

  void setToken(String token) {
    state = token;
  }

  void clearToken() {
    state = null;
  }
}
