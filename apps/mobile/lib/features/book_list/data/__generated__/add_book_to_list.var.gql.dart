// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'add_book_to_list.var.gql.g.dart';

abstract class GAddBookToListVars
    implements Built<GAddBookToListVars, GAddBookToListVarsBuilder> {
  GAddBookToListVars._();

  factory GAddBookToListVars(
          [void Function(GAddBookToListVarsBuilder b) updates]) =
      _$GAddBookToListVars;

  int get listId;
  int get userBookId;
  static Serializer<GAddBookToListVars> get serializer =>
      _$gAddBookToListVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAddBookToListVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAddBookToListVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAddBookToListVars.serializer,
        json,
      );
}
