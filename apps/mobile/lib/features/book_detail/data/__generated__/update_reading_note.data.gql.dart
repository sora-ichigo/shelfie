// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart'
    as _i2;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'update_reading_note.data.gql.g.dart';

abstract class GUpdateReadingNoteData
    implements Built<GUpdateReadingNoteData, GUpdateReadingNoteDataBuilder> {
  GUpdateReadingNoteData._();

  factory GUpdateReadingNoteData(
          [void Function(GUpdateReadingNoteDataBuilder b) updates]) =
      _$GUpdateReadingNoteData;

  static void _initializeBuilder(GUpdateReadingNoteDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GUpdateReadingNoteData_updateReadingNote get updateReadingNote;
  static Serializer<GUpdateReadingNoteData> get serializer =>
      _$gUpdateReadingNoteDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateReadingNoteData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateReadingNoteData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateReadingNoteData.serializer,
        json,
      );
}

abstract class GUpdateReadingNoteData_updateReadingNote
    implements
        Built<GUpdateReadingNoteData_updateReadingNote,
            GUpdateReadingNoteData_updateReadingNoteBuilder> {
  GUpdateReadingNoteData_updateReadingNote._();

  factory GUpdateReadingNoteData_updateReadingNote(
      [void Function(GUpdateReadingNoteData_updateReadingNoteBuilder b)
          updates]) = _$GUpdateReadingNoteData_updateReadingNote;

  static void _initializeBuilder(
          GUpdateReadingNoteData_updateReadingNoteBuilder b) =>
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
  static Serializer<GUpdateReadingNoteData_updateReadingNote> get serializer =>
      _$gUpdateReadingNoteDataUpdateReadingNoteSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateReadingNoteData_updateReadingNote.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateReadingNoteData_updateReadingNote? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateReadingNoteData_updateReadingNote.serializer,
        json,
      );
}
