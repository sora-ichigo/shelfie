// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_sort_option_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userProfileSortOptionNotifierHash() =>
    r'd3415b19ce70a0aaf70415cee116c868d38d8b04';

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

abstract class _$UserProfileSortOptionNotifier
    extends BuildlessAutoDisposeNotifier<SortOption> {
  late final int userId;

  SortOption build(
    int userId,
  );
}

/// See also [UserProfileSortOptionNotifier].
@ProviderFor(UserProfileSortOptionNotifier)
const userProfileSortOptionNotifierProvider =
    UserProfileSortOptionNotifierFamily();

/// See also [UserProfileSortOptionNotifier].
class UserProfileSortOptionNotifierFamily extends Family<SortOption> {
  /// See also [UserProfileSortOptionNotifier].
  const UserProfileSortOptionNotifierFamily();

  /// See also [UserProfileSortOptionNotifier].
  UserProfileSortOptionNotifierProvider call(
    int userId,
  ) {
    return UserProfileSortOptionNotifierProvider(
      userId,
    );
  }

  @override
  UserProfileSortOptionNotifierProvider getProviderOverride(
    covariant UserProfileSortOptionNotifierProvider provider,
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
  String? get name => r'userProfileSortOptionNotifierProvider';
}

/// See also [UserProfileSortOptionNotifier].
class UserProfileSortOptionNotifierProvider
    extends AutoDisposeNotifierProviderImpl<UserProfileSortOptionNotifier,
        SortOption> {
  /// See also [UserProfileSortOptionNotifier].
  UserProfileSortOptionNotifierProvider(
    int userId,
  ) : this._internal(
          () => UserProfileSortOptionNotifier()..userId = userId,
          from: userProfileSortOptionNotifierProvider,
          name: r'userProfileSortOptionNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userProfileSortOptionNotifierHash,
          dependencies: UserProfileSortOptionNotifierFamily._dependencies,
          allTransitiveDependencies:
              UserProfileSortOptionNotifierFamily._allTransitiveDependencies,
          userId: userId,
        );

  UserProfileSortOptionNotifierProvider._internal(
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
  SortOption runNotifierBuild(
    covariant UserProfileSortOptionNotifier notifier,
  ) {
    return notifier.build(
      userId,
    );
  }

  @override
  Override overrideWith(UserProfileSortOptionNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: UserProfileSortOptionNotifierProvider._internal(
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
  AutoDisposeNotifierProviderElement<UserProfileSortOptionNotifier, SortOption>
      createElement() {
    return _UserProfileSortOptionNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserProfileSortOptionNotifierProvider &&
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
mixin UserProfileSortOptionNotifierRef
    on AutoDisposeNotifierProviderRef<SortOption> {
  /// The parameter `userId` of this provider.
  int get userId;
}

class _UserProfileSortOptionNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<UserProfileSortOptionNotifier,
        SortOption> with UserProfileSortOptionNotifierRef {
  _UserProfileSortOptionNotifierProviderElement(super.provider);

  @override
  int get userId => (origin as UserProfileSortOptionNotifierProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
