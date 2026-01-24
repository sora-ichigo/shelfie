// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'update_reading_note.var.gql.g.dart';

abstract class GUpdateReadingNoteVars
    implements Built<GUpdateReadingNoteVars, GUpdateReadingNoteVarsBuilder> {
  GUpdateReadingNoteVars._();

  factory GUpdateReadingNoteVars(
          [void Function(GUpdateReadingNoteVarsBuilder b) updates]) =
      _$GUpdateReadingNoteVars;

  int get userBookId;
  String get note;
  static Serializer<GUpdateReadingNoteVars> get serializer =>
      _$gUpdateReadingNoteVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateReadingNoteVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateReadingNoteVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateReadingNoteVars.serializer,
        json,
      );
}
