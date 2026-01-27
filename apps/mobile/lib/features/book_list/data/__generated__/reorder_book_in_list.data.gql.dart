// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'reorder_book_in_list.data.gql.g.dart';

abstract class GReorderBookInListData
    implements Built<GReorderBookInListData, GReorderBookInListDataBuilder> {
  GReorderBookInListData._();

  factory GReorderBookInListData(
          [void Function(GReorderBookInListDataBuilder b) updates]) =
      _$GReorderBookInListData;

  static void _initializeBuilder(GReorderBookInListDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  bool get reorderBookInList;
  static Serializer<GReorderBookInListData> get serializer =>
      _$gReorderBookInListDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GReorderBookInListData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GReorderBookInListData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GReorderBookInListData.serializer,
        json,
      );
}
