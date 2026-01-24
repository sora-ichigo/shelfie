// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart'
    as _i1;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i2;

part 'request_email_change.var.gql.g.dart';

abstract class GRequestEmailChangeVars
    implements Built<GRequestEmailChangeVars, GRequestEmailChangeVarsBuilder> {
  GRequestEmailChangeVars._();

  factory GRequestEmailChangeVars(
          [void Function(GRequestEmailChangeVarsBuilder b) updates]) =
      _$GRequestEmailChangeVars;

  _i1.GRequestEmailChangeInput get input;
  static Serializer<GRequestEmailChangeVars> get serializer =>
      _$gRequestEmailChangeVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GRequestEmailChangeVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRequestEmailChangeVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GRequestEmailChangeVars.serializer,
        json,
      );
}
