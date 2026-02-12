// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'unfollow.var.gql.g.dart';

abstract class GUnfollowVars
    implements Built<GUnfollowVars, GUnfollowVarsBuilder> {
  GUnfollowVars._();

  factory GUnfollowVars([void Function(GUnfollowVarsBuilder b) updates]) =
      _$GUnfollowVars;

  int get targetUserId;
  static Serializer<GUnfollowVars> get serializer => _$gUnfollowVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUnfollowVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUnfollowVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUnfollowVars.serializer,
        json,
      );
}
