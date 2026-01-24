// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'remove_from_shelf.var.gql.g.dart';

abstract class GRemoveFromShelfVars
    implements Built<GRemoveFromShelfVars, GRemoveFromShelfVarsBuilder> {
  GRemoveFromShelfVars._();

  factory GRemoveFromShelfVars(
          [void Function(GRemoveFromShelfVarsBuilder b) updates]) =
      _$GRemoveFromShelfVars;

  int get userBookId;
  static Serializer<GRemoveFromShelfVars> get serializer =>
      _$gRemoveFromShelfVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRemoveFromShelfVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRemoveFromShelfVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRemoveFromShelfVars.serializer,
        json,
      );
}
