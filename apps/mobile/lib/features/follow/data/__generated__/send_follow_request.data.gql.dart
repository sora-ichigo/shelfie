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

part 'send_follow_request.data.gql.g.dart';

abstract class GSendFollowRequestData
    implements Built<GSendFollowRequestData, GSendFollowRequestDataBuilder> {
  GSendFollowRequestData._();

  factory GSendFollowRequestData(
          [void Function(GSendFollowRequestDataBuilder b) updates]) =
      _$GSendFollowRequestData;

  static void _initializeBuilder(GSendFollowRequestDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GSendFollowRequestData_sendFollowRequest? get sendFollowRequest;
  static Serializer<GSendFollowRequestData> get serializer =>
      _$gSendFollowRequestDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSendFollowRequestData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendFollowRequestData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSendFollowRequestData.serializer,
        json,
      );
}

abstract class GSendFollowRequestData_sendFollowRequest {
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GSendFollowRequestData_sendFollowRequest> get serializer =>
      _i2.InlineFragmentSerializer<GSendFollowRequestData_sendFollowRequest>(
        'GSendFollowRequestData_sendFollowRequest',
        GSendFollowRequestData_sendFollowRequest__base,
        {
          'MutationSendFollowRequestSuccess':
              GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess,
          'ValidationError':
              GSendFollowRequestData_sendFollowRequest__asValidationError,
        },
      );

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSendFollowRequestData_sendFollowRequest.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendFollowRequestData_sendFollowRequest? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSendFollowRequestData_sendFollowRequest.serializer,
        json,
      );
}

abstract class GSendFollowRequestData_sendFollowRequest__base
    implements
        Built<GSendFollowRequestData_sendFollowRequest__base,
            GSendFollowRequestData_sendFollowRequest__baseBuilder>,
        GSendFollowRequestData_sendFollowRequest {
  GSendFollowRequestData_sendFollowRequest__base._();

  factory GSendFollowRequestData_sendFollowRequest__base(
      [void Function(GSendFollowRequestData_sendFollowRequest__baseBuilder b)
          updates]) = _$GSendFollowRequestData_sendFollowRequest__base;

  static void _initializeBuilder(
          GSendFollowRequestData_sendFollowRequest__baseBuilder b) =>
      b..G__typename = 'MutationSendFollowRequestResult';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GSendFollowRequestData_sendFollowRequest__base>
      get serializer => _$gSendFollowRequestDataSendFollowRequestBaseSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSendFollowRequestData_sendFollowRequest__base.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendFollowRequestData_sendFollowRequest__base? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSendFollowRequestData_sendFollowRequest__base.serializer,
        json,
      );
}

abstract class GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess
    implements
        Built<
            GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess,
            GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccessBuilder>,
        GSendFollowRequestData_sendFollowRequest {
  GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess._();

  factory GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess(
          [void Function(
                  GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccessBuilder
                      b)
              updates]) =
      _$GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess;

  static void _initializeBuilder(
          GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccessBuilder
              b) =>
      b..G__typename = 'MutationSendFollowRequestSuccess';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data
      get data;
  static Serializer<
          GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess>
      get serializer =>
          _$gSendFollowRequestDataSendFollowRequestAsMutationSendFollowRequestSuccessSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess
                .serializer,
            json,
          );
}

abstract class GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data
    implements
        Built<
            GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data,
            GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_dataBuilder> {
  GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data._();

  factory GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data(
          [void Function(
                  GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_dataBuilder
                      b)
              updates]) =
      _$GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data;

  static void _initializeBuilder(
          GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_dataBuilder
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
          GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data>
      get serializer =>
          _$gSendFollowRequestDataSendFollowRequestAsMutationSendFollowRequestSuccessDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data
                .serializer,
            json,
          );
}

abstract class GSendFollowRequestData_sendFollowRequest__asValidationError
    implements
        Built<GSendFollowRequestData_sendFollowRequest__asValidationError,
            GSendFollowRequestData_sendFollowRequest__asValidationErrorBuilder>,
        GSendFollowRequestData_sendFollowRequest {
  GSendFollowRequestData_sendFollowRequest__asValidationError._();

  factory GSendFollowRequestData_sendFollowRequest__asValidationError(
      [void Function(
              GSendFollowRequestData_sendFollowRequest__asValidationErrorBuilder
                  b)
          updates]) = _$GSendFollowRequestData_sendFollowRequest__asValidationError;

  static void _initializeBuilder(
          GSendFollowRequestData_sendFollowRequest__asValidationErrorBuilder
              b) =>
      b..G__typename = 'ValidationError';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get message;
  String? get code;
  static Serializer<GSendFollowRequestData_sendFollowRequest__asValidationError>
      get serializer =>
          _$gSendFollowRequestDataSendFollowRequestAsValidationErrorSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSendFollowRequestData_sendFollowRequest__asValidationError.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendFollowRequestData_sendFollowRequest__asValidationError? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSendFollowRequestData_sendFollowRequest__asValidationError.serializer,
        json,
      );
}
