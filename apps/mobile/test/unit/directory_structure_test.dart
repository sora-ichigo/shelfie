import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Feature-first Directory Structure', () {
    final libPath = Directory('lib');

    group('lib/app/ directory', () {
      test('app directory exists', () {
        final appDir = Directory('${libPath.path}/app');
        expect(appDir.existsSync(), isTrue);
      });

      test('app.dart file exists', () {
        final appFile = File('${libPath.path}/app/app.dart');
        expect(appFile.existsSync(), isTrue);
      });

      test('providers.dart file exists', () {
        final providersFile = File('${libPath.path}/app/providers.dart');
        expect(providersFile.existsSync(), isTrue);
      });
    });

    group('lib/core/ directory', () {
      test('core directory exists', () {
        final coreDir = Directory('${libPath.path}/core');
        expect(coreDir.existsSync(), isTrue);
      });

      test('error subdirectory exists', () {
        final errorDir = Directory('${libPath.path}/core/error');
        expect(errorDir.existsSync(), isTrue);
      });

      test('network subdirectory exists', () {
        final networkDir = Directory('${libPath.path}/core/network');
        expect(networkDir.existsSync(), isTrue);
      });

      test('theme subdirectory exists', () {
        final themeDir = Directory('${libPath.path}/core/theme');
        expect(themeDir.existsSync(), isTrue);
      });

      test('widgets subdirectory exists', () {
        final widgetsDir = Directory('${libPath.path}/core/widgets');
        expect(widgetsDir.existsSync(), isTrue);
      });

      test('utils subdirectory exists', () {
        final utilsDir = Directory('${libPath.path}/core/utils');
        expect(utilsDir.existsSync(), isTrue);
      });

      test('utils/extensions subdirectory exists', () {
        final extensionsDir =
            Directory('${libPath.path}/core/utils/extensions');
        expect(extensionsDir.existsSync(), isTrue);
      });

      test('utils/helpers subdirectory exists', () {
        final helpersDir = Directory('${libPath.path}/core/utils/helpers');
        expect(helpersDir.existsSync(), isTrue);
      });
    });

    group('lib/routing/ directory', () {
      test('routing directory exists', () {
        final routingDir = Directory('${libPath.path}/routing');
        expect(routingDir.existsSync(), isTrue);
      });

      test('app_router.dart file exists', () {
        final routerFile = File('${libPath.path}/routing/app_router.dart');
        expect(routerFile.existsSync(), isTrue);
      });

      test('route_guards.dart file exists', () {
        final guardsFile = File('${libPath.path}/routing/route_guards.dart');
        expect(guardsFile.existsSync(), isTrue);
      });
    });

    group('lib/features/ directory', () {
      test('features directory exists', () {
        final featuresDir = Directory('${libPath.path}/features');
        expect(featuresDir.existsSync(), isTrue);
      });

      group('feature template structure', () {
        final exampleFeature = '${libPath.path}/features/example';

        test('example feature directory exists', () {
          final featureDir = Directory(exampleFeature);
          expect(featureDir.existsSync(), isTrue);
        });

        test('presentation layer exists', () {
          final presentationDir = Directory('$exampleFeature/presentation');
          expect(presentationDir.existsSync(), isTrue);
        });

        test('presentation/screens exists', () {
          final screensDir =
              Directory('$exampleFeature/presentation/screens');
          expect(screensDir.existsSync(), isTrue);
        });

        test('presentation/widgets exists', () {
          final widgetsDir =
              Directory('$exampleFeature/presentation/widgets');
          expect(widgetsDir.existsSync(), isTrue);
        });

        test('presentation/providers exists', () {
          final providersDir =
              Directory('$exampleFeature/presentation/providers');
          expect(providersDir.existsSync(), isTrue);
        });

        test('application layer exists', () {
          final applicationDir = Directory('$exampleFeature/application');
          expect(applicationDir.existsSync(), isTrue);
        });

        test('application/use_cases exists', () {
          final useCasesDir =
              Directory('$exampleFeature/application/use_cases');
          expect(useCasesDir.existsSync(), isTrue);
        });

        test('application/services exists', () {
          final servicesDir =
              Directory('$exampleFeature/application/services');
          expect(servicesDir.existsSync(), isTrue);
        });

        test('domain layer exists', () {
          final domainDir = Directory('$exampleFeature/domain');
          expect(domainDir.existsSync(), isTrue);
        });

        test('domain/models exists', () {
          final modelsDir = Directory('$exampleFeature/domain/models');
          expect(modelsDir.existsSync(), isTrue);
        });

        test('domain/entities exists', () {
          final entitiesDir = Directory('$exampleFeature/domain/entities');
          expect(entitiesDir.existsSync(), isTrue);
        });

        test('domain/repositories exists', () {
          final reposDir = Directory('$exampleFeature/domain/repositories');
          expect(reposDir.existsSync(), isTrue);
        });

        test('infrastructure layer exists', () {
          final infraDir = Directory('$exampleFeature/infrastructure');
          expect(infraDir.existsSync(), isTrue);
        });

        test('infrastructure/repositories exists', () {
          final reposDir =
              Directory('$exampleFeature/infrastructure/repositories');
          expect(reposDir.existsSync(), isTrue);
        });

        test('infrastructure/data_sources exists', () {
          final dataSourcesDir =
              Directory('$exampleFeature/infrastructure/data_sources');
          expect(dataSourcesDir.existsSync(), isTrue);
        });

        test('infrastructure/dtos exists', () {
          final dtosDir = Directory('$exampleFeature/infrastructure/dtos');
          expect(dtosDir.existsSync(), isTrue);
        });
      });
    });

    group('test/ directory structure', () {
      final testPath = Directory('test');

      test('unit test directory exists', () {
        final unitDir = Directory('${testPath.path}/unit');
        expect(unitDir.existsSync(), isTrue);
      });

      test('widget test directory exists', () {
        final widgetDir = Directory('${testPath.path}/widget');
        expect(widgetDir.existsSync(), isTrue);
      });

      test('integration test directory exists', () {
        final integrationDir = Directory('${testPath.path}/integration');
        expect(integrationDir.existsSync(), isTrue);
      });
    });
  });
}
