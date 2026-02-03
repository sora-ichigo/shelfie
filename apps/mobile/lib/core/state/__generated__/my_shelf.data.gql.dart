// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart'
    as _i2;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'my_shelf.data.gql.g.dart';

abstract class GMyShelfData
    implements Built<GMyShelfData, GMyShelfDataBuilder> {
  GMyShelfData._();

  factory GMyShelfData([void Function(GMyShelfDataBuilder b) updates]) =
      _$GMyShelfData;

  static void _initializeBuilder(GMyShelfDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GMyShelfData_myShelf get myShelf;
  static Serializer<GMyShelfData> get serializer => _$gMyShelfDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMyShelfData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyShelfData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMyShelfData.serializer,
        json,
      );
}

abstract class GMyShelfData_myShelf
    implements Built<GMyShelfData_myShelf, GMyShelfData_myShelfBuilder> {
  GMyShelfData_myShelf._();

  factory GMyShelfData_myShelf(
          [void Function(GMyShelfData_myShelfBuilder b) updates]) =
      _$GMyShelfData_myShelf;

  static void _initializeBuilder(GMyShelfData_myShelfBuilder b) =>
      b..G__typename = 'MyShelfResult';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GMyShelfData_myShelf_items> get items;
  int get totalCount;
  bool get hasMore;
  static Serializer<GMyShelfData_myShelf> get serializer =>
      _$gMyShelfDataMyShelfSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMyShelfData_myShelf.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyShelfData_myShelf? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMyShelfData_myShelf.serializer,
        json,
      );
}

abstract class GMyShelfData_myShelf_items
    implements
        Built<GMyShelfData_myShelf_items, GMyShelfData_myShelf_itemsBuilder> {
  GMyShelfData_myShelf_items._();

  factory GMyShelfData_myShelf_items(
          [void Function(GMyShelfData_myShelf_itemsBuilder b) updates]) =
      _$GMyShelfData_myShelf_items;

  static void _initializeBuilder(GMyShelfData_myShelf_itemsBuilder b) =>
      b..G__typename = 'UserBook';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String get externalId;
  String get title;
  BuiltList<String> get authors;
  _i2.GReadingStatus get readingStatus;
  String? get note;
  DateTime? get noteUpdatedAt;
  DateTime get addedAt;
  DateTime? get startedAt;
  DateTime? get completedAt;
  static Serializer<GMyShelfData_myShelf_items> get serializer =>
      _$gMyShelfDataMyShelfItemsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMyShelfData_myShelf_items.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyShelfData_myShelf_items? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMyShelfData_myShelf_items.serializer,
        json,
      );
}
