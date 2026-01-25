// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:shelfie/features/account/data/__generated__/get_my_profile.ast.gql.dart'
    as _i5;
import 'package:shelfie/features/account/data/__generated__/get_my_profile.data.gql.dart'
    as _i2;
import 'package:shelfie/features/account/data/__generated__/get_my_profile.var.gql.dart'
    as _i3;

part 'get_my_profile.req.gql.g.dart';

abstract class GGetMyProfileReq
    implements
        Built<GGetMyProfileReq, GGetMyProfileReqBuilder>,
        _i1.OperationRequest<_i2.GGetMyProfileData, _i3.GGetMyProfileVars> {
  GGetMyProfileReq._();

  factory GGetMyProfileReq([void Function(GGetMyProfileReqBuilder b) updates]) =
      _$GGetMyProfileReq;

  static void _initializeBuilder(GGetMyProfileReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetMyProfile',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetMyProfileVars get vars;
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
  _i2.GGetMyProfileData? Function(
    _i2.GGetMyProfileData?,
    _i2.GGetMyProfileData?,
  )? get updateResult;
  @override
  _i2.GGetMyProfileData? get optimisticResponse;
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
  _i2.GGetMyProfileData? parseData(Map<String, dynamic> json) =>
      _i2.GGetMyProfileData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetMyProfileData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetMyProfileData, _i3.GGetMyProfileVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetMyProfileReq> get serializer =>
      _$gGetMyProfileReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GGetMyProfileReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMyProfileReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GGetMyProfileReq.serializer,
        json,
      );
}
