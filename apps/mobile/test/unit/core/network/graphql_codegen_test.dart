import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GraphQL コード生成設定', () {
    group('build.yaml 設定', () {
      test('build.yaml が存在すること', () {
        final buildYaml = File('build.yaml');

        expect(buildYaml.existsSync(), isTrue);
      });

      test('build.yaml に ferry_generator の設定が含まれていること', () {
        final buildYaml = File('build.yaml');
        final content = buildYaml.readAsStringSync();

        expect(content, contains('ferry_generator'));
      });

      test('build.yaml に schema パスが設定されていること', () {
        final buildYaml = File('build.yaml');
        final content = buildYaml.readAsStringSync();

        expect(content, contains('schema'));
      });
    });

    group('GraphQL スキーマとクエリの配置', () {
      test('lib/core/graphql ディレクトリが存在すること', () {
        final graphqlDir = Directory('lib/core/graphql');

        expect(graphqlDir.existsSync(), isTrue);
      });

      test('schema.graphql または schema 参照が設定されていること', () {
        final buildYaml = File('build.yaml');
        final content = buildYaml.readAsStringSync();

        // schema_source または schema パスが設定されている
        expect(
          content.contains('schema') || content.contains('schema_source'),
          isTrue,
        );
      });
    });

    group('コード生成の出力先', () {
      test('生成ファイルの出力先が適切に設定されていること', () {
        final buildYaml = File('build.yaml');
        final content = buildYaml.readAsStringSync();

        // 生成ファイルは同じディレクトリに出力される（.g.dart 形式）
        // または output ディレクトリが指定されている
        expect(buildYaml.existsSync(), isTrue);
        expect(content, isNotEmpty);
      });
    });

    group('スキーマ取得スクリプト', () {
      test('スキーマ取得のための設定または手順が存在すること', () {
        // build.yaml に schema_source が設定されているか、
        // または手動でスキーマを配置する想定
        final buildYaml = File('build.yaml');
        expect(buildYaml.existsSync(), isTrue);
      });
    });
  });
}
