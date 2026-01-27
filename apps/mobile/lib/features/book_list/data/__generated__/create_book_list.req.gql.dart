// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:shelfie/features/book_list/data/__generated__/create_book_list.ast.gql.dart'
    as _i5;
import 'package:shelfie/features/book_list/data/__generated__/create_book_list.data.gql.dart'
    as _i2;
import 'package:shelfie/features/book_list/data/__generated__/create_book_list.var.gql.dart'
    as _i3;

part 'create_book_list.req.gql.g.dart';

abstract class GCreateBookListReq
    implements
        Built<GCreateBookListReq, GCreateBookListReqBuilder>,
        _i1.OperationRequest<_i2.GCreateBookListData, _i3.GCreateBookListVars> {
  GCreateBookListReq._();

  factory GCreateBookListReq(
          [void Function(GCreateBookListReqBuilder b) updates]) =
      _$GCreateBookListReq;

  static void _initializeBuilder(GCreateBookListReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'CreateBookList',
    )
    ..executeOnListen = true;

  @override
  _i3.GCreateBookListVars get vars;
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
  _i2.GCreateBookListData? Function(
    _i2.GCreateBookListData?,
    _i2.GCreateBookListData?,
  )? get updateResult;
  @override
  _i2.GCreateBookListData? get optimisticResponse;
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
  _i2.GCreateBookListData? parseData(Map<String, dynamic> json) =>
      _i2.GCreateBookListData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GCreateBookListData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GCreateBookListData, _i3.GCreateBookListVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GCreateBookListReq> get serializer =>
      _$gCreateBookListReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GCreateBookListReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateBookListReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GCreateBookListReq.serializer,
        json,
      );
}
