// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gql_code_builder_serializers/gql_code_builder_serializers.dart'
    as _i2;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'unfollow.data.gql.g.dart';

abstract class GUnfollowData
    implements Built<GUnfollowData, GUnfollowDataBuilder> {
  GUnfollowData._();

  factory GUnfollowData([void Function(GUnfollowDataBuilder b) updates]) =
      _$GUnfollowData;

  static void _initializeBuilder(GUnfollowDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GUnfollowData_unfollow? get unfollow;
  static Serializer<GUnfollowData> get serializer => _$gUnfollowDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUnfollowData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUnfollowData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUnfollowData.serializer,
        json,
      );
}

abstract class GUnfollowData_unfollow {
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GUnfollowData_unfollow> get serializer =>
      _i2.InlineFragmentSerializer<GUnfollowData_unfollow>(
        'GUnfollowData_unfollow',
        GUnfollowData_unfollow__base,
        {
          'MutationUnfollowSuccess':
              GUnfollowData_unfollow__asMutationUnfollowSuccess,
          'ValidationError': GUnfollowData_unfollow__asValidationError,
        },
      );

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUnfollowData_unfollow.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUnfollowData_unfollow? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUnfollowData_unfollow.serializer,
        json,
      );
}

abstract class GUnfollowData_unfollow__base
    implements
        Built<GUnfollowData_unfollow__base,
            GUnfollowData_unfollow__baseBuilder>,
        GUnfollowData_unfollow {
  GUnfollowData_unfollow__base._();

  factory GUnfollowData_unfollow__base(
          [void Function(GUnfollowData_unfollow__baseBuilder b) updates]) =
      _$GUnfollowData_unfollow__base;

  static void _initializeBuilder(GUnfollowData_unfollow__baseBuilder b) =>
      b..G__typename = 'MutationUnfollowResult';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GUnfollowData_unfollow__base> get serializer =>
      _$gUnfollowDataUnfollowBaseSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUnfollowData_unfollow__base.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUnfollowData_unfollow__base? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUnfollowData_unfollow__base.serializer,
        json,
      );
}

abstract class GUnfollowData_unfollow__asMutationUnfollowSuccess
    implements
        Built<GUnfollowData_unfollow__asMutationUnfollowSuccess,
            GUnfollowData_unfollow__asMutationUnfollowSuccessBuilder>,
        GUnfollowData_unfollow {
  GUnfollowData_unfollow__asMutationUnfollowSuccess._();

  factory GUnfollowData_unfollow__asMutationUnfollowSuccess(
      [void Function(GUnfollowData_unfollow__asMutationUnfollowSuccessBuilder b)
          updates]) = _$GUnfollowData_unfollow__asMutationUnfollowSuccess;

  static void _initializeBuilder(
          GUnfollowData_unfollow__asMutationUnfollowSuccessBuilder b) =>
      b..G__typename = 'MutationUnfollowSuccess';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  bool get data;
  static Serializer<GUnfollowData_unfollow__asMutationUnfollowSuccess>
      get serializer =>
          _$gUnfollowDataUnfollowAsMutationUnfollowSuccessSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUnfollowData_unfollow__asMutationUnfollowSuccess.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUnfollowData_unfollow__asMutationUnfollowSuccess? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUnfollowData_unfollow__asMutationUnfollowSuccess.serializer,
        json,
      );
}

abstract class GUnfollowData_unfollow__asValidationError
    implements
        Built<GUnfollowData_unfollow__asValidationError,
            GUnfollowData_unfollow__asValidationErrorBuilder>,
        GUnfollowData_unfollow {
  GUnfollowData_unfollow__asValidationError._();

  factory GUnfollowData_unfollow__asValidationError(
      [void Function(GUnfollowData_unfollow__asValidationErrorBuilder b)
          updates]) = _$GUnfollowData_unfollow__asValidationError;

  static void _initializeBuilder(
          GUnfollowData_unfollow__asValidationErrorBuilder b) =>
      b..G__typename = 'ValidationError';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get message;
  String? get code;
  static Serializer<GUnfollowData_unfollow__asValidationError> get serializer =>
      _$gUnfollowDataUnfollowAsValidationErrorSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUnfollowData_unfollow__asValidationError.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUnfollowData_unfollow__asValidationError? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUnfollowData_unfollow__asValidationError.serializer,
        json,
      );
}
