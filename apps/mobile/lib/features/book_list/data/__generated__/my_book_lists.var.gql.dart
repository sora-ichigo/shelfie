// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart'
    as _i1;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i2;

part 'my_book_lists.var.gql.g.dart';

abstract class GMyBookListsVars
    implements Built<GMyBookListsVars, GMyBookListsVarsBuilder> {
  GMyBookListsVars._();

  factory GMyBookListsVars([void Function(GMyBookListsVarsBuilder b) updates]) =
      _$GMyBookListsVars;

  _i1.GMyBookListsInput? get input;
  static Serializer<GMyBookListsVars> get serializer =>
      _$gMyBookListsVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GMyBookListsVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyBookListsVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GMyBookListsVars.serializer,
        json,
      );
}
