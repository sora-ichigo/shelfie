import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_version.g.dart';

@Riverpod(keepAlive: true)
class ProfileVersion extends _$ProfileVersion {
  @override
  int build() => 0;

  void increment() => state++;
}
