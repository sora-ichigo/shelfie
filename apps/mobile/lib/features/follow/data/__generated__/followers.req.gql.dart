// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:shelfie/features/follow/data/__generated__/followers.ast.gql.dart'
    as _i5;
import 'package:shelfie/features/follow/data/__generated__/followers.data.gql.dart'
    as _i2;
import 'package:shelfie/features/follow/data/__generated__/followers.var.gql.dart'
    as _i3;

part 'followers.req.gql.g.dart';

abstract class GFollowersReq
    implements
        Built<GFollowersReq, GFollowersReqBuilder>,
        _i1.OperationRequest<_i2.GFollowersData, _i3.GFollowersVars> {
  GFollowersReq._();

  factory GFollowersReq([void Function(GFollowersReqBuilder b) updates]) =
      _$GFollowersReq;

  static void _initializeBuilder(GFollowersReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'Followers',
    )
    ..executeOnListen = true;

  @override
  _i3.GFollowersVars get vars;
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
  _i2.GFollowersData? Function(
    _i2.GFollowersData?,
    _i2.GFollowersData?,
  )? get updateResult;
  @override
  _i2.GFollowersData? get optimisticResponse;
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
  _i2.GFollowersData? parseData(Map<String, dynamic> json) =>
      _i2.GFollowersData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GFollowersData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GFollowersData, _i3.GFollowersVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GFollowersReq> get serializer => _$gFollowersReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GFollowersReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GFollowersReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GFollowersReq.serializer,
        json,
      );
}
