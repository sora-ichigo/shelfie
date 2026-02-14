// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shelf_search_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$shelfSearchNotifierHash() =>
    r'20ea482d2229ddfc45fbd3722ac5d10318993c00';

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

abstract class _$ShelfSearchNotifier
    extends BuildlessAutoDisposeNotifier<ShelfSearchState> {
  late final int? userId;

  ShelfSearchState build({
    int? userId,
  });
}

/// See also [ShelfSearchNotifier].
@ProviderFor(ShelfSearchNotifier)
const shelfSearchNotifierProvider = ShelfSearchNotifierFamily();

/// See also [ShelfSearchNotifier].
class ShelfSearchNotifierFamily extends Family<ShelfSearchState> {
  /// See also [ShelfSearchNotifier].
  const ShelfSearchNotifierFamily();

  /// See also [ShelfSearchNotifier].
  ShelfSearchNotifierProvider call({
    int? userId,
  }) {
    return ShelfSearchNotifierProvider(
      userId: userId,
    );
  }

  @override
  ShelfSearchNotifierProvider getProviderOverride(
    covariant ShelfSearchNotifierProvider provider,
  ) {
    return call(
      userId: provider.userId,
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
  String? get name => r'shelfSearchNotifierProvider';
}

/// See also [ShelfSearchNotifier].
class ShelfSearchNotifierProvider extends AutoDisposeNotifierProviderImpl<
    ShelfSearchNotifier, ShelfSearchState> {
  /// See also [ShelfSearchNotifier].
  ShelfSearchNotifierProvider({
    int? userId,
  }) : this._internal(
          () => ShelfSearchNotifier()..userId = userId,
          from: shelfSearchNotifierProvider,
          name: r'shelfSearchNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$shelfSearchNotifierHash,
          dependencies: ShelfSearchNotifierFamily._dependencies,
          allTransitiveDependencies:
              ShelfSearchNotifierFamily._allTransitiveDependencies,
          userId: userId,
        );

  ShelfSearchNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final int? userId;

  @override
  ShelfSearchState runNotifierBuild(
    covariant ShelfSearchNotifier notifier,
  ) {
    return notifier.build(
      userId: userId,
    );
  }

  @override
  Override overrideWith(ShelfSearchNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ShelfSearchNotifierProvider._internal(
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
  AutoDisposeNotifierProviderElement<ShelfSearchNotifier, ShelfSearchState>
      createElement() {
    return _ShelfSearchNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ShelfSearchNotifierProvider && other.userId == userId;
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
mixin ShelfSearchNotifierRef
    on AutoDisposeNotifierProviderRef<ShelfSearchState> {
  /// The parameter `userId` of this provider.
  int? get userId;
}

class _ShelfSearchNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<ShelfSearchNotifier,
        ShelfSearchState> with ShelfSearchNotifierRef {
  _ShelfSearchNotifierProviderElement(super.provider);

  @override
  int? get userId => (origin as ShelfSearchNotifierProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
