// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:shelfie/features/notification/data/__generated__/mark_notifications_as_read.ast.gql.dart'
    as _i5;
import 'package:shelfie/features/notification/data/__generated__/mark_notifications_as_read.data.gql.dart'
    as _i2;
import 'package:shelfie/features/notification/data/__generated__/mark_notifications_as_read.var.gql.dart'
    as _i3;

part 'mark_notifications_as_read.req.gql.g.dart';

abstract class GMarkNotificationsAsReadReq
    implements
        Built<GMarkNotificationsAsReadReq, GMarkNotificationsAsReadReqBuilder>,
        _i1.OperationRequest<_i2.GMarkNotificationsAsReadData,
            _i3.GMarkNotificationsAsReadVars> {
  GMarkNotificationsAsReadReq._();

  factory GMarkNotificationsAsReadReq(
          [void Function(GMarkNotificationsAsReadReqBuilder b) updates]) =
      _$GMarkNotificationsAsReadReq;

  static void _initializeBuilder(GMarkNotificationsAsReadReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'MarkNotificationsAsRead',
    )
    ..executeOnListen = true;

  @override
  _i3.GMarkNotificationsAsReadVars get vars;
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
  _i2.GMarkNotificationsAsReadData? Function(
    _i2.GMarkNotificationsAsReadData?,
    _i2.GMarkNotificationsAsReadData?,
  )? get updateResult;
  @override
  _i2.GMarkNotificationsAsReadData? get optimisticResponse;
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
  _i2.GMarkNotificationsAsReadData? parseData(Map<String, dynamic> json) =>
      _i2.GMarkNotificationsAsReadData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GMarkNotificationsAsReadData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GMarkNotificationsAsReadData,
      _i3.GMarkNotificationsAsReadVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GMarkNotificationsAsReadReq> get serializer =>
      _$gMarkNotificationsAsReadReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GMarkNotificationsAsReadReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMarkNotificationsAsReadReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GMarkNotificationsAsReadReq.serializer,
        json,
      );
}
