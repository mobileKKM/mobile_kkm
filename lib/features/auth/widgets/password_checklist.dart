import 'package:flutter/material.dart';
import 'package:mobile_kkm/features/auth/models/password_rule.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// Live checklist of the server's password policy.
class PasswordChecklist extends StatelessWidget {
  const PasswordChecklist({super.key, required this.rules, required this.password});

  final List<PasswordRule> rules;
  final String password;

  @override
  Widget build(BuildContext context) {
    if (rules.isEmpty) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final rule in rules)
          Builder(
            builder: (context) {
              final met = rule.isSatisfiedBy(password);
              final color = met ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    Icon(met ? Icons.check_circle : Icons.radio_button_unchecked, size: 16, color: color),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(_label(l10n, rule), style: theme.textTheme.bodySmall?.copyWith(color: color)),
                    ),
                  ],
                ),
              );
            },
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
