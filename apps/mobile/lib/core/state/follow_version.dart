import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'follow_version.g.dart';

@Riverpod(keepAlive: true)
class FollowVersion extends _$FollowVersion {
  @override
  int build() => 0;

  void increment() => state++;

  void reset() => state = 0;
}
