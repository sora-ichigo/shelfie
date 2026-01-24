// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:shelfie/core/state/__generated__/my_shelf.ast.gql.dart' as _i5;
import 'package:shelfie/core/state/__generated__/my_shelf.data.gql.dart' as _i2;
import 'package:shelfie/core/state/__generated__/my_shelf.var.gql.dart' as _i3;

part 'my_shelf.req.gql.g.dart';

abstract class GMyShelfReq
    implements
        Built<GMyShelfReq, GMyShelfReqBuilder>,
        _i1.OperationRequest<_i2.GMyShelfData, _i3.GMyShelfVars> {
  GMyShelfReq._();

  factory GMyShelfReq([void Function(GMyShelfReqBuilder b) updates]) =
      _$GMyShelfReq;

  static void _initializeBuilder(GMyShelfReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'MyShelf',
    )
    ..executeOnListen = true;

  @override
  _i3.GMyShelfVars get vars;
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
  _i2.GMyShelfData? Function(
    _i2.GMyShelfData?,
    _i2.GMyShelfData?,
  )? get updateResult;
  @override
  _i2.GMyShelfData? get optimisticResponse;
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
  _i2.GMyShelfData? parseData(Map<String, dynamic> json) =>
      _i2.GMyShelfData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GMyShelfData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GMyShelfData, _i3.GMyShelfVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GMyShelfReq> get serializer => _$gMyShelfReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GMyShelfReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyShelfReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GMyShelfReq.serializer,
        json,
      );
}
