// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'user_profile.var.gql.g.dart';

abstract class GUserProfileVars
    implements Built<GUserProfileVars, GUserProfileVarsBuilder> {
  GUserProfileVars._();

  factory GUserProfileVars([void Function(GUserProfileVarsBuilder b) updates]) =
      _$GUserProfileVars;

  String get handle;
  static Serializer<GUserProfileVars> get serializer =>
      _$gUserProfileVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUserProfileVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUserProfileVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUserProfileVars.serializer,
        json,
      );
}
