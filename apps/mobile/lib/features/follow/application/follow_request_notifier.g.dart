// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_request_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$followRequestNotifierHash() =>
    r'3f2485ba9dcd264d9e1aed42ba09dad193e2cbf1';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$FollowRequestNotifier
    extends BuildlessAutoDisposeNotifier<AsyncValue<FollowStatusType>> {
  late final int targetUserId;

  AsyncValue<FollowStatusType> build(
    int targetUserId,
  );
}

/// See also [FollowRequestNotifier].
@ProviderFor(FollowRequestNotifier)
const followRequestNotifierProvider = FollowRequestNotifierFamily();

/// See also [FollowRequestNotifier].
class FollowRequestNotifierFamily extends Family<AsyncValue<FollowStatusType>> {
  /// See also [FollowRequestNotifier].
  const FollowRequestNotifierFamily();

  /// See also [FollowRequestNotifier].
  FollowRequestNotifierProvider call(
    int targetUserId,
  ) {
    return FollowRequestNotifierProvider(
      targetUserId,
    );
  }

  @override
  FollowRequestNotifierProvider getProviderOverride(
    covariant FollowRequestNotifierProvider provider,
  ) {
    return call(
      provider.targetUserId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'followRequestNotifierProvider';
}

/// See also [FollowRequestNotifier].
class FollowRequestNotifierProvider extends AutoDisposeNotifierProviderImpl<
    FollowRequestNotifier, AsyncValue<FollowStatusType>> {
  /// See also [FollowRequestNotifier].
  FollowRequestNotifierProvider(
    int targetUserId,
  ) : this._internal(
          () => FollowRequestNotifier()..targetUserId = targetUserId,
          from: followRequestNotifierProvider,
          name: r'followRequestNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$followRequestNotifierHash,
          dependencies: FollowRequestNotifierFamily._dependencies,
          allTransitiveDependencies:
              FollowRequestNotifierFamily._allTransitiveDependencies,
          targetUserId: targetUserId,
        );

  FollowRequestNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.targetUserId,
  }) : super.internal();

  final int targetUserId;

  @override
  AsyncValue<FollowStatusType> runNotifierBuild(
    covariant FollowRequestNotifier notifier,
  ) {
    return notifier.build(
      targetUserId,
    );
  }

  @override
  Override overrideWith(FollowRequestNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: FollowRequestNotifierProvider._internal(
        () => create()..targetUserId = targetUserId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        targetUserId: targetUserId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<FollowRequestNotifier,
      AsyncValue<FollowStatusType>> createElement() {
    return _FollowRequestNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FollowRequestNotifierProvider &&
        other.targetUserId == targetUserId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, targetUserId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FollowRequestNotifierRef
    on AutoDisposeNotifierProviderRef<AsyncValue<FollowStatusType>> {
  /// The parameter `targetUserId` of this provider.
  int get targetUserId;
}

class _FollowRequestNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<FollowRequestNotifier,
        AsyncValue<FollowStatusType>> with FollowRequestNotifierRef {
  _FollowRequestNotifierProviderElement(super.provider);

  @override
  int get targetUserId =>
      (origin as FollowRequestNotifierProvider).targetUserId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
