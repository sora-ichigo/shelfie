// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'pending_follow_requests.var.gql.g.dart';

abstract class GPendingFollowRequestsVars
    implements
        Built<GPendingFollowRequestsVars, GPendingFollowRequestsVarsBuilder> {
  GPendingFollowRequestsVars._();

  factory GPendingFollowRequestsVars(
          [void Function(GPendingFollowRequestsVarsBuilder b) updates]) =
      _$GPendingFollowRequestsVars;

  int? get cursor;
  int? get limit;
  static Serializer<GPendingFollowRequestsVars> get serializer =>
      _$gPendingFollowRequestsVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPendingFollowRequestsVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPendingFollowRequestsVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPendingFollowRequestsVars.serializer,
        json,
      );
}
