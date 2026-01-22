// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'search_book_by_isbn.var.gql.g.dart';

abstract class GSearchBookByISBNVars
    implements Built<GSearchBookByISBNVars, GSearchBookByISBNVarsBuilder> {
  GSearchBookByISBNVars._();

  factory GSearchBookByISBNVars(
          [void Function(GSearchBookByISBNVarsBuilder b) updates]) =
      _$GSearchBookByISBNVars;

  String get isbn;
  static Serializer<GSearchBookByISBNVars> get serializer =>
      _$gSearchBookByISBNVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchBookByISBNVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchBookByISBNVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchBookByISBNVars.serializer,
        json,
      );
}
