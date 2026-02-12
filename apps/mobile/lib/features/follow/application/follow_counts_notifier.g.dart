// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_counts_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$followCountsNotifierHash() =>
    r'822d5b9dfcf2e3042c5678e6e38d1295655ea58b';

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

abstract class _$FollowCountsNotifier
    extends BuildlessAutoDisposeAsyncNotifier<FollowCounts> {
  late final int userId;

  FutureOr<FollowCounts> build(
    int userId,
  );
}

/// See also [FollowCountsNotifier].
@ProviderFor(FollowCountsNotifier)
const followCountsNotifierProvider = FollowCountsNotifierFamily();

/// See also [FollowCountsNotifier].
class FollowCountsNotifierFamily extends Family<AsyncValue<FollowCounts>> {
  /// See also [FollowCountsNotifier].
  const FollowCountsNotifierFamily();

  /// See also [FollowCountsNotifier].
  FollowCountsNotifierProvider call(
    int userId,
  ) {
    return FollowCountsNotifierProvider(
      userId,
    );
  }

  @override
  FollowCountsNotifierProvider getProviderOverride(
    covariant FollowCountsNotifierProvider provider,
  ) {
    return call(
      provider.userId,
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
  String? get name => r'followCountsNotifierProvider';
}

/// See also [FollowCountsNotifier].
class FollowCountsNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    FollowCountsNotifier, FollowCounts> {
  /// See also [FollowCountsNotifier].
  FollowCountsNotifierProvider(
    int userId,
  ) : this._internal(
          () => FollowCountsNotifier()..userId = userId,
          from: followCountsNotifierProvider,
          name: r'followCountsNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$followCountsNotifierHash,
          dependencies: FollowCountsNotifierFamily._dependencies,
          allTransitiveDependencies:
              FollowCountsNotifierFamily._allTransitiveDependencies,
          userId: userId,
        );

  FollowCountsNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final int userId;

  @override
  FutureOr<FollowCounts> runNotifierBuild(
    covariant FollowCountsNotifier notifier,
  ) {
    return notifier.build(
      userId,
    );
  }

  @override
  Override overrideWith(FollowCountsNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: FollowCountsNotifierProvider._internal(
        () => create()..userId = userId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<FollowCountsNotifier, FollowCounts>
      createElement() {
    return _FollowCountsNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FollowCountsNotifierProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FollowCountsNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<FollowCounts> {
  /// The parameter `userId` of this provider.
  int get userId;
}

class _FollowCountsNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<FollowCountsNotifier,
        FollowCounts> with FollowCountsNotifierRef {
  _FollowCountsNotifierProviderElement(super.provider);

  @override
  int get userId => (origin as FollowCountsNotifierProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
