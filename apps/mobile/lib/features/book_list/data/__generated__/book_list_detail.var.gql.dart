// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'book_list_detail.var.gql.g.dart';

abstract class GBookListDetailVars
    implements Built<GBookListDetailVars, GBookListDetailVarsBuilder> {
  GBookListDetailVars._();

  factory GBookListDetailVars(
          [void Function(GBookListDetailVarsBuilder b) updates]) =
      _$GBookListDetailVars;

  int get listId;
  static Serializer<GBookListDetailVars> get serializer =>
      _$gBookListDetailVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GBookListDetailVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GBookListDetailVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GBookListDetailVars.serializer,
        json,
      );
}
