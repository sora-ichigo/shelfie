// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'unread_notification_count.var.gql.g.dart';

abstract class GUnreadNotificationCountVars
    implements
        Built<GUnreadNotificationCountVars,
            GUnreadNotificationCountVarsBuilder> {
  GUnreadNotificationCountVars._();

  factory GUnreadNotificationCountVars(
          [void Function(GUnreadNotificationCountVarsBuilder b) updates]) =
      _$GUnreadNotificationCountVars;

  static Serializer<GUnreadNotificationCountVars> get serializer =>
      _$gUnreadNotificationCountVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUnreadNotificationCountVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUnreadNotificationCountVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUnreadNotificationCountVars.serializer,
        json,
      );
}
