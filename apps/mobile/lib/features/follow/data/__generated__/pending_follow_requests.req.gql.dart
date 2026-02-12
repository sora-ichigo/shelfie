// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:shelfie/features/follow/data/__generated__/pending_follow_requests.ast.gql.dart'
    as _i5;
import 'package:shelfie/features/follow/data/__generated__/pending_follow_requests.data.gql.dart'
    as _i2;
import 'package:shelfie/features/follow/data/__generated__/pending_follow_requests.var.gql.dart'
    as _i3;

part 'pending_follow_requests.req.gql.g.dart';

abstract class GPendingFollowRequestsReq
    implements
        Built<GPendingFollowRequestsReq, GPendingFollowRequestsReqBuilder>,
        _i1.OperationRequest<_i2.GPendingFollowRequestsData,
            _i3.GPendingFollowRequestsVars> {
  GPendingFollowRequestsReq._();

  factory GPendingFollowRequestsReq(
          [void Function(GPendingFollowRequestsReqBuilder b) updates]) =
      _$GPendingFollowRequestsReq;

  static void _initializeBuilder(GPendingFollowRequestsReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'PendingFollowRequests',
    )
    ..executeOnListen = true;

  @override
  _i3.GPendingFollowRequestsVars get vars;
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
  _i2.GPendingFollowRequestsData? Function(
    _i2.GPendingFollowRequestsData?,
    _i2.GPendingFollowRequestsData?,
  )? get updateResult;
  @override
  _i2.GPendingFollowRequestsData? get optimisticResponse;
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
  _i2.GPendingFollowRequestsData? parseData(Map<String, dynamic> json) =>
      _i2.GPendingFollowRequestsData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GPendingFollowRequestsData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GPendingFollowRequestsData,
      _i3.GPendingFollowRequestsVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GPendingFollowRequestsReq> get serializer =>
      _$gPendingFollowRequestsReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GPendingFollowRequestsReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPendingFollowRequestsReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GPendingFollowRequestsReq.serializer,
        json,
      );
}
