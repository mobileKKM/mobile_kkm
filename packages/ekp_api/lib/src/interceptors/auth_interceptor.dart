import 'package:dio/dio.dart';

import '../common/api_exception.dart';
import '../common/api_paths.dart';
import '../session/session_manager.dart';

/// Attaches `Authorization: Bearer <jwt>` and transparently recovers from
/// HTTP 401 via the session manager.
///
/// Recovery is single-flight (concurrent 401s share one recover/refresh
/// round-trip) and the failed request is retried exactly once with the new
/// token. If recovery is impossible or fails, the error surfaces as
/// [EkpSessionExpiredException] and [EkpSessionExpired] is emitted on
/// [EkpSessionManager.events].
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._session, this._dio);

  final EkpSessionManager _session;
  final Dio _dio;

  /// Endpoints that must never carry a Bearer token: the anonymous auth
  /// flows and `auth/token/recover` (which authenticates via the refresh
  /// token in its body and is also exempt from recovery recursion below).
  static const List<String> _anonymousPaths = [
    EkpApiPaths.login,
    EkpApiPaths.register,
    EkpApiPaths.activate,
    EkpApiPaths.resetPassword,
    EkpApiPaths.resetPasswordLinkRequest,
    EkpApiPaths.tokenRecover,
  ];

  static const String _retriedFlag = 'ekp_api.retried';

  Future<bool>? _recoveryInFlight;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final session = await _session.currentSession();
    if (session != null && _wantsBearer(options)) {
      options.headers['authorization'] = 'Bearer ${session.token}';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final status = err.response?.statusCode;
    final requestOptions = err.requestOptions;

    final recoverable =
        status == 401 && !requestOptions.path.contains('/auth/') && requestOptions.extra[_retriedFlag] != true;

    if (!recoverable) {
      handler.next(err);
      return;
    }

    final recovered = await _recoverSingleFlight();
    if (!recovered) {
      handler.reject(
        DioException(
          requestOptions: requestOptions,
          error: const EkpSessionExpiredException(message: 'Sesja wygasła. Zaloguj się ponownie.'),
        ),
      );
      return;
    }

    final session = await _session.currentSession();
    if (session == null) {
      handler.next(err);
      return;
    }

    requestOptions.extra[_retriedFlag] = true;
    if (_wantsBearer(requestOptions)) {
      requestOptions.headers['authorization'] = 'Bearer ${session.token}';
    }
    try {
      final response = await _dio.fetch(requestOptions);
      handler.resolve(response);
    } on DioException catch (e) {
      handler.next(e);
    }
  }

  static bool _wantsBearer(RequestOptions options) => !_anonymousPaths.any(options.path.endsWith);

  Future<bool> _recoverSingleFlight() {
    return _recoveryInFlight ??= _session.recover().whenComplete(() => _recoveryInFlight = null);
  }
}
