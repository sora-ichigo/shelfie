import 'package:built_value/serializer.dart';

/// ISO8601 文字列形式の DateTime をシリアライズ/デシリアライズする
///
/// GraphQL API から返される `createdAt` などの日時フィールドは
/// ISO8601 形式の文字列（例: "2026-01-21T11:52:44.329Z"）で返されるため、
/// このシリアライザーで変換する。
class Iso8601DateTimeSerializer implements PrimitiveSerializer<DateTime> {
  @override
  DateTime deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    if (serialized is String) {
      return DateTime.parse(serialized);
    }
    if (serialized is int) {
      return DateTime.fromMillisecondsSinceEpoch(serialized);
    }
    throw ArgumentError('Cannot deserialize DateTime from $serialized');
  }

  @override
  Object serialize(
    Serializers serializers,
    DateTime object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return object.toIso8601String();
  }

  @override
  Iterable<Type> get types => [DateTime];

  @override
  String get wireName => 'DateTime';
}
