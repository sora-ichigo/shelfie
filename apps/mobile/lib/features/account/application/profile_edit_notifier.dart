import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/features/account/application/profile_form_state.dart';
import 'package:shelfie/features/account/data/account_repository.dart';
import 'package:shelfie/features/account/domain/user_profile.dart';

part 'profile_edit_notifier.freezed.dart';
part 'profile_edit_notifier.g.dart';

@freezed
sealed class ProfileEditState with _$ProfileEditState {
  const factory ProfileEditState.initial() = ProfileEditStateInitial;
  const factory ProfileEditState.loading() = ProfileEditStateLoading;
  const factory ProfileEditState.success({
    required UserProfile profile,
    String? emailChangeMessage,
  }) = ProfileEditStateSuccess;
  const factory ProfileEditState.error({
    required String message,
    String? field,
  }) = ProfileEditStateError;
}

@riverpod
class ProfileEditNotifier extends _$ProfileEditNotifier {
  @override
  ProfileEditState build() {
    return const ProfileEditState.initial();
  }

  Future<void> save() async {
    state = const ProfileEditState.loading();

    final formState = ref.read(profileFormStateProvider);
    final repository = ref.read(accountRepositoryProvider);

    final updateResult = await repository.updateProfile(
      name: formState.name,
    );

    final result = updateResult.fold<ProfileEditState>(
      (failure) => _mapFailureToErrorState(failure),
      (profile) => ProfileEditState.success(profile: profile),
    );

    if (result is ProfileEditStateError) {
      state = result;
      return;
    }

    final successResult = result as ProfileEditStateSuccess;

    final formNotifier = ref.read(profileFormStateProvider.notifier);
    if (formNotifier.hasEmailChanged) {
      final emailResult = await repository.requestEmailChange(
        newEmail: formState.email,
      );

      final finalResult = emailResult.fold<ProfileEditState>(
        (failure) => _mapFailureToErrorState(failure),
        (_) => ProfileEditState.success(
          profile: successResult.profile,
          emailChangeMessage: '確認メールを送信しました',
        ),
      );

      state = finalResult;
      return;
    }

    state = successResult;
  }

  void setAvatarImage(XFile? image) {
    ref.read(profileFormStateProvider.notifier).setAvatarImage(image);
  }

  void reset() {
    state = const ProfileEditState.initial();
  }

  ProfileEditState _mapFailureToErrorState(Failure failure) {
    return switch (failure) {
      ValidationFailure(:final message, :final fieldErrors) =>
        ProfileEditState.error(
          message: message,
          field: fieldErrors?.keys.firstOrNull,
        ),
      _ => ProfileEditState.error(message: failure.userMessage),
    };
  }
}
