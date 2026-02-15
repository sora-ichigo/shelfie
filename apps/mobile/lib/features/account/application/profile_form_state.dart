import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/features/account/domain/profile_validators.dart';
import 'package:shelfie/features/account/domain/user_profile.dart';

part 'profile_form_state.freezed.dart';
part 'profile_form_state.g.dart';

@freezed
class ProfileFormData with _$ProfileFormData {
  const factory ProfileFormData({
    @Default('') String name,
    @Default('') String email,
    @Default('') String handle,
    @Default('') String bio,
    @Default('') String instagramHandle,
    @Default(false) bool isPublic,
    XFile? pendingAvatarImage,
    @Default(false) bool hasChanges,
  }) = _ProfileFormData;
}

@riverpod
class ProfileFormState extends _$ProfileFormState {
  @override
  ProfileFormData build() {
    return const ProfileFormData();
  }

  void initialize(UserProfile profile) {
    state = ProfileFormData(
      name: profile.name ?? '',
      email: profile.email,
      handle: profile.handle ?? '',
      bio: profile.bio ?? '',
      instagramHandle: profile.instagramHandle ?? '',
      isPublic: profile.isPublic,
    );
  }

  void updateName(String value) {
    state = state.copyWith(name: value, hasChanges: true);
  }

  void updateHandle(String value) {
    state = state.copyWith(handle: value, hasChanges: true);
  }

  void updateBio(String value) {
    state = state.copyWith(bio: value, hasChanges: true);
  }

  void updateInstagramHandle(String value) {
    state = state.copyWith(instagramHandle: value, hasChanges: true);
  }

  void updateIsPublic({required bool value}) {
    state = state.copyWith(isPublic: value, hasChanges: true);
  }

  void setAvatarImage(XFile? image) {
    state = state.copyWith(pendingAvatarImage: image, hasChanges: true);
  }

  String? get nameError => ProfileValidators.validateName(state.name);
  String? get handleError => ProfileValidators.validateHandle(state.handle);
  String? get bioError => ProfileValidators.validateBio(state.bio);
  String? get instagramHandleError =>
      ProfileValidators.validateInstagramHandle(state.instagramHandle);

  bool get isValid =>
      nameError == null &&
      handleError == null &&
      bioError == null &&
      instagramHandleError == null;
}
