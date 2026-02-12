// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'follow_counts.var.gql.g.dart';

abstract class GFollowCountsVars
    implements Built<GFollowCountsVars, GFollowCountsVarsBuilder> {
  GFollowCountsVars._();

  factory GFollowCountsVars(
          [void Function(GFollowCountsVarsBuilder b) updates]) =
      _$GFollowCountsVars;

  int get userId;
  static Serializer<GFollowCountsVars> get serializer =>
      _$gFollowCountsVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GFollowCountsVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GFollowCountsVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GFollowCountsVars.serializer,
        json,
      );
}
