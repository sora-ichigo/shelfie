// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_list_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$followListNotifierHash() =>
    r'b67f9153e7f58f8afdaf86126788b9dccff9a70e';

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

abstract class _$FollowListNotifier
    extends BuildlessAutoDisposeNotifier<AsyncValue<List<UserSummary>>> {
  late final int userId;
  late final FollowListType listType;

  AsyncValue<List<UserSummary>> build(
    int userId,
    FollowListType listType,
  );
}

/// See also [FollowListNotifier].
@ProviderFor(FollowListNotifier)
const followListNotifierProvider = FollowListNotifierFamily();

/// See also [FollowListNotifier].
class FollowListNotifierFamily extends Family<AsyncValue<List<UserSummary>>> {
  /// See also [FollowListNotifier].
  const FollowListNotifierFamily();

  /// See also [FollowListNotifier].
  FollowListNotifierProvider call(
    int userId,
    FollowListType listType,
  ) {
    return FollowListNotifierProvider(
      userId,
      listType,
    );
  }

  @override
  FollowListNotifierProvider getProviderOverride(
    covariant FollowListNotifierProvider provider,
  ) {
    return call(
      provider.userId,
      provider.listType,
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
  String? get name => r'followListNotifierProvider';
}

/// See also [FollowListNotifier].
class FollowListNotifierProvider extends AutoDisposeNotifierProviderImpl<
    FollowListNotifier, AsyncValue<List<UserSummary>>> {
  /// See also [FollowListNotifier].
  FollowListNotifierProvider(
    int userId,
    FollowListType listType,
  ) : this._internal(
          () => FollowListNotifier()
            ..userId = userId
            ..listType = listType,
          from: followListNotifierProvider,
          name: r'followListNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$followListNotifierHash,
          dependencies: FollowListNotifierFamily._dependencies,
          allTransitiveDependencies:
              FollowListNotifierFamily._allTransitiveDependencies,
          userId: userId,
          listType: listType,
        );

  FollowListNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
    required this.listType,
  }) : super.internal();

  final int userId;
  final FollowListType listType;

  @override
  AsyncValue<List<UserSummary>> runNotifierBuild(
    covariant FollowListNotifier notifier,
  ) {
    return notifier.build(
      userId,
      listType,
    );
  }

  @override
  Override overrideWith(FollowListNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: FollowListNotifierProvider._internal(
        () => create()
          ..userId = userId
          ..listType = listType,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
        listType: listType,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<FollowListNotifier,
      AsyncValue<List<UserSummary>>> createElement() {
    return _FollowListNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FollowListNotifierProvider &&
        other.userId == userId &&
        other.listType == listType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);
    hash = _SystemHash.combine(hash, listType.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FollowListNotifierRef
    on AutoDisposeNotifierProviderRef<AsyncValue<List<UserSummary>>> {
  /// The parameter `userId` of this provider.
  int get userId;

  /// The parameter `listType` of this provider.
  FollowListType get listType;
}

class _FollowListNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<FollowListNotifier,
        AsyncValue<List<UserSummary>>> with FollowListNotifierRef {
  _FollowListNotifierProviderElement(super.provider);

  @override
  int get userId => (origin as FollowListNotifierProvider).userId;
  @override
  FollowListType get listType =>
      (origin as FollowListNotifierProvider).listType;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
