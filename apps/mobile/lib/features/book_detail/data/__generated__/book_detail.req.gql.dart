// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:shelfie/features/book_detail/data/__generated__/book_detail.ast.gql.dart'
    as _i5;
import 'package:shelfie/features/book_detail/data/__generated__/book_detail.data.gql.dart'
    as _i2;
import 'package:shelfie/features/book_detail/data/__generated__/book_detail.var.gql.dart'
    as _i3;

part 'book_detail.req.gql.g.dart';

abstract class GBookDetailReq
    implements
        Built<GBookDetailReq, GBookDetailReqBuilder>,
        _i1.OperationRequest<_i2.GBookDetailData, _i3.GBookDetailVars> {
  GBookDetailReq._();

  factory GBookDetailReq([void Function(GBookDetailReqBuilder b) updates]) =
      _$GBookDetailReq;

  static void _initializeBuilder(GBookDetailReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'BookDetail',
    )
    ..executeOnListen = true;

  @override
  _i3.GBookDetailVars get vars;
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
  _i2.GBookDetailData? Function(
    _i2.GBookDetailData?,
    _i2.GBookDetailData?,
  )? get updateResult;
  @override
  _i2.GBookDetailData? get optimisticResponse;
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
  _i2.GBookDetailData? parseData(Map<String, dynamic> json) =>
      _i2.GBookDetailData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GBookDetailData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GBookDetailData, _i3.GBookDetailVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GBookDetailReq> get serializer =>
      _$gBookDetailReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GBookDetailReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GBookDetailReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GBookDetailReq.serializer,
        json,
      );
}
