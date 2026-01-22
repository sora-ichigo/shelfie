// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'search_book_by_isbn.data.gql.g.dart';

abstract class GSearchBookByISBNData
    implements Built<GSearchBookByISBNData, GSearchBookByISBNDataBuilder> {
  GSearchBookByISBNData._();

  factory GSearchBookByISBNData(
          [void Function(GSearchBookByISBNDataBuilder b) updates]) =
      _$GSearchBookByISBNData;

  static void _initializeBuilder(GSearchBookByISBNDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GSearchBookByISBNData_searchBookByISBN? get searchBookByISBN;
  static Serializer<GSearchBookByISBNData> get serializer =>
      _$gSearchBookByISBNDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchBookByISBNData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchBookByISBNData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchBookByISBNData.serializer,
        json,
      );
}

abstract class GSearchBookByISBNData_searchBookByISBN
    implements
        Built<GSearchBookByISBNData_searchBookByISBN,
            GSearchBookByISBNData_searchBookByISBNBuilder> {
  GSearchBookByISBNData_searchBookByISBN._();

  factory GSearchBookByISBNData_searchBookByISBN(
      [void Function(GSearchBookByISBNData_searchBookByISBNBuilder b)
          updates]) = _$GSearchBookByISBNData_searchBookByISBN;

  static void _initializeBuilder(
          GSearchBookByISBNData_searchBookByISBNBuilder b) =>
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
  static Serializer<GSearchBookByISBNData_searchBookByISBN> get serializer =>
      _$gSearchBookByISBNDataSearchBookByISBNSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchBookByISBNData_searchBookByISBN.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchBookByISBNData_searchBookByISBN? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchBookByISBNData_searchBookByISBN.serializer,
        json,
      );
}
