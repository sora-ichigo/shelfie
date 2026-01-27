// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:shelfie/features/book_list/data/__generated__/reorder_book_in_list.ast.gql.dart'
    as _i5;
import 'package:shelfie/features/book_list/data/__generated__/reorder_book_in_list.data.gql.dart'
    as _i2;
import 'package:shelfie/features/book_list/data/__generated__/reorder_book_in_list.var.gql.dart'
    as _i3;

part 'reorder_book_in_list.req.gql.g.dart';

abstract class GReorderBookInListReq
    implements
        Built<GReorderBookInListReq, GReorderBookInListReqBuilder>,
        _i1.OperationRequest<_i2.GReorderBookInListData,
            _i3.GReorderBookInListVars> {
  GReorderBookInListReq._();

  factory GReorderBookInListReq(
          [void Function(GReorderBookInListReqBuilder b) updates]) =
      _$GReorderBookInListReq;

  static void _initializeBuilder(GReorderBookInListReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'ReorderBookInList',
    )
    ..executeOnListen = true;

  @override
  _i3.GReorderBookInListVars get vars;
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
  _i2.GReorderBookInListData? Function(
    _i2.GReorderBookInListData?,
    _i2.GReorderBookInListData?,
  )? get updateResult;
  @override
  _i2.GReorderBookInListData? get optimisticResponse;
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
  _i2.GReorderBookInListData? parseData(Map<String, dynamic> json) =>
      _i2.GReorderBookInListData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GReorderBookInListData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GReorderBookInListData, _i3.GReorderBookInListVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GReorderBookInListReq> get serializer =>
      _$gReorderBookInListReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GReorderBookInListReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GReorderBookInListReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GReorderBookInListReq.serializer,
        json,
      );
}
