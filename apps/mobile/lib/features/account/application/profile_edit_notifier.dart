import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/features/account/application/profile_form_state.dart';
import 'package:shelfie/features/account/data/account_repository.dart';
import 'package:shelfie/features/account/data/avatar_upload_service.dart';
import 'package:shelfie/features/account/domain/user_profile.dart';

part 'profile_edit_notifier.freezed.dart';
part 'profile_edit_notifier.g.dart';

@freezed
sealed class ProfileEditState with _$ProfileEditState {
  const factory ProfileEditState.initial() = ProfileEditStateInitial;
  const factory ProfileEditState.loading() = ProfileEditStateLoading;
  const factory ProfileEditState.uploading({
    required double progress,
  }) = ProfileEditStateUploading;
  const factory ProfileEditState.success({
    required UserProfile profile,
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
    final pendingImage = formState.pendingAvatarImage;

    if (pendingImage != null) {
      await _saveWithAvatar(formState, pendingImage);
    } else {
      await _saveProfile(formState);
    }
  }

  Future<void> _saveWithAvatar(ProfileFormData formState, XFile image) async {
    final uploadService = ref.read(avatarUploadServiceProvider);

    final result = await uploadService.uploadAndUpdateProfile(
      file: image,
      name: formState.name,
      bio: formState.bio,
      instagramHandle: formState.instagramHandle,
      handle: formState.handle,
      onProgress: (progress) {
        state = ProfileEditState.uploading(progress: progress);
      },
    );

    state = result.fold<ProfileEditState>(
      _mapFailureToErrorState,
      (profile) => ProfileEditState.success(profile: profile),
    );
  }

  Future<void> _saveProfile(ProfileFormData formState) async {
    final repository = ref.read(accountRepositoryProvider);

    final updateResult = await repository.updateProfile(
      name: formState.name,
      bio: formState.bio,
      instagramHandle: formState.instagramHandle,
      handle: formState.handle,
    );

    state = updateResult.fold<ProfileEditState>(
      _mapFailureToErrorState,
      (profile) => ProfileEditState.success(profile: profile),
    );
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
