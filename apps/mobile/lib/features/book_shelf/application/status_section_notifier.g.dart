// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_section_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$statusSectionNotifierHash() =>
    r'44ed224ad5f83aa8c13da7632cab9872422525b0';

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

abstract class _$StatusSectionNotifier
    extends BuildlessAutoDisposeNotifier<StatusSectionState> {
  late final ReadingStatus status;

  StatusSectionState build(ReadingStatus status);
}

/// See also [StatusSectionNotifier].
@ProviderFor(StatusSectionNotifier)
const statusSectionNotifierProvider = StatusSectionNotifierFamily();

/// See also [StatusSectionNotifier].
class StatusSectionNotifierFamily extends Family<StatusSectionState> {
  /// See also [StatusSectionNotifier].
  const StatusSectionNotifierFamily();

  /// See also [StatusSectionNotifier].
  StatusSectionNotifierProvider call(ReadingStatus status) {
    return StatusSectionNotifierProvider(status);
  }

  @override
  StatusSectionNotifierProvider getProviderOverride(
    covariant StatusSectionNotifierProvider provider,
  ) {
    return call(provider.status);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'statusSectionNotifierProvider';
}

/// See also [StatusSectionNotifier].
class StatusSectionNotifierProvider
    extends
        AutoDisposeNotifierProviderImpl<
          StatusSectionNotifier,
          StatusSectionState
        > {
  /// See also [StatusSectionNotifier].
  StatusSectionNotifierProvider(ReadingStatus status)
    : this._internal(
        () => StatusSectionNotifier()..status = status,
        from: statusSectionNotifierProvider,
        name: r'statusSectionNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$statusSectionNotifierHash,
        dependencies: StatusSectionNotifierFamily._dependencies,
        allTransitiveDependencies:
            StatusSectionNotifierFamily._allTransitiveDependencies,
        status: status,
      );

  StatusSectionNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.status,
  }) : super.internal();

  final ReadingStatus status;

  @override
  StatusSectionState runNotifierBuild(
    covariant StatusSectionNotifier notifier,
  ) {
    return notifier.build(status);
  }

  @override
  Override overrideWith(StatusSectionNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: StatusSectionNotifierProvider._internal(
        () => create()..status = status,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        status: status,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<StatusSectionNotifier, StatusSectionState>
  createElement() {
    return _StatusSectionNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StatusSectionNotifierProvider && other.status == status;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, status.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin StatusSectionNotifierRef
    on AutoDisposeNotifierProviderRef<StatusSectionState> {
  /// The parameter `status` of this provider.
  ReadingStatus get status;
}

class _StatusSectionNotifierProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          StatusSectionNotifier,
          StatusSectionState
        >
    with StatusSectionNotifierRef {
  _StatusSectionNotifierProviderElement(super.provider);

  @override
  ReadingStatus get status => (origin as StatusSectionNotifierProvider).status;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
