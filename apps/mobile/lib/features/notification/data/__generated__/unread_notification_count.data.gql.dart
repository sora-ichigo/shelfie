// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'unread_notification_count.data.gql.g.dart';

abstract class GUnreadNotificationCountData
    implements
        Built<GUnreadNotificationCountData,
            GUnreadNotificationCountDataBuilder> {
  GUnreadNotificationCountData._();

  factory GUnreadNotificationCountData(
          [void Function(GUnreadNotificationCountDataBuilder b) updates]) =
      _$GUnreadNotificationCountData;

  static void _initializeBuilder(GUnreadNotificationCountDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get unreadNotificationCount;
  static Serializer<GUnreadNotificationCountData> get serializer =>
      _$gUnreadNotificationCountDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUnreadNotificationCountData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUnreadNotificationCountData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUnreadNotificationCountData.serializer,
        json,
      );
}
