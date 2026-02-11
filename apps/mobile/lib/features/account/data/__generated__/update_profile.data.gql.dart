// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gql_code_builder_serializers/gql_code_builder_serializers.dart'
    as _i2;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'update_profile.data.gql.g.dart';

abstract class GUpdateProfileData
    implements Built<GUpdateProfileData, GUpdateProfileDataBuilder> {
  GUpdateProfileData._();

  factory GUpdateProfileData(
          [void Function(GUpdateProfileDataBuilder b) updates]) =
      _$GUpdateProfileData;

  static void _initializeBuilder(GUpdateProfileDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GUpdateProfileData_updateProfile? get updateProfile;
  static Serializer<GUpdateProfileData> get serializer =>
      _$gUpdateProfileDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateProfileData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateProfileData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateProfileData.serializer,
        json,
      );
}

abstract class GUpdateProfileData_updateProfile {
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GUpdateProfileData_updateProfile> get serializer =>
      _i2.InlineFragmentSerializer<GUpdateProfileData_updateProfile>(
        'GUpdateProfileData_updateProfile',
        GUpdateProfileData_updateProfile__base,
        {
          'MutationUpdateProfileSuccess':
              GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess,
          'ValidationError':
              GUpdateProfileData_updateProfile__asValidationError,
        },
      );

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateProfileData_updateProfile.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateProfileData_updateProfile? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateProfileData_updateProfile.serializer,
        json,
      );
}

abstract class GUpdateProfileData_updateProfile__base
    implements
        Built<GUpdateProfileData_updateProfile__base,
            GUpdateProfileData_updateProfile__baseBuilder>,
        GUpdateProfileData_updateProfile {
  GUpdateProfileData_updateProfile__base._();

  factory GUpdateProfileData_updateProfile__base(
      [void Function(GUpdateProfileData_updateProfile__baseBuilder b)
          updates]) = _$GUpdateProfileData_updateProfile__base;

  static void _initializeBuilder(
          GUpdateProfileData_updateProfile__baseBuilder b) =>
      b..G__typename = 'MutationUpdateProfileResult';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GUpdateProfileData_updateProfile__base> get serializer =>
      _$gUpdateProfileDataUpdateProfileBaseSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateProfileData_updateProfile__base.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateProfileData_updateProfile__base? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateProfileData_updateProfile__base.serializer,
        json,
      );
}

abstract class GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess
    implements
        Built<GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess,
            GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccessBuilder>,
        GUpdateProfileData_updateProfile {
  GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess._();

  factory GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess(
          [void Function(
                  GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccessBuilder
                      b)
              updates]) =
      _$GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess;

  static void _initializeBuilder(
          GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccessBuilder
              b) =>
      b..G__typename = 'MutationUpdateProfileSuccess';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data
      get data;
  static Serializer<
          GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess>
      get serializer =>
          _$gUpdateProfileDataUpdateProfileAsMutationUpdateProfileSuccessSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess
                .serializer,
            json,
          );
}

abstract class GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data
    implements
        Built<
            GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data,
            GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_dataBuilder> {
  GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data._();

  factory GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data(
          [void Function(
                  GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_dataBuilder
                      b)
              updates]) =
      _$GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data;

  static void _initializeBuilder(
          GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_dataBuilder
              b) =>
      b..G__typename = 'User';

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
  static Serializer<
          GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data>
      get serializer =>
          _$gUpdateProfileDataUpdateProfileAsMutationUpdateProfileSuccessDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data
                .serializer,
            json,
          );
}

abstract class GUpdateProfileData_updateProfile__asValidationError
    implements
        Built<GUpdateProfileData_updateProfile__asValidationError,
            GUpdateProfileData_updateProfile__asValidationErrorBuilder>,
        GUpdateProfileData_updateProfile {
  GUpdateProfileData_updateProfile__asValidationError._();

  factory GUpdateProfileData_updateProfile__asValidationError(
      [void Function(
              GUpdateProfileData_updateProfile__asValidationErrorBuilder b)
          updates]) = _$GUpdateProfileData_updateProfile__asValidationError;

  static void _initializeBuilder(
          GUpdateProfileData_updateProfile__asValidationErrorBuilder b) =>
      b..G__typename = 'ValidationError';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get code;
  String? get message;
  String? get field;
  static Serializer<GUpdateProfileData_updateProfile__asValidationError>
      get serializer =>
          _$gUpdateProfileDataUpdateProfileAsValidationErrorSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateProfileData_updateProfile__asValidationError.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateProfileData_updateProfile__asValidationError? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateProfileData_updateProfile__asValidationError.serializer,
        json,
      );
}
