// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'update_completed_at.var.gql.g.dart';

abstract class GUpdateCompletedAtVars
    implements Built<GUpdateCompletedAtVars, GUpdateCompletedAtVarsBuilder> {
  GUpdateCompletedAtVars._();

  factory GUpdateCompletedAtVars(
          [void Function(GUpdateCompletedAtVarsBuilder b) updates]) =
      _$GUpdateCompletedAtVars;

  int get userBookId;
  DateTime get completedAt;
  static Serializer<GUpdateCompletedAtVars> get serializer =>
      _$gUpdateCompletedAtVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateCompletedAtVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateCompletedAtVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateCompletedAtVars.serializer,
        json,
      );
}
