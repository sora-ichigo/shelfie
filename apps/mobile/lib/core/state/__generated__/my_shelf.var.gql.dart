// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'my_shelf.var.gql.g.dart';

abstract class GMyShelfVars
    implements Built<GMyShelfVars, GMyShelfVarsBuilder> {
  GMyShelfVars._();

  factory GMyShelfVars([void Function(GMyShelfVarsBuilder b) updates]) =
      _$GMyShelfVars;

  static Serializer<GMyShelfVars> get serializer => _$gMyShelfVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMyShelfVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyShelfVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMyShelfVars.serializer,
        json,
      );
}
