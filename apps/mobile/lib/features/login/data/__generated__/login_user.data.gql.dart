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

part 'login_user.data.gql.g.dart';

abstract class GLoginUserData
    implements Built<GLoginUserData, GLoginUserDataBuilder> {
  GLoginUserData._();

  factory GLoginUserData([void Function(GLoginUserDataBuilder b) updates]) =
      _$GLoginUserData;

  static void _initializeBuilder(GLoginUserDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GLoginUserData_loginUser? get loginUser;
  static Serializer<GLoginUserData> get serializer =>
      _$gLoginUserDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GLoginUserData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GLoginUserData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GLoginUserData.serializer,
        json,
      );
}

abstract class GLoginUserData_loginUser {
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GLoginUserData_loginUser> get serializer =>
      _i2.InlineFragmentSerializer<GLoginUserData_loginUser>(
        'GLoginUserData_loginUser',
        GLoginUserData_loginUser__base,
        {
          'MutationLoginUserSuccess':
              GLoginUserData_loginUser__asMutationLoginUserSuccess,
          'AuthError': GLoginUserData_loginUser__asAuthError,
        },
      );

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GLoginUserData_loginUser.serializer,
        this,
      ) as Map<String, dynamic>);

  static GLoginUserData_loginUser? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GLoginUserData_loginUser.serializer,
        json,
      );
}

abstract class GLoginUserData_loginUser__base
    implements
        Built<GLoginUserData_loginUser__base,
            GLoginUserData_loginUser__baseBuilder>,
        GLoginUserData_loginUser {
  GLoginUserData_loginUser__base._();

  factory GLoginUserData_loginUser__base(
          [void Function(GLoginUserData_loginUser__baseBuilder b) updates]) =
      _$GLoginUserData_loginUser__base;

  static void _initializeBuilder(GLoginUserData_loginUser__baseBuilder b) =>
      b..G__typename = 'MutationLoginUserResult';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GLoginUserData_loginUser__base> get serializer =>
      _$gLoginUserDataLoginUserBaseSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GLoginUserData_loginUser__base.serializer,
        this,
      ) as Map<String, dynamic>);

  static GLoginUserData_loginUser__base? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GLoginUserData_loginUser__base.serializer,
        json,
      );
}

abstract class GLoginUserData_loginUser__asMutationLoginUserSuccess
    implements
        Built<GLoginUserData_loginUser__asMutationLoginUserSuccess,
            GLoginUserData_loginUser__asMutationLoginUserSuccessBuilder>,
        GLoginUserData_loginUser {
  GLoginUserData_loginUser__asMutationLoginUserSuccess._();

  factory GLoginUserData_loginUser__asMutationLoginUserSuccess(
      [void Function(
              GLoginUserData_loginUser__asMutationLoginUserSuccessBuilder b)
          updates]) = _$GLoginUserData_loginUser__asMutationLoginUserSuccess;

  static void _initializeBuilder(
          GLoginUserData_loginUser__asMutationLoginUserSuccessBuilder b) =>
      b..G__typename = 'MutationLoginUserSuccess';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GLoginUserData_loginUser__asMutationLoginUserSuccess_data get data;
  static Serializer<GLoginUserData_loginUser__asMutationLoginUserSuccess>
      get serializer =>
          _$gLoginUserDataLoginUserAsMutationLoginUserSuccessSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GLoginUserData_loginUser__asMutationLoginUserSuccess.serializer,
        this,
      ) as Map<String, dynamic>);

  static GLoginUserData_loginUser__asMutationLoginUserSuccess? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GLoginUserData_loginUser__asMutationLoginUserSuccess.serializer,
        json,
      );
}

abstract class GLoginUserData_loginUser__asMutationLoginUserSuccess_data
    implements
        Built<GLoginUserData_loginUser__asMutationLoginUserSuccess_data,
            GLoginUserData_loginUser__asMutationLoginUserSuccess_dataBuilder> {
  GLoginUserData_loginUser__asMutationLoginUserSuccess_data._();

  factory GLoginUserData_loginUser__asMutationLoginUserSuccess_data(
      [void Function(
              GLoginUserData_loginUser__asMutationLoginUserSuccess_dataBuilder
                  b)
          updates]) = _$GLoginUserData_loginUser__asMutationLoginUserSuccess_data;

  static void _initializeBuilder(
          GLoginUserData_loginUser__asMutationLoginUserSuccess_dataBuilder b) =>
      b..G__typename = 'LoginResult';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user get user;
  String get idToken;
  String get refreshToken;
  static Serializer<GLoginUserData_loginUser__asMutationLoginUserSuccess_data>
      get serializer =>
          _$gLoginUserDataLoginUserAsMutationLoginUserSuccessDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GLoginUserData_loginUser__asMutationLoginUserSuccess_data.serializer,
        this,
      ) as Map<String, dynamic>);

  static GLoginUserData_loginUser__asMutationLoginUserSuccess_data? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GLoginUserData_loginUser__asMutationLoginUserSuccess_data.serializer,
        json,
      );
}

abstract class GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user
    implements
        Built<GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user,
            GLoginUserData_loginUser__asMutationLoginUserSuccess_data_userBuilder> {
  GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user._();

  factory GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user(
          [void Function(
                  GLoginUserData_loginUser__asMutationLoginUserSuccess_data_userBuilder
                      b)
              updates]) =
      _$GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user;

  static void _initializeBuilder(
          GLoginUserData_loginUser__asMutationLoginUserSuccess_data_userBuilder
              b) =>
      b..G__typename = 'User';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int? get id;
  String? get email;
  DateTime? get createdAt;
  static Serializer<
          GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user>
      get serializer =>
          _$gLoginUserDataLoginUserAsMutationLoginUserSuccessDataUserSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user
                .serializer,
            json,
          );
}

abstract class GLoginUserData_loginUser__asAuthError
    implements
        Built<GLoginUserData_loginUser__asAuthError,
            GLoginUserData_loginUser__asAuthErrorBuilder>,
        GLoginUserData_loginUser {
  GLoginUserData_loginUser__asAuthError._();

  factory GLoginUserData_loginUser__asAuthError(
      [void Function(GLoginUserData_loginUser__asAuthErrorBuilder b)
          updates]) = _$GLoginUserData_loginUser__asAuthError;

  static void _initializeBuilder(
          GLoginUserData_loginUser__asAuthErrorBuilder b) =>
      b..G__typename = 'AuthError';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  _i3.GAuthErrorCode? get code;
  String? get message;
  String? get field;
  bool? get retryable;
  static Serializer<GLoginUserData_loginUser__asAuthError> get serializer =>
      _$gLoginUserDataLoginUserAsAuthErrorSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GLoginUserData_loginUser__asAuthError.serializer,
        this,
      ) as Map<String, dynamic>);

  static GLoginUserData_loginUser__asAuthError? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GLoginUserData_loginUser__asAuthError.serializer,
        json,
      );
}
