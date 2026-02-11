// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gql_code_builder_serializers/gql_code_builder_serializers.dart'
    as _i2;
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart'
    as _i3;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'get_my_profile.data.gql.g.dart';

abstract class GGetMyProfileData
    implements Built<GGetMyProfileData, GGetMyProfileDataBuilder> {
  GGetMyProfileData._();

  factory GGetMyProfileData(
          [void Function(GGetMyProfileDataBuilder b) updates]) =
      _$GGetMyProfileData;

  static void _initializeBuilder(GGetMyProfileDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetMyProfileData_me get me;
  static Serializer<GGetMyProfileData> get serializer =>
      _$gGetMyProfileDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetMyProfileData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMyProfileData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetMyProfileData.serializer,
        json,
      );
}

abstract class GGetMyProfileData_me {
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GGetMyProfileData_me> get serializer =>
      _i2.InlineFragmentSerializer<GGetMyProfileData_me>(
        'GGetMyProfileData_me',
        GGetMyProfileData_me__base,
        {
          'User': GGetMyProfileData_me__asUser,
          'AuthErrorResult': GGetMyProfileData_me__asAuthErrorResult,
        },
      );

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetMyProfileData_me.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMyProfileData_me? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetMyProfileData_me.serializer,
        json,
      );
}

abstract class GGetMyProfileData_me__base
    implements
        Built<GGetMyProfileData_me__base, GGetMyProfileData_me__baseBuilder>,
        GGetMyProfileData_me {
  GGetMyProfileData_me__base._();

  factory GGetMyProfileData_me__base(
          [void Function(GGetMyProfileData_me__baseBuilder b) updates]) =
      _$GGetMyProfileData_me__base;

  static void _initializeBuilder(GGetMyProfileData_me__baseBuilder b) =>
      b..G__typename = 'MeResult';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GGetMyProfileData_me__base> get serializer =>
      _$gGetMyProfileDataMeBaseSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetMyProfileData_me__base.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMyProfileData_me__base? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetMyProfileData_me__base.serializer,
        json,
      );
}

abstract class GGetMyProfileData_me__asUser
    implements
        Built<GGetMyProfileData_me__asUser,
            GGetMyProfileData_me__asUserBuilder>,
        GGetMyProfileData_me {
  GGetMyProfileData_me__asUser._();

  factory GGetMyProfileData_me__asUser(
          [void Function(GGetMyProfileData_me__asUserBuilder b) updates]) =
      _$GGetMyProfileData_me__asUser;

  static void _initializeBuilder(GGetMyProfileData_me__asUserBuilder b) =>
      b..G__typename = 'User';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int? get id;
  String? get email;
  String? get name;
  String? get avatarUrl;
  DateTime? get createdAt;
  int get bookCount;
  String? get bio;
  String? get instagramHandle;
  String? get handle;
  static Serializer<GGetMyProfileData_me__asUser> get serializer =>
      _$gGetMyProfileDataMeAsUserSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetMyProfileData_me__asUser.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMyProfileData_me__asUser? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetMyProfileData_me__asUser.serializer,
        json,
      );
}

abstract class GGetMyProfileData_me__asAuthErrorResult
    implements
        Built<GGetMyProfileData_me__asAuthErrorResult,
            GGetMyProfileData_me__asAuthErrorResultBuilder>,
        GGetMyProfileData_me {
  GGetMyProfileData_me__asAuthErrorResult._();

  factory GGetMyProfileData_me__asAuthErrorResult(
      [void Function(GGetMyProfileData_me__asAuthErrorResultBuilder b)
          updates]) = _$GGetMyProfileData_me__asAuthErrorResult;

  static void _initializeBuilder(
          GGetMyProfileData_me__asAuthErrorResultBuilder b) =>
      b..G__typename = 'AuthErrorResult';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  _i3.GAuthErrorCode? get code;
  String? get message;
  static Serializer<GGetMyProfileData_me__asAuthErrorResult> get serializer =>
      _$gGetMyProfileDataMeAsAuthErrorResultSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetMyProfileData_me__asAuthErrorResult.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMyProfileData_me__asAuthErrorResult? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetMyProfileData_me__asAuthErrorResult.serializer,
        json,
      );
}
