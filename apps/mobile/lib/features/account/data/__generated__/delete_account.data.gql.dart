// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gql_code_builder_serializers/gql_code_builder_serializers.dart'
    as _i2;
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart'
    as _i3;
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'delete_account.data.gql.g.dart';

abstract class GDeleteAccountData
    implements Built<GDeleteAccountData, GDeleteAccountDataBuilder> {
  GDeleteAccountData._();

  factory GDeleteAccountData(
          [void Function(GDeleteAccountDataBuilder b) updates]) =
      _$GDeleteAccountData;

  static void _initializeBuilder(GDeleteAccountDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GDeleteAccountData_deleteAccount? get deleteAccount;
  static Serializer<GDeleteAccountData> get serializer =>
      _$gDeleteAccountDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GDeleteAccountData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GDeleteAccountData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GDeleteAccountData.serializer,
        json,
      );
}

abstract class GDeleteAccountData_deleteAccount {
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GDeleteAccountData_deleteAccount> get serializer =>
      _i2.InlineFragmentSerializer<GDeleteAccountData_deleteAccount>(
        'GDeleteAccountData_deleteAccount',
        GDeleteAccountData_deleteAccount__base,
        {
          'MutationDeleteAccountSuccess':
              GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess,
          'AuthError': GDeleteAccountData_deleteAccount__asAuthError,
        },
      );

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GDeleteAccountData_deleteAccount.serializer,
        this,
      ) as Map<String, dynamic>);

  static GDeleteAccountData_deleteAccount? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GDeleteAccountData_deleteAccount.serializer,
        json,
      );
}

abstract class GDeleteAccountData_deleteAccount__base
    implements
        Built<GDeleteAccountData_deleteAccount__base,
            GDeleteAccountData_deleteAccount__baseBuilder>,
        GDeleteAccountData_deleteAccount {
  GDeleteAccountData_deleteAccount__base._();

  factory GDeleteAccountData_deleteAccount__base(
      [void Function(GDeleteAccountData_deleteAccount__baseBuilder b)
          updates]) = _$GDeleteAccountData_deleteAccount__base;

  static void _initializeBuilder(
          GDeleteAccountData_deleteAccount__baseBuilder b) =>
      b..G__typename = 'MutationDeleteAccountResult';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GDeleteAccountData_deleteAccount__base> get serializer =>
      _$gDeleteAccountDataDeleteAccountBaseSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GDeleteAccountData_deleteAccount__base.serializer,
        this,
      ) as Map<String, dynamic>);

  static GDeleteAccountData_deleteAccount__base? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GDeleteAccountData_deleteAccount__base.serializer,
        json,
      );
}

abstract class GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess
    implements
        Built<GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess,
            GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccessBuilder>,
        GDeleteAccountData_deleteAccount {
  GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess._();

  factory GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess(
          [void Function(
                  GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccessBuilder
                      b)
              updates]) =
      _$GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess;

  static void _initializeBuilder(
          GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccessBuilder
              b) =>
      b..G__typename = 'MutationDeleteAccountSuccess';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data
      get data;
  static Serializer<
          GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess>
      get serializer =>
          _$gDeleteAccountDataDeleteAccountAsMutationDeleteAccountSuccessSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess
                .serializer,
            json,
          );
}

abstract class GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data
    implements
        Built<
            GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data,
            GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_dataBuilder> {
  GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data._();

  factory GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data(
          [void Function(
                  GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_dataBuilder
                      b)
              updates]) =
      _$GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data;

  static void _initializeBuilder(
          GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_dataBuilder
              b) =>
      b..G__typename = 'DeleteAccountResult';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  bool? get success;
  static Serializer<
          GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data>
      get serializer =>
          _$gDeleteAccountDataDeleteAccountAsMutationDeleteAccountSuccessDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data
                .serializer,
            json,
          );
}

abstract class GDeleteAccountData_deleteAccount__asAuthError
    implements
        Built<GDeleteAccountData_deleteAccount__asAuthError,
            GDeleteAccountData_deleteAccount__asAuthErrorBuilder>,
        GDeleteAccountData_deleteAccount {
  GDeleteAccountData_deleteAccount__asAuthError._();

  factory GDeleteAccountData_deleteAccount__asAuthError(
      [void Function(GDeleteAccountData_deleteAccount__asAuthErrorBuilder b)
          updates]) = _$GDeleteAccountData_deleteAccount__asAuthError;

  static void _initializeBuilder(
          GDeleteAccountData_deleteAccount__asAuthErrorBuilder b) =>
      b..G__typename = 'AuthError';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  _i3.GAuthErrorCode? get code;
  String? get message;
  static Serializer<GDeleteAccountData_deleteAccount__asAuthError>
      get serializer => _$gDeleteAccountDataDeleteAccountAsAuthErrorSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GDeleteAccountData_deleteAccount__asAuthError.serializer,
        this,
      ) as Map<String, dynamic>);

  static GDeleteAccountData_deleteAccount__asAuthError? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GDeleteAccountData_deleteAccount__asAuthError.serializer,
        json,
      );
}
