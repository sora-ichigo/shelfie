// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:shelfie/features/book_list/data/__generated__/list_ids_containing_user_book.ast.gql.dart'
    as _i5;
import 'package:shelfie/features/book_list/data/__generated__/list_ids_containing_user_book.data.gql.dart'
    as _i2;
import 'package:shelfie/features/book_list/data/__generated__/list_ids_containing_user_book.var.gql.dart'
    as _i3;

part 'list_ids_containing_user_book.req.gql.g.dart';

abstract class GListIdsContainingUserBookReq
    implements
        Built<GListIdsContainingUserBookReq,
            GListIdsContainingUserBookReqBuilder>,
        _i1.OperationRequest<_i2.GListIdsContainingUserBookData,
            _i3.GListIdsContainingUserBookVars> {
  GListIdsContainingUserBookReq._();

  factory GListIdsContainingUserBookReq(
          [void Function(GListIdsContainingUserBookReqBuilder b) updates]) =
      _$GListIdsContainingUserBookReq;

  static void _initializeBuilder(GListIdsContainingUserBookReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'ListIdsContainingUserBook',
    )
    ..executeOnListen = true;

  @override
  _i3.GListIdsContainingUserBookVars get vars;
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
  _i2.GListIdsContainingUserBookData? Function(
    _i2.GListIdsContainingUserBookData?,
    _i2.GListIdsContainingUserBookData?,
  )? get updateResult;
  @override
  _i2.GListIdsContainingUserBookData? get optimisticResponse;
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
  _i2.GListIdsContainingUserBookData? parseData(Map<String, dynamic> json) =>
      _i2.GListIdsContainingUserBookData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GListIdsContainingUserBookData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GListIdsContainingUserBookData,
      _i3.GListIdsContainingUserBookVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GListIdsContainingUserBookReq> get serializer =>
      _$gListIdsContainingUserBookReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GListIdsContainingUserBookReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GListIdsContainingUserBookReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GListIdsContainingUserBookReq.serializer,
        json,
      );
}
