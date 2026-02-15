// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:shelfie/features/notification/data/__generated__/mark_notification_as_read.ast.gql.dart'
    as _i5;
import 'package:shelfie/features/notification/data/__generated__/mark_notification_as_read.data.gql.dart'
    as _i2;
import 'package:shelfie/features/notification/data/__generated__/mark_notification_as_read.var.gql.dart'
    as _i3;

part 'mark_notification_as_read.req.gql.g.dart';

abstract class GMarkNotificationAsReadReq
    implements
        Built<GMarkNotificationAsReadReq, GMarkNotificationAsReadReqBuilder>,
        _i1.OperationRequest<_i2.GMarkNotificationAsReadData,
            _i3.GMarkNotificationAsReadVars> {
  GMarkNotificationAsReadReq._();

  factory GMarkNotificationAsReadReq(
          [void Function(GMarkNotificationAsReadReqBuilder b) updates]) =
      _$GMarkNotificationAsReadReq;

  static void _initializeBuilder(GMarkNotificationAsReadReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'MarkNotificationAsRead',
    )
    ..executeOnListen = true;

  @override
  _i3.GMarkNotificationAsReadVars get vars;
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
  _i2.GMarkNotificationAsReadData? Function(
    _i2.GMarkNotificationAsReadData?,
    _i2.GMarkNotificationAsReadData?,
  )? get updateResult;
  @override
  _i2.GMarkNotificationAsReadData? get optimisticResponse;
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
  _i2.GMarkNotificationAsReadData? parseData(Map<String, dynamic> json) =>
      _i2.GMarkNotificationAsReadData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GMarkNotificationAsReadData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GMarkNotificationAsReadData,
      _i3.GMarkNotificationAsReadVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GMarkNotificationAsReadReq> get serializer =>
      _$gMarkNotificationAsReadReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GMarkNotificationAsReadReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMarkNotificationAsReadReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GMarkNotificationAsReadReq.serializer,
        json,
      );
}
