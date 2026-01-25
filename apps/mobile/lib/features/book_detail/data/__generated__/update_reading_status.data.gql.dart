// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart'
    as _i2;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'update_reading_status.data.gql.g.dart';

abstract class GUpdateReadingStatusData
    implements
        Built<GUpdateReadingStatusData, GUpdateReadingStatusDataBuilder> {
  GUpdateReadingStatusData._();

  factory GUpdateReadingStatusData(
          [void Function(GUpdateReadingStatusDataBuilder b) updates]) =
      _$GUpdateReadingStatusData;

  static void _initializeBuilder(GUpdateReadingStatusDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GUpdateReadingStatusData_updateReadingStatus get updateReadingStatus;
  static Serializer<GUpdateReadingStatusData> get serializer =>
      _$gUpdateReadingStatusDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateReadingStatusData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateReadingStatusData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateReadingStatusData.serializer,
        json,
      );
}

abstract class GUpdateReadingStatusData_updateReadingStatus
    implements
        Built<GUpdateReadingStatusData_updateReadingStatus,
            GUpdateReadingStatusData_updateReadingStatusBuilder> {
  GUpdateReadingStatusData_updateReadingStatus._();

  factory GUpdateReadingStatusData_updateReadingStatus(
      [void Function(GUpdateReadingStatusData_updateReadingStatusBuilder b)
          updates]) = _$GUpdateReadingStatusData_updateReadingStatus;

  static void _initializeBuilder(
          GUpdateReadingStatusData_updateReadingStatusBuilder b) =>
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
  DateTime? get completedAt;
  String? get note;
  DateTime? get noteUpdatedAt;
  int? get rating;
  static Serializer<GUpdateReadingStatusData_updateReadingStatus>
      get serializer => _$gUpdateReadingStatusDataUpdateReadingStatusSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateReadingStatusData_updateReadingStatus.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateReadingStatusData_updateReadingStatus? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateReadingStatusData_updateReadingStatus.serializer,
        json,
      );
}
