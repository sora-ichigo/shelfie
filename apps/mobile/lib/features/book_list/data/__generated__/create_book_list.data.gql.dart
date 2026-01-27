// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'create_book_list.data.gql.g.dart';

abstract class GCreateBookListData
    implements Built<GCreateBookListData, GCreateBookListDataBuilder> {
  GCreateBookListData._();

  factory GCreateBookListData(
          [void Function(GCreateBookListDataBuilder b) updates]) =
      _$GCreateBookListData;

  static void _initializeBuilder(GCreateBookListDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GCreateBookListData_createBookList get createBookList;
  static Serializer<GCreateBookListData> get serializer =>
      _$gCreateBookListDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateBookListData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateBookListData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateBookListData.serializer,
        json,
      );
}

abstract class GCreateBookListData_createBookList
    implements
        Built<GCreateBookListData_createBookList,
            GCreateBookListData_createBookListBuilder> {
  GCreateBookListData_createBookList._();

  factory GCreateBookListData_createBookList(
      [void Function(GCreateBookListData_createBookListBuilder b)
          updates]) = _$GCreateBookListData_createBookList;

  static void _initializeBuilder(GCreateBookListData_createBookListBuilder b) =>
      b..G__typename = 'BookList';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String get title;
  String? get description;
  DateTime get createdAt;
  DateTime get updatedAt;
  static Serializer<GCreateBookListData_createBookList> get serializer =>
      _$gCreateBookListDataCreateBookListSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateBookListData_createBookList.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateBookListData_createBookList? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateBookListData_createBookList.serializer,
        json,
      );
}
