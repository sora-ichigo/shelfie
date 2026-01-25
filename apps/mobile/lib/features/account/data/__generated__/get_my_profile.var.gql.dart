// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'get_my_profile.var.gql.g.dart';

abstract class GGetMyProfileVars
    implements Built<GGetMyProfileVars, GGetMyProfileVarsBuilder> {
  GGetMyProfileVars._();

  factory GGetMyProfileVars(
          [void Function(GGetMyProfileVarsBuilder b) updates]) =
      _$GGetMyProfileVars;

  static Serializer<GGetMyProfileVars> get serializer =>
      _$gGetMyProfileVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetMyProfileVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMyProfileVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetMyProfileVars.serializer,
        json,
      );
}
