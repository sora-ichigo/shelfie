// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart'
    as _i2;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'pending_follow_requests.data.gql.g.dart';

abstract class GPendingFollowRequestsData
    implements
        Built<GPendingFollowRequestsData, GPendingFollowRequestsDataBuilder> {
  GPendingFollowRequestsData._();

  factory GPendingFollowRequestsData(
          [void Function(GPendingFollowRequestsDataBuilder b) updates]) =
      _$GPendingFollowRequestsData;

  static void _initializeBuilder(GPendingFollowRequestsDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GPendingFollowRequestsData_pendingFollowRequests>
      get pendingFollowRequests;
  static Serializer<GPendingFollowRequestsData> get serializer =>
      _$gPendingFollowRequestsDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPendingFollowRequestsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPendingFollowRequestsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPendingFollowRequestsData.serializer,
        json,
      );
}

abstract class GPendingFollowRequestsData_pendingFollowRequests
    implements
        Built<GPendingFollowRequestsData_pendingFollowRequests,
            GPendingFollowRequestsData_pendingFollowRequestsBuilder> {
  GPendingFollowRequestsData_pendingFollowRequests._();

  factory GPendingFollowRequestsData_pendingFollowRequests(
      [void Function(GPendingFollowRequestsData_pendingFollowRequestsBuilder b)
          updates]) = _$GPendingFollowRequestsData_pendingFollowRequests;

  static void _initializeBuilder(
          GPendingFollowRequestsData_pendingFollowRequestsBuilder b) =>
      b..G__typename = 'FollowRequest';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  int get senderId;
  int get receiverId;
  _i2.GFollowRequestStatus get status;
  DateTime get createdAt;
  static Serializer<GPendingFollowRequestsData_pendingFollowRequests>
      get serializer =>
          _$gPendingFollowRequestsDataPendingFollowRequestsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPendingFollowRequestsData_pendingFollowRequests.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPendingFollowRequestsData_pendingFollowRequests? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPendingFollowRequestsData_pendingFollowRequests.serializer,
        json,
      );
}
