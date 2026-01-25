// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gql_code_builder_serializers/gql_code_builder_serializers.dart'
    as _i2;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'get_upload_credentials.data.gql.g.dart';

abstract class GGetUploadCredentialsData
    implements
        Built<GGetUploadCredentialsData, GGetUploadCredentialsDataBuilder> {
  GGetUploadCredentialsData._();

  factory GGetUploadCredentialsData(
          [void Function(GGetUploadCredentialsDataBuilder b) updates]) =
      _$GGetUploadCredentialsData;

  static void _initializeBuilder(GGetUploadCredentialsDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetUploadCredentialsData_getUploadCredentials? get getUploadCredentials;
  static Serializer<GGetUploadCredentialsData> get serializer =>
      _$gGetUploadCredentialsDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetUploadCredentialsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetUploadCredentialsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetUploadCredentialsData.serializer,
        json,
      );
}

abstract class GGetUploadCredentialsData_getUploadCredentials {
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GGetUploadCredentialsData_getUploadCredentials>
      get serializer => _i2.InlineFragmentSerializer<
              GGetUploadCredentialsData_getUploadCredentials>(
            'GGetUploadCredentialsData_getUploadCredentials',
            GGetUploadCredentialsData_getUploadCredentials__base,
            {
              'QueryGetUploadCredentialsSuccess':
                  GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess,
              'ImageUploadError':
                  GGetUploadCredentialsData_getUploadCredentials__asImageUploadError,
            },
          );

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetUploadCredentialsData_getUploadCredentials.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetUploadCredentialsData_getUploadCredentials? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetUploadCredentialsData_getUploadCredentials.serializer,
        json,
      );
}

abstract class GGetUploadCredentialsData_getUploadCredentials__base
    implements
        Built<GGetUploadCredentialsData_getUploadCredentials__base,
            GGetUploadCredentialsData_getUploadCredentials__baseBuilder>,
        GGetUploadCredentialsData_getUploadCredentials {
  GGetUploadCredentialsData_getUploadCredentials__base._();

  factory GGetUploadCredentialsData_getUploadCredentials__base(
      [void Function(
              GGetUploadCredentialsData_getUploadCredentials__baseBuilder b)
          updates]) = _$GGetUploadCredentialsData_getUploadCredentials__base;

  static void _initializeBuilder(
          GGetUploadCredentialsData_getUploadCredentials__baseBuilder b) =>
      b..G__typename = 'QueryGetUploadCredentialsResult';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GGetUploadCredentialsData_getUploadCredentials__base>
      get serializer =>
          _$gGetUploadCredentialsDataGetUploadCredentialsBaseSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetUploadCredentialsData_getUploadCredentials__base.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetUploadCredentialsData_getUploadCredentials__base? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetUploadCredentialsData_getUploadCredentials__base.serializer,
        json,
      );
}

abstract class GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess
    implements
        Built<
            GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess,
            GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccessBuilder>,
        GGetUploadCredentialsData_getUploadCredentials {
  GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess._();

  factory GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess(
          [void Function(
                  GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccessBuilder
                      b)
              updates]) =
      _$GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess;

  static void _initializeBuilder(
          GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccessBuilder
              b) =>
      b..G__typename = 'QueryGetUploadCredentialsSuccess';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data
      get data;
  static Serializer<
          GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess>
      get serializer =>
          _$gGetUploadCredentialsDataGetUploadCredentialsAsQueryGetUploadCredentialsSuccessSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess
                .serializer,
            json,
          );
}

abstract class GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data
    implements
        Built<
            GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data,
            GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_dataBuilder> {
  GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data._();

  factory GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data(
          [void Function(
                  GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_dataBuilder
                      b)
              updates]) =
      _$GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data;

  static void _initializeBuilder(
          GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_dataBuilder
              b) =>
      b..G__typename = 'UploadCredentials';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get token;
  String? get signature;
  int? get expire;
  String? get publicKey;
  String? get uploadEndpoint;
  static Serializer<
          GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data>
      get serializer =>
          _$gGetUploadCredentialsDataGetUploadCredentialsAsQueryGetUploadCredentialsSuccessDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data
                .serializer,
            json,
          );
}

abstract class GGetUploadCredentialsData_getUploadCredentials__asImageUploadError
    implements
        Built<
            GGetUploadCredentialsData_getUploadCredentials__asImageUploadError,
            GGetUploadCredentialsData_getUploadCredentials__asImageUploadErrorBuilder>,
        GGetUploadCredentialsData_getUploadCredentials {
  GGetUploadCredentialsData_getUploadCredentials__asImageUploadError._();

  factory GGetUploadCredentialsData_getUploadCredentials__asImageUploadError(
          [void Function(
                  GGetUploadCredentialsData_getUploadCredentials__asImageUploadErrorBuilder
                      b)
              updates]) =
      _$GGetUploadCredentialsData_getUploadCredentials__asImageUploadError;

  static void _initializeBuilder(
          GGetUploadCredentialsData_getUploadCredentials__asImageUploadErrorBuilder
              b) =>
      b..G__typename = 'ImageUploadError';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get code;
  String? get message;
  static Serializer<
          GGetUploadCredentialsData_getUploadCredentials__asImageUploadError>
      get serializer =>
          _$gGetUploadCredentialsDataGetUploadCredentialsAsImageUploadErrorSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetUploadCredentialsData_getUploadCredentials__asImageUploadError
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetUploadCredentialsData_getUploadCredentials__asImageUploadError?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetUploadCredentialsData_getUploadCredentials__asImageUploadError
                .serializer,
            json,
          );
}
