// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'remove_book_from_list.var.gql.g.dart';

abstract class GRemoveBookFromListVars
    implements Built<GRemoveBookFromListVars, GRemoveBookFromListVarsBuilder> {
  GRemoveBookFromListVars._();

  factory GRemoveBookFromListVars(
          [void Function(GRemoveBookFromListVarsBuilder b) updates]) =
      _$GRemoveBookFromListVars;

  int get listId;
  int get userBookId;
  static Serializer<GRemoveBookFromListVars> get serializer =>
      _$gRemoveBookFromListVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRemoveBookFromListVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRemoveBookFromListVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRemoveBookFromListVars.serializer,
        json,
      );
}
