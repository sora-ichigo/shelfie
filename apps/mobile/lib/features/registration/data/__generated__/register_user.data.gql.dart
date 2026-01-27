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

part 'register_user.data.gql.g.dart';

abstract class GRegisterUserData
    implements Built<GRegisterUserData, GRegisterUserDataBuilder> {
  GRegisterUserData._();

  factory GRegisterUserData(
          [void Function(GRegisterUserDataBuilder b) updates]) =
      _$GRegisterUserData;

  static void _initializeBuilder(GRegisterUserDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GRegisterUserData_registerUser? get registerUser;
  static Serializer<GRegisterUserData> get serializer =>
      _$gRegisterUserDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRegisterUserData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRegisterUserData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRegisterUserData.serializer,
        json,
      );
}

abstract class GRegisterUserData_registerUser {
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GRegisterUserData_registerUser> get serializer =>
      _i2.InlineFragmentSerializer<GRegisterUserData_registerUser>(
        'GRegisterUserData_registerUser',
        GRegisterUserData_registerUser__base,
        {
          'MutationRegisterUserSuccess':
              GRegisterUserData_registerUser__asMutationRegisterUserSuccess,
          'AuthError': GRegisterUserData_registerUser__asAuthError,
        },
      );

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRegisterUserData_registerUser.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRegisterUserData_registerUser? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRegisterUserData_registerUser.serializer,
        json,
      );
}

abstract class GRegisterUserData_registerUser__base
    implements
        Built<GRegisterUserData_registerUser__base,
            GRegisterUserData_registerUser__baseBuilder>,
        GRegisterUserData_registerUser {
  GRegisterUserData_registerUser__base._();

  factory GRegisterUserData_registerUser__base(
      [void Function(GRegisterUserData_registerUser__baseBuilder b)
          updates]) = _$GRegisterUserData_registerUser__base;

  static void _initializeBuilder(
          GRegisterUserData_registerUser__baseBuilder b) =>
      b..G__typename = 'MutationRegisterUserResult';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GRegisterUserData_registerUser__base> get serializer =>
      _$gRegisterUserDataRegisterUserBaseSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRegisterUserData_registerUser__base.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRegisterUserData_registerUser__base? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRegisterUserData_registerUser__base.serializer,
        json,
      );
}

abstract class GRegisterUserData_registerUser__asMutationRegisterUserSuccess
    implements
        Built<GRegisterUserData_registerUser__asMutationRegisterUserSuccess,
            GRegisterUserData_registerUser__asMutationRegisterUserSuccessBuilder>,
        GRegisterUserData_registerUser {
  GRegisterUserData_registerUser__asMutationRegisterUserSuccess._();

  factory GRegisterUserData_registerUser__asMutationRegisterUserSuccess(
          [void Function(
                  GRegisterUserData_registerUser__asMutationRegisterUserSuccessBuilder
                      b)
              updates]) =
      _$GRegisterUserData_registerUser__asMutationRegisterUserSuccess;

  static void _initializeBuilder(
          GRegisterUserData_registerUser__asMutationRegisterUserSuccessBuilder
              b) =>
      b..G__typename = 'MutationRegisterUserSuccess';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data get data;
  static Serializer<
          GRegisterUserData_registerUser__asMutationRegisterUserSuccess>
      get serializer =>
          _$gRegisterUserDataRegisterUserAsMutationRegisterUserSuccessSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRegisterUserData_registerUser__asMutationRegisterUserSuccess
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GRegisterUserData_registerUser__asMutationRegisterUserSuccess?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GRegisterUserData_registerUser__asMutationRegisterUserSuccess
                .serializer,
            json,
          );
}

abstract class GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data
    implements
        Built<
            GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data,
            GRegisterUserData_registerUser__asMutationRegisterUserSuccess_dataBuilder> {
  GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data._();

  factory GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data(
          [void Function(
                  GRegisterUserData_registerUser__asMutationRegisterUserSuccess_dataBuilder
                      b)
              updates]) =
      _$GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data;

  static void _initializeBuilder(
          GRegisterUserData_registerUser__asMutationRegisterUserSuccess_dataBuilder
              b) =>
      b..G__typename = 'LoginResult';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user
      get user;
  String get idToken;
  String get refreshToken;
  static Serializer<
          GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data>
      get serializer =>
          _$gRegisterUserDataRegisterUserAsMutationRegisterUserSuccessDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data
                .serializer,
            json,
          );
}

abstract class GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user
    implements
        Built<
            GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user,
            GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_userBuilder> {
  GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user._();

  factory GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user(
          [void Function(
                  GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_userBuilder
                      b)
              updates]) =
      _$GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user;

  static void _initializeBuilder(
          GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_userBuilder
              b) =>
      b..G__typename = 'User';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int? get id;
  String? get email;
  DateTime? get createdAt;
  static Serializer<
          GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user>
      get serializer =>
          _$gRegisterUserDataRegisterUserAsMutationRegisterUserSuccessDataUserSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user
                .serializer,
            json,
          );
}

abstract class GRegisterUserData_registerUser__asAuthError
    implements
        Built<GRegisterUserData_registerUser__asAuthError,
            GRegisterUserData_registerUser__asAuthErrorBuilder>,
        GRegisterUserData_registerUser {
  GRegisterUserData_registerUser__asAuthError._();

  factory GRegisterUserData_registerUser__asAuthError(
      [void Function(GRegisterUserData_registerUser__asAuthErrorBuilder b)
          updates]) = _$GRegisterUserData_registerUser__asAuthError;

  static void _initializeBuilder(
          GRegisterUserData_registerUser__asAuthErrorBuilder b) =>
      b..G__typename = 'AuthError';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  _i3.GAuthErrorCode? get code;
  String? get message;
  String? get field;
  bool? get retryable;
  static Serializer<GRegisterUserData_registerUser__asAuthError>
      get serializer => _$gRegisterUserDataRegisterUserAsAuthErrorSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRegisterUserData_registerUser__asAuthError.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRegisterUserData_registerUser__asAuthError? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRegisterUserData_registerUser__asAuthError.serializer,
        json,
      );
}
