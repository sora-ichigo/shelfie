import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidDirectColors extends DartLintRule {
  const AvoidDirectColors() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_direct_colors',
    problemMessage:
        'AppColors のセマンティックカラーを使用してください。'
        '直接的な色参照（Colors.*, colorScheme.*, Color(0x...)）は禁止されています。',
  );

  static const _allowedColorNames = {'transparent'};

  static const _excludedPathSegments = [
    '/core/theme/',
    '/test/',
    '/gradient_color_matcher.dart',
    '/reading_status_color.dart',
    '/book_list_edit_screen.dart',
  ];

  static const _generatedExtensions = [
    '.g.dart',
    '.freezed.dart',
    '.gql.dart',
  ];

  bool _isExcluded(String path) {
    for (final segment in _excludedPathSegments) {
      if (path.contains(segment)) return true;
    }
    for (final ext in _generatedExtensions) {
      if (path.endsWith(ext)) return true;
    }
    return false;
  }

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    final path = resolver.path;
    if (_isExcluded(path)) return;

    // Colors.* (e.g. Colors.white, Colors.black54)
    context.registry.addPrefixedIdentifier((node) {
      if (node.prefix.name != 'Colors') return;
      if (_allowedColorNames.contains(node.identifier.name)) return;
      reporter.atNode(node, code);
    });

    // colorScheme.* (e.g. theme.colorScheme.onSurfaceVariant)
    context.registry.addPropertyAccess((node) {
      final target = node.target;
      if (target == null) return;
      final targetStr = target.toSource();
      if (!targetStr.endsWith('colorScheme')) return;
      reporter.atNode(node, code);
    });

    // Color(0x...) constructor
    context.registry.addInstanceCreationExpression((node) {
      final typeName = node.constructorName.type.name2.lexeme;
      if (typeName != 'Color') return;
      reporter.atNode(node, code);
    });
  }
}
