// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'update_started_at.var.gql.g.dart';

abstract class GUpdateStartedAtVars
    implements Built<GUpdateStartedAtVars, GUpdateStartedAtVarsBuilder> {
  GUpdateStartedAtVars._();

  factory GUpdateStartedAtVars(
          [void Function(GUpdateStartedAtVarsBuilder b) updates]) =
      _$GUpdateStartedAtVars;

  int get userBookId;
  DateTime get startedAt;
  static Serializer<GUpdateStartedAtVars> get serializer =>
      _$gUpdateStartedAtVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateStartedAtVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateStartedAtVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateStartedAtVars.serializer,
        json,
      );
}
