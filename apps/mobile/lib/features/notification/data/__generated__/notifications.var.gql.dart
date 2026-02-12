// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'notifications.var.gql.g.dart';

abstract class GNotificationsVars
    implements Built<GNotificationsVars, GNotificationsVarsBuilder> {
  GNotificationsVars._();

  factory GNotificationsVars(
          [void Function(GNotificationsVarsBuilder b) updates]) =
      _$GNotificationsVars;

  int? get cursor;
  int? get limit;
  static Serializer<GNotificationsVars> get serializer =>
      _$gNotificationsVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GNotificationsVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationsVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GNotificationsVars.serializer,
        json,
      );
}
