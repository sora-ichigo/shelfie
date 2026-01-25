// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'get_upload_credentials.var.gql.g.dart';

abstract class GGetUploadCredentialsVars
    implements
        Built<GGetUploadCredentialsVars, GGetUploadCredentialsVarsBuilder> {
  GGetUploadCredentialsVars._();

  factory GGetUploadCredentialsVars(
          [void Function(GGetUploadCredentialsVarsBuilder b) updates]) =
      _$GGetUploadCredentialsVars;

  static Serializer<GGetUploadCredentialsVars> get serializer =>
      _$gGetUploadCredentialsVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetUploadCredentialsVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetUploadCredentialsVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetUploadCredentialsVars.serializer,
        json,
      );
}
