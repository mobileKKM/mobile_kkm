import 'package:mobile_kkm/features/auth/models/password_rule.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

final _emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

String? validateRequired(AppLocalizations l10n, String? value) =>
    (value == null || value.trim().isEmpty) ? l10n.fieldRequired : null;

String? validateEmail(AppLocalizations l10n, String? value) {
  final email = value?.trim() ?? '';
  if (email.isEmpty) return l10n.fieldRequired;
  return _emailPattern.hasMatch(email) ? null : l10n.emailInvalid;
}

String? validateNewPassword(AppLocalizations l10n, List<PasswordRule> rules, String? value) {
  final password = value ?? '';
  if (password.isEmpty) return l10n.fieldRequired;
  return rules.every((rule) => rule.isSatisfiedBy(password)) ? null : l10n.passwordTooWeak;
}
