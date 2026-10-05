import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_kkm/features/auth/models/password_rule.dart';

void main() {
  test('only requirements with a positive count become rules', () {
    final rules = passwordRulesFor(
      const PasswordPolicy(minLength: 8, requiredLowercase: 0, requiredUppercase: 1, requiredDigits: 1),
    );
    expect(rules.map((rule) => rule.kind), [
      PasswordRuleKind.minLength,
      PasswordRuleKind.uppercase,
      PasswordRuleKind.digits,
    ]);
  });

  test('no policy means no client-side rules', () {
    expect(passwordRulesFor(null), isEmpty);
  });

  test('counts characters per rule', () {
    const twoUpper = PasswordRule(PasswordRuleKind.uppercase, 2);
    expect(twoUpper.isSatisfiedBy('Abc'), isFalse);
    expect(twoUpper.isSatisfiedBy('AbC'), isTrue);

    const twoLower = PasswordRule(PasswordRuleKind.lowercase, 2);
    expect(twoLower.isSatisfiedBy('ABc1'), isFalse);
    expect(twoLower.isSatisfiedBy('Abc1'), isTrue);

    const oneDigit = PasswordRule(PasswordRuleKind.digits, 1);
    expect(oneDigit.isSatisfiedBy('abc'), isFalse);
    expect(oneDigit.isSatisfiedBy('abc1'), isTrue);

    const eightLong = PasswordRule(PasswordRuleKind.minLength, 8);
    expect(eightLong.isSatisfiedBy('1234567'), isFalse);
    expect(eightLong.isSatisfiedBy('12345678'), isTrue);
  });

  test('Polish letters count as upper/lowercase', () {
    expect(const PasswordRule(PasswordRuleKind.uppercase, 1).isSatisfiedBy('łódŹ'), isTrue);
    expect(const PasswordRule(PasswordRuleKind.lowercase, 1).isSatisfiedBy('ŁÓDź'), isTrue);
  });
}
