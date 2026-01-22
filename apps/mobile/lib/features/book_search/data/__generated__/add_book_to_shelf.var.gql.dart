// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart'
    as _i1;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i2;

part 'add_book_to_shelf.var.gql.g.dart';

abstract class GAddBookToShelfVars
    implements Built<GAddBookToShelfVars, GAddBookToShelfVarsBuilder> {
  GAddBookToShelfVars._();

  factory GAddBookToShelfVars(
          [void Function(GAddBookToShelfVarsBuilder b) updates]) =
      _$GAddBookToShelfVars;

  _i1.GAddBookInput get bookInput;
  static Serializer<GAddBookToShelfVars> get serializer =>
      _$gAddBookToShelfVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GAddBookToShelfVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAddBookToShelfVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GAddBookToShelfVars.serializer,
        json,
      );
}
