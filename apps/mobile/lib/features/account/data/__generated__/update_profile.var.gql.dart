// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart'
    as _i1;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i2;

part 'update_profile.var.gql.g.dart';

abstract class GUpdateProfileVars
    implements Built<GUpdateProfileVars, GUpdateProfileVarsBuilder> {
  GUpdateProfileVars._();

  factory GUpdateProfileVars(
          [void Function(GUpdateProfileVarsBuilder b) updates]) =
      _$GUpdateProfileVars;

  _i1.GUpdateProfileInput get input;
  static Serializer<GUpdateProfileVars> get serializer =>
      _$gUpdateProfileVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GUpdateProfileVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateProfileVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GUpdateProfileVars.serializer,
        json,
      );
}
