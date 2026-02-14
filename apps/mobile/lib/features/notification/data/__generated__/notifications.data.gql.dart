// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart'
    as _i2;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'notifications.data.gql.g.dart';

abstract class GNotificationsData
    implements Built<GNotificationsData, GNotificationsDataBuilder> {
  GNotificationsData._();

  factory GNotificationsData(
          [void Function(GNotificationsDataBuilder b) updates]) =
      _$GNotificationsData;

  static void _initializeBuilder(GNotificationsDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GNotificationsData_notifications> get notifications;
  static Serializer<GNotificationsData> get serializer =>
      _$gNotificationsDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GNotificationsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GNotificationsData.serializer,
        json,
      );
}

abstract class GNotificationsData_notifications
    implements
        Built<GNotificationsData_notifications,
            GNotificationsData_notificationsBuilder> {
  GNotificationsData_notifications._();

  factory GNotificationsData_notifications(
          [void Function(GNotificationsData_notificationsBuilder b) updates]) =
      _$GNotificationsData_notifications;

  static void _initializeBuilder(GNotificationsData_notificationsBuilder b) =>
      b..G__typename = 'AppNotification';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  GNotificationsData_notifications_sender get sender;
  _i2.GNotificationType get type;
  _i2.GFollowStatus get outgoingFollowStatus;
  _i2.GFollowStatus get incomingFollowStatus;
  int? get followRequestId;
  bool get isRead;
  DateTime get createdAt;
  static Serializer<GNotificationsData_notifications> get serializer =>
      _$gNotificationsDataNotificationsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GNotificationsData_notifications.serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationsData_notifications? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GNotificationsData_notifications.serializer,
        json,
      );
}

abstract class GNotificationsData_notifications_sender
    implements
        Built<GNotificationsData_notifications_sender,
            GNotificationsData_notifications_senderBuilder> {
  GNotificationsData_notifications_sender._();

  factory GNotificationsData_notifications_sender(
      [void Function(GNotificationsData_notifications_senderBuilder b)
          updates]) = _$GNotificationsData_notifications_sender;

  static void _initializeBuilder(
          GNotificationsData_notifications_senderBuilder b) =>
      b..G__typename = 'User';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int? get id;
  String? get name;
  String? get avatarUrl;
  String? get handle;
  static Serializer<GNotificationsData_notifications_sender> get serializer =>
      _$gNotificationsDataNotificationsSenderSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GNotificationsData_notifications_sender.serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationsData_notifications_sender? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GNotificationsData_notifications_sender.serializer,
        json,
      );
}
