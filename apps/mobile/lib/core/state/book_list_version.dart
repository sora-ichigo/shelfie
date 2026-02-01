import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'book_list_version.g.dart';

@Riverpod(keepAlive: true)
class BookListVersion extends _$BookListVersion {
  @override
  int build() => 0;

  void increment() => state++;
}
