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
    @Default('') String originalEmail,
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
      originalEmail: profile.email,
    );
  }

  void updateName(String value) {
    state = state.copyWith(name: value, hasChanges: true);
  }

  void updateEmail(String value) {
    state = state.copyWith(email: value, hasChanges: true);
  }

  void setAvatarImage(XFile? image) {
    state = state.copyWith(pendingAvatarImage: image, hasChanges: true);
  }

  String? get nameError => ProfileValidators.validateName(state.name);

  String? get emailError => ProfileValidators.validateEmail(state.email);

  bool get isValid => nameError == null && emailError == null;

  bool get hasEmailChanged => state.email != state.originalEmail;
}
