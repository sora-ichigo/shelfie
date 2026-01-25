// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'update_rating.var.gql.g.dart';

abstract class GUpdateBookRatingVars
    implements Built<GUpdateBookRatingVars, GUpdateBookRatingVarsBuilder> {
  GUpdateBookRatingVars._();

  factory GUpdateBookRatingVars(
          [void Function(GUpdateBookRatingVarsBuilder b) updates]) =
      _$GUpdateBookRatingVars;

  int get userBookId;
  int get rating;
  static Serializer<GUpdateBookRatingVars> get serializer =>
      _$gUpdateBookRatingVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateBookRatingVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateBookRatingVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateBookRatingVars.serializer,
        json,
      );
}
