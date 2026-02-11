// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_token_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$firebaseMessagingWrapperHash() =>
    r'a7dd55014c74e9c27b25cc3ce8866affcb651654';

/// See also [firebaseMessagingWrapper].
@ProviderFor(firebaseMessagingWrapper)
final firebaseMessagingWrapperProvider =
    Provider<FirebaseMessagingWrapper>.internal(
  firebaseMessagingWrapper,
  name: r'firebaseMessagingWrapperProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$firebaseMessagingWrapperHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FirebaseMessagingWrapperRef = ProviderRef<FirebaseMessagingWrapper>;
String _$deviceTokenNotifierHash() =>
    r'6e414e6ca9e69c2c41ca1dfc7396316a4e1ed848';

/// See also [DeviceTokenNotifier].
@ProviderFor(DeviceTokenNotifier)
final deviceTokenNotifierProvider =
    NotifierProvider<DeviceTokenNotifier, DeviceTokenState>.internal(
  DeviceTokenNotifier.new,
  name: r'deviceTokenNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deviceTokenNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DeviceTokenNotifier = Notifier<DeviceTokenState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
