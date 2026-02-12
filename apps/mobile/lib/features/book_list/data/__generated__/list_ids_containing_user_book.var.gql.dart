// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'list_ids_containing_user_book.var.gql.g.dart';

abstract class GListIdsContainingUserBookVars
    implements
        Built<GListIdsContainingUserBookVars,
            GListIdsContainingUserBookVarsBuilder> {
  GListIdsContainingUserBookVars._();

  factory GListIdsContainingUserBookVars(
          [void Function(GListIdsContainingUserBookVarsBuilder b) updates]) =
      _$GListIdsContainingUserBookVars;

  int get userBookId;
  static Serializer<GListIdsContainingUserBookVars> get serializer =>
      _$gListIdsContainingUserBookVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GListIdsContainingUserBookVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GListIdsContainingUserBookVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GListIdsContainingUserBookVars.serializer,
        json,
      );
}
