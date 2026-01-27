// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'my_book_lists.data.gql.g.dart';

abstract class GMyBookListsData
    implements Built<GMyBookListsData, GMyBookListsDataBuilder> {
  GMyBookListsData._();

  factory GMyBookListsData([void Function(GMyBookListsDataBuilder b) updates]) =
      _$GMyBookListsData;

  static void _initializeBuilder(GMyBookListsDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GMyBookListsData_myBookLists get myBookLists;
  static Serializer<GMyBookListsData> get serializer =>
      _$gMyBookListsDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMyBookListsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyBookListsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMyBookListsData.serializer,
        json,
      );
}

abstract class GMyBookListsData_myBookLists
    implements
        Built<GMyBookListsData_myBookLists,
            GMyBookListsData_myBookListsBuilder> {
  GMyBookListsData_myBookLists._();

  factory GMyBookListsData_myBookLists(
          [void Function(GMyBookListsData_myBookListsBuilder b) updates]) =
      _$GMyBookListsData_myBookLists;

  static void _initializeBuilder(GMyBookListsData_myBookListsBuilder b) =>
      b..G__typename = 'MyBookListsResult';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GMyBookListsData_myBookLists_items> get items;
  int get totalCount;
  bool get hasMore;
  static Serializer<GMyBookListsData_myBookLists> get serializer =>
      _$gMyBookListsDataMyBookListsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMyBookListsData_myBookLists.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyBookListsData_myBookLists? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMyBookListsData_myBookLists.serializer,
        json,
      );
}

abstract class GMyBookListsData_myBookLists_items
    implements
        Built<GMyBookListsData_myBookLists_items,
            GMyBookListsData_myBookLists_itemsBuilder> {
  GMyBookListsData_myBookLists_items._();

  factory GMyBookListsData_myBookLists_items(
      [void Function(GMyBookListsData_myBookLists_itemsBuilder b)
          updates]) = _$GMyBookListsData_myBookLists_items;

  static void _initializeBuilder(GMyBookListsData_myBookLists_itemsBuilder b) =>
      b..G__typename = 'BookListSummary';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String get title;
  String? get description;
  int get bookCount;
  BuiltList<String> get coverImages;
  DateTime get createdAt;
  DateTime get updatedAt;
  static Serializer<GMyBookListsData_myBookLists_items> get serializer =>
      _$gMyBookListsDataMyBookListsItemsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMyBookListsData_myBookLists_items.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyBookListsData_myBookLists_items? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMyBookListsData_myBookLists_items.serializer,
        json,
      );
}
