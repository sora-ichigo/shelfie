// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_detail_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bookDetailNotifierHash() =>
    r'fa025f9f5c45f83dac1f617764ed608eabe56dcc';

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

abstract class _$BookDetailNotifier
    extends BuildlessAutoDisposeAsyncNotifier<BookDetail?> {
  late final String externalId;

  FutureOr<BookDetail?> build(
    String externalId,
  );
}

/// See also [BookDetailNotifier].
@ProviderFor(BookDetailNotifier)
const bookDetailNotifierProvider = BookDetailNotifierFamily();

/// See also [BookDetailNotifier].
class BookDetailNotifierFamily extends Family<AsyncValue<BookDetail?>> {
  /// See also [BookDetailNotifier].
  const BookDetailNotifierFamily();

  /// See also [BookDetailNotifier].
  BookDetailNotifierProvider call(
    String externalId,
  ) {
    return BookDetailNotifierProvider(
      externalId,
    );
  }

  @override
  BookDetailNotifierProvider getProviderOverride(
    covariant BookDetailNotifierProvider provider,
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
  String? get name => r'bookDetailNotifierProvider';
}

/// See also [BookDetailNotifier].
class BookDetailNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    BookDetailNotifier, BookDetail?> {
  /// See also [BookDetailNotifier].
  BookDetailNotifierProvider(
    String externalId,
  ) : this._internal(
          () => BookDetailNotifier()..externalId = externalId,
          from: bookDetailNotifierProvider,
          name: r'bookDetailNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$bookDetailNotifierHash,
          dependencies: BookDetailNotifierFamily._dependencies,
          allTransitiveDependencies:
              BookDetailNotifierFamily._allTransitiveDependencies,
          externalId: externalId,
        );

  BookDetailNotifierProvider._internal(
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
  FutureOr<BookDetail?> runNotifierBuild(
    covariant BookDetailNotifier notifier,
  ) {
    return notifier.build(
      externalId,
    );
  }

  @override
  Override overrideWith(BookDetailNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: BookDetailNotifierProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<BookDetailNotifier, BookDetail?>
      createElement() {
    return _BookDetailNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BookDetailNotifierProvider &&
        other.externalId == externalId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, externalId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin BookDetailNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<BookDetail?> {
  /// The parameter `externalId` of this provider.
  String get externalId;
}

class _BookDetailNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<BookDetailNotifier,
        BookDetail?> with BookDetailNotifierRef {
  _BookDetailNotifierProviderElement(super.provider);

  @override
  String get externalId => (origin as BookDetailNotifierProvider).externalId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
