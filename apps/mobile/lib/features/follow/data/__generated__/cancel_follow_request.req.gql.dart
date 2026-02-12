// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:shelfie/features/follow/data/__generated__/cancel_follow_request.ast.gql.dart'
    as _i5;
import 'package:shelfie/features/follow/data/__generated__/cancel_follow_request.data.gql.dart'
    as _i2;
import 'package:shelfie/features/follow/data/__generated__/cancel_follow_request.var.gql.dart'
    as _i3;

part 'cancel_follow_request.req.gql.g.dart';

abstract class GCancelFollowRequestReq
    implements
        Built<GCancelFollowRequestReq, GCancelFollowRequestReqBuilder>,
        _i1.OperationRequest<_i2.GCancelFollowRequestData,
            _i3.GCancelFollowRequestVars> {
  GCancelFollowRequestReq._();

  factory GCancelFollowRequestReq(
          [void Function(GCancelFollowRequestReqBuilder b) updates]) =
      _$GCancelFollowRequestReq;

  static void _initializeBuilder(GCancelFollowRequestReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'CancelFollowRequest',
    )
    ..executeOnListen = true;

  @override
  _i3.GCancelFollowRequestVars get vars;
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
  _i2.GCancelFollowRequestData? Function(
    _i2.GCancelFollowRequestData?,
    _i2.GCancelFollowRequestData?,
  )? get updateResult;
  @override
  _i2.GCancelFollowRequestData? get optimisticResponse;
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
  _i2.GCancelFollowRequestData? parseData(Map<String, dynamic> json) =>
      _i2.GCancelFollowRequestData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GCancelFollowRequestData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GCancelFollowRequestData,
      _i3.GCancelFollowRequestVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GCancelFollowRequestReq> get serializer =>
      _$gCancelFollowRequestReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GCancelFollowRequestReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCancelFollowRequestReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GCancelFollowRequestReq.serializer,
        json,
      );
}
