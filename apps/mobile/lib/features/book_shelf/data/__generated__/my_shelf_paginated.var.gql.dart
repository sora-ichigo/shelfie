// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart'
    as _i1;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i2;

part 'my_shelf_paginated.var.gql.g.dart';

abstract class GMyShelfPaginatedVars
    implements Built<GMyShelfPaginatedVars, GMyShelfPaginatedVarsBuilder> {
  GMyShelfPaginatedVars._();

  factory GMyShelfPaginatedVars(
          [void Function(GMyShelfPaginatedVarsBuilder b) updates]) =
      _$GMyShelfPaginatedVars;

  _i1.GMyShelfInput? get input;
  static Serializer<GMyShelfPaginatedVars> get serializer =>
      _$gMyShelfPaginatedVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GMyShelfPaginatedVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyShelfPaginatedVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GMyShelfPaginatedVars.serializer,
        json,
      );
}
