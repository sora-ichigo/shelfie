// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'pending_follow_request_count.var.gql.g.dart';

abstract class GPendingFollowRequestCountVars
    implements
        Built<GPendingFollowRequestCountVars,
            GPendingFollowRequestCountVarsBuilder> {
  GPendingFollowRequestCountVars._();

  factory GPendingFollowRequestCountVars(
          [void Function(GPendingFollowRequestCountVarsBuilder b) updates]) =
      _$GPendingFollowRequestCountVars;

  static Serializer<GPendingFollowRequestCountVars> get serializer =>
      _$gPendingFollowRequestCountVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPendingFollowRequestCountVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPendingFollowRequestCountVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPendingFollowRequestCountVars.serializer,
        json,
      );
}
