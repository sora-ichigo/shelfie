// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'followers.var.gql.g.dart';

abstract class GFollowersVars
    implements Built<GFollowersVars, GFollowersVarsBuilder> {
  GFollowersVars._();

  factory GFollowersVars([void Function(GFollowersVarsBuilder b) updates]) =
      _$GFollowersVars;

  int get userId;
  int? get cursor;
  int? get limit;
  static Serializer<GFollowersVars> get serializer =>
      _$gFollowersVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GFollowersVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GFollowersVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GFollowersVars.serializer,
        json,
      );
}
