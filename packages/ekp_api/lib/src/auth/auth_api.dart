import 'package:dio/dio.dart';

import '../common/api_exception.dart';
import '../common/api_paths.dart';
import '../common/api_service.dart';
import '../session/device_identity.dart';
import '../session/auth_session.dart';
import '../session/session_manager.dart';
import 'auth_models.dart';

/// Auth domain: login/logout, registration, password management, consents.
class AuthApi extends EkpApiService {
  AuthApi(super.dio, this._session, this._device);

  final EkpSessionManager _session;
  final EkpDeviceIdentity _device;

  /// `POST auth/login`
  ///
  /// On success the session is persisted and
  /// [EkpSessionAuthenticated] emitted. HTTP 401 (wrong credentials —
  /// the server sends an empty body) becomes [EkpUnauthorizedException].
  Future<AuthSession> login(
    String username,
    String password, {
    bool rememberMe = true,
  }) async {
    return guard(() async {
      try {
        final response = await dio.post<Map<String, dynamic>>(
          EkpApiPaths.login,
          data: {
            'rememberMe': rememberMe,
            'deviceId': _device.deviceId,
            'deviceName': _device.deviceName,
            'username': username,
            'password': password,
          },
        );
        final session = AuthSession.fromJson(
          response.data ?? const <String, dynamic>{},
        );
        await _session.publishAuthenticated(session);
        return session;
      } on DioException catch (e) {
        if (e.response?.statusCode == 401) {
          throw const EkpUnauthorizedException(
            message: 'Nieprawidłowy e-mail lub hasło.',
          );
        }
        rethrow;
      }
    });
  }

  /// `POST auth/logout` — authenticated via Bearer (and, like every
  /// request, the replayed cookies).
  ///
  /// Best-effort: the local session is cleared and [EkpSessionLoggedOut]
  /// emitted even when the server call fails.
  Future<void> logout() async {
    try {
      await dio.post<dynamic>(
        EkpApiPaths.logout,
        queryParameters: {'id': _device.deviceId},
        options: Options(responseType: ResponseType.plain),
      );
    } on DioException {
      // Swallowed on purpose — local logout must always succeed.
    }
    await _session.publishLoggedOut();
  }

  /// `POST auth/register`
  ///
  /// The official client ALWAYS sends a `birthDate`: derived from the
  /// PESEL client-side once the user types a valid number (so a PESEL
  /// registration carries both `pesel` and the derived `birthDate`), or
  /// entered manually for PESEL-less accounts (which later show
  /// `pesel: null` in user data, and `mkkmData: null` until a medium is
  /// created). This package deliberately does NOT derive birth dates
  /// from PESELs — the host app computes the prefill and passes it in.
  Future<CodeMessageResponse> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required DateTime birthDate,
    String? pesel,
    List<MarketingConsent> marketingConsents = const [],
  }) async {
    return guard(() async {
      final response = await dio.post<Map<String, dynamic>>(
        EkpApiPaths.register,
        data: {
          'marketingConsents': [
            for (final c in marketingConsents)
              {'id': c.id, 'isChecked': c.isChecked},
          ],
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'repeat_email': email,
          'password': password,
          'repeat_password': password,
          'pesel': ?pesel,
          'birthDate': formatEkpBirthDate(birthDate),
        },
      );
      return CodeMessageResponse.fromJson(
        response.data ?? const <String, dynamic>{},
      );
    });
  }

  /// `POST auth/activate` — token comes from the activation e-mail link
  /// (`ekp.mpk.krakow.pl/...?token=...`).
  Future<CodeMessageResponse> activate(String token) async {
    return guard(() async {
      final response = await dio.post<Map<String, dynamic>>(
        EkpApiPaths.activate,
        data: {'token': token},
      );
      return CodeMessageResponse.fromJson(
        response.data ?? const <String, dynamic>{},
      );
    });
  }

  /// `POST auth/change-password` (authenticated).
  Future<CodeMessageResponse> changePassword({
    required String previousPassword,
    required String newPassword,
    required String repeatPassword,
  }) async {
    return guard(() async {
      final response = await dio.post<Map<String, dynamic>>(
        EkpApiPaths.changePassword,
        data: {
          'previousPassword': previousPassword,
          'newPassword': newPassword,
          'repeatPassword': repeatPassword,
        },
      );
      return CodeMessageResponse.fromJson(
        response.data ?? const <String, dynamic>{},
      );
    });
  }

  /// `POST auth/reset-password-link-request` — sends the reset e-mail.
  Future<CodeMessageResponse> requestPasswordReset(String email) async {
    return guard(() async {
      final response = await dio.post<Map<String, dynamic>>(
        EkpApiPaths.resetPasswordLinkRequest,
        data: {'email': email},
      );
      return CodeMessageResponse.fromJson(
        response.data ?? const <String, dynamic>{},
      );
    });
  }

  /// `POST auth/reset-password` — token comes from the reset e-mail link.
  Future<CodeMessageResponse> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    return guard(() async {
      final response = await dio.post<Map<String, dynamic>>(
        EkpApiPaths.resetPassword,
        data: {'token': token, 'newPassword': newPassword},
      );
      return CodeMessageResponse.fromJson(
        response.data ?? const <String, dynamic>{},
      );
    });
  }

  /// `GET auth/password-policy`
  Future<PasswordPolicy> passwordPolicy() async {
    return guard(() async {
      final response = await dio.get<Map<String, dynamic>>(
        EkpApiPaths.passwordPolicy,
      );
      return PasswordPolicy.fromJson(
        response.data ?? const <String, dynamic>{},
      );
    });
  }

  /// `GET auth/marketing-consents`
  Future<MarketingConsentsResponse> marketingConsents() async {
    return guard(() async {
      final response = await dio.get<Map<String, dynamic>>(
        EkpApiPaths.authMarketingConsents,
      );
      return MarketingConsentsResponse.fromJson(
        response.data ?? const <String, dynamic>{},
      );
    });
  }
}

/// Formats a local calendar date as the official client does for the
/// registration `birthDate` field: `1983-09-28T00:00:00+01:00`.
///
/// [date] should be a "local" DateTime (as produced by `DateTime(y, m, d)`);
/// the timezone offset written is the device offset for that instant.
String formatEkpBirthDate(DateTime date) {
  final local = DateTime(date.year, date.month, date.day);
  final offset = local.timeZoneOffset;
  final sign = offset.isNegative ? '-' : '+';
  final hh = offset.inHours.abs().toString().padLeft(2, '0');
  final mm = (offset.inMinutes.abs() % 60).toString().padLeft(2, '0');
  final iso = local.toIso8601String(); // e.g. 1983-09-28T00:00:00.000
  return '${iso.substring(0, 19)}$sign$hh:$mm';
}
