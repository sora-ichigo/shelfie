// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'mark_notification_as_read.var.gql.g.dart';

abstract class GMarkNotificationAsReadVars
    implements
        Built<GMarkNotificationAsReadVars, GMarkNotificationAsReadVarsBuilder> {
  GMarkNotificationAsReadVars._();

  factory GMarkNotificationAsReadVars(
          [void Function(GMarkNotificationAsReadVarsBuilder b) updates]) =
      _$GMarkNotificationAsReadVars;

  int get notificationId;
  static Serializer<GMarkNotificationAsReadVars> get serializer =>
      _$gMarkNotificationAsReadVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMarkNotificationAsReadVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMarkNotificationAsReadVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMarkNotificationAsReadVars.serializer,
        json,
      );
}
