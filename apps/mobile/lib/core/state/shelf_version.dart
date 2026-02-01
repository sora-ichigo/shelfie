import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shelf_version.g.dart';

@Riverpod(keepAlive: true)
class ShelfVersion extends _$ShelfVersion {
  @override
  int build() => 0;

  void increment() => state++;
}
