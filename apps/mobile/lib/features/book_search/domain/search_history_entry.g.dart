// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_history_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SearchHistoryEntryImpl _$$SearchHistoryEntryImplFromJson(
  Map<String, dynamic> json,
) => _$SearchHistoryEntryImpl(
  query: json['query'] as String,
  searchedAt: DateTime.parse(json['searchedAt'] as String),
);

Map<String, dynamic> _$$SearchHistoryEntryImplToJson(
  _$SearchHistoryEntryImpl instance,
) => <String, dynamic>{
  'query': instance.query,
  'searchedAt': instance.searchedAt.toIso8601String(),
};
