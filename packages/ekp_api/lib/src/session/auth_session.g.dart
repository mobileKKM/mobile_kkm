// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthSession _$AuthSessionFromJson(Map<String, dynamic> json) => _AuthSession(
  token: json['token'] as String,
  refresh: json['refresh'] as String,
  expires: json['expires'] == null
      ? null
      : DateTime.parse(json['expires'] as String),
);

Map<String, dynamic> _$AuthSessionToJson(_AuthSession instance) =>
    <String, dynamic>{
      'token': instance.token,
      'refresh': instance.refresh,
      'expires': instance.expires?.toIso8601String(),
    };
