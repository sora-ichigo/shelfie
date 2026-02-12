// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'following.data.gql.g.dart';

abstract class GFollowingData
    implements Built<GFollowingData, GFollowingDataBuilder> {
  GFollowingData._();

  factory GFollowingData([void Function(GFollowingDataBuilder b) updates]) =
      _$GFollowingData;

  static void _initializeBuilder(GFollowingDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GFollowingData_following> get following;
  static Serializer<GFollowingData> get serializer =>
      _$gFollowingDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GFollowingData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GFollowingData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GFollowingData.serializer,
        json,
      );
}

abstract class GFollowingData_following
    implements
        Built<GFollowingData_following, GFollowingData_followingBuilder> {
  GFollowingData_following._();

  factory GFollowingData_following(
          [void Function(GFollowingData_followingBuilder b) updates]) =
      _$GFollowingData_following;

  static void _initializeBuilder(GFollowingData_followingBuilder b) =>
      b..G__typename = 'User';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int? get id;
  String? get name;
  String? get avatarUrl;
  String? get handle;
  static Serializer<GFollowingData_following> get serializer =>
      _$gFollowingDataFollowingSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GFollowingData_following.serializer,
        this,
      ) as Map<String, dynamic>);

  static GFollowingData_following? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GFollowingData_following.serializer,
        json,
      );
}
