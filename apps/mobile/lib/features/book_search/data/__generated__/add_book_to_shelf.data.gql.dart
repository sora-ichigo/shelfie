// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart'
    as _i2;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'add_book_to_shelf.data.gql.g.dart';

abstract class GAddBookToShelfData
    implements Built<GAddBookToShelfData, GAddBookToShelfDataBuilder> {
  GAddBookToShelfData._();

  factory GAddBookToShelfData(
          [void Function(GAddBookToShelfDataBuilder b) updates]) =
      _$GAddBookToShelfData;

  static void _initializeBuilder(GAddBookToShelfDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GAddBookToShelfData_addBookToShelf get addBookToShelf;
  static Serializer<GAddBookToShelfData> get serializer =>
      _$gAddBookToShelfDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAddBookToShelfData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAddBookToShelfData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAddBookToShelfData.serializer,
        json,
      );
}

abstract class GAddBookToShelfData_addBookToShelf
    implements
        Built<GAddBookToShelfData_addBookToShelf,
            GAddBookToShelfData_addBookToShelfBuilder> {
  GAddBookToShelfData_addBookToShelf._();

  factory GAddBookToShelfData_addBookToShelf(
      [void Function(GAddBookToShelfData_addBookToShelfBuilder b)
          updates]) = _$GAddBookToShelfData_addBookToShelf;

  static void _initializeBuilder(GAddBookToShelfData_addBookToShelfBuilder b) =>
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
  _i2.GBookSource get source;
  DateTime get addedAt;
  static Serializer<GAddBookToShelfData_addBookToShelf> get serializer =>
      _$gAddBookToShelfDataAddBookToShelfSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAddBookToShelfData_addBookToShelf.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAddBookToShelfData_addBookToShelf? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAddBookToShelfData_addBookToShelf.serializer,
        json,
      );
}
