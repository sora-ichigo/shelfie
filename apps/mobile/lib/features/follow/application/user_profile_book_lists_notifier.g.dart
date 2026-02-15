// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_book_lists_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userProfileBookListsNotifierHash() =>
    r'7f195b73caa0ed43560c04b43615e6024c9bd2b8';

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

abstract class _$UserProfileBookListsNotifier
    extends BuildlessAutoDisposeNotifier<UserProfileBookListsState> {
  late final int userId;

  UserProfileBookListsState build(
    int userId,
  );
}

/// See also [UserProfileBookListsNotifier].
@ProviderFor(UserProfileBookListsNotifier)
const userProfileBookListsNotifierProvider =
    UserProfileBookListsNotifierFamily();

/// See also [UserProfileBookListsNotifier].
class UserProfileBookListsNotifierFamily
    extends Family<UserProfileBookListsState> {
  /// See also [UserProfileBookListsNotifier].
  const UserProfileBookListsNotifierFamily();

  /// See also [UserProfileBookListsNotifier].
  UserProfileBookListsNotifierProvider call(
    int userId,
  ) {
    return UserProfileBookListsNotifierProvider(
      userId,
    );
  }

  @override
  UserProfileBookListsNotifierProvider getProviderOverride(
    covariant UserProfileBookListsNotifierProvider provider,
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
  String? get name => r'userProfileBookListsNotifierProvider';
}

/// See also [UserProfileBookListsNotifier].
class UserProfileBookListsNotifierProvider
    extends AutoDisposeNotifierProviderImpl<UserProfileBookListsNotifier,
        UserProfileBookListsState> {
  /// See also [UserProfileBookListsNotifier].
  UserProfileBookListsNotifierProvider(
    int userId,
  ) : this._internal(
          () => UserProfileBookListsNotifier()..userId = userId,
          from: userProfileBookListsNotifierProvider,
          name: r'userProfileBookListsNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userProfileBookListsNotifierHash,
          dependencies: UserProfileBookListsNotifierFamily._dependencies,
          allTransitiveDependencies:
              UserProfileBookListsNotifierFamily._allTransitiveDependencies,
          userId: userId,
        );

  UserProfileBookListsNotifierProvider._internal(
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
  UserProfileBookListsState runNotifierBuild(
    covariant UserProfileBookListsNotifier notifier,
  ) {
    return notifier.build(
      userId,
    );
  }

  @override
  Override overrideWith(UserProfileBookListsNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: UserProfileBookListsNotifierProvider._internal(
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
  AutoDisposeNotifierProviderElement<UserProfileBookListsNotifier,
      UserProfileBookListsState> createElement() {
    return _UserProfileBookListsNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserProfileBookListsNotifierProvider &&
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
mixin UserProfileBookListsNotifierRef
    on AutoDisposeNotifierProviderRef<UserProfileBookListsState> {
  /// The parameter `userId` of this provider.
  int get userId;
}

class _UserProfileBookListsNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<UserProfileBookListsNotifier,
        UserProfileBookListsState> with UserProfileBookListsNotifierRef {
  _UserProfileBookListsNotifierProviderElement(super.provider);

  @override
  int get userId => (origin as UserProfileBookListsNotifierProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
