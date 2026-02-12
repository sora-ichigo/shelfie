// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'user_book_lists.data.gql.g.dart';

abstract class GUserBookListsData
    implements Built<GUserBookListsData, GUserBookListsDataBuilder> {
  GUserBookListsData._();

  factory GUserBookListsData(
          [void Function(GUserBookListsDataBuilder b) updates]) =
      _$GUserBookListsData;

  static void _initializeBuilder(GUserBookListsDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GUserBookListsData_userBookLists get userBookLists;
  static Serializer<GUserBookListsData> get serializer =>
      _$gUserBookListsDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUserBookListsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUserBookListsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUserBookListsData.serializer,
        json,
      );
}

abstract class GUserBookListsData_userBookLists
    implements
        Built<GUserBookListsData_userBookLists,
            GUserBookListsData_userBookListsBuilder> {
  GUserBookListsData_userBookLists._();

  factory GUserBookListsData_userBookLists(
          [void Function(GUserBookListsData_userBookListsBuilder b) updates]) =
      _$GUserBookListsData_userBookLists;

  static void _initializeBuilder(GUserBookListsData_userBookListsBuilder b) =>
      b..G__typename = 'MyBookListsResult';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GUserBookListsData_userBookLists_items> get items;
  int get totalCount;
  bool get hasMore;
  static Serializer<GUserBookListsData_userBookLists> get serializer =>
      _$gUserBookListsDataUserBookListsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUserBookListsData_userBookLists.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUserBookListsData_userBookLists? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUserBookListsData_userBookLists.serializer,
        json,
      );
}

abstract class GUserBookListsData_userBookLists_items
    implements
        Built<GUserBookListsData_userBookLists_items,
            GUserBookListsData_userBookLists_itemsBuilder> {
  GUserBookListsData_userBookLists_items._();

  factory GUserBookListsData_userBookLists_items(
      [void Function(GUserBookListsData_userBookLists_itemsBuilder b)
          updates]) = _$GUserBookListsData_userBookLists_items;

  static void _initializeBuilder(
          GUserBookListsData_userBookLists_itemsBuilder b) =>
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
  static Serializer<GUserBookListsData_userBookLists_items> get serializer =>
      _$gUserBookListsDataUserBookListsItemsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUserBookListsData_userBookLists_items.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUserBookListsData_userBookLists_items? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUserBookListsData_userBookLists_items.serializer,
        json,
      );
}
