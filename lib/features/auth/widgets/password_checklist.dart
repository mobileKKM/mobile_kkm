import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/features/auth/models/password_rule.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// Live checklist of the server's password policy, two rules to a row.
class PasswordChecklist extends StatelessWidget {
  const PasswordChecklist({super.key, required this.rules, required this.password});

  final List<PasswordRule> rules;
  final String password;

  @override
  Widget build(BuildContext context) {
    if (rules.isEmpty) {
      return const SizedBox.shrink();
    }
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    Widget item(PasswordRule rule) {
      final met = rule.isSatisfiedBy(password);
      final color = met ? scheme.primary : scheme.onSurfaceVariant;
      return Container(
        constraints: const BoxConstraints(minHeight: 24),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Row(
          children: [
            // Ticked as well as coloured: never the colour alone.
            Icon(
              met ? Symbols.check_circle_rounded : Symbols.radio_button_unchecked_rounded,
              size: 18,
              color: color,
              fill: met ? 1 : 0,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                _label(l10n, rule),
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 13,
                  height: 18 / 13,
                  fontWeight: met ? FontWeight.w600 : FontWeight.w500,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      spacing: 6,
      children: [
        for (var row = 0; row < rules.length; row += 2)
          Row(
            spacing: 6,
            children: [
              Expanded(child: item(rules[row])),
              Expanded(child: row + 1 < rules.length ? item(rules[row + 1]) : const SizedBox.shrink()),
            ],
          ),
      ],
    );
  }

  static String _label(AppLocalizations l10n, PasswordRule rule) => switch (rule.kind) {
    PasswordRuleKind.minLength => l10n.passwordRuleMinLength(rule.count),
    PasswordRuleKind.lowercase => l10n.passwordRuleLowercase(rule.count),
    PasswordRuleKind.uppercase => l10n.passwordRuleUppercase(rule.count),
    PasswordRuleKind.digits => l10n.passwordRuleDigits(rule.count),
  };
}
