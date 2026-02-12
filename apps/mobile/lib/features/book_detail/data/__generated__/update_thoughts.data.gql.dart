// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart'
    as _i2;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'update_thoughts.data.gql.g.dart';

abstract class GUpdateThoughtsData
    implements Built<GUpdateThoughtsData, GUpdateThoughtsDataBuilder> {
  GUpdateThoughtsData._();

  factory GUpdateThoughtsData(
          [void Function(GUpdateThoughtsDataBuilder b) updates]) =
      _$GUpdateThoughtsData;

  static void _initializeBuilder(GUpdateThoughtsDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GUpdateThoughtsData_updateThoughts get updateThoughts;
  static Serializer<GUpdateThoughtsData> get serializer =>
      _$gUpdateThoughtsDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateThoughtsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateThoughtsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateThoughtsData.serializer,
        json,
      );
}

abstract class GUpdateThoughtsData_updateThoughts
    implements
        Built<GUpdateThoughtsData_updateThoughts,
            GUpdateThoughtsData_updateThoughtsBuilder> {
  GUpdateThoughtsData_updateThoughts._();

  factory GUpdateThoughtsData_updateThoughts(
      [void Function(GUpdateThoughtsData_updateThoughtsBuilder b)
          updates]) = _$GUpdateThoughtsData_updateThoughts;

  static void _initializeBuilder(GUpdateThoughtsData_updateThoughtsBuilder b) =>
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
  String? get thoughts;
  DateTime? get thoughtsUpdatedAt;
  static Serializer<GUpdateThoughtsData_updateThoughts> get serializer =>
      _$gUpdateThoughtsDataUpdateThoughtsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateThoughtsData_updateThoughts.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateThoughtsData_updateThoughts? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateThoughtsData_updateThoughts.serializer,
        json,
      );
}
