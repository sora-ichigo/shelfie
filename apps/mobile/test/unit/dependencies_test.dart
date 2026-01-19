// Task 1.1: Dependencies verification tests
// These tests verify that all required packages are properly installed
// and importable.

import 'package:ferry/ferry.dart';
import 'package:ferry_flutter/ferry_flutter.dart';
import 'package:ferry_hive_store/ferry_hive_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

void main() {
  group('Task 1.1: Dependencies verification', () {
    test('flutter_riverpod is available', () {
      expect(ProviderScope, isNotNull);
    });

    test('riverpod_annotation is available', () {
      expect(Riverpod, isNotNull);
    });

    test('freezed_annotation is available', () {
      expect(freezed, isNotNull);
    });

    test('json_annotation is available (via freezed_annotation)', () {
      expect(JsonSerializable, isNotNull);
    });

    test('go_router is available', () {
      expect(GoRouter, isNotNull);
    });

    test('ferry is available', () {
      expect(Client, isNotNull);
    });

    test('ferry_flutter is available', () {
      expect(Operation, isNotNull);
    });

    test('gql_http_link is available', () {
      expect(HttpLink, isNotNull);
    });

    test('ferry_hive_store is available', () {
      expect(HiveStore, isNotNull);
    });

    test('hive_flutter is available', () {
      expect(Hive, isNotNull);
    });

    test('fpdart is available', () {
      expect(Either, isNotNull);
      expect(Option, isNotNull);
    });

    test('mocktail is available', () {
      expect(Mock, isNotNull);
    });
  });

  group('Task 1.1: Either type functionality', () {
    test('Either.right creates success value', () {
      final result = Either<String, int>.right(42);
      expect(result.isRight(), isTrue);
      expect(result.getOrElse((l) => 0), equals(42));
    });

    test('Either.left creates failure value', () {
      final result = Either<String, int>.left('error');
      expect(result.isLeft(), isTrue);
    });
  });

  group('Task 1.1: Option type functionality', () {
    test('Option.some creates value', () {
      const result = Option.of(42);
      expect(result.isSome(), isTrue);
      expect(result.getOrElse(() => 0), equals(42));
    });

    test('Option.none creates empty', () {
      const result = Option<int>.none();
      expect(result.isNone(), isTrue);
    });
  });
}
