// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'update_book_list.data.gql.g.dart';

abstract class GUpdateBookListData
    implements Built<GUpdateBookListData, GUpdateBookListDataBuilder> {
  GUpdateBookListData._();

  factory GUpdateBookListData(
          [void Function(GUpdateBookListDataBuilder b) updates]) =
      _$GUpdateBookListData;

  static void _initializeBuilder(GUpdateBookListDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GUpdateBookListData_updateBookList get updateBookList;
  static Serializer<GUpdateBookListData> get serializer =>
      _$gUpdateBookListDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateBookListData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateBookListData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateBookListData.serializer,
        json,
      );
}

abstract class GUpdateBookListData_updateBookList
    implements
        Built<GUpdateBookListData_updateBookList,
            GUpdateBookListData_updateBookListBuilder> {
  GUpdateBookListData_updateBookList._();

  factory GUpdateBookListData_updateBookList(
      [void Function(GUpdateBookListData_updateBookListBuilder b)
          updates]) = _$GUpdateBookListData_updateBookList;

  static void _initializeBuilder(GUpdateBookListData_updateBookListBuilder b) =>
      b..G__typename = 'BookList';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String get title;
  String? get description;
  DateTime get createdAt;
  DateTime get updatedAt;
  static Serializer<GUpdateBookListData_updateBookList> get serializer =>
      _$gUpdateBookListDataUpdateBookListSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateBookListData_updateBookList.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateBookListData_updateBookList? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateBookListData_updateBookList.serializer,
        json,
      );
}
