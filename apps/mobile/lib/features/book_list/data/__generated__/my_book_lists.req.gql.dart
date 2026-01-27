// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:shelfie/features/book_list/data/__generated__/my_book_lists.ast.gql.dart'
    as _i5;
import 'package:shelfie/features/book_list/data/__generated__/my_book_lists.data.gql.dart'
    as _i2;
import 'package:shelfie/features/book_list/data/__generated__/my_book_lists.var.gql.dart'
    as _i3;

part 'my_book_lists.req.gql.g.dart';

abstract class GMyBookListsReq
    implements
        Built<GMyBookListsReq, GMyBookListsReqBuilder>,
        _i1.OperationRequest<_i2.GMyBookListsData, _i3.GMyBookListsVars> {
  GMyBookListsReq._();

  factory GMyBookListsReq([void Function(GMyBookListsReqBuilder b) updates]) =
      _$GMyBookListsReq;

  static void _initializeBuilder(GMyBookListsReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'MyBookLists',
    )
    ..executeOnListen = true;

  @override
  _i3.GMyBookListsVars get vars;
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
  _i2.GMyBookListsData? Function(
    _i2.GMyBookListsData?,
    _i2.GMyBookListsData?,
  )? get updateResult;
  @override
  _i2.GMyBookListsData? get optimisticResponse;
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
  _i2.GMyBookListsData? parseData(Map<String, dynamic> json) =>
      _i2.GMyBookListsData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GMyBookListsData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GMyBookListsData, _i3.GMyBookListsVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GMyBookListsReq> get serializer =>
      _$gMyBookListsReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GMyBookListsReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyBookListsReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GMyBookListsReq.serializer,
        json,
      );
}
