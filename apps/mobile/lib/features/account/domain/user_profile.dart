import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required int id,
    required String email,
    required String? name,
    required String? avatarUrl,
    required String? username,
    required int bookCount,
    required int? readingStartYear,
    required int? readingStartMonth,
    required DateTime createdAt,
  }) = _UserProfile;

  factory UserProfile.guest() => UserProfile(
    id: 0,
    email: '@ゲストモード',
    name: null,
    avatarUrl: null,
    username: null,
    bookCount: 0,
    readingStartYear: null,
    readingStartMonth: null,
    createdAt: DateTime.now(),
  );
}
