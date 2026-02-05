// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'share_card_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ShareCardData {
  /// 書籍タイトル
  String get title => throw _privateConstructorUsedError;

  /// 著者名リスト
  List<String> get authors => throw _privateConstructorUsedError;

  /// 表紙画像 URL（null の場合はプレースホルダー）
  String? get thumbnailUrl => throw _privateConstructorUsedError;

  /// ユーザー名
  String? get userName => throw _privateConstructorUsedError;

  /// ユーザーアバター URL
  String? get avatarUrl => throw _privateConstructorUsedError;

  /// 星評価（1-5、null は未設定）
  int? get rating => throw _privateConstructorUsedError;

  /// 読了日
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// 読書メモ
  String? get note => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ShareCardDataCopyWith<ShareCardData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShareCardDataCopyWith<$Res> {
  factory $ShareCardDataCopyWith(
          ShareCardData value, $Res Function(ShareCardData) then) =
      _$ShareCardDataCopyWithImpl<$Res, ShareCardData>;
  @useResult
  $Res call(
      {String title,
      List<String> authors,
      String? thumbnailUrl,
      String? userName,
      String? avatarUrl,
      int? rating,
      DateTime? completedAt,
      String? note});
}

/// @nodoc
class _$ShareCardDataCopyWithImpl<$Res, $Val extends ShareCardData>
    implements $ShareCardDataCopyWith<$Res> {
  _$ShareCardDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? authors = null,
    Object? thumbnailUrl = freezed,
    Object? userName = freezed,
    Object? avatarUrl = freezed,
    Object? rating = freezed,
    Object? completedAt = freezed,
    Object? note = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      authors: null == authors
          ? _value.authors
          : authors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      thumbnailUrl: freezed == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShareCardDataImplCopyWith<$Res>
    implements $ShareCardDataCopyWith<$Res> {
  factory _$$ShareCardDataImplCopyWith(
          _$ShareCardDataImpl value, $Res Function(_$ShareCardDataImpl) then) =
      __$$ShareCardDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      List<String> authors,
      String? thumbnailUrl,
      String? userName,
      String? avatarUrl,
      int? rating,
      DateTime? completedAt,
      String? note});
}

/// @nodoc
class __$$ShareCardDataImplCopyWithImpl<$Res>
    extends _$ShareCardDataCopyWithImpl<$Res, _$ShareCardDataImpl>
    implements _$$ShareCardDataImplCopyWith<$Res> {
  __$$ShareCardDataImplCopyWithImpl(
      _$ShareCardDataImpl _value, $Res Function(_$ShareCardDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? authors = null,
    Object? thumbnailUrl = freezed,
    Object? userName = freezed,
    Object? avatarUrl = freezed,
    Object? rating = freezed,
    Object? completedAt = freezed,
    Object? note = freezed,
  }) {
    return _then(_$ShareCardDataImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      authors: null == authors
          ? _value._authors
          : authors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      thumbnailUrl: freezed == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ShareCardDataImpl implements _ShareCardData {
  const _$ShareCardDataImpl(
      {required this.title,
      required final List<String> authors,
      this.thumbnailUrl,
      this.userName,
      this.avatarUrl,
      this.rating,
      this.completedAt,
      this.note})
      : _authors = authors;

  /// 書籍タイトル
  @override
  final String title;

  /// 著者名リスト
  final List<String> _authors;

  /// 著者名リスト
  @override
  List<String> get authors {
    if (_authors is EqualUnmodifiableListView) return _authors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_authors);
  }

  /// 表紙画像 URL（null の場合はプレースホルダー）
  @override
  final String? thumbnailUrl;

  /// ユーザー名
  @override
  final String? userName;

  /// ユーザーアバター URL
  @override
  final String? avatarUrl;

  /// 星評価（1-5、null は未設定）
  @override
  final int? rating;

  /// 読了日
  @override
  final DateTime? completedAt;

  /// 読書メモ
  @override
  final String? note;

  @override
  String toString() {
    return 'ShareCardData(title: $title, authors: $authors, thumbnailUrl: $thumbnailUrl, userName: $userName, avatarUrl: $avatarUrl, rating: $rating, completedAt: $completedAt, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShareCardDataImpl &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._authors, _authors) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.note, note) || other.note == note));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      const DeepCollectionEquality().hash(_authors),
      thumbnailUrl,
      userName,
      avatarUrl,
      rating,
      completedAt,
      note);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShareCardDataImplCopyWith<_$ShareCardDataImpl> get copyWith =>
      __$$ShareCardDataImplCopyWithImpl<_$ShareCardDataImpl>(this, _$identity);
}

abstract class _ShareCardData implements ShareCardData {
  const factory _ShareCardData(
      {required final String title,
      required final List<String> authors,
      final String? thumbnailUrl,
      final String? userName,
      final String? avatarUrl,
      final int? rating,
      final DateTime? completedAt,
      final String? note}) = _$ShareCardDataImpl;

  @override

  /// 書籍タイトル
  String get title;
  @override

  /// 著者名リスト
  List<String> get authors;
  @override

  /// 表紙画像 URL（null の場合はプレースホルダー）
  String? get thumbnailUrl;
  @override

  /// ユーザー名
  String? get userName;
  @override

  /// ユーザーアバター URL
  String? get avatarUrl;
  @override

  /// 星評価（1-5、null は未設定）
  int? get rating;
  @override

  /// 読了日
  DateTime? get completedAt;
  @override

  /// 読書メモ
  String? get note;
  @override
  @JsonKey(ignore: true)
  _$$ShareCardDataImplCopyWith<_$ShareCardDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
