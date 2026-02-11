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
    required int readingCount,
    required int backlogCount,
    required int completedCount,
    required int interestedCount,
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
    readingCount: 0,
    backlogCount: 0,
    completedCount: 0,
    interestedCount: 0,
    readingStartYear: null,
    readingStartMonth: null,
    createdAt: DateTime.now(),
  );
}
