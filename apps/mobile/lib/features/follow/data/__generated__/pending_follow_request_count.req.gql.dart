// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:shelfie/features/follow/data/__generated__/pending_follow_request_count.ast.gql.dart'
    as _i5;
import 'package:shelfie/features/follow/data/__generated__/pending_follow_request_count.data.gql.dart'
    as _i2;
import 'package:shelfie/features/follow/data/__generated__/pending_follow_request_count.var.gql.dart'
    as _i3;

part 'pending_follow_request_count.req.gql.g.dart';

abstract class GPendingFollowRequestCountReq
    implements
        Built<GPendingFollowRequestCountReq,
            GPendingFollowRequestCountReqBuilder>,
        _i1.OperationRequest<_i2.GPendingFollowRequestCountData,
            _i3.GPendingFollowRequestCountVars> {
  GPendingFollowRequestCountReq._();

  factory GPendingFollowRequestCountReq(
          [void Function(GPendingFollowRequestCountReqBuilder b) updates]) =
      _$GPendingFollowRequestCountReq;

  static void _initializeBuilder(GPendingFollowRequestCountReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'PendingFollowRequestCount',
    )
    ..executeOnListen = true;

  @override
  _i3.GPendingFollowRequestCountVars get vars;
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
  _i2.GPendingFollowRequestCountData? Function(
    _i2.GPendingFollowRequestCountData?,
    _i2.GPendingFollowRequestCountData?,
  )? get updateResult;
  @override
  _i2.GPendingFollowRequestCountData? get optimisticResponse;
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
  _i2.GPendingFollowRequestCountData? parseData(Map<String, dynamic> json) =>
      _i2.GPendingFollowRequestCountData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GPendingFollowRequestCountData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GPendingFollowRequestCountData,
      _i3.GPendingFollowRequestCountVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GPendingFollowRequestCountReq> get serializer =>
      _$gPendingFollowRequestCountReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GPendingFollowRequestCountReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPendingFollowRequestCountReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GPendingFollowRequestCountReq.serializer,
        json,
      );
}
