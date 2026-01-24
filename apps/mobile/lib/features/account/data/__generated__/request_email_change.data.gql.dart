// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gql_code_builder_serializers/gql_code_builder_serializers.dart'
    as _i2;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'request_email_change.data.gql.g.dart';

abstract class GRequestEmailChangeData
    implements Built<GRequestEmailChangeData, GRequestEmailChangeDataBuilder> {
  GRequestEmailChangeData._();

  factory GRequestEmailChangeData(
          [void Function(GRequestEmailChangeDataBuilder b) updates]) =
      _$GRequestEmailChangeData;

  static void _initializeBuilder(GRequestEmailChangeDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GRequestEmailChangeData_requestEmailChange? get requestEmailChange;
  static Serializer<GRequestEmailChangeData> get serializer =>
      _$gRequestEmailChangeDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRequestEmailChangeData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRequestEmailChangeData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRequestEmailChangeData.serializer,
        json,
      );
}

abstract class GRequestEmailChangeData_requestEmailChange {
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GRequestEmailChangeData_requestEmailChange>
      get serializer => _i2.InlineFragmentSerializer<
              GRequestEmailChangeData_requestEmailChange>(
            'GRequestEmailChangeData_requestEmailChange',
            GRequestEmailChangeData_requestEmailChange__base,
            {
              'MutationRequestEmailChangeSuccess':
                  GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess,
              'ValidationError':
                  GRequestEmailChangeData_requestEmailChange__asValidationError,
            },
          );

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRequestEmailChangeData_requestEmailChange.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRequestEmailChangeData_requestEmailChange? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRequestEmailChangeData_requestEmailChange.serializer,
        json,
      );
}

abstract class GRequestEmailChangeData_requestEmailChange__base
    implements
        Built<GRequestEmailChangeData_requestEmailChange__base,
            GRequestEmailChangeData_requestEmailChange__baseBuilder>,
        GRequestEmailChangeData_requestEmailChange {
  GRequestEmailChangeData_requestEmailChange__base._();

  factory GRequestEmailChangeData_requestEmailChange__base(
      [void Function(GRequestEmailChangeData_requestEmailChange__baseBuilder b)
          updates]) = _$GRequestEmailChangeData_requestEmailChange__base;

  static void _initializeBuilder(
          GRequestEmailChangeData_requestEmailChange__baseBuilder b) =>
      b..G__typename = 'MutationRequestEmailChangeResult';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GRequestEmailChangeData_requestEmailChange__base>
      get serializer =>
          _$gRequestEmailChangeDataRequestEmailChangeBaseSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRequestEmailChangeData_requestEmailChange__base.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRequestEmailChangeData_requestEmailChange__base? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRequestEmailChangeData_requestEmailChange__base.serializer,
        json,
      );
}

abstract class GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess
    implements
        Built<
            GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess,
            GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccessBuilder>,
        GRequestEmailChangeData_requestEmailChange {
  GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess._();

  factory GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess(
          [void Function(
                  GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccessBuilder
                      b)
              updates]) =
      _$GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess;

  static void _initializeBuilder(
          GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccessBuilder
              b) =>
      b..G__typename = 'MutationRequestEmailChangeSuccess';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data
      get data;
  static Serializer<
          GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess>
      get serializer =>
          _$gRequestEmailChangeDataRequestEmailChangeAsMutationRequestEmailChangeSuccessSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess
                .serializer,
            json,
          );
}

abstract class GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data
    implements
        Built<
            GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data,
            GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_dataBuilder> {
  GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data._();

  factory GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data(
          [void Function(
                  GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_dataBuilder
                      b)
              updates]) =
      _$GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data;

  static void _initializeBuilder(
          GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_dataBuilder
              b) =>
      b..G__typename = 'EmailChangeRequested';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get message;
  static Serializer<
          GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data>
      get serializer =>
          _$gRequestEmailChangeDataRequestEmailChangeAsMutationRequestEmailChangeSuccessDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data
                .serializer,
            json,
          );
}

abstract class GRequestEmailChangeData_requestEmailChange__asValidationError
    implements
        Built<GRequestEmailChangeData_requestEmailChange__asValidationError,
            GRequestEmailChangeData_requestEmailChange__asValidationErrorBuilder>,
        GRequestEmailChangeData_requestEmailChange {
  GRequestEmailChangeData_requestEmailChange__asValidationError._();

  factory GRequestEmailChangeData_requestEmailChange__asValidationError(
          [void Function(
                  GRequestEmailChangeData_requestEmailChange__asValidationErrorBuilder
                      b)
              updates]) =
      _$GRequestEmailChangeData_requestEmailChange__asValidationError;

  static void _initializeBuilder(
          GRequestEmailChangeData_requestEmailChange__asValidationErrorBuilder
              b) =>
      b..G__typename = 'ValidationError';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get code;
  String? get message;
  String? get field;
  static Serializer<
          GRequestEmailChangeData_requestEmailChange__asValidationError>
      get serializer =>
          _$gRequestEmailChangeDataRequestEmailChangeAsValidationErrorSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRequestEmailChangeData_requestEmailChange__asValidationError
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GRequestEmailChangeData_requestEmailChange__asValidationError?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GRequestEmailChangeData_requestEmailChange__asValidationError
                .serializer,
            json,
          );
}
