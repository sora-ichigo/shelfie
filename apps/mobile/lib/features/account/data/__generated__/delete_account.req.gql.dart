// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:shelfie/features/account/data/__generated__/delete_account.ast.gql.dart'
    as _i5;
import 'package:shelfie/features/account/data/__generated__/delete_account.data.gql.dart'
    as _i2;
import 'package:shelfie/features/account/data/__generated__/delete_account.var.gql.dart'
    as _i3;

part 'delete_account.req.gql.g.dart';

abstract class GDeleteAccountReq
    implements
        Built<GDeleteAccountReq, GDeleteAccountReqBuilder>,
        _i1.OperationRequest<_i2.GDeleteAccountData, _i3.GDeleteAccountVars> {
  GDeleteAccountReq._();

  factory GDeleteAccountReq(
          [void Function(GDeleteAccountReqBuilder b) updates]) =
      _$GDeleteAccountReq;

  static void _initializeBuilder(GDeleteAccountReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'DeleteAccount',
    )
    ..executeOnListen = true;

  @override
  _i3.GDeleteAccountVars get vars;
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
  _i2.GDeleteAccountData? Function(
    _i2.GDeleteAccountData?,
    _i2.GDeleteAccountData?,
  )? get updateResult;
  @override
  _i2.GDeleteAccountData? get optimisticResponse;
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
  _i2.GDeleteAccountData? parseData(Map<String, dynamic> json) =>
      _i2.GDeleteAccountData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GDeleteAccountData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GDeleteAccountData, _i3.GDeleteAccountVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GDeleteAccountReq> get serializer =>
      _$gDeleteAccountReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GDeleteAccountReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GDeleteAccountReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GDeleteAccountReq.serializer,
        json,
      );
}
