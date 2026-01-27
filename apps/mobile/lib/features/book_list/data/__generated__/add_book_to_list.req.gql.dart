// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:shelfie/features/book_list/data/__generated__/add_book_to_list.ast.gql.dart'
    as _i5;
import 'package:shelfie/features/book_list/data/__generated__/add_book_to_list.data.gql.dart'
    as _i2;
import 'package:shelfie/features/book_list/data/__generated__/add_book_to_list.var.gql.dart'
    as _i3;

part 'add_book_to_list.req.gql.g.dart';

abstract class GAddBookToListReq
    implements
        Built<GAddBookToListReq, GAddBookToListReqBuilder>,
        _i1.OperationRequest<_i2.GAddBookToListData, _i3.GAddBookToListVars> {
  GAddBookToListReq._();

  factory GAddBookToListReq(
          [void Function(GAddBookToListReqBuilder b) updates]) =
      _$GAddBookToListReq;

  static void _initializeBuilder(GAddBookToListReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'AddBookToList',
    )
    ..executeOnListen = true;

  @override
  _i3.GAddBookToListVars get vars;
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
  _i2.GAddBookToListData? Function(
    _i2.GAddBookToListData?,
    _i2.GAddBookToListData?,
  )? get updateResult;
  @override
  _i2.GAddBookToListData? get optimisticResponse;
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
  _i2.GAddBookToListData? parseData(Map<String, dynamic> json) =>
      _i2.GAddBookToListData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GAddBookToListData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GAddBookToListData, _i3.GAddBookToListVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GAddBookToListReq> get serializer =>
      _$gAddBookToListReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GAddBookToListReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAddBookToListReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GAddBookToListReq.serializer,
        json,
      );
}
