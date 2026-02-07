import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:shelfie_lints/src/lints/avoid_direct_colors.dart';

PluginBase createPlugin() => _ShelfieLints();

class _ShelfieLints extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
        const AvoidDirectColors(),
      ];
}
