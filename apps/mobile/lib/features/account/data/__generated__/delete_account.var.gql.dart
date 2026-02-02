// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'delete_account.var.gql.g.dart';

abstract class GDeleteAccountVars
    implements Built<GDeleteAccountVars, GDeleteAccountVarsBuilder> {
  GDeleteAccountVars._();

  factory GDeleteAccountVars(
          [void Function(GDeleteAccountVarsBuilder b) updates]) =
      _$GDeleteAccountVars;

  static Serializer<GDeleteAccountVars> get serializer =>
      _$gDeleteAccountVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GDeleteAccountVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GDeleteAccountVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GDeleteAccountVars.serializer,
        json,
      );
}
