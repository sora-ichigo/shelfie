// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:shelfie/features/follow/data/__generated__/reject_follow_request.ast.gql.dart'
    as _i5;
import 'package:shelfie/features/follow/data/__generated__/reject_follow_request.data.gql.dart'
    as _i2;
import 'package:shelfie/features/follow/data/__generated__/reject_follow_request.var.gql.dart'
    as _i3;

part 'reject_follow_request.req.gql.g.dart';

abstract class GRejectFollowRequestReq
    implements
        Built<GRejectFollowRequestReq, GRejectFollowRequestReqBuilder>,
        _i1.OperationRequest<_i2.GRejectFollowRequestData,
            _i3.GRejectFollowRequestVars> {
  GRejectFollowRequestReq._();

  factory GRejectFollowRequestReq(
          [void Function(GRejectFollowRequestReqBuilder b) updates]) =
      _$GRejectFollowRequestReq;

  static void _initializeBuilder(GRejectFollowRequestReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'RejectFollowRequest',
    )
    ..executeOnListen = true;

  @override
  _i3.GRejectFollowRequestVars get vars;
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
  _i2.GRejectFollowRequestData? Function(
    _i2.GRejectFollowRequestData?,
    _i2.GRejectFollowRequestData?,
  )? get updateResult;
  @override
  _i2.GRejectFollowRequestData? get optimisticResponse;
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
  _i2.GRejectFollowRequestData? parseData(Map<String, dynamic> json) =>
      _i2.GRejectFollowRequestData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GRejectFollowRequestData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GRejectFollowRequestData,
      _i3.GRejectFollowRequestVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GRejectFollowRequestReq> get serializer =>
      _$gRejectFollowRequestReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GRejectFollowRequestReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRejectFollowRequestReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GRejectFollowRequestReq.serializer,
        json,
      );
}
