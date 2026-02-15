import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/state/profile_version.dart';
import 'package:shelfie/core/state/shelf_version.dart';
import 'package:shelfie/features/account/data/account_repository.dart';
import 'package:shelfie/features/account/domain/user_profile.dart';

part 'account_notifier.g.dart';

@riverpod
class AccountNotifier extends _$AccountNotifier {
  UserProfile? _cachedProfile;

  @override
  FutureOr<UserProfile> build() {
    ref.watch(shelfVersionProvider);
    ref.watch(profileVersionProvider);

    final cached = _cachedProfile;
    if (cached != null) {
      Future.microtask(_silentRefresh);
      return cached;
    }

    return _fetchProfile();
  }

  Future<UserProfile> _fetchProfile() async {
    final repository = ref.read(accountRepositoryProvider);
    final result = await repository.getMyProfile();

    return result.fold(
      (failure) => throw failure,
      (profile) {
        _cachedProfile = profile;
        return profile;
      },
    );
  }

  Future<void> _silentRefresh() async {
    try {
      final profile = await _fetchProfile();
      state = AsyncData(profile);
    } catch (_) {}
  }

  void setProfile(UserProfile profile) {
    _cachedProfile = profile;
    state = AsyncData(profile);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchProfile());
  }
}
