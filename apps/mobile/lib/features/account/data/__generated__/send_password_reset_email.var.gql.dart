// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart'
    as _i1;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i2;

part 'send_password_reset_email.var.gql.g.dart';

abstract class GSendPasswordResetEmailVars
    implements
        Built<GSendPasswordResetEmailVars, GSendPasswordResetEmailVarsBuilder> {
  GSendPasswordResetEmailVars._();

  factory GSendPasswordResetEmailVars(
          [void Function(GSendPasswordResetEmailVarsBuilder b) updates]) =
      _$GSendPasswordResetEmailVars;

  _i1.GSendPasswordResetEmailInput get input;
  static Serializer<GSendPasswordResetEmailVars> get serializer =>
      _$gSendPasswordResetEmailVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GSendPasswordResetEmailVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendPasswordResetEmailVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GSendPasswordResetEmailVars.serializer,
        json,
      );
}
