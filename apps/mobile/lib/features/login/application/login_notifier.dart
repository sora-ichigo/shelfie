import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/auth/auth_state.dart';
import 'package:shelfie/features/login/application/login_form_state.dart';
import 'package:shelfie/features/login/data/login_repository.dart';

part 'login_notifier.freezed.dart';
part 'login_notifier.g.dart';

@freezed
sealed class LoginState with _$LoginState {
  const factory LoginState.initial() = LoginStateInitial;
  const factory LoginState.loading() = LoginStateLoading;
  const factory LoginState.success({
    required String userId,
    required String email,
    required String idToken,
  }) = LoginStateSuccess;
  const factory LoginState.error({
    required String message,
    String? field,
  }) = LoginStateError;
}

@riverpod
class LoginNotifier extends _$LoginNotifier {
  @override
  LoginState build() {
    return const LoginState.initial();
  }

  Future<void> login() async {
    final formState = ref.read(loginFormStateProvider);
    final repository = ref.read(loginRepositoryProvider);

    state = const LoginState.loading();

    final result = await repository.login(
      email: formState.email,
      password: formState.password,
    );

    result.fold(
      (error) {
        final (String message, String? field) = switch (error) {
          InvalidCredentialsError(:final message) => (message, null),
          UserNotFoundError(:final message) => (message, null),
          NetworkError(:final message) => (message, null),
          UnknownError(:final message) => (message, null),
        };
        state = LoginState.error(message: message, field: field);
      },
      (user) {
        ref.read(authStateProvider.notifier).setToken(user.idToken);
        state = LoginState.success(
          userId: user.id.toString(),
          email: user.email,
          idToken: user.idToken,
        );
      },
    );
  }

  void reset() {
    state = const LoginState.initial();
  }
}
