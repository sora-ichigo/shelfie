// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart'
    as _i2;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'update_rating.data.gql.g.dart';

abstract class GUpdateBookRatingData
    implements Built<GUpdateBookRatingData, GUpdateBookRatingDataBuilder> {
  GUpdateBookRatingData._();

  factory GUpdateBookRatingData(
          [void Function(GUpdateBookRatingDataBuilder b) updates]) =
      _$GUpdateBookRatingData;

  static void _initializeBuilder(GUpdateBookRatingDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GUpdateBookRatingData_updateBookRating get updateBookRating;
  static Serializer<GUpdateBookRatingData> get serializer =>
      _$gUpdateBookRatingDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateBookRatingData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateBookRatingData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateBookRatingData.serializer,
        json,
      );
}

abstract class GUpdateBookRatingData_updateBookRating
    implements
        Built<GUpdateBookRatingData_updateBookRating,
            GUpdateBookRatingData_updateBookRatingBuilder> {
  GUpdateBookRatingData_updateBookRating._();

  factory GUpdateBookRatingData_updateBookRating(
      [void Function(GUpdateBookRatingData_updateBookRatingBuilder b)
          updates]) = _$GUpdateBookRatingData_updateBookRating;

  static void _initializeBuilder(
          GUpdateBookRatingData_updateBookRatingBuilder b) =>
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
  static Serializer<GUpdateBookRatingData_updateBookRating> get serializer =>
      _$gUpdateBookRatingDataUpdateBookRatingSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateBookRatingData_updateBookRating.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateBookRatingData_updateBookRating? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateBookRatingData_updateBookRating.serializer,
        json,
      );
}
