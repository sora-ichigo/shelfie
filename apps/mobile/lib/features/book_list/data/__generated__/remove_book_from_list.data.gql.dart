// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'remove_book_from_list.data.gql.g.dart';

abstract class GRemoveBookFromListData
    implements Built<GRemoveBookFromListData, GRemoveBookFromListDataBuilder> {
  GRemoveBookFromListData._();

  factory GRemoveBookFromListData(
          [void Function(GRemoveBookFromListDataBuilder b) updates]) =
      _$GRemoveBookFromListData;

  static void _initializeBuilder(GRemoveBookFromListDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  bool get removeBookFromList;
  static Serializer<GRemoveBookFromListData> get serializer =>
      _$gRemoveBookFromListDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRemoveBookFromListData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRemoveBookFromListData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRemoveBookFromListData.serializer,
        json,
      );
}
