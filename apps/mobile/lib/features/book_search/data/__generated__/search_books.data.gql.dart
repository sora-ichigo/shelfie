// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart'
    as _i2;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'search_books.data.gql.g.dart';

abstract class GSearchBooksData
    implements Built<GSearchBooksData, GSearchBooksDataBuilder> {
  GSearchBooksData._();

  factory GSearchBooksData([void Function(GSearchBooksDataBuilder b) updates]) =
      _$GSearchBooksData;

  static void _initializeBuilder(GSearchBooksDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GSearchBooksData_searchBooks get searchBooks;
  static Serializer<GSearchBooksData> get serializer =>
      _$gSearchBooksDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchBooksData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchBooksData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchBooksData.serializer,
        json,
      );
}

abstract class GSearchBooksData_searchBooks
    implements
        Built<GSearchBooksData_searchBooks,
            GSearchBooksData_searchBooksBuilder> {
  GSearchBooksData_searchBooks._();

  factory GSearchBooksData_searchBooks(
          [void Function(GSearchBooksData_searchBooksBuilder b) updates]) =
      _$GSearchBooksData_searchBooks;

  static void _initializeBuilder(GSearchBooksData_searchBooksBuilder b) =>
      b..G__typename = 'SearchBooksResult';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GSearchBooksData_searchBooks_items> get items;
  int get totalCount;
  bool get hasMore;
  static Serializer<GSearchBooksData_searchBooks> get serializer =>
      _$gSearchBooksDataSearchBooksSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchBooksData_searchBooks.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchBooksData_searchBooks? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchBooksData_searchBooks.serializer,
        json,
      );
}

abstract class GSearchBooksData_searchBooks_items
    implements
        Built<GSearchBooksData_searchBooks_items,
            GSearchBooksData_searchBooks_itemsBuilder> {
  GSearchBooksData_searchBooks_items._();

  factory GSearchBooksData_searchBooks_items(
      [void Function(GSearchBooksData_searchBooks_itemsBuilder b)
          updates]) = _$GSearchBooksData_searchBooks_items;

  static void _initializeBuilder(GSearchBooksData_searchBooks_itemsBuilder b) =>
      b..G__typename = 'Book';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get title;
  BuiltList<String> get authors;
  String? get publisher;
  String? get publishedDate;
  String? get isbn;
  String? get coverImageUrl;
  _i2.GBookSource get source;
  static Serializer<GSearchBooksData_searchBooks_items> get serializer =>
      _$gSearchBooksDataSearchBooksItemsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchBooksData_searchBooks_items.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchBooksData_searchBooks_items? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchBooksData_searchBooks_items.serializer,
        json,
      );
}
