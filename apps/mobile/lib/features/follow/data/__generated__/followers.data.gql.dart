// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'followers.data.gql.g.dart';

abstract class GFollowersData
    implements Built<GFollowersData, GFollowersDataBuilder> {
  GFollowersData._();

  factory GFollowersData([void Function(GFollowersDataBuilder b) updates]) =
      _$GFollowersData;

  static void _initializeBuilder(GFollowersDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GFollowersData_followers> get followers;
  static Serializer<GFollowersData> get serializer =>
      _$gFollowersDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GFollowersData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GFollowersData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GFollowersData.serializer,
        json,
      );
}

abstract class GFollowersData_followers
    implements
        Built<GFollowersData_followers, GFollowersData_followersBuilder> {
  GFollowersData_followers._();

  factory GFollowersData_followers(
          [void Function(GFollowersData_followersBuilder b) updates]) =
      _$GFollowersData_followers;

  static void _initializeBuilder(GFollowersData_followersBuilder b) =>
      b..G__typename = 'User';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int? get id;
  String? get name;
  String? get avatarUrl;
  String? get handle;
  static Serializer<GFollowersData_followers> get serializer =>
      _$gFollowersDataFollowersSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GFollowersData_followers.serializer,
        this,
      ) as Map<String, dynamic>);

  static GFollowersData_followers? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GFollowersData_followers.serializer,
        json,
      );
}
