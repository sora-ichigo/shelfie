// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_reading_status_counts_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userReadingStatusCountsNotifierHash() =>
    r'59872bd298d3f2ed4aa63230d52dd500459154e2';

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

abstract class _$UserReadingStatusCountsNotifier
    extends BuildlessAutoDisposeNotifier<Map<ReadingStatus, int>> {
  late final int userId;

  Map<ReadingStatus, int> build(
    int userId,
  );
}

/// See also [UserReadingStatusCountsNotifier].
@ProviderFor(UserReadingStatusCountsNotifier)
const userReadingStatusCountsNotifierProvider =
    UserReadingStatusCountsNotifierFamily();

/// See also [UserReadingStatusCountsNotifier].
class UserReadingStatusCountsNotifierFamily
    extends Family<Map<ReadingStatus, int>> {
  /// See also [UserReadingStatusCountsNotifier].
  const UserReadingStatusCountsNotifierFamily();

  /// See also [UserReadingStatusCountsNotifier].
  UserReadingStatusCountsNotifierProvider call(
    int userId,
  ) {
    return UserReadingStatusCountsNotifierProvider(
      userId,
    );
  }

  @override
  UserReadingStatusCountsNotifierProvider getProviderOverride(
    covariant UserReadingStatusCountsNotifierProvider provider,
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
  String? get name => r'userReadingStatusCountsNotifierProvider';
}

/// See also [UserReadingStatusCountsNotifier].
class UserReadingStatusCountsNotifierProvider
    extends AutoDisposeNotifierProviderImpl<UserReadingStatusCountsNotifier,
        Map<ReadingStatus, int>> {
  /// See also [UserReadingStatusCountsNotifier].
  UserReadingStatusCountsNotifierProvider(
    int userId,
  ) : this._internal(
          () => UserReadingStatusCountsNotifier()..userId = userId,
          from: userReadingStatusCountsNotifierProvider,
          name: r'userReadingStatusCountsNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userReadingStatusCountsNotifierHash,
          dependencies: UserReadingStatusCountsNotifierFamily._dependencies,
          allTransitiveDependencies:
              UserReadingStatusCountsNotifierFamily._allTransitiveDependencies,
          userId: userId,
        );

  UserReadingStatusCountsNotifierProvider._internal(
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
  Map<ReadingStatus, int> runNotifierBuild(
    covariant UserReadingStatusCountsNotifier notifier,
  ) {
    return notifier.build(
      userId,
    );
  }

  @override
  Override overrideWith(UserReadingStatusCountsNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: UserReadingStatusCountsNotifierProvider._internal(
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
  AutoDisposeNotifierProviderElement<UserReadingStatusCountsNotifier,
      Map<ReadingStatus, int>> createElement() {
    return _UserReadingStatusCountsNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserReadingStatusCountsNotifierProvider &&
        other.userId == userId;
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
mixin UserReadingStatusCountsNotifierRef
    on AutoDisposeNotifierProviderRef<Map<ReadingStatus, int>> {
  /// The parameter `userId` of this provider.
  int get userId;
}

class _UserReadingStatusCountsNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<UserReadingStatusCountsNotifier,
        Map<ReadingStatus, int>> with UserReadingStatusCountsNotifierRef {
  _UserReadingStatusCountsNotifierProviderElement(super.provider);

  @override
  int get userId => (origin as UserReadingStatusCountsNotifierProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
