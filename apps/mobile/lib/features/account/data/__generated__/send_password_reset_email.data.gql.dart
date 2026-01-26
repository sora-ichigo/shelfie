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

part 'send_password_reset_email.data.gql.g.dart';

abstract class GSendPasswordResetEmailData
    implements
        Built<GSendPasswordResetEmailData, GSendPasswordResetEmailDataBuilder> {
  GSendPasswordResetEmailData._();

  factory GSendPasswordResetEmailData(
          [void Function(GSendPasswordResetEmailDataBuilder b) updates]) =
      _$GSendPasswordResetEmailData;

  static void _initializeBuilder(GSendPasswordResetEmailDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GSendPasswordResetEmailData_sendPasswordResetEmail?
      get sendPasswordResetEmail;
  static Serializer<GSendPasswordResetEmailData> get serializer =>
      _$gSendPasswordResetEmailDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSendPasswordResetEmailData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendPasswordResetEmailData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSendPasswordResetEmailData.serializer,
        json,
      );
}

abstract class GSendPasswordResetEmailData_sendPasswordResetEmail {
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GSendPasswordResetEmailData_sendPasswordResetEmail>
      get serializer => _i2.InlineFragmentSerializer<
              GSendPasswordResetEmailData_sendPasswordResetEmail>(
            'GSendPasswordResetEmailData_sendPasswordResetEmail',
            GSendPasswordResetEmailData_sendPasswordResetEmail__base,
            {
              'MutationSendPasswordResetEmailSuccess':
                  GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess,
              'AuthError':
                  GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError,
            },
          );

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSendPasswordResetEmailData_sendPasswordResetEmail.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendPasswordResetEmailData_sendPasswordResetEmail? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSendPasswordResetEmailData_sendPasswordResetEmail.serializer,
        json,
      );
}

abstract class GSendPasswordResetEmailData_sendPasswordResetEmail__base
    implements
        Built<GSendPasswordResetEmailData_sendPasswordResetEmail__base,
            GSendPasswordResetEmailData_sendPasswordResetEmail__baseBuilder>,
        GSendPasswordResetEmailData_sendPasswordResetEmail {
  GSendPasswordResetEmailData_sendPasswordResetEmail__base._();

  factory GSendPasswordResetEmailData_sendPasswordResetEmail__base(
      [void Function(
              GSendPasswordResetEmailData_sendPasswordResetEmail__baseBuilder b)
          updates]) = _$GSendPasswordResetEmailData_sendPasswordResetEmail__base;

  static void _initializeBuilder(
          GSendPasswordResetEmailData_sendPasswordResetEmail__baseBuilder b) =>
      b..G__typename = 'MutationSendPasswordResetEmailResult';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GSendPasswordResetEmailData_sendPasswordResetEmail__base>
      get serializer =>
          _$gSendPasswordResetEmailDataSendPasswordResetEmailBaseSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSendPasswordResetEmailData_sendPasswordResetEmail__base.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendPasswordResetEmailData_sendPasswordResetEmail__base? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSendPasswordResetEmailData_sendPasswordResetEmail__base.serializer,
        json,
      );
}

abstract class GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess
    implements
        Built<
            GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess,
            GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccessBuilder>,
        GSendPasswordResetEmailData_sendPasswordResetEmail {
  GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess._();

  factory GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess(
          [void Function(
                  GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccessBuilder
                      b)
              updates]) =
      _$GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess;

  static void _initializeBuilder(
          GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccessBuilder
              b) =>
      b..G__typename = 'MutationSendPasswordResetEmailSuccess';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data
      get data;
  static Serializer<
          GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess>
      get serializer =>
          _$gSendPasswordResetEmailDataSendPasswordResetEmailAsMutationSendPasswordResetEmailSuccessSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess
                .serializer,
            json,
          );
}

abstract class GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data
    implements
        Built<
            GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data,
            GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_dataBuilder> {
  GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data._();

  factory GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data(
          [void Function(
                  GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_dataBuilder
                      b)
              updates]) =
      _$GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data;

  static void _initializeBuilder(
          GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_dataBuilder
              b) =>
      b..G__typename = 'SendPasswordResetEmailResult';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  bool? get success;
  static Serializer<
          GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data>
      get serializer =>
          _$gSendPasswordResetEmailDataSendPasswordResetEmailAsMutationSendPasswordResetEmailSuccessDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data
                .serializer,
            json,
          );
}

abstract class GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError
    implements
        Built<GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError,
            GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthErrorBuilder>,
        GSendPasswordResetEmailData_sendPasswordResetEmail {
  GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError._();

  factory GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError(
          [void Function(
                  GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthErrorBuilder
                      b)
              updates]) =
      _$GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError;

  static void _initializeBuilder(
          GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthErrorBuilder
              b) =>
      b..G__typename = 'AuthError';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  _i3.GAuthErrorCode? get code;
  String? get message;
  String? get field;
  bool? get retryable;
  static Serializer<
          GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError>
      get serializer =>
          _$gSendPasswordResetEmailDataSendPasswordResetEmailAsAuthErrorSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError
                .serializer,
            json,
          );
}
