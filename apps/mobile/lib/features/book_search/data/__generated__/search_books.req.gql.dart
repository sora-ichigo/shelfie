// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:shelfie/features/book_search/data/__generated__/search_books.ast.gql.dart'
    as _i5;
import 'package:shelfie/features/book_search/data/__generated__/search_books.data.gql.dart'
    as _i2;
import 'package:shelfie/features/book_search/data/__generated__/search_books.var.gql.dart'
    as _i3;

part 'search_books.req.gql.g.dart';

abstract class GSearchBooksReq
    implements
        Built<GSearchBooksReq, GSearchBooksReqBuilder>,
        _i1.OperationRequest<_i2.GSearchBooksData, _i3.GSearchBooksVars> {
  GSearchBooksReq._();

  factory GSearchBooksReq([void Function(GSearchBooksReqBuilder b) updates]) =
      _$GSearchBooksReq;

  static void _initializeBuilder(GSearchBooksReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'SearchBooks',
    )
    ..executeOnListen = true;

  @override
  _i3.GSearchBooksVars get vars;
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
  _i2.GSearchBooksData? Function(
    _i2.GSearchBooksData?,
    _i2.GSearchBooksData?,
  )? get updateResult;
  @override
  _i2.GSearchBooksData? get optimisticResponse;
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
  _i2.GSearchBooksData? parseData(Map<String, dynamic> json) =>
      _i2.GSearchBooksData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GSearchBooksData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GSearchBooksData, _i3.GSearchBooksVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GSearchBooksReq> get serializer =>
      _$gSearchBooksReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GSearchBooksReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchBooksReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GSearchBooksReq.serializer,
        json,
      );
}
