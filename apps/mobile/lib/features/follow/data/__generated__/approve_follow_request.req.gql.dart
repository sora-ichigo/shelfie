// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:shelfie/features/follow/data/__generated__/approve_follow_request.ast.gql.dart'
    as _i5;
import 'package:shelfie/features/follow/data/__generated__/approve_follow_request.data.gql.dart'
    as _i2;
import 'package:shelfie/features/follow/data/__generated__/approve_follow_request.var.gql.dart'
    as _i3;

part 'approve_follow_request.req.gql.g.dart';

abstract class GApproveFollowRequestReq
    implements
        Built<GApproveFollowRequestReq, GApproveFollowRequestReqBuilder>,
        _i1.OperationRequest<_i2.GApproveFollowRequestData,
            _i3.GApproveFollowRequestVars> {
  GApproveFollowRequestReq._();

  factory GApproveFollowRequestReq(
          [void Function(GApproveFollowRequestReqBuilder b) updates]) =
      _$GApproveFollowRequestReq;

  static void _initializeBuilder(GApproveFollowRequestReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'ApproveFollowRequest',
    )
    ..executeOnListen = true;

  @override
  _i3.GApproveFollowRequestVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GApproveFollowRequestData? Function(
    _i2.GApproveFollowRequestData?,
    _i2.GApproveFollowRequestData?,
  )? get updateResult;
  @override
  _i2.GApproveFollowRequestData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GApproveFollowRequestData? parseData(Map<String, dynamic> json) =>
      _i2.GApproveFollowRequestData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GApproveFollowRequestData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GApproveFollowRequestData,
      _i3.GApproveFollowRequestVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GApproveFollowRequestReq> get serializer =>
      _$gApproveFollowRequestReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GApproveFollowRequestReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GApproveFollowRequestReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GApproveFollowRequestReq.serializer,
        json,
      );
}
