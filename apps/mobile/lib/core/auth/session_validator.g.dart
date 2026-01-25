// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_validator.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sessionValidatorHash() => r'4f92e15ff3aec801bc61aabe7a929563aa74421e';

/// セッション検証サービス
///
/// me クエリを呼び出してセッションが有効かどうかを検証する。
///
/// Copied from [sessionValidator].
@ProviderFor(sessionValidator)
final sessionValidatorProvider = AutoDisposeProvider<SessionValidator>.internal(
  sessionValidator,
  name: r'sessionValidatorProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sessionValidatorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SessionValidatorRef = AutoDisposeProviderRef<SessionValidator>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
