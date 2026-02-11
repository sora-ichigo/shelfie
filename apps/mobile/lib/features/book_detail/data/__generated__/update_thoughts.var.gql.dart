// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'update_thoughts.var.gql.g.dart';

abstract class GUpdateThoughtsVars
    implements Built<GUpdateThoughtsVars, GUpdateThoughtsVarsBuilder> {
  GUpdateThoughtsVars._();

  factory GUpdateThoughtsVars(
          [void Function(GUpdateThoughtsVarsBuilder b) updates]) =
      _$GUpdateThoughtsVars;

  int get userBookId;
  String get thoughts;
  static Serializer<GUpdateThoughtsVars> get serializer =>
      _$gUpdateThoughtsVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateThoughtsVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateThoughtsVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateThoughtsVars.serializer,
        json,
      );
}
