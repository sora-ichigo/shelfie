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

part 'reject_follow_request.data.gql.g.dart';

abstract class GRejectFollowRequestData
    implements
        Built<GRejectFollowRequestData, GRejectFollowRequestDataBuilder> {
  GRejectFollowRequestData._();

  factory GRejectFollowRequestData(
          [void Function(GRejectFollowRequestDataBuilder b) updates]) =
      _$GRejectFollowRequestData;

  static void _initializeBuilder(GRejectFollowRequestDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GRejectFollowRequestData_rejectFollowRequest? get rejectFollowRequest;
  static Serializer<GRejectFollowRequestData> get serializer =>
      _$gRejectFollowRequestDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRejectFollowRequestData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRejectFollowRequestData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRejectFollowRequestData.serializer,
        json,
      );
}

abstract class GRejectFollowRequestData_rejectFollowRequest {
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GRejectFollowRequestData_rejectFollowRequest>
      get serializer => _i2.InlineFragmentSerializer<
              GRejectFollowRequestData_rejectFollowRequest>(
            'GRejectFollowRequestData_rejectFollowRequest',
            GRejectFollowRequestData_rejectFollowRequest__base,
            {
              'MutationRejectFollowRequestSuccess':
                  GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess,
              'ValidationError':
                  GRejectFollowRequestData_rejectFollowRequest__asValidationError,
            },
          );

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRejectFollowRequestData_rejectFollowRequest.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRejectFollowRequestData_rejectFollowRequest? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRejectFollowRequestData_rejectFollowRequest.serializer,
        json,
      );
}

abstract class GRejectFollowRequestData_rejectFollowRequest__base
    implements
        Built<GRejectFollowRequestData_rejectFollowRequest__base,
            GRejectFollowRequestData_rejectFollowRequest__baseBuilder>,
        GRejectFollowRequestData_rejectFollowRequest {
  GRejectFollowRequestData_rejectFollowRequest__base._();

  factory GRejectFollowRequestData_rejectFollowRequest__base(
      [void Function(
              GRejectFollowRequestData_rejectFollowRequest__baseBuilder b)
          updates]) = _$GRejectFollowRequestData_rejectFollowRequest__base;

  static void _initializeBuilder(
          GRejectFollowRequestData_rejectFollowRequest__baseBuilder b) =>
      b..G__typename = 'MutationRejectFollowRequestResult';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GRejectFollowRequestData_rejectFollowRequest__base>
      get serializer =>
          _$gRejectFollowRequestDataRejectFollowRequestBaseSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRejectFollowRequestData_rejectFollowRequest__base.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRejectFollowRequestData_rejectFollowRequest__base? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRejectFollowRequestData_rejectFollowRequest__base.serializer,
        json,
      );
}

abstract class GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess
    implements
        Built<
            GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess,
            GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccessBuilder>,
        GRejectFollowRequestData_rejectFollowRequest {
  GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess._();

  factory GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess(
          [void Function(
                  GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccessBuilder
                      b)
              updates]) =
      _$GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess;

  static void _initializeBuilder(
          GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccessBuilder
              b) =>
      b..G__typename = 'MutationRejectFollowRequestSuccess';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data
      get data;
  static Serializer<
          GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess>
      get serializer =>
          _$gRejectFollowRequestDataRejectFollowRequestAsMutationRejectFollowRequestSuccessSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess
                .serializer,
            json,
          );
}

abstract class GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data
    implements
        Built<
            GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data,
            GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_dataBuilder> {
  GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data._();

  factory GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data(
          [void Function(
                  GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_dataBuilder
                      b)
              updates]) =
      _$GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data;

  static void _initializeBuilder(
          GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_dataBuilder
              b) =>
      b..G__typename = 'FollowRequest';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int? get id;
  int? get senderId;
  int? get receiverId;
  _i3.GFollowRequestStatus? get status;
  DateTime? get createdAt;
  static Serializer<
          GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data>
      get serializer =>
          _$gRejectFollowRequestDataRejectFollowRequestAsMutationRejectFollowRequestSuccessDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data
                .serializer,
            json,
          );
}

abstract class GRejectFollowRequestData_rejectFollowRequest__asValidationError
    implements
        Built<GRejectFollowRequestData_rejectFollowRequest__asValidationError,
            GRejectFollowRequestData_rejectFollowRequest__asValidationErrorBuilder>,
        GRejectFollowRequestData_rejectFollowRequest {
  GRejectFollowRequestData_rejectFollowRequest__asValidationError._();

  factory GRejectFollowRequestData_rejectFollowRequest__asValidationError(
          [void Function(
                  GRejectFollowRequestData_rejectFollowRequest__asValidationErrorBuilder
                      b)
              updates]) =
      _$GRejectFollowRequestData_rejectFollowRequest__asValidationError;

  static void _initializeBuilder(
          GRejectFollowRequestData_rejectFollowRequest__asValidationErrorBuilder
              b) =>
      b..G__typename = 'ValidationError';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get message;
  String? get code;
  static Serializer<
          GRejectFollowRequestData_rejectFollowRequest__asValidationError>
      get serializer =>
          _$gRejectFollowRequestDataRejectFollowRequestAsValidationErrorSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRejectFollowRequestData_rejectFollowRequest__asValidationError
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GRejectFollowRequestData_rejectFollowRequest__asValidationError?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GRejectFollowRequestData_rejectFollowRequest__asValidationError
                .serializer,
            json,
          );
}
