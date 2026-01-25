// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:shelfie/features/account/data/__generated__/update_profile.ast.gql.dart'
    as _i5;
import 'package:shelfie/features/account/data/__generated__/update_profile.data.gql.dart'
    as _i2;
import 'package:shelfie/features/account/data/__generated__/update_profile.var.gql.dart'
    as _i3;

part 'update_profile.req.gql.g.dart';

abstract class GUpdateProfileReq
    implements
        Built<GUpdateProfileReq, GUpdateProfileReqBuilder>,
        _i1.OperationRequest<_i2.GUpdateProfileData, _i3.GUpdateProfileVars> {
  GUpdateProfileReq._();

  factory GUpdateProfileReq(
          [void Function(GUpdateProfileReqBuilder b) updates]) =
      _$GUpdateProfileReq;

  static void _initializeBuilder(GUpdateProfileReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'UpdateProfile',
    )
    ..executeOnListen = true;

  @override
  _i3.GUpdateProfileVars get vars;
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
  _i2.GUpdateProfileData? Function(
    _i2.GUpdateProfileData?,
    _i2.GUpdateProfileData?,
  )? get updateResult;
  @override
  _i2.GUpdateProfileData? get optimisticResponse;
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
  _i2.GUpdateProfileData? parseData(Map<String, dynamic> json) =>
      _i2.GUpdateProfileData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GUpdateProfileData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GUpdateProfileData, _i3.GUpdateProfileVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GUpdateProfileReq> get serializer =>
      _$gUpdateProfileReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GUpdateProfileReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateProfileReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GUpdateProfileReq.serializer,
        json,
      );
}
