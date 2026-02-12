// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'send_follow_request.var.gql.g.dart';

abstract class GSendFollowRequestVars
    implements Built<GSendFollowRequestVars, GSendFollowRequestVarsBuilder> {
  GSendFollowRequestVars._();

  factory GSendFollowRequestVars(
          [void Function(GSendFollowRequestVarsBuilder b) updates]) =
      _$GSendFollowRequestVars;

  int get receiverId;
  static Serializer<GSendFollowRequestVars> get serializer =>
      _$gSendFollowRequestVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSendFollowRequestVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendFollowRequestVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSendFollowRequestVars.serializer,
        json,
      );
}
