// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'following.var.gql.g.dart';

abstract class GFollowingVars
    implements Built<GFollowingVars, GFollowingVarsBuilder> {
  GFollowingVars._();

  factory GFollowingVars([void Function(GFollowingVarsBuilder b) updates]) =
      _$GFollowingVars;

  int get userId;
  int? get cursor;
  int? get limit;
  static Serializer<GFollowingVars> get serializer =>
      _$gFollowingVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GFollowingVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GFollowingVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GFollowingVars.serializer,
        json,
      );
}
