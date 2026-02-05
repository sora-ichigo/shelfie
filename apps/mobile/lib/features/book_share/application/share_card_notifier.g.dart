// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_card_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$shareCardNotifierHash() => r'0d43484d7fed82a5db635edf96c0f6f5af1a0436';

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

abstract class _$ShareCardNotifier
    extends BuildlessAutoDisposeNotifier<ShareCardState> {
  late final String externalId;

  ShareCardState build(
    String externalId,
  );
}

/// See also [ShareCardNotifier].
@ProviderFor(ShareCardNotifier)
const shareCardNotifierProvider = ShareCardNotifierFamily();

/// See also [ShareCardNotifier].
class ShareCardNotifierFamily extends Family<ShareCardState> {
  /// See also [ShareCardNotifier].
  const ShareCardNotifierFamily();

  /// See also [ShareCardNotifier].
  ShareCardNotifierProvider call(
    String externalId,
  ) {
    return ShareCardNotifierProvider(
      externalId,
    );
  }

  @override
  ShareCardNotifierProvider getProviderOverride(
    covariant ShareCardNotifierProvider provider,
  ) {
    return call(
      provider.externalId,
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
  String? get name => r'shareCardNotifierProvider';
}

/// See also [ShareCardNotifier].
class ShareCardNotifierProvider
    extends AutoDisposeNotifierProviderImpl<ShareCardNotifier, ShareCardState> {
  /// See also [ShareCardNotifier].
  ShareCardNotifierProvider(
    String externalId,
  ) : this._internal(
          () => ShareCardNotifier()..externalId = externalId,
          from: shareCardNotifierProvider,
          name: r'shareCardNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$shareCardNotifierHash,
          dependencies: ShareCardNotifierFamily._dependencies,
          allTransitiveDependencies:
              ShareCardNotifierFamily._allTransitiveDependencies,
          externalId: externalId,
        );

  ShareCardNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.externalId,
  }) : super.internal();

  final String externalId;

  @override
  ShareCardState runNotifierBuild(
    covariant ShareCardNotifier notifier,
  ) {
    return notifier.build(
      externalId,
    );
  }

  @override
  Override overrideWith(ShareCardNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ShareCardNotifierProvider._internal(
        () => create()..externalId = externalId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        externalId: externalId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ShareCardNotifier, ShareCardState>
      createElement() {
    return _ShareCardNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ShareCardNotifierProvider && other.externalId == externalId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, externalId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ShareCardNotifierRef on AutoDisposeNotifierProviderRef<ShareCardState> {
  /// The parameter `externalId` of this provider.
  String get externalId;
}

class _ShareCardNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<ShareCardNotifier,
        ShareCardState> with ShareCardNotifierRef {
  _ShareCardNotifierProviderElement(super.provider);

  @override
  String get externalId => (origin as ShareCardNotifierProvider).externalId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
