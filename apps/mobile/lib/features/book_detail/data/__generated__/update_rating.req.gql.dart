// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:shelfie/features/book_detail/data/__generated__/update_rating.ast.gql.dart'
    as _i5;
import 'package:shelfie/features/book_detail/data/__generated__/update_rating.data.gql.dart'
    as _i2;
import 'package:shelfie/features/book_detail/data/__generated__/update_rating.var.gql.dart'
    as _i3;

part 'update_rating.req.gql.g.dart';

abstract class GUpdateBookRatingReq
    implements
        Built<GUpdateBookRatingReq, GUpdateBookRatingReqBuilder>,
        _i1.OperationRequest<_i2.GUpdateBookRatingData,
            _i3.GUpdateBookRatingVars> {
  GUpdateBookRatingReq._();

  factory GUpdateBookRatingReq(
          [void Function(GUpdateBookRatingReqBuilder b) updates]) =
      _$GUpdateBookRatingReq;

  static void _initializeBuilder(GUpdateBookRatingReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'UpdateBookRating',
    )
    ..executeOnListen = true;

  @override
  _i3.GUpdateBookRatingVars get vars;
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
  _i2.GUpdateBookRatingData? Function(
    _i2.GUpdateBookRatingData?,
    _i2.GUpdateBookRatingData?,
  )? get updateResult;
  @override
  _i2.GUpdateBookRatingData? get optimisticResponse;
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
  _i2.GUpdateBookRatingData? parseData(Map<String, dynamic> json) =>
      _i2.GUpdateBookRatingData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GUpdateBookRatingData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GUpdateBookRatingData, _i3.GUpdateBookRatingVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GUpdateBookRatingReq> get serializer =>
      _$gUpdateBookRatingReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GUpdateBookRatingReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateBookRatingReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GUpdateBookRatingReq.serializer,
        json,
      );
}
