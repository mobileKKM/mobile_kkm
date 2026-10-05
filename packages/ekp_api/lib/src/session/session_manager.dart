import 'dart:async';

import 'package:dio/dio.dart';

import '../common/api_paths.dart';
import 'auth_session.dart';
import 'device_identity.dart';
import 'session_event.dart';
import 'token_store.dart';

/// Owns the [AuthSession]: persistence, lifecycle events and single-flight
/// token recovery.
class EkpSessionManager {
  EkpSessionManager({
    // `this._dio` (the lint's suggestion) would require a private-named
    // parameter, which callers outside this library could not use.
    required Dio dio,
    required this.device,
    TokenStore? tokenStore,
  }) : _dio = dio, // ignore: prefer_initializing_formals
       store = tokenStore ?? InMemoryTokenStore();

  /// The shared client — recovery travels the normal pipeline (device
  /// headers, cookies). The auth interceptor exempts token endpoints from
  /// Bearer injection and from recovery recursion.
  final Dio _dio;

  /// Session persistence owned by the host app.
  final TokenStore store;

  /// Device identity used in recovery request bodies.
  final EkpDeviceIdentity device;

  final _events = StreamController<EkpSessionEvent>.broadcast();

  /// Auth lifecycle events (broadcast — listen anywhere).
  Stream<EkpSessionEvent> get events => _events.stream;

  Future<void> dispose() => _events.close();

  /// Current session, if any.
  Future<AuthSession?> currentSession() => store.read();

  /// Stores [session] and emits [EkpSessionAuthenticated].
  Future<void> publishAuthenticated(AuthSession session) async {
    await store.write(session);
    _events.add(EkpSessionAuthenticated(session));
  }

  /// Stores a rotated [session] and emits [EkpSessionUpdated].
  Future<void> publishUpdated(AuthSession session) async {
    await store.write(session);
    _events.add(EkpSessionUpdated(session));
  }

  /// Clears the session and emits [EkpSessionLoggedOut].
  Future<void> publishLoggedOut() async {
    await store.clear();
    _events.add(const EkpSessionLoggedOut());
  }

  /// Clears the session and emits [EkpSessionExpired].
  Future<void> publishExpired() async {
    await store.clear();
    _events.add(const EkpSessionExpired());
  }

  Future<bool>? _recoveryInFlight;

  /// Single-flight token recovery via `POST auth/token/recover` — the
  /// endpoint the official app uses to renew a session (its refresh token
  /// in the body) and the only way this client rotates tokens.
  ///
  /// The official app also fires `GET auth/token/refresh` at session
  /// start, but that request carries no credential of its own: it
  /// authenticates via the `access-token` cookie persisted by an earlier
  /// login/recover, so it only works with a pre-loaded cookie jar (an
  /// empty jar — like this client's after an app restart — just gets a
  /// 401). It is deliberately not implemented.
  ///
  /// On success the store is updated and [EkpSessionUpdated] emitted. When
  /// the server rejects the refresh token the session is cleared,
  /// [EkpSessionExpired] emitted and `false` returned. A connection-level
  /// failure (no response) also returns `false` but leaves the session
  /// untouched. Concurrent callers share one recovery attempt.
  Future<bool> recover() {
    return _recoveryInFlight ??= _recover().whenComplete(() {
      _recoveryInFlight = null;
    });
  }

  Future<bool> _recover() async {
    final session = await store.read();
    final refresh = session?.refresh;
    if (session == null || refresh == null || refresh.isEmpty) {
      return false;
    }

    try {
      final response = await _dio.post<dynamic>(
        EkpApiPaths.tokenRecover,
        data: {'token': refresh, 'deviceId': device.deviceId, 'deviceName': device.deviceName},
      );
      await publishUpdated(AuthSession.fromJson(_asMap(response.data)));
      return true;
    } on DioException catch (e) {
      // No response at all (offline, timeout): the refresh token was never
      // judged, so keep the session and let a later attempt try again.
      if (e.response == null) return false;
      await publishExpired();
      return false;
    } on FormatException {
      await publishExpired();
      return false;
    }
  }

  static Map<String, dynamic> _asMap(Object? data) {
    if (data is Map<String, dynamic>) return data;
    throw const FormatException('Expected a JSON object response');
  }
}
