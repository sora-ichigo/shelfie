// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:shelfie/features/book_list/data/__generated__/book_list_detail.ast.gql.dart'
    as _i5;
import 'package:shelfie/features/book_list/data/__generated__/book_list_detail.data.gql.dart'
    as _i2;
import 'package:shelfie/features/book_list/data/__generated__/book_list_detail.var.gql.dart'
    as _i3;

part 'book_list_detail.req.gql.g.dart';

abstract class GBookListDetailReq
    implements
        Built<GBookListDetailReq, GBookListDetailReqBuilder>,
        _i1.OperationRequest<_i2.GBookListDetailData, _i3.GBookListDetailVars> {
  GBookListDetailReq._();

  factory GBookListDetailReq(
          [void Function(GBookListDetailReqBuilder b) updates]) =
      _$GBookListDetailReq;

  static void _initializeBuilder(GBookListDetailReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'BookListDetail',
    )
    ..executeOnListen = true;

  @override
  _i3.GBookListDetailVars get vars;
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
  _i2.GBookListDetailData? Function(
    _i2.GBookListDetailData?,
    _i2.GBookListDetailData?,
  )? get updateResult;
  @override
  _i2.GBookListDetailData? get optimisticResponse;
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
  _i2.GBookListDetailData? parseData(Map<String, dynamic> json) =>
      _i2.GBookListDetailData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GBookListDetailData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GBookListDetailData, _i3.GBookListDetailVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GBookListDetailReq> get serializer =>
      _$gBookListDetailReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GBookListDetailReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GBookListDetailReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GBookListDetailReq.serializer,
        json,
      );
}
