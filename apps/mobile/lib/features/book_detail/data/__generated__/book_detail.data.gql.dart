// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart'
    as _i2;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'book_detail.data.gql.g.dart';

abstract class GBookDetailData
    implements Built<GBookDetailData, GBookDetailDataBuilder> {
  GBookDetailData._();

  factory GBookDetailData([void Function(GBookDetailDataBuilder b) updates]) =
      _$GBookDetailData;

  static void _initializeBuilder(GBookDetailDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GBookDetailData_bookDetail get bookDetail;
  static Serializer<GBookDetailData> get serializer =>
      _$gBookDetailDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GBookDetailData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GBookDetailData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GBookDetailData.serializer,
        json,
      );
}

abstract class GBookDetailData_bookDetail
    implements
        Built<GBookDetailData_bookDetail, GBookDetailData_bookDetailBuilder> {
  GBookDetailData_bookDetail._();

  factory GBookDetailData_bookDetail(
          [void Function(GBookDetailData_bookDetailBuilder b) updates]) =
      _$GBookDetailData_bookDetail;

  static void _initializeBuilder(GBookDetailData_bookDetailBuilder b) =>
      b..G__typename = 'BookDetail';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get title;
  BuiltList<String> get authors;
  String? get publisher;
  String? get publishedDate;
  int? get pageCount;
  BuiltList<String>? get categories;
  String? get description;
  String? get isbn;
  String? get coverImageUrl;
  String? get amazonUrl;
  String? get rakutenBooksUrl;
  GBookDetailData_bookDetail_userBook? get userBook;
  static Serializer<GBookDetailData_bookDetail> get serializer =>
      _$gBookDetailDataBookDetailSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GBookDetailData_bookDetail.serializer,
        this,
      ) as Map<String, dynamic>);

  static GBookDetailData_bookDetail? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GBookDetailData_bookDetail.serializer,
        json,
      );
}

abstract class GBookDetailData_bookDetail_userBook
    implements
        Built<GBookDetailData_bookDetail_userBook,
            GBookDetailData_bookDetail_userBookBuilder> {
  GBookDetailData_bookDetail_userBook._();

  factory GBookDetailData_bookDetail_userBook(
      [void Function(GBookDetailData_bookDetail_userBookBuilder b)
          updates]) = _$GBookDetailData_bookDetail_userBook;

  static void _initializeBuilder(
          GBookDetailData_bookDetail_userBookBuilder b) =>
      b..G__typename = 'UserBook';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String get externalId;
  String get title;
  BuiltList<String> get authors;
  String? get publisher;
  String? get publishedDate;
  String? get isbn;
  String? get coverImageUrl;
  DateTime get addedAt;
  _i2.GReadingStatus get readingStatus;
  DateTime? get startedAt;
  DateTime? get completedAt;
  String? get note;
  DateTime? get noteUpdatedAt;
  int? get rating;
  static Serializer<GBookDetailData_bookDetail_userBook> get serializer =>
      _$gBookDetailDataBookDetailUserBookSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GBookDetailData_bookDetail_userBook.serializer,
        this,
      ) as Map<String, dynamic>);

  static GBookDetailData_bookDetail_userBook? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GBookDetailData_bookDetail_userBook.serializer,
        json,
      );
}
