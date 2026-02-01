// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_book_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecentBookEntryImpl _$$RecentBookEntryImplFromJson(
        Map<String, dynamic> json) =>
    _$RecentBookEntryImpl(
      bookId: json['bookId'] as String,
      title: json['title'] as String,
      authors:
          (json['authors'] as List<dynamic>).map((e) => e as String).toList(),
      coverImageUrl: json['coverImageUrl'] as String?,
      viewedAt: DateTime.parse(json['viewedAt'] as String),
      source: json['source'] as String?,
    );

Map<String, dynamic> _$$RecentBookEntryImplToJson(
    _$RecentBookEntryImpl instance) {
  final val = <String, dynamic>{
    'bookId': instance.bookId,
    'title': instance.title,
    'authors': instance.authors,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('coverImageUrl', instance.coverImageUrl);
  val['viewedAt'] = instance.viewedAt.toIso8601String();
  writeNotNull('source', instance.source);
  return val;
}
