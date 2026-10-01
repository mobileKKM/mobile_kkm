import 'package:freezed_annotation/freezed_annotation.dart';

import '../common/code_message.dart';

part 'auth_models.freezed.dart';
part 'auth_models.g.dart';

/// `GET auth/password-policy`
@freezed
abstract class PasswordPolicy with _$PasswordPolicy {
  const factory PasswordPolicy({
    int? minLength,
    int? requiredLowercase,
    int? requiredUppercase,
    int? requiredDigits,
  }) = _PasswordPolicy;

  factory PasswordPolicy.fromJson(Map<String, dynamic> json) =>
      _$PasswordPolicyFromJson(json);
}

/// A single marketing consent checkbox.
@freezed
abstract class MarketingConsent with _$MarketingConsent {
  const factory MarketingConsent({int? id, String? content, bool? isChecked}) =
      _MarketingConsent;

  factory MarketingConsent.fromJson(Map<String, dynamic> json) =>
      _$MarketingConsentFromJson(json);
}

/// `GET auth/marketing-consents` and `GET subscriptions/marketing-consents`.
@freezed
abstract class MarketingConsentsResponse with _$MarketingConsentsResponse {
  const factory MarketingConsentsResponse({
    @Default(<MarketingConsent>[]) List<MarketingConsent> marketingConsents,
  }) = _MarketingConsentsResponse;

  factory MarketingConsentsResponse.fromJson(Map<String, dynamic> json) =>
      _$MarketingConsentsResponseFromJson(json);
}

/// Generic `{code, message}` envelope used by auth mutations
/// (register, activate, change-password, reset-password, photo upload...).
@freezed
abstract class CodeMessageResponse with EkpCodeMessage, _$CodeMessageResponse {
  const CodeMessageResponse._();

  const factory CodeMessageResponse({Object? code, String? message}) =
      _CodeMessageResponse;

  factory CodeMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$CodeMessageResponseFromJson(json);
}
