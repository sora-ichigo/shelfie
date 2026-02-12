import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_summary.freezed.dart';

@freezed
class UserSummary with _$UserSummary {
  const factory UserSummary({
    required int id,
    required String? name,
    required String? avatarUrl,
    required String? handle,
  }) = _UserSummary;
}
