import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/features/login/application/login_form_state.dart';

part 'login_notifier.freezed.dart';
part 'login_notifier.g.dart';

@freezed
sealed class LoginState with _$LoginState {
  const factory LoginState.initial() = LoginStateInitial;
  const factory LoginState.loading() = LoginStateLoading;
  const factory LoginState.success({
    required String userId,
    required String email,
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

    state = const LoginState.loading();

    await Future<void>.delayed(const Duration(seconds: 1));

    state = LoginState.success(
      userId: 'mock-user-id',
      email: formState.email,
    );
  }

  void reset() {
    state = const LoginState.initial();
  }
}
