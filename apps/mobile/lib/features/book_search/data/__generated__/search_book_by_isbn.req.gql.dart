// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:shelfie/features/book_search/data/__generated__/search_book_by_isbn.ast.gql.dart'
    as _i5;
import 'package:shelfie/features/book_search/data/__generated__/search_book_by_isbn.data.gql.dart'
    as _i2;
import 'package:shelfie/features/book_search/data/__generated__/search_book_by_isbn.var.gql.dart'
    as _i3;

part 'search_book_by_isbn.req.gql.g.dart';

abstract class GSearchBookByISBNReq
    implements
        Built<GSearchBookByISBNReq, GSearchBookByISBNReqBuilder>,
        _i1.OperationRequest<_i2.GSearchBookByISBNData,
            _i3.GSearchBookByISBNVars> {
  GSearchBookByISBNReq._();

  factory GSearchBookByISBNReq(
          [void Function(GSearchBookByISBNReqBuilder b) updates]) =
      _$GSearchBookByISBNReq;

  static void _initializeBuilder(GSearchBookByISBNReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'SearchBookByISBN',
    )
    ..executeOnListen = true;

  @override
  _i3.GSearchBookByISBNVars get vars;
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
  _i2.GSearchBookByISBNData? Function(
    _i2.GSearchBookByISBNData?,
    _i2.GSearchBookByISBNData?,
  )? get updateResult;
  @override
  _i2.GSearchBookByISBNData? get optimisticResponse;
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
  _i2.GSearchBookByISBNData? parseData(Map<String, dynamic> json) =>
      _i2.GSearchBookByISBNData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GSearchBookByISBNData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GSearchBookByISBNData, _i3.GSearchBookByISBNVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GSearchBookByISBNReq> get serializer =>
      _$gSearchBookByISBNReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GSearchBookByISBNReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchBookByISBNReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GSearchBookByISBNReq.serializer,
        json,
      );
}
