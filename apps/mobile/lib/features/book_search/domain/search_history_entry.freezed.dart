// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_history_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SearchHistoryEntry _$SearchHistoryEntryFromJson(Map<String, dynamic> json) {
  return _SearchHistoryEntry.fromJson(json);
}

/// @nodoc
mixin _$SearchHistoryEntry {
  /// 検索クエリ文字列
  String get query => throw _privateConstructorUsedError;

  /// 検索を実行した日時
  DateTime get searchedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SearchHistoryEntryCopyWith<SearchHistoryEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchHistoryEntryCopyWith<$Res> {
  factory $SearchHistoryEntryCopyWith(
          SearchHistoryEntry value, $Res Function(SearchHistoryEntry) then) =
      _$SearchHistoryEntryCopyWithImpl<$Res, SearchHistoryEntry>;
  @useResult
  $Res call({String query, DateTime searchedAt});
}

/// @nodoc
class _$SearchHistoryEntryCopyWithImpl<$Res, $Val extends SearchHistoryEntry>
    implements $SearchHistoryEntryCopyWith<$Res> {
  _$SearchHistoryEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? searchedAt = null,
  }) {
    return _then(_value.copyWith(
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      searchedAt: null == searchedAt
          ? _value.searchedAt
          : searchedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchHistoryEntryImplCopyWith<$Res>
    implements $SearchHistoryEntryCopyWith<$Res> {
  factory _$$SearchHistoryEntryImplCopyWith(_$SearchHistoryEntryImpl value,
          $Res Function(_$SearchHistoryEntryImpl) then) =
      __$$SearchHistoryEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String query, DateTime searchedAt});
}

/// @nodoc
class __$$SearchHistoryEntryImplCopyWithImpl<$Res>
    extends _$SearchHistoryEntryCopyWithImpl<$Res, _$SearchHistoryEntryImpl>
    implements _$$SearchHistoryEntryImplCopyWith<$Res> {
  __$$SearchHistoryEntryImplCopyWithImpl(_$SearchHistoryEntryImpl _value,
      $Res Function(_$SearchHistoryEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? searchedAt = null,
  }) {
    return _then(_$SearchHistoryEntryImpl(
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      searchedAt: null == searchedAt
          ? _value.searchedAt
          : searchedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SearchHistoryEntryImpl implements _SearchHistoryEntry {
  const _$SearchHistoryEntryImpl(
      {required this.query, required this.searchedAt});

  factory _$SearchHistoryEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$SearchHistoryEntryImplFromJson(json);

  /// 検索クエリ文字列
  @override
  final String query;

  /// 検索を実行した日時
  @override
  final DateTime searchedAt;

  @override
  String toString() {
    return 'SearchHistoryEntry(query: $query, searchedAt: $searchedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchHistoryEntryImpl &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.searchedAt, searchedAt) ||
                other.searchedAt == searchedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, query, searchedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchHistoryEntryImplCopyWith<_$SearchHistoryEntryImpl> get copyWith =>
      __$$SearchHistoryEntryImplCopyWithImpl<_$SearchHistoryEntryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchHistoryEntryImplToJson(
      this,
    );
  }
}

abstract class _SearchHistoryEntry implements SearchHistoryEntry {
  const factory _SearchHistoryEntry(
      {required final String query,
      required final DateTime searchedAt}) = _$SearchHistoryEntryImpl;

  factory _SearchHistoryEntry.fromJson(Map<String, dynamic> json) =
      _$SearchHistoryEntryImpl.fromJson;

  @override

  /// 検索クエリ文字列
  String get query;
  @override

  /// 検索を実行した日時
  DateTime get searchedAt;
  @override
  @JsonKey(ignore: true)
  _$$SearchHistoryEntryImplCopyWith<_$SearchHistoryEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
