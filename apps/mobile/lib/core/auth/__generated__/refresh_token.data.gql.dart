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

part 'refresh_token.data.gql.g.dart';

abstract class GRefreshTokenData
    implements Built<GRefreshTokenData, GRefreshTokenDataBuilder> {
  GRefreshTokenData._();

  factory GRefreshTokenData(
          [void Function(GRefreshTokenDataBuilder b) updates]) =
      _$GRefreshTokenData;

  static void _initializeBuilder(GRefreshTokenDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GRefreshTokenData_refreshToken? get refreshToken;
  static Serializer<GRefreshTokenData> get serializer =>
      _$gRefreshTokenDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRefreshTokenData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRefreshTokenData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRefreshTokenData.serializer,
        json,
      );
}

abstract class GRefreshTokenData_refreshToken {
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GRefreshTokenData_refreshToken> get serializer =>
      _i2.InlineFragmentSerializer<GRefreshTokenData_refreshToken>(
        'GRefreshTokenData_refreshToken',
        GRefreshTokenData_refreshToken__base,
        {
          'MutationRefreshTokenSuccess':
              GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess,
          'AuthError': GRefreshTokenData_refreshToken__asAuthError,
        },
      );

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRefreshTokenData_refreshToken.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRefreshTokenData_refreshToken? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRefreshTokenData_refreshToken.serializer,
        json,
      );
}

abstract class GRefreshTokenData_refreshToken__base
    implements
        Built<GRefreshTokenData_refreshToken__base,
            GRefreshTokenData_refreshToken__baseBuilder>,
        GRefreshTokenData_refreshToken {
  GRefreshTokenData_refreshToken__base._();

  factory GRefreshTokenData_refreshToken__base(
      [void Function(GRefreshTokenData_refreshToken__baseBuilder b)
          updates]) = _$GRefreshTokenData_refreshToken__base;

  static void _initializeBuilder(
          GRefreshTokenData_refreshToken__baseBuilder b) =>
      b..G__typename = 'MutationRefreshTokenResult';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GRefreshTokenData_refreshToken__base> get serializer =>
      _$gRefreshTokenDataRefreshTokenBaseSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRefreshTokenData_refreshToken__base.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRefreshTokenData_refreshToken__base? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRefreshTokenData_refreshToken__base.serializer,
        json,
      );
}

abstract class GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess
    implements
        Built<GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess,
            GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccessBuilder>,
        GRefreshTokenData_refreshToken {
  GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess._();

  factory GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess(
          [void Function(
                  GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccessBuilder
                      b)
              updates]) =
      _$GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess;

  static void _initializeBuilder(
          GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccessBuilder
              b) =>
      b..G__typename = 'MutationRefreshTokenSuccess';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data get data;
  static Serializer<
          GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess>
      get serializer =>
          _$gRefreshTokenDataRefreshTokenAsMutationRefreshTokenSuccessSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess
                .serializer,
            json,
          );
}

abstract class GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data
    implements
        Built<
            GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data,
            GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_dataBuilder> {
  GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data._();

  factory GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data(
          [void Function(
                  GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_dataBuilder
                      b)
              updates]) =
      _$GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data;

  static void _initializeBuilder(
          GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_dataBuilder
              b) =>
      b..G__typename = 'RefreshTokenResult';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get idToken;
  String get refreshToken;
  static Serializer<
          GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data>
      get serializer =>
          _$gRefreshTokenDataRefreshTokenAsMutationRefreshTokenSuccessDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data
                .serializer,
            json,
          );
}

abstract class GRefreshTokenData_refreshToken__asAuthError
    implements
        Built<GRefreshTokenData_refreshToken__asAuthError,
            GRefreshTokenData_refreshToken__asAuthErrorBuilder>,
        GRefreshTokenData_refreshToken {
  GRefreshTokenData_refreshToken__asAuthError._();

  factory GRefreshTokenData_refreshToken__asAuthError(
      [void Function(GRefreshTokenData_refreshToken__asAuthErrorBuilder b)
          updates]) = _$GRefreshTokenData_refreshToken__asAuthError;

  static void _initializeBuilder(
          GRefreshTokenData_refreshToken__asAuthErrorBuilder b) =>
      b..G__typename = 'AuthError';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  _i3.GAuthErrorCode? get code;
  String? get message;
  String? get field;
  bool? get retryable;
  static Serializer<GRefreshTokenData_refreshToken__asAuthError>
      get serializer => _$gRefreshTokenDataRefreshTokenAsAuthErrorSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRefreshTokenData_refreshToken__asAuthError.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRefreshTokenData_refreshToken__asAuthError? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRefreshTokenData_refreshToken__asAuthError.serializer,
        json,
      );
}
