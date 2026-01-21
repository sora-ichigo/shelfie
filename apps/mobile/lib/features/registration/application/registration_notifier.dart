import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/features/registration/application/registration_form_state.dart';
import 'package:shelfie/features/registration/data/registration_repository.dart';

part 'registration_notifier.freezed.dart';
part 'registration_notifier.g.dart';

@freezed
sealed class RegistrationState with _$RegistrationState {
  const factory RegistrationState.initial() = RegistrationStateInitial;
  const factory RegistrationState.loading() = RegistrationStateLoading;
  const factory RegistrationState.success({
    required RegisteredUser user,
  }) = RegistrationStateSuccess;
  const factory RegistrationState.error({
    required String message,
    String? field,
  }) = RegistrationStateError;
}

@riverpod
class RegistrationNotifier extends _$RegistrationNotifier {
  @override
  RegistrationState build() {
    return const RegistrationState.initial();
  }

  Future<void> register() async {
    final formState = ref.read(registrationFormStateProvider);
    final repository = ref.read(registrationRepositoryProvider);

    state = const RegistrationState.loading();

    final result = await repository.registerUser(
      email: formState.email,
      password: formState.password,
    );

    state = result.fold(
      (error) => switch (error) {
        EmailAlreadyExistsError(:final message) => RegistrationState.error(
            message: message,
            field: 'email',
          ),
        InvalidPasswordError(:final message) => RegistrationState.error(
            message: message,
            field: 'password',
          ),
        NetworkError(:final message) => RegistrationState.error(
            message: message,
          ),
        UnknownError(:final message) => RegistrationState.error(
            message: message,
          ),
      },
      (user) => RegistrationState.success(user: user),
    );
  }

  void reset() {
    state = const RegistrationState.initial();
  }
}
