// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'approve_follow_request.var.gql.g.dart';

abstract class GApproveFollowRequestVars
    implements
        Built<GApproveFollowRequestVars, GApproveFollowRequestVarsBuilder> {
  GApproveFollowRequestVars._();

  factory GApproveFollowRequestVars(
          [void Function(GApproveFollowRequestVarsBuilder b) updates]) =
      _$GApproveFollowRequestVars;

  int get requestId;
  static Serializer<GApproveFollowRequestVars> get serializer =>
      _$gApproveFollowRequestVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GApproveFollowRequestVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GApproveFollowRequestVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GApproveFollowRequestVars.serializer,
        json,
      );
}
