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

part 'approve_follow_request.data.gql.g.dart';

abstract class GApproveFollowRequestData
    implements
        Built<GApproveFollowRequestData, GApproveFollowRequestDataBuilder> {
  GApproveFollowRequestData._();

  factory GApproveFollowRequestData(
          [void Function(GApproveFollowRequestDataBuilder b) updates]) =
      _$GApproveFollowRequestData;

  static void _initializeBuilder(GApproveFollowRequestDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GApproveFollowRequestData_approveFollowRequest? get approveFollowRequest;
  static Serializer<GApproveFollowRequestData> get serializer =>
      _$gApproveFollowRequestDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GApproveFollowRequestData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GApproveFollowRequestData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GApproveFollowRequestData.serializer,
        json,
      );
}

abstract class GApproveFollowRequestData_approveFollowRequest {
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GApproveFollowRequestData_approveFollowRequest>
      get serializer => _i2.InlineFragmentSerializer<
              GApproveFollowRequestData_approveFollowRequest>(
            'GApproveFollowRequestData_approveFollowRequest',
            GApproveFollowRequestData_approveFollowRequest__base,
            {
              'MutationApproveFollowRequestSuccess':
                  GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess,
              'ValidationError':
                  GApproveFollowRequestData_approveFollowRequest__asValidationError,
            },
          );

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GApproveFollowRequestData_approveFollowRequest.serializer,
        this,
      ) as Map<String, dynamic>);

  static GApproveFollowRequestData_approveFollowRequest? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GApproveFollowRequestData_approveFollowRequest.serializer,
        json,
      );
}

abstract class GApproveFollowRequestData_approveFollowRequest__base
    implements
        Built<GApproveFollowRequestData_approveFollowRequest__base,
            GApproveFollowRequestData_approveFollowRequest__baseBuilder>,
        GApproveFollowRequestData_approveFollowRequest {
  GApproveFollowRequestData_approveFollowRequest__base._();

  factory GApproveFollowRequestData_approveFollowRequest__base(
      [void Function(
              GApproveFollowRequestData_approveFollowRequest__baseBuilder b)
          updates]) = _$GApproveFollowRequestData_approveFollowRequest__base;

  static void _initializeBuilder(
          GApproveFollowRequestData_approveFollowRequest__baseBuilder b) =>
      b..G__typename = 'MutationApproveFollowRequestResult';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GApproveFollowRequestData_approveFollowRequest__base>
      get serializer =>
          _$gApproveFollowRequestDataApproveFollowRequestBaseSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GApproveFollowRequestData_approveFollowRequest__base.serializer,
        this,
      ) as Map<String, dynamic>);

  static GApproveFollowRequestData_approveFollowRequest__base? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GApproveFollowRequestData_approveFollowRequest__base.serializer,
        json,
      );
}

abstract class GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess
    implements
        Built<
            GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess,
            GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccessBuilder>,
        GApproveFollowRequestData_approveFollowRequest {
  GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess._();

  factory GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess(
          [void Function(
                  GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccessBuilder
                      b)
              updates]) =
      _$GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess;

  static void _initializeBuilder(
          GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccessBuilder
              b) =>
      b..G__typename = 'MutationApproveFollowRequestSuccess';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data
      get data;
  static Serializer<
          GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess>
      get serializer =>
          _$gApproveFollowRequestDataApproveFollowRequestAsMutationApproveFollowRequestSuccessSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess
                .serializer,
            json,
          );
}

abstract class GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data
    implements
        Built<
            GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data,
            GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_dataBuilder> {
  GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data._();

  factory GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data(
          [void Function(
                  GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_dataBuilder
                      b)
              updates]) =
      _$GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data;

  static void _initializeBuilder(
          GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_dataBuilder
              b) =>
      b..G__typename = 'FollowRequest';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  int get senderId;
  int get receiverId;
  _i3.GFollowRequestStatus get status;
  DateTime get createdAt;
  static Serializer<
          GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data>
      get serializer =>
          _$gApproveFollowRequestDataApproveFollowRequestAsMutationApproveFollowRequestSuccessDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data
                .serializer,
            json,
          );
}

abstract class GApproveFollowRequestData_approveFollowRequest__asValidationError
    implements
        Built<GApproveFollowRequestData_approveFollowRequest__asValidationError,
            GApproveFollowRequestData_approveFollowRequest__asValidationErrorBuilder>,
        GApproveFollowRequestData_approveFollowRequest {
  GApproveFollowRequestData_approveFollowRequest__asValidationError._();

  factory GApproveFollowRequestData_approveFollowRequest__asValidationError(
          [void Function(
                  GApproveFollowRequestData_approveFollowRequest__asValidationErrorBuilder
                      b)
              updates]) =
      _$GApproveFollowRequestData_approveFollowRequest__asValidationError;

  static void _initializeBuilder(
          GApproveFollowRequestData_approveFollowRequest__asValidationErrorBuilder
              b) =>
      b..G__typename = 'ValidationError';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get message;
  String? get code;
  static Serializer<
          GApproveFollowRequestData_approveFollowRequest__asValidationError>
      get serializer =>
          _$gApproveFollowRequestDataApproveFollowRequestAsValidationErrorSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GApproveFollowRequestData_approveFollowRequest__asValidationError
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GApproveFollowRequestData_approveFollowRequest__asValidationError?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GApproveFollowRequestData_approveFollowRequest__asValidationError
                .serializer,
            json,
          );
}
