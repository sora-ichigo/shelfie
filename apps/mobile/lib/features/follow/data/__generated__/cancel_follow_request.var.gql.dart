// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'cancel_follow_request.var.gql.g.dart';

abstract class GCancelFollowRequestVars
    implements
        Built<GCancelFollowRequestVars, GCancelFollowRequestVarsBuilder> {
  GCancelFollowRequestVars._();

  factory GCancelFollowRequestVars(
          [void Function(GCancelFollowRequestVarsBuilder b) updates]) =
      _$GCancelFollowRequestVars;

  int get targetUserId;
  static Serializer<GCancelFollowRequestVars> get serializer =>
      _$gCancelFollowRequestVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCancelFollowRequestVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCancelFollowRequestVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCancelFollowRequestVars.serializer,
        json,
      );
}
