import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required int id,
    required String email,
    required String? name,
    required String? avatarUrl,
    required String? handle,
    required int bookCount,
    required String? bio,
    required String? instagramHandle,
    required String? shareUrl,
    required int? readingStartYear,
    required int? readingStartMonth,
    required DateTime createdAt,
    required bool isPublic,
  }) = _UserProfile;

  factory UserProfile.guest() => UserProfile(
    id: 0,
    email: '@ゲストモード',
    name: null,
    avatarUrl: null,
    handle: null,
    bookCount: 0,
    bio: null,
    instagramHandle: null,
    shareUrl: null,
    readingStartYear: null,
    readingStartMonth: null,
    createdAt: DateTime.now(),
    isPublic: false,
  );
}
