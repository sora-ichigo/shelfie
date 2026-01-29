// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'add_book_to_list.data.gql.g.dart';

abstract class GAddBookToListData
    implements Built<GAddBookToListData, GAddBookToListDataBuilder> {
  GAddBookToListData._();

  factory GAddBookToListData(
          [void Function(GAddBookToListDataBuilder b) updates]) =
      _$GAddBookToListData;

  static void _initializeBuilder(GAddBookToListDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GAddBookToListData_addBookToList get addBookToList;
  static Serializer<GAddBookToListData> get serializer =>
      _$gAddBookToListDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAddBookToListData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAddBookToListData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAddBookToListData.serializer,
        json,
      );
}

abstract class GAddBookToListData_addBookToList
    implements
        Built<GAddBookToListData_addBookToList,
            GAddBookToListData_addBookToListBuilder> {
  GAddBookToListData_addBookToList._();

  factory GAddBookToListData_addBookToList(
          [void Function(GAddBookToListData_addBookToListBuilder b) updates]) =
      _$GAddBookToListData_addBookToList;

  static void _initializeBuilder(GAddBookToListData_addBookToListBuilder b) =>
      b..G__typename = 'BookListDetailItem';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  int get position;
  DateTime get addedAt;
  GAddBookToListData_addBookToList_userBook? get userBook;
  static Serializer<GAddBookToListData_addBookToList> get serializer =>
      _$gAddBookToListDataAddBookToListSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAddBookToListData_addBookToList.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAddBookToListData_addBookToList? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAddBookToListData_addBookToList.serializer,
        json,
      );
}

abstract class GAddBookToListData_addBookToList_userBook
    implements
        Built<GAddBookToListData_addBookToList_userBook,
            GAddBookToListData_addBookToList_userBookBuilder> {
  GAddBookToListData_addBookToList_userBook._();

  factory GAddBookToListData_addBookToList_userBook(
      [void Function(GAddBookToListData_addBookToList_userBookBuilder b)
          updates]) = _$GAddBookToListData_addBookToList_userBook;

  static void _initializeBuilder(
          GAddBookToListData_addBookToList_userBookBuilder b) =>
      b..G__typename = 'BookListDetailUserBook';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String get externalId;
  String get title;
  BuiltList<String> get authors;
  String? get coverImageUrl;
  String get readingStatus;
  String get source;
  static Serializer<GAddBookToListData_addBookToList_userBook> get serializer =>
      _$gAddBookToListDataAddBookToListUserBookSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAddBookToListData_addBookToList_userBook.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAddBookToListData_addBookToList_userBook? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAddBookToListData_addBookToList_userBook.serializer,
        json,
      );
}
