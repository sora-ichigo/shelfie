// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart'
    as _i1;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i2;

part 'update_reading_status.var.gql.g.dart';

abstract class GUpdateReadingStatusVars
    implements
        Built<GUpdateReadingStatusVars, GUpdateReadingStatusVarsBuilder> {
  GUpdateReadingStatusVars._();

  factory GUpdateReadingStatusVars(
          [void Function(GUpdateReadingStatusVarsBuilder b) updates]) =
      _$GUpdateReadingStatusVars;

  int get userBookId;
  _i1.GReadingStatus get status;
  static Serializer<GUpdateReadingStatusVars> get serializer =>
      _$gUpdateReadingStatusVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GUpdateReadingStatusVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateReadingStatusVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GUpdateReadingStatusVars.serializer,
        json,
      );
}
