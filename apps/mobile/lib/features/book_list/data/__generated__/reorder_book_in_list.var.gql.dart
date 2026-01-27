// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'reorder_book_in_list.var.gql.g.dart';

abstract class GReorderBookInListVars
    implements Built<GReorderBookInListVars, GReorderBookInListVarsBuilder> {
  GReorderBookInListVars._();

  factory GReorderBookInListVars(
          [void Function(GReorderBookInListVarsBuilder b) updates]) =
      _$GReorderBookInListVars;

  int get listId;
  int get itemId;
  int get newPosition;
  static Serializer<GReorderBookInListVars> get serializer =>
      _$gReorderBookInListVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GReorderBookInListVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GReorderBookInListVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GReorderBookInListVars.serializer,
        json,
      );
}
