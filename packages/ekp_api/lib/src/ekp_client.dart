import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'account/account_api.dart';
import 'auth/auth_api.dart';
import 'common/ekp_defaults.dart';
import 'dictionary/dictionary_api.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/device_headers_interceptor.dart';
import 'invoices/invoices_api.dart';
import 'misc/misc_api.dart';
import 'payments/payments_api.dart';
import 'session/device_identity.dart';
import 'session/session_manager.dart';
import 'session/token_store.dart';
import 'storage_medium/storage_medium_api.dart';
import 'subscriptions/subscriptions_api.dart';
import 'tickets/tickets_api.dart';

/// Facade composing the [Dio] pipeline and all domain APIs.
///
/// ```dart
/// final client = EkpClient(device: identity, tokenStore: store);
/// final session = await client.auth.login(email, password);
/// final tickets = await client.tickets.mkkmTickets();
/// ```
class EkpClient {
  EkpClient({EkpDeviceIdentity? device, TokenStore? tokenStore, Dio? dio, String baseUrl = EkpDefaults.baseUrl})
    : device = device ?? EkpDeviceIdentity.test(),
      dio = dio ?? Dio(BaseOptions(baseUrl: baseUrl, headers: {Headers.acceptHeader: 'application/json'})) {
    session = EkpSessionManager(dio: this.dio, device: this.device, tokenStore: tokenStore);

    // Standard cookie jar: login/recover responses store the auth cookies
    // and the logout response overwrites them with blank values — exactly
    // the official client's observed cookie behavior, with zero custom
    // logic. In-memory only: after an app restart no cookies are sent
    // until the next login/recover (functionally irrelevant — the Bearer
    // header authenticates).
    this.dio.interceptors.addAll([
      CookieManager(CookieJar()),
      DeviceHeadersInterceptor(this.device),
      AuthInterceptor(session, this.dio),
    ]);
  }

  /// Device identity used in headers and auth bodies.
  final EkpDeviceIdentity device;

  /// The underlying [Dio] — exposed for advanced use (timeouts, proxies).
  final Dio dio;

  /// Session persistence + lifecycle events + recovery.
  late final EkpSessionManager session;

  /// Auth domain: login, logout, registration, passwords, consents.
  late final AuthApi auth = AuthApi(dio, session, device);

  /// Account domain: user data, inhabitant status, photo.
  late final AccountApi account = AccountApi(dio);

  /// Storage media (cards) list & mKKM creation.
  late final StorageMediumApi storageMediums = StorageMediumApi(dio);

  /// Dictionaries for the purchase wizard.
  late final DictionaryApi dictionaries = DictionaryApi(dio);

  /// Tickets: mobile tickets, history, purchase, returns, encrypted
  /// assign/contract (AZTEC) endpoints.
  late final TicketsApi tickets = TicketsApi(dio, device);

  /// Payments (tpay): banks, payment status.
  late final PaymentsApi payments = PaymentsApi(dio);

  /// Subscriptions (5+1) read endpoints.
  late final SubscriptionsApi subscriptions = SubscriptionsApi(dio);

  /// Invoice list.
  late final InvoicesApi invoices = InvoicesApi(dio);

  /// Service status & app config.
  late final MiscApi misc = MiscApi(dio);

  /// Releases the session event stream. The client must not be used after.
  Future<void> dispose() => session.dispose();
}
