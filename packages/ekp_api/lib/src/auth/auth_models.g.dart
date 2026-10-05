// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PasswordPolicy _$PasswordPolicyFromJson(Map<String, dynamic> json) => _PasswordPolicy(
  minLength: (json['minLength'] as num?)?.toInt(),
  requiredLowercase: (json['requiredLowercase'] as num?)?.toInt(),
  requiredUppercase: (json['requiredUppercase'] as num?)?.toInt(),
  requiredDigits: (json['requiredDigits'] as num?)?.toInt(),
);

Map<String, dynamic> _$PasswordPolicyToJson(_PasswordPolicy instance) => <String, dynamic>{
  'minLength': instance.minLength,
  'requiredLowercase': instance.requiredLowercase,
  'requiredUppercase': instance.requiredUppercase,
  'requiredDigits': instance.requiredDigits,
};

_MarketingConsent _$MarketingConsentFromJson(Map<String, dynamic> json) => _MarketingConsent(
  id: (json['id'] as num?)?.toInt(),
  content: json['content'] as String?,
  isChecked: json['isChecked'] as bool?,
);

Map<String, dynamic> _$MarketingConsentToJson(_MarketingConsent instance) => <String, dynamic>{
  'id': instance.id,
  'content': instance.content,
  'isChecked': instance.isChecked,
};

_MarketingConsentsResponse _$MarketingConsentsResponseFromJson(Map<String, dynamic> json) => _MarketingConsentsResponse(
  marketingConsents:
      (json['marketingConsents'] as List<dynamic>?)
          ?.map((e) => MarketingConsent.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <MarketingConsent>[],
);

Map<String, dynamic> _$MarketingConsentsResponseToJson(_MarketingConsentsResponse instance) => <String, dynamic>{
  'marketingConsents': instance.marketingConsents,
};

_CodeMessageResponse _$CodeMessageResponseFromJson(Map<String, dynamic> json) =>
    _CodeMessageResponse(code: json['code'], message: json['message'] as String?);

Map<String, dynamic> _$CodeMessageResponseToJson(_CodeMessageResponse instance) => <String, dynamic>{
  'code': instance.code,
  'message': instance.message,
};
