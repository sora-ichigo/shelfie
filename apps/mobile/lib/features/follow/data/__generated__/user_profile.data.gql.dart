// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart'
    as _i2;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'user_profile.data.gql.g.dart';

abstract class GUserProfileData
    implements Built<GUserProfileData, GUserProfileDataBuilder> {
  GUserProfileData._();

  factory GUserProfileData([void Function(GUserProfileDataBuilder b) updates]) =
      _$GUserProfileData;

  static void _initializeBuilder(GUserProfileDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GUserProfileData_userProfile? get userProfile;
  static Serializer<GUserProfileData> get serializer =>
      _$gUserProfileDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUserProfileData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUserProfileData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUserProfileData.serializer,
        json,
      );
}

abstract class GUserProfileData_userProfile
    implements
        Built<GUserProfileData_userProfile,
            GUserProfileData_userProfileBuilder> {
  GUserProfileData_userProfile._();

  factory GUserProfileData_userProfile(
          [void Function(GUserProfileData_userProfileBuilder b) updates]) =
      _$GUserProfileData_userProfile;

  static void _initializeBuilder(GUserProfileData_userProfileBuilder b) =>
      b..G__typename = 'UserProfile';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GUserProfileData_userProfile_user get user;
  _i2.GFollowStatus get outgoingFollowStatus;
  _i2.GFollowStatus get incomingFollowStatus;
  GUserProfileData_userProfile_followCounts get followCounts;
  bool get isOwnProfile;
  static Serializer<GUserProfileData_userProfile> get serializer =>
      _$gUserProfileDataUserProfileSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUserProfileData_userProfile.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUserProfileData_userProfile? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUserProfileData_userProfile.serializer,
        json,
      );
}

abstract class GUserProfileData_userProfile_user
    implements
        Built<GUserProfileData_userProfile_user,
            GUserProfileData_userProfile_userBuilder> {
  GUserProfileData_userProfile_user._();

  factory GUserProfileData_userProfile_user(
          [void Function(GUserProfileData_userProfile_userBuilder b) updates]) =
      _$GUserProfileData_userProfile_user;

  static void _initializeBuilder(GUserProfileData_userProfile_userBuilder b) =>
      b..G__typename = 'User';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int? get id;
  String? get name;
  String? get avatarUrl;
  String? get handle;
  String? get bio;
  int get bookCount;
  String? get instagramHandle;
  static Serializer<GUserProfileData_userProfile_user> get serializer =>
      _$gUserProfileDataUserProfileUserSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUserProfileData_userProfile_user.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUserProfileData_userProfile_user? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUserProfileData_userProfile_user.serializer,
        json,
      );
}

abstract class GUserProfileData_userProfile_followCounts
    implements
        Built<GUserProfileData_userProfile_followCounts,
            GUserProfileData_userProfile_followCountsBuilder> {
  GUserProfileData_userProfile_followCounts._();

  factory GUserProfileData_userProfile_followCounts(
      [void Function(GUserProfileData_userProfile_followCountsBuilder b)
          updates]) = _$GUserProfileData_userProfile_followCounts;

  static void _initializeBuilder(
          GUserProfileData_userProfile_followCountsBuilder b) =>
      b..G__typename = 'FollowCounts';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get followingCount;
  int get followerCount;
  static Serializer<GUserProfileData_userProfile_followCounts> get serializer =>
      _$gUserProfileDataUserProfileFollowCountsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUserProfileData_userProfile_followCounts.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUserProfileData_userProfile_followCounts? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUserProfileData_userProfile_followCounts.serializer,
        json,
      );
}
