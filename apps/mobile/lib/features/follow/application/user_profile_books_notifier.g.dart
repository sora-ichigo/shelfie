// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_books_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userProfileBooksNotifierHash() =>
    r'6a95049dea84f17d8c61881e9dd552af1e32674f';

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

abstract class _$UserProfileBooksNotifier
    extends BuildlessAutoDisposeNotifier<UserProfileBooksState> {
  late final int userId;

  UserProfileBooksState build(
    int userId,
  );
}

/// See also [UserProfileBooksNotifier].
@ProviderFor(UserProfileBooksNotifier)
const userProfileBooksNotifierProvider = UserProfileBooksNotifierFamily();

/// See also [UserProfileBooksNotifier].
class UserProfileBooksNotifierFamily extends Family<UserProfileBooksState> {
  /// See also [UserProfileBooksNotifier].
  const UserProfileBooksNotifierFamily();

  /// See also [UserProfileBooksNotifier].
  UserProfileBooksNotifierProvider call(
    int userId,
  ) {
    return UserProfileBooksNotifierProvider(
      userId,
    );
  }

  @override
  UserProfileBooksNotifierProvider getProviderOverride(
    covariant UserProfileBooksNotifierProvider provider,
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
  String? get name => r'userProfileBooksNotifierProvider';
}

/// See also [UserProfileBooksNotifier].
class UserProfileBooksNotifierProvider extends AutoDisposeNotifierProviderImpl<
    UserProfileBooksNotifier, UserProfileBooksState> {
  /// See also [UserProfileBooksNotifier].
  UserProfileBooksNotifierProvider(
    int userId,
  ) : this._internal(
          () => UserProfileBooksNotifier()..userId = userId,
          from: userProfileBooksNotifierProvider,
          name: r'userProfileBooksNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userProfileBooksNotifierHash,
          dependencies: UserProfileBooksNotifierFamily._dependencies,
          allTransitiveDependencies:
              UserProfileBooksNotifierFamily._allTransitiveDependencies,
          userId: userId,
        );

  UserProfileBooksNotifierProvider._internal(
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
  UserProfileBooksState runNotifierBuild(
    covariant UserProfileBooksNotifier notifier,
  ) {
    return notifier.build(
      userId,
    );
  }

  @override
  Override overrideWith(UserProfileBooksNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: UserProfileBooksNotifierProvider._internal(
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
  AutoDisposeNotifierProviderElement<UserProfileBooksNotifier,
      UserProfileBooksState> createElement() {
    return _UserProfileBooksNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserProfileBooksNotifierProvider && other.userId == userId;
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
mixin UserProfileBooksNotifierRef
    on AutoDisposeNotifierProviderRef<UserProfileBooksState> {
  /// The parameter `userId` of this provider.
  int get userId;
}

class _UserProfileBooksNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<UserProfileBooksNotifier,
        UserProfileBooksState> with UserProfileBooksNotifierRef {
  _UserProfileBooksNotifierProviderElement(super.provider);

  @override
  int get userId => (origin as UserProfileBooksNotifierProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
