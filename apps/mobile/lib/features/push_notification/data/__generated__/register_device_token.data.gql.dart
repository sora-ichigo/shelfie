// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'register_device_token.data.gql.g.dart';

abstract class GRegisterDeviceTokenData
    implements
        Built<GRegisterDeviceTokenData, GRegisterDeviceTokenDataBuilder> {
  GRegisterDeviceTokenData._();

  factory GRegisterDeviceTokenData(
          [void Function(GRegisterDeviceTokenDataBuilder b) updates]) =
      _$GRegisterDeviceTokenData;

  static void _initializeBuilder(GRegisterDeviceTokenDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GRegisterDeviceTokenData_registerDeviceToken? get registerDeviceToken;
  static Serializer<GRegisterDeviceTokenData> get serializer =>
      _$gRegisterDeviceTokenDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRegisterDeviceTokenData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRegisterDeviceTokenData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRegisterDeviceTokenData.serializer,
        json,
      );
}

abstract class GRegisterDeviceTokenData_registerDeviceToken
    implements
        Built<GRegisterDeviceTokenData_registerDeviceToken,
            GRegisterDeviceTokenData_registerDeviceTokenBuilder> {
  GRegisterDeviceTokenData_registerDeviceToken._();

  factory GRegisterDeviceTokenData_registerDeviceToken(
      [void Function(GRegisterDeviceTokenData_registerDeviceTokenBuilder b)
          updates]) = _$GRegisterDeviceTokenData_registerDeviceToken;

  static void _initializeBuilder(
          GRegisterDeviceTokenData_registerDeviceTokenBuilder b) =>
      b..G__typename = 'DeviceToken';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int? get id;
  int? get userId;
  String? get platform;
  DateTime? get createdAt;
  static Serializer<GRegisterDeviceTokenData_registerDeviceToken>
      get serializer => _$gRegisterDeviceTokenDataRegisterDeviceTokenSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRegisterDeviceTokenData_registerDeviceToken.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRegisterDeviceTokenData_registerDeviceToken? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRegisterDeviceTokenData_registerDeviceToken.serializer,
        json,
      );
}
