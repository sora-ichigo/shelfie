// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'pending_follow_request_count.data.gql.g.dart';

abstract class GPendingFollowRequestCountData
    implements
        Built<GPendingFollowRequestCountData,
            GPendingFollowRequestCountDataBuilder> {
  GPendingFollowRequestCountData._();

  factory GPendingFollowRequestCountData(
          [void Function(GPendingFollowRequestCountDataBuilder b) updates]) =
      _$GPendingFollowRequestCountData;

  static void _initializeBuilder(GPendingFollowRequestCountDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get pendingFollowRequestCount;
  static Serializer<GPendingFollowRequestCountData> get serializer =>
      _$gPendingFollowRequestCountDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPendingFollowRequestCountData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPendingFollowRequestCountData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPendingFollowRequestCountData.serializer,
        json,
      );
}
