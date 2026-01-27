// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'book_list_detail.data.gql.g.dart';

abstract class GBookListDetailData
    implements Built<GBookListDetailData, GBookListDetailDataBuilder> {
  GBookListDetailData._();

  factory GBookListDetailData(
          [void Function(GBookListDetailDataBuilder b) updates]) =
      _$GBookListDetailData;

  static void _initializeBuilder(GBookListDetailDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GBookListDetailData_bookListDetail get bookListDetail;
  static Serializer<GBookListDetailData> get serializer =>
      _$gBookListDetailDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GBookListDetailData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GBookListDetailData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GBookListDetailData.serializer,
        json,
      );
}

abstract class GBookListDetailData_bookListDetail
    implements
        Built<GBookListDetailData_bookListDetail,
            GBookListDetailData_bookListDetailBuilder> {
  GBookListDetailData_bookListDetail._();

  factory GBookListDetailData_bookListDetail(
      [void Function(GBookListDetailData_bookListDetailBuilder b)
          updates]) = _$GBookListDetailData_bookListDetail;

  static void _initializeBuilder(GBookListDetailData_bookListDetailBuilder b) =>
      b..G__typename = 'BookListDetail';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String get title;
  String? get description;
  BuiltList<GBookListDetailData_bookListDetail_items> get items;
  DateTime get createdAt;
  DateTime get updatedAt;
  static Serializer<GBookListDetailData_bookListDetail> get serializer =>
      _$gBookListDetailDataBookListDetailSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GBookListDetailData_bookListDetail.serializer,
        this,
      ) as Map<String, dynamic>);

  static GBookListDetailData_bookListDetail? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GBookListDetailData_bookListDetail.serializer,
        json,
      );
}

abstract class GBookListDetailData_bookListDetail_items
    implements
        Built<GBookListDetailData_bookListDetail_items,
            GBookListDetailData_bookListDetail_itemsBuilder> {
  GBookListDetailData_bookListDetail_items._();

  factory GBookListDetailData_bookListDetail_items(
      [void Function(GBookListDetailData_bookListDetail_itemsBuilder b)
          updates]) = _$GBookListDetailData_bookListDetail_items;

  static void _initializeBuilder(
          GBookListDetailData_bookListDetail_itemsBuilder b) =>
      b..G__typename = 'BookListItem';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  int get position;
  DateTime get addedAt;
  static Serializer<GBookListDetailData_bookListDetail_items> get serializer =>
      _$gBookListDetailDataBookListDetailItemsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GBookListDetailData_bookListDetail_items.serializer,
        this,
      ) as Map<String, dynamic>);

  static GBookListDetailData_bookListDetail_items? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GBookListDetailData_bookListDetail_items.serializer,
        json,
      );
}
