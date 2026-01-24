// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'remove_from_shelf.data.gql.g.dart';

abstract class GRemoveFromShelfData
    implements Built<GRemoveFromShelfData, GRemoveFromShelfDataBuilder> {
  GRemoveFromShelfData._();

  factory GRemoveFromShelfData(
          [void Function(GRemoveFromShelfDataBuilder b) updates]) =
      _$GRemoveFromShelfData;

  static void _initializeBuilder(GRemoveFromShelfDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  bool get removeFromShelf;
  static Serializer<GRemoveFromShelfData> get serializer =>
      _$gRemoveFromShelfDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRemoveFromShelfData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRemoveFromShelfData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRemoveFromShelfData.serializer,
        json,
      );
}
