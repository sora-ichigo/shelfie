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

part 'change_password.data.gql.g.dart';

abstract class GChangePasswordData
    implements Built<GChangePasswordData, GChangePasswordDataBuilder> {
  GChangePasswordData._();

  factory GChangePasswordData(
          [void Function(GChangePasswordDataBuilder b) updates]) =
      _$GChangePasswordData;

  static void _initializeBuilder(GChangePasswordDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GChangePasswordData_changePassword? get changePassword;
  static Serializer<GChangePasswordData> get serializer =>
      _$gChangePasswordDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChangePasswordData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChangePasswordData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChangePasswordData.serializer,
        json,
      );
}

abstract class GChangePasswordData_changePassword {
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GChangePasswordData_changePassword> get serializer =>
      _i2.InlineFragmentSerializer<GChangePasswordData_changePassword>(
        'GChangePasswordData_changePassword',
        GChangePasswordData_changePassword__base,
        {
          'MutationChangePasswordSuccess':
              GChangePasswordData_changePassword__asMutationChangePasswordSuccess,
          'AuthError': GChangePasswordData_changePassword__asAuthError,
        },
      );

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChangePasswordData_changePassword.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChangePasswordData_changePassword? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChangePasswordData_changePassword.serializer,
        json,
      );
}

abstract class GChangePasswordData_changePassword__base
    implements
        Built<GChangePasswordData_changePassword__base,
            GChangePasswordData_changePassword__baseBuilder>,
        GChangePasswordData_changePassword {
  GChangePasswordData_changePassword__base._();

  factory GChangePasswordData_changePassword__base(
      [void Function(GChangePasswordData_changePassword__baseBuilder b)
          updates]) = _$GChangePasswordData_changePassword__base;

  static void _initializeBuilder(
          GChangePasswordData_changePassword__baseBuilder b) =>
      b..G__typename = 'MutationChangePasswordResult';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GChangePasswordData_changePassword__base> get serializer =>
      _$gChangePasswordDataChangePasswordBaseSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChangePasswordData_changePassword__base.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChangePasswordData_changePassword__base? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChangePasswordData_changePassword__base.serializer,
        json,
      );
}

abstract class GChangePasswordData_changePassword__asMutationChangePasswordSuccess
    implements
        Built<
            GChangePasswordData_changePassword__asMutationChangePasswordSuccess,
            GChangePasswordData_changePassword__asMutationChangePasswordSuccessBuilder>,
        GChangePasswordData_changePassword {
  GChangePasswordData_changePassword__asMutationChangePasswordSuccess._();

  factory GChangePasswordData_changePassword__asMutationChangePasswordSuccess(
          [void Function(
                  GChangePasswordData_changePassword__asMutationChangePasswordSuccessBuilder
                      b)
              updates]) =
      _$GChangePasswordData_changePassword__asMutationChangePasswordSuccess;

  static void _initializeBuilder(
          GChangePasswordData_changePassword__asMutationChangePasswordSuccessBuilder
              b) =>
      b..G__typename = 'MutationChangePasswordSuccess';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data
      get data;
  static Serializer<
          GChangePasswordData_changePassword__asMutationChangePasswordSuccess>
      get serializer =>
          _$gChangePasswordDataChangePasswordAsMutationChangePasswordSuccessSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChangePasswordData_changePassword__asMutationChangePasswordSuccess
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GChangePasswordData_changePassword__asMutationChangePasswordSuccess?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GChangePasswordData_changePassword__asMutationChangePasswordSuccess
                .serializer,
            json,
          );
}

abstract class GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data
    implements
        Built<
            GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data,
            GChangePasswordData_changePassword__asMutationChangePasswordSuccess_dataBuilder> {
  GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data._();

  factory GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data(
          [void Function(
                  GChangePasswordData_changePassword__asMutationChangePasswordSuccess_dataBuilder
                      b)
              updates]) =
      _$GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data;

  static void _initializeBuilder(
          GChangePasswordData_changePassword__asMutationChangePasswordSuccess_dataBuilder
              b) =>
      b..G__typename = 'ChangePasswordResult';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get idToken;
  String get refreshToken;
  static Serializer<
          GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data>
      get serializer =>
          _$gChangePasswordDataChangePasswordAsMutationChangePasswordSuccessDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data
                .serializer,
            json,
          );
}

abstract class GChangePasswordData_changePassword__asAuthError
    implements
        Built<GChangePasswordData_changePassword__asAuthError,
            GChangePasswordData_changePassword__asAuthErrorBuilder>,
        GChangePasswordData_changePassword {
  GChangePasswordData_changePassword__asAuthError._();

  factory GChangePasswordData_changePassword__asAuthError(
      [void Function(GChangePasswordData_changePassword__asAuthErrorBuilder b)
          updates]) = _$GChangePasswordData_changePassword__asAuthError;

  static void _initializeBuilder(
          GChangePasswordData_changePassword__asAuthErrorBuilder b) =>
      b..G__typename = 'AuthError';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  _i3.GAuthErrorCode? get code;
  String? get message;
  String? get field;
  bool? get retryable;
  static Serializer<GChangePasswordData_changePassword__asAuthError>
      get serializer =>
          _$gChangePasswordDataChangePasswordAsAuthErrorSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChangePasswordData_changePassword__asAuthError.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChangePasswordData_changePassword__asAuthError? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChangePasswordData_changePassword__asAuthError.serializer,
        json,
      );
}
