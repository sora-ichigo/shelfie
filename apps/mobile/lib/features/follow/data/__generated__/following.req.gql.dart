// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:shelfie/features/follow/data/__generated__/following.ast.gql.dart'
    as _i5;
import 'package:shelfie/features/follow/data/__generated__/following.data.gql.dart'
    as _i2;
import 'package:shelfie/features/follow/data/__generated__/following.var.gql.dart'
    as _i3;

part 'following.req.gql.g.dart';

abstract class GFollowingReq
    implements
        Built<GFollowingReq, GFollowingReqBuilder>,
        _i1.OperationRequest<_i2.GFollowingData, _i3.GFollowingVars> {
  GFollowingReq._();

  factory GFollowingReq([void Function(GFollowingReqBuilder b) updates]) =
      _$GFollowingReq;

  static void _initializeBuilder(GFollowingReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'Following',
    )
    ..executeOnListen = true;

  @override
  _i3.GFollowingVars get vars;
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
  _i2.GFollowingData? Function(
    _i2.GFollowingData?,
    _i2.GFollowingData?,
  )? get updateResult;
  @override
  _i2.GFollowingData? get optimisticResponse;
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
  _i2.GFollowingData? parseData(Map<String, dynamic> json) =>
      _i2.GFollowingData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GFollowingData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GFollowingData, _i3.GFollowingVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GFollowingReq> get serializer => _$gFollowingReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GFollowingReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GFollowingReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GFollowingReq.serializer,
        json,
      );
}
