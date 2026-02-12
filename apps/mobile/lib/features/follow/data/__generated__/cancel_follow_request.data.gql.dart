// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gql_code_builder_serializers/gql_code_builder_serializers.dart'
    as _i2;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'cancel_follow_request.data.gql.g.dart';

abstract class GCancelFollowRequestData
    implements
        Built<GCancelFollowRequestData, GCancelFollowRequestDataBuilder> {
  GCancelFollowRequestData._();

  factory GCancelFollowRequestData(
          [void Function(GCancelFollowRequestDataBuilder b) updates]) =
      _$GCancelFollowRequestData;

  static void _initializeBuilder(GCancelFollowRequestDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GCancelFollowRequestData_cancelFollowRequest? get cancelFollowRequest;
  static Serializer<GCancelFollowRequestData> get serializer =>
      _$gCancelFollowRequestDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCancelFollowRequestData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCancelFollowRequestData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCancelFollowRequestData.serializer,
        json,
      );
}

abstract class GCancelFollowRequestData_cancelFollowRequest {
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GCancelFollowRequestData_cancelFollowRequest>
      get serializer => _i2.InlineFragmentSerializer<
              GCancelFollowRequestData_cancelFollowRequest>(
            'GCancelFollowRequestData_cancelFollowRequest',
            GCancelFollowRequestData_cancelFollowRequest__base,
            {
              'MutationCancelFollowRequestSuccess':
                  GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccess,
              'ValidationError':
                  GCancelFollowRequestData_cancelFollowRequest__asValidationError,
            },
          );

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCancelFollowRequestData_cancelFollowRequest.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCancelFollowRequestData_cancelFollowRequest? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCancelFollowRequestData_cancelFollowRequest.serializer,
        json,
      );
}

abstract class GCancelFollowRequestData_cancelFollowRequest__base
    implements
        Built<GCancelFollowRequestData_cancelFollowRequest__base,
            GCancelFollowRequestData_cancelFollowRequest__baseBuilder>,
        GCancelFollowRequestData_cancelFollowRequest {
  GCancelFollowRequestData_cancelFollowRequest__base._();

  factory GCancelFollowRequestData_cancelFollowRequest__base(
      [void Function(
              GCancelFollowRequestData_cancelFollowRequest__baseBuilder b)
          updates]) = _$GCancelFollowRequestData_cancelFollowRequest__base;

  static void _initializeBuilder(
          GCancelFollowRequestData_cancelFollowRequest__baseBuilder b) =>
      b..G__typename = 'MutationCancelFollowRequestResult';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GCancelFollowRequestData_cancelFollowRequest__base>
      get serializer =>
          _$gCancelFollowRequestDataCancelFollowRequestBaseSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCancelFollowRequestData_cancelFollowRequest__base.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCancelFollowRequestData_cancelFollowRequest__base? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCancelFollowRequestData_cancelFollowRequest__base.serializer,
        json,
      );
}

abstract class GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccess
    implements
        Built<
            GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccess,
            GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccessBuilder>,
        GCancelFollowRequestData_cancelFollowRequest {
  GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccess._();

  factory GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccess(
          [void Function(
                  GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccessBuilder
                      b)
              updates]) =
      _$GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccess;

  static void _initializeBuilder(
          GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccessBuilder
              b) =>
      b..G__typename = 'MutationCancelFollowRequestSuccess';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  bool get data;
  static Serializer<
          GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccess>
      get serializer =>
          _$gCancelFollowRequestDataCancelFollowRequestAsMutationCancelFollowRequestSuccessSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccess
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccess?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccess
                .serializer,
            json,
          );
}

abstract class GCancelFollowRequestData_cancelFollowRequest__asValidationError
    implements
        Built<GCancelFollowRequestData_cancelFollowRequest__asValidationError,
            GCancelFollowRequestData_cancelFollowRequest__asValidationErrorBuilder>,
        GCancelFollowRequestData_cancelFollowRequest {
  GCancelFollowRequestData_cancelFollowRequest__asValidationError._();

  factory GCancelFollowRequestData_cancelFollowRequest__asValidationError(
          [void Function(
                  GCancelFollowRequestData_cancelFollowRequest__asValidationErrorBuilder
                      b)
              updates]) =
      _$GCancelFollowRequestData_cancelFollowRequest__asValidationError;

  static void _initializeBuilder(
          GCancelFollowRequestData_cancelFollowRequest__asValidationErrorBuilder
              b) =>
      b..G__typename = 'ValidationError';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get message;
  String? get code;
  static Serializer<
          GCancelFollowRequestData_cancelFollowRequest__asValidationError>
      get serializer =>
          _$gCancelFollowRequestDataCancelFollowRequestAsValidationErrorSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCancelFollowRequestData_cancelFollowRequest__asValidationError
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GCancelFollowRequestData_cancelFollowRequest__asValidationError?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GCancelFollowRequestData_cancelFollowRequest__asValidationError
                .serializer,
            json,
          );
}
