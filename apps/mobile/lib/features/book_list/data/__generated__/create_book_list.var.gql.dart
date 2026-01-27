// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart'
    as _i1;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i2;

part 'create_book_list.var.gql.g.dart';

abstract class GCreateBookListVars
    implements Built<GCreateBookListVars, GCreateBookListVarsBuilder> {
  GCreateBookListVars._();

  factory GCreateBookListVars(
          [void Function(GCreateBookListVarsBuilder b) updates]) =
      _$GCreateBookListVars;

  _i1.GCreateBookListInput get input;
  static Serializer<GCreateBookListVars> get serializer =>
      _$gCreateBookListVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GCreateBookListVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateBookListVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GCreateBookListVars.serializer,
        json,
      );
}
