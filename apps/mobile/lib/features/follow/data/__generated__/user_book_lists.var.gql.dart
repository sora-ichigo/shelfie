// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart'
    as _i1;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i2;

part 'user_book_lists.var.gql.g.dart';

abstract class GUserBookListsVars
    implements Built<GUserBookListsVars, GUserBookListsVarsBuilder> {
  GUserBookListsVars._();

  factory GUserBookListsVars(
          [void Function(GUserBookListsVarsBuilder b) updates]) =
      _$GUserBookListsVars;

  int get userId;
  _i1.GMyBookListsInput? get input;
  static Serializer<GUserBookListsVars> get serializer =>
      _$gUserBookListsVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GUserBookListsVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUserBookListsVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GUserBookListsVars.serializer,
        json,
      );
}
