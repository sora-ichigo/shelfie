// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'delete_book_list.data.gql.g.dart';

abstract class GDeleteBookListData
    implements Built<GDeleteBookListData, GDeleteBookListDataBuilder> {
  GDeleteBookListData._();

  factory GDeleteBookListData(
          [void Function(GDeleteBookListDataBuilder b) updates]) =
      _$GDeleteBookListData;

  static void _initializeBuilder(GDeleteBookListDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  bool get deleteBookList;
  static Serializer<GDeleteBookListData> get serializer =>
      _$gDeleteBookListDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GDeleteBookListData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GDeleteBookListData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GDeleteBookListData.serializer,
        json,
      );
}
