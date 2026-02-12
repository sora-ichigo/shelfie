// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart'
    as _i2;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'user_shelf.data.gql.g.dart';

abstract class GUserShelfData
    implements Built<GUserShelfData, GUserShelfDataBuilder> {
  GUserShelfData._();

  factory GUserShelfData([void Function(GUserShelfDataBuilder b) updates]) =
      _$GUserShelfData;

  static void _initializeBuilder(GUserShelfDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GUserShelfData_userShelf get userShelf;
  static Serializer<GUserShelfData> get serializer =>
      _$gUserShelfDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUserShelfData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUserShelfData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUserShelfData.serializer,
        json,
      );
}

abstract class GUserShelfData_userShelf
    implements
        Built<GUserShelfData_userShelf, GUserShelfData_userShelfBuilder> {
  GUserShelfData_userShelf._();

  factory GUserShelfData_userShelf(
          [void Function(GUserShelfData_userShelfBuilder b) updates]) =
      _$GUserShelfData_userShelf;

  static void _initializeBuilder(GUserShelfData_userShelfBuilder b) =>
      b..G__typename = 'MyShelfResult';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GUserShelfData_userShelf_items> get items;
  int get totalCount;
  bool get hasMore;
  static Serializer<GUserShelfData_userShelf> get serializer =>
      _$gUserShelfDataUserShelfSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUserShelfData_userShelf.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUserShelfData_userShelf? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUserShelfData_userShelf.serializer,
        json,
      );
}

abstract class GUserShelfData_userShelf_items
    implements
        Built<GUserShelfData_userShelf_items,
            GUserShelfData_userShelf_itemsBuilder> {
  GUserShelfData_userShelf_items._();

  factory GUserShelfData_userShelf_items(
          [void Function(GUserShelfData_userShelf_itemsBuilder b) updates]) =
      _$GUserShelfData_userShelf_items;

  static void _initializeBuilder(GUserShelfData_userShelf_itemsBuilder b) =>
      b..G__typename = 'UserBook';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String get externalId;
  String get title;
  BuiltList<String> get authors;
  String? get coverImageUrl;
  _i2.GReadingStatus get readingStatus;
  _i2.GBookSource get source;
  DateTime get addedAt;
  DateTime? get startedAt;
  DateTime? get completedAt;
  int? get rating;
  static Serializer<GUserShelfData_userShelf_items> get serializer =>
      _$gUserShelfDataUserShelfItemsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUserShelfData_userShelf_items.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUserShelfData_userShelf_items? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUserShelfData_userShelf_items.serializer,
        json,
      );
}
