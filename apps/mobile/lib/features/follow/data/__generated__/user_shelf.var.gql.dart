// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart'
    as _i1;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i2;

part 'user_shelf.var.gql.g.dart';

abstract class GUserShelfVars
    implements Built<GUserShelfVars, GUserShelfVarsBuilder> {
  GUserShelfVars._();

  factory GUserShelfVars([void Function(GUserShelfVarsBuilder b) updates]) =
      _$GUserShelfVars;

  int get userId;
  _i1.GMyShelfInput? get input;
  static Serializer<GUserShelfVars> get serializer =>
      _$gUserShelfVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GUserShelfVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUserShelfVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GUserShelfVars.serializer,
        json,
      );
}
