// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'delete_book_list.var.gql.g.dart';

abstract class GDeleteBookListVars
    implements Built<GDeleteBookListVars, GDeleteBookListVarsBuilder> {
  GDeleteBookListVars._();

  factory GDeleteBookListVars(
          [void Function(GDeleteBookListVarsBuilder b) updates]) =
      _$GDeleteBookListVars;

  int get listId;
  static Serializer<GDeleteBookListVars> get serializer =>
      _$gDeleteBookListVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GDeleteBookListVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GDeleteBookListVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GDeleteBookListVars.serializer,
        json,
      );
}
