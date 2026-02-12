// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'mark_notifications_as_read.data.gql.g.dart';

abstract class GMarkNotificationsAsReadData
    implements
        Built<GMarkNotificationsAsReadData,
            GMarkNotificationsAsReadDataBuilder> {
  GMarkNotificationsAsReadData._();

  factory GMarkNotificationsAsReadData(
          [void Function(GMarkNotificationsAsReadDataBuilder b) updates]) =
      _$GMarkNotificationsAsReadData;

  static void _initializeBuilder(GMarkNotificationsAsReadDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  bool? get markNotificationsAsRead;
  static Serializer<GMarkNotificationsAsReadData> get serializer =>
      _$gMarkNotificationsAsReadDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMarkNotificationsAsReadData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMarkNotificationsAsReadData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMarkNotificationsAsReadData.serializer,
        json,
      );
}
