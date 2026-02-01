// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart'
    as _i1;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i2;

part 'book_detail.var.gql.g.dart';

abstract class GBookDetailVars
    implements Built<GBookDetailVars, GBookDetailVarsBuilder> {
  GBookDetailVars._();

  factory GBookDetailVars([void Function(GBookDetailVarsBuilder b) updates]) =
      _$GBookDetailVars;

  String get bookId;
  _i1.GBookSource get source;
  static Serializer<GBookDetailVars> get serializer =>
      _$gBookDetailVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GBookDetailVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GBookDetailVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GBookDetailVars.serializer,
        json,
      );
}
