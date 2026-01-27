// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart'
    as _i1;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i2;

part 'update_book_list.var.gql.g.dart';

abstract class GUpdateBookListVars
    implements Built<GUpdateBookListVars, GUpdateBookListVarsBuilder> {
  GUpdateBookListVars._();

  factory GUpdateBookListVars(
          [void Function(GUpdateBookListVarsBuilder b) updates]) =
      _$GUpdateBookListVars;

  _i1.GUpdateBookListInput get input;
  static Serializer<GUpdateBookListVars> get serializer =>
      _$gUpdateBookListVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GUpdateBookListVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateBookListVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GUpdateBookListVars.serializer,
        json,
      );
}
