import 'package:ekp_api/ekp_api.dart';

enum PasswordRuleKind { minLength, lowercase, uppercase, digits }

/// One requirement of the server's password policy.
class PasswordRule {
  const PasswordRule(this.kind, this.count);

  final PasswordRuleKind kind;
  final int count;

  bool isSatisfiedBy(String password) {
    final chars = password.runes.map(String.fromCharCode);
    final actual = switch (kind) {
      PasswordRuleKind.minLength => password.runes.length,
      // Case-mapping instead of [a-z] so Polish letters count too.
      PasswordRuleKind.lowercase =>
        chars.where((c) => c != c.toUpperCase()).length,
      PasswordRuleKind.uppercase =>
        chars.where((c) => c != c.toLowerCase()).length,
      PasswordRuleKind.digits =>
        chars.where((c) => RegExp(r'^\d$').hasMatch(c)).length,
    };
    return actual >= count;
  }
}

/// The rules of [policy] that actually require something.
List<PasswordRule> passwordRulesFor(PasswordPolicy? policy) {
  if (policy == null) return const [];
  return [
    for (final (kind, count) in [
      (PasswordRuleKind.minLength, policy.minLength),
      (PasswordRuleKind.lowercase, policy.requiredLowercase),
      (PasswordRuleKind.uppercase, policy.requiredUppercase),
      (PasswordRuleKind.digits, policy.requiredDigits),
    ])
      if (count != null && count > 0) PasswordRule(kind, count),
  ];
}
