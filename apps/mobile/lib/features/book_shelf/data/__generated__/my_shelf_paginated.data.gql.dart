// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart'
    as _i2;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'my_shelf_paginated.data.gql.g.dart';

abstract class GMyShelfPaginatedData
    implements Built<GMyShelfPaginatedData, GMyShelfPaginatedDataBuilder> {
  GMyShelfPaginatedData._();

  factory GMyShelfPaginatedData(
          [void Function(GMyShelfPaginatedDataBuilder b) updates]) =
      _$GMyShelfPaginatedData;

  static void _initializeBuilder(GMyShelfPaginatedDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GMyShelfPaginatedData_myShelf get myShelf;
  static Serializer<GMyShelfPaginatedData> get serializer =>
      _$gMyShelfPaginatedDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMyShelfPaginatedData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyShelfPaginatedData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMyShelfPaginatedData.serializer,
        json,
      );
}

abstract class GMyShelfPaginatedData_myShelf
    implements
        Built<GMyShelfPaginatedData_myShelf,
            GMyShelfPaginatedData_myShelfBuilder> {
  GMyShelfPaginatedData_myShelf._();

  factory GMyShelfPaginatedData_myShelf(
          [void Function(GMyShelfPaginatedData_myShelfBuilder b) updates]) =
      _$GMyShelfPaginatedData_myShelf;

  static void _initializeBuilder(GMyShelfPaginatedData_myShelfBuilder b) =>
      b..G__typename = 'MyShelfResult';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GMyShelfPaginatedData_myShelf_items> get items;
  int get totalCount;
  bool get hasMore;
  static Serializer<GMyShelfPaginatedData_myShelf> get serializer =>
      _$gMyShelfPaginatedDataMyShelfSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMyShelfPaginatedData_myShelf.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyShelfPaginatedData_myShelf? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMyShelfPaginatedData_myShelf.serializer,
        json,
      );
}

abstract class GMyShelfPaginatedData_myShelf_items
    implements
        Built<GMyShelfPaginatedData_myShelf_items,
            GMyShelfPaginatedData_myShelf_itemsBuilder> {
  GMyShelfPaginatedData_myShelf_items._();

  factory GMyShelfPaginatedData_myShelf_items(
      [void Function(GMyShelfPaginatedData_myShelf_itemsBuilder b)
          updates]) = _$GMyShelfPaginatedData_myShelf_items;

  static void _initializeBuilder(
          GMyShelfPaginatedData_myShelf_itemsBuilder b) =>
      b..G__typename = 'UserBook';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String get externalId;
  String get title;
  BuiltList<String> get authors;
  String? get coverImageUrl;
  _i2.GReadingStatus get readingStatus;
  DateTime get addedAt;
  DateTime? get completedAt;
  int? get rating;
  static Serializer<GMyShelfPaginatedData_myShelf_items> get serializer =>
      _$gMyShelfPaginatedDataMyShelfItemsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMyShelfPaginatedData_myShelf_items.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyShelfPaginatedData_myShelf_items? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMyShelfPaginatedData_myShelf_items.serializer,
        json,
      );
}
