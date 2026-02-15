// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'mark_notification_as_read.data.gql.g.dart';

abstract class GMarkNotificationAsReadData
    implements
        Built<GMarkNotificationAsReadData, GMarkNotificationAsReadDataBuilder> {
  GMarkNotificationAsReadData._();

  factory GMarkNotificationAsReadData(
          [void Function(GMarkNotificationAsReadDataBuilder b) updates]) =
      _$GMarkNotificationAsReadData;

  static void _initializeBuilder(GMarkNotificationAsReadDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  bool? get markNotificationAsRead;
  static Serializer<GMarkNotificationAsReadData> get serializer =>
      _$gMarkNotificationAsReadDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMarkNotificationAsReadData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMarkNotificationAsReadData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMarkNotificationAsReadData.serializer,
        json,
      );
}
