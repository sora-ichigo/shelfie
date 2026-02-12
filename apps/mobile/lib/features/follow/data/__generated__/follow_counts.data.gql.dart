// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'follow_counts.data.gql.g.dart';

abstract class GFollowCountsData
    implements Built<GFollowCountsData, GFollowCountsDataBuilder> {
  GFollowCountsData._();

  factory GFollowCountsData(
          [void Function(GFollowCountsDataBuilder b) updates]) =
      _$GFollowCountsData;

  static void _initializeBuilder(GFollowCountsDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GFollowCountsData_followCounts get followCounts;
  static Serializer<GFollowCountsData> get serializer =>
      _$gFollowCountsDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GFollowCountsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GFollowCountsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GFollowCountsData.serializer,
        json,
      );
}

abstract class GFollowCountsData_followCounts
    implements
        Built<GFollowCountsData_followCounts,
            GFollowCountsData_followCountsBuilder> {
  GFollowCountsData_followCounts._();

  factory GFollowCountsData_followCounts(
          [void Function(GFollowCountsData_followCountsBuilder b) updates]) =
      _$GFollowCountsData_followCounts;

  static void _initializeBuilder(GFollowCountsData_followCountsBuilder b) =>
      b..G__typename = 'FollowCounts';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get followingCount;
  int get followerCount;
  static Serializer<GFollowCountsData_followCounts> get serializer =>
      _$gFollowCountsDataFollowCountsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GFollowCountsData_followCounts.serializer,
        this,
      ) as Map<String, dynamic>);

  static GFollowCountsData_followCounts? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GFollowCountsData_followCounts.serializer,
        json,
      );
}
