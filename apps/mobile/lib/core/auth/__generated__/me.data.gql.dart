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

part 'me.data.gql.g.dart';

abstract class GGetMeData implements Built<GGetMeData, GGetMeDataBuilder> {
  GGetMeData._();

  factory GGetMeData([void Function(GGetMeDataBuilder b) updates]) =
      _$GGetMeData;

  static void _initializeBuilder(GGetMeDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetMeData_me get me;
  static Serializer<GGetMeData> get serializer => _$gGetMeDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetMeData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMeData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetMeData.serializer,
        json,
      );
}

abstract class GGetMeData_me {
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GGetMeData_me> get serializer =>
      _i2.InlineFragmentSerializer<GGetMeData_me>(
        'GGetMeData_me',
        GGetMeData_me__base,
        {
          'User': GGetMeData_me__asUser,
          'AuthErrorResult': GGetMeData_me__asAuthErrorResult,
        },
      );

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetMeData_me.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMeData_me? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetMeData_me.serializer,
        json,
      );
}

abstract class GGetMeData_me__base
    implements
        Built<GGetMeData_me__base, GGetMeData_me__baseBuilder>,
        GGetMeData_me {
  GGetMeData_me__base._();

  factory GGetMeData_me__base(
          [void Function(GGetMeData_me__baseBuilder b) updates]) =
      _$GGetMeData_me__base;

  static void _initializeBuilder(GGetMeData_me__baseBuilder b) =>
      b..G__typename = 'MeResult';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GGetMeData_me__base> get serializer =>
      _$gGetMeDataMeBaseSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetMeData_me__base.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMeData_me__base? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetMeData_me__base.serializer,
        json,
      );
}

abstract class GGetMeData_me__asUser
    implements
        Built<GGetMeData_me__asUser, GGetMeData_me__asUserBuilder>,
        GGetMeData_me {
  GGetMeData_me__asUser._();

  factory GGetMeData_me__asUser(
          [void Function(GGetMeData_me__asUserBuilder b) updates]) =
      _$GGetMeData_me__asUser;

  static void _initializeBuilder(GGetMeData_me__asUserBuilder b) =>
      b..G__typename = 'User';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int? get id;
  String? get email;
  static Serializer<GGetMeData_me__asUser> get serializer =>
      _$gGetMeDataMeAsUserSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetMeData_me__asUser.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMeData_me__asUser? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetMeData_me__asUser.serializer,
        json,
      );
}

abstract class GGetMeData_me__asAuthErrorResult
    implements
        Built<GGetMeData_me__asAuthErrorResult,
            GGetMeData_me__asAuthErrorResultBuilder>,
        GGetMeData_me {
  GGetMeData_me__asAuthErrorResult._();

  factory GGetMeData_me__asAuthErrorResult(
          [void Function(GGetMeData_me__asAuthErrorResultBuilder b) updates]) =
      _$GGetMeData_me__asAuthErrorResult;

  static void _initializeBuilder(GGetMeData_me__asAuthErrorResultBuilder b) =>
      b..G__typename = 'AuthErrorResult';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  _i3.GAuthErrorCode? get code;
  String? get message;
  static Serializer<GGetMeData_me__asAuthErrorResult> get serializer =>
      _$gGetMeDataMeAsAuthErrorResultSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetMeData_me__asAuthErrorResult.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMeData_me__asAuthErrorResult? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetMeData_me__asAuthErrorResult.serializer,
        json,
      );
}
