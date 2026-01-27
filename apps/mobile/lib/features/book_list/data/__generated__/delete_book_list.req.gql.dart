// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:shelfie/features/book_list/data/__generated__/delete_book_list.ast.gql.dart'
    as _i5;
import 'package:shelfie/features/book_list/data/__generated__/delete_book_list.data.gql.dart'
    as _i2;
import 'package:shelfie/features/book_list/data/__generated__/delete_book_list.var.gql.dart'
    as _i3;

part 'delete_book_list.req.gql.g.dart';

abstract class GDeleteBookListReq
    implements
        Built<GDeleteBookListReq, GDeleteBookListReqBuilder>,
        _i1.OperationRequest<_i2.GDeleteBookListData, _i3.GDeleteBookListVars> {
  GDeleteBookListReq._();

  factory GDeleteBookListReq(
          [void Function(GDeleteBookListReqBuilder b) updates]) =
      _$GDeleteBookListReq;

  static void _initializeBuilder(GDeleteBookListReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'DeleteBookList',
    )
    ..executeOnListen = true;

  @override
  _i3.GDeleteBookListVars get vars;
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
  _i2.GDeleteBookListData? Function(
    _i2.GDeleteBookListData?,
    _i2.GDeleteBookListData?,
  )? get updateResult;
  @override
  _i2.GDeleteBookListData? get optimisticResponse;
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
  _i2.GDeleteBookListData? parseData(Map<String, dynamic> json) =>
      _i2.GDeleteBookListData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GDeleteBookListData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GDeleteBookListData, _i3.GDeleteBookListVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GDeleteBookListReq> get serializer =>
      _$gDeleteBookListReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GDeleteBookListReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GDeleteBookListReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GDeleteBookListReq.serializer,
        json,
      );
}
