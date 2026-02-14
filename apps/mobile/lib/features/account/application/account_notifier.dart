import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/state/profile_version.dart';
import 'package:shelfie/core/state/shelf_version.dart';
import 'package:shelfie/features/account/data/account_repository.dart';
import 'package:shelfie/features/account/domain/user_profile.dart';

part 'account_notifier.g.dart';

@riverpod
class AccountNotifier extends _$AccountNotifier {
  @override
  Future<UserProfile> build() async {
    ref.watch(shelfVersionProvider);
    ref.watch(profileVersionProvider);
    return _fetchProfile();
  }

  Future<UserProfile> _fetchProfile() async {
    final repository = ref.read(accountRepositoryProvider);
    final result = await repository.getMyProfile();

    return result.fold(
      (failure) => throw failure,
      (profile) => profile,
    );
  }

  void setProfile(UserProfile profile) {
    state = AsyncData(profile);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchProfile());
  }
}
