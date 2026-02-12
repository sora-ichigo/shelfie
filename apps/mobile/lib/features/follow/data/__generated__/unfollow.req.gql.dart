// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:shelfie/features/follow/data/__generated__/unfollow.ast.gql.dart'
    as _i5;
import 'package:shelfie/features/follow/data/__generated__/unfollow.data.gql.dart'
    as _i2;
import 'package:shelfie/features/follow/data/__generated__/unfollow.var.gql.dart'
    as _i3;

part 'unfollow.req.gql.g.dart';

abstract class GUnfollowReq
    implements
        Built<GUnfollowReq, GUnfollowReqBuilder>,
        _i1.OperationRequest<_i2.GUnfollowData, _i3.GUnfollowVars> {
  GUnfollowReq._();

  factory GUnfollowReq([void Function(GUnfollowReqBuilder b) updates]) =
      _$GUnfollowReq;

  static void _initializeBuilder(GUnfollowReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'Unfollow',
    )
    ..executeOnListen = true;

  @override
  _i3.GUnfollowVars get vars;
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
  _i2.GUnfollowData? Function(
    _i2.GUnfollowData?,
    _i2.GUnfollowData?,
  )? get updateResult;
  @override
  _i2.GUnfollowData? get optimisticResponse;
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
  _i2.GUnfollowData? parseData(Map<String, dynamic> json) =>
      _i2.GUnfollowData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GUnfollowData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GUnfollowData, _i3.GUnfollowVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GUnfollowReq> get serializer => _$gUnfollowReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GUnfollowReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUnfollowReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GUnfollowReq.serializer,
        json,
      );
}
