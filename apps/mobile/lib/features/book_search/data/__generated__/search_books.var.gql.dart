// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'search_books.var.gql.g.dart';

abstract class GSearchBooksVars
    implements Built<GSearchBooksVars, GSearchBooksVarsBuilder> {
  GSearchBooksVars._();

  factory GSearchBooksVars([void Function(GSearchBooksVarsBuilder b) updates]) =
      _$GSearchBooksVars;

  String get query;
  int? get limit;
  int? get offset;
  static Serializer<GSearchBooksVars> get serializer =>
      _$gSearchBooksVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchBooksVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchBooksVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchBooksVars.serializer,
        json,
      );
}
