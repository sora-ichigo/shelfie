// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'list_ids_containing_user_book.data.gql.g.dart';

abstract class GListIdsContainingUserBookData
    implements
        Built<GListIdsContainingUserBookData,
            GListIdsContainingUserBookDataBuilder> {
  GListIdsContainingUserBookData._();

  factory GListIdsContainingUserBookData(
          [void Function(GListIdsContainingUserBookDataBuilder b) updates]) =
      _$GListIdsContainingUserBookData;

  static void _initializeBuilder(GListIdsContainingUserBookDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GListIdsContainingUserBookData_listIdsContainingUserBook
      get listIdsContainingUserBook;
  static Serializer<GListIdsContainingUserBookData> get serializer =>
      _$gListIdsContainingUserBookDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GListIdsContainingUserBookData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GListIdsContainingUserBookData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GListIdsContainingUserBookData.serializer,
        json,
      );
}

abstract class GListIdsContainingUserBookData_listIdsContainingUserBook
    implements
        Built<GListIdsContainingUserBookData_listIdsContainingUserBook,
            GListIdsContainingUserBookData_listIdsContainingUserBookBuilder> {
  GListIdsContainingUserBookData_listIdsContainingUserBook._();

  factory GListIdsContainingUserBookData_listIdsContainingUserBook(
      [void Function(
              GListIdsContainingUserBookData_listIdsContainingUserBookBuilder b)
          updates]) = _$GListIdsContainingUserBookData_listIdsContainingUserBook;

  static void _initializeBuilder(
          GListIdsContainingUserBookData_listIdsContainingUserBookBuilder b) =>
      b..G__typename = 'ListIdsContainingUserBookResult';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<int> get listIds;
  static Serializer<GListIdsContainingUserBookData_listIdsContainingUserBook>
      get serializer =>
          _$gListIdsContainingUserBookDataListIdsContainingUserBookSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GListIdsContainingUserBookData_listIdsContainingUserBook.serializer,
        this,
      ) as Map<String, dynamic>);

  static GListIdsContainingUserBookData_listIdsContainingUserBook? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GListIdsContainingUserBookData_listIdsContainingUserBook.serializer,
        json,
      );
}
