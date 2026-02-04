// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart'
    as _i2;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'update_completed_at.data.gql.g.dart';

abstract class GUpdateCompletedAtData
    implements Built<GUpdateCompletedAtData, GUpdateCompletedAtDataBuilder> {
  GUpdateCompletedAtData._();

  factory GUpdateCompletedAtData(
          [void Function(GUpdateCompletedAtDataBuilder b) updates]) =
      _$GUpdateCompletedAtData;

  static void _initializeBuilder(GUpdateCompletedAtDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GUpdateCompletedAtData_updateCompletedAt get updateCompletedAt;
  static Serializer<GUpdateCompletedAtData> get serializer =>
      _$gUpdateCompletedAtDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateCompletedAtData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateCompletedAtData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateCompletedAtData.serializer,
        json,
      );
}

abstract class GUpdateCompletedAtData_updateCompletedAt
    implements
        Built<GUpdateCompletedAtData_updateCompletedAt,
            GUpdateCompletedAtData_updateCompletedAtBuilder> {
  GUpdateCompletedAtData_updateCompletedAt._();

  factory GUpdateCompletedAtData_updateCompletedAt(
      [void Function(GUpdateCompletedAtData_updateCompletedAtBuilder b)
          updates]) = _$GUpdateCompletedAtData_updateCompletedAt;

  static void _initializeBuilder(
          GUpdateCompletedAtData_updateCompletedAtBuilder b) =>
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
  static Serializer<GUpdateCompletedAtData_updateCompletedAt> get serializer =>
      _$gUpdateCompletedAtDataUpdateCompletedAtSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateCompletedAtData_updateCompletedAt.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateCompletedAtData_updateCompletedAt? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateCompletedAtData_updateCompletedAt.serializer,
        json,
      );
}
