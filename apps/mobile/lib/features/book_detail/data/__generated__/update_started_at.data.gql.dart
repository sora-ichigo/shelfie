// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart'
    as _i2;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'update_started_at.data.gql.g.dart';

abstract class GUpdateStartedAtData
    implements Built<GUpdateStartedAtData, GUpdateStartedAtDataBuilder> {
  GUpdateStartedAtData._();

  factory GUpdateStartedAtData(
          [void Function(GUpdateStartedAtDataBuilder b) updates]) =
      _$GUpdateStartedAtData;

  static void _initializeBuilder(GUpdateStartedAtDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GUpdateStartedAtData_updateStartedAt get updateStartedAt;
  static Serializer<GUpdateStartedAtData> get serializer =>
      _$gUpdateStartedAtDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateStartedAtData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateStartedAtData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateStartedAtData.serializer,
        json,
      );
}

abstract class GUpdateStartedAtData_updateStartedAt
    implements
        Built<GUpdateStartedAtData_updateStartedAt,
            GUpdateStartedAtData_updateStartedAtBuilder> {
  GUpdateStartedAtData_updateStartedAt._();

  factory GUpdateStartedAtData_updateStartedAt(
      [void Function(GUpdateStartedAtData_updateStartedAtBuilder b)
          updates]) = _$GUpdateStartedAtData_updateStartedAt;

  static void _initializeBuilder(
          GUpdateStartedAtData_updateStartedAtBuilder b) =>
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
  static Serializer<GUpdateStartedAtData_updateStartedAt> get serializer =>
      _$gUpdateStartedAtDataUpdateStartedAtSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateStartedAtData_updateStartedAt.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateStartedAtData_updateStartedAt? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateStartedAtData_updateStartedAt.serializer,
        json,
      );
}
