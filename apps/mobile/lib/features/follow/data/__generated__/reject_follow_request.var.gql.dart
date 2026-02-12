// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'reject_follow_request.var.gql.g.dart';

abstract class GRejectFollowRequestVars
    implements
        Built<GRejectFollowRequestVars, GRejectFollowRequestVarsBuilder> {
  GRejectFollowRequestVars._();

  factory GRejectFollowRequestVars(
          [void Function(GRejectFollowRequestVarsBuilder b) updates]) =
      _$GRejectFollowRequestVars;

  int get requestId;
  static Serializer<GRejectFollowRequestVars> get serializer =>
      _$gRejectFollowRequestVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRejectFollowRequestVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRejectFollowRequestVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRejectFollowRequestVars.serializer,
        json,
      );
}
