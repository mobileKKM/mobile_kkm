import 'dart:async';

import 'package:clock/clock.dart';
import 'package:ekp_api/ekp_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/platform/payment_browser.dart';
import 'package:mobile_kkm/core/providers/app_startup_provider.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/core/providers/platform_providers.dart';
import 'package:mobile_kkm/core/router/app_router.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/features/auth/providers/auth_controller.dart';
import 'package:mobile_kkm/features/purchase/providers/purchase_notice_provider.dart';
import 'package:mobile_kkm/features/purchase/services/checkout_controller.dart';
import 'package:mobile_kkm/features/purchase/services/payments_dao.dart';
import 'package:mobile_kkm/features/tickets/providers/tickets_providers.dart';
import 'package:mobile_kkm/features/tickets/services/ticket_sync.dart';

/// What the Payment screen shows.
enum PaymentPhase {
  idle,

  /// tPay's page is open over the Payment screen.
  opening,

  /// The success link came: reporting it and reloading the tickets.
  finishing,

  /// The browser closed without a link: asking `payments/check`.
  checking,

  /// tPay's rejected link came.
  rejected,

  /// Three checks found no payment.
  notBooked,
}

class PaymentSession {
  const PaymentSession({
    this.phase = PaymentPhase.idle,
    this.ticketGuid,
    this.checkout,
    this.message,
    this.linksAllowed,
  });

  final PaymentPhase phase;
  final String? ticketGuid;

  /// The Check and pay screen the payment started from.
  final CheckoutEntry? checkout;

  /// The server's word on a payment it hasn't booked.
  final String? message;

  /// Android: whether tPay's return links open the app, read when the
  /// payment opens; null on iOS.
  final bool? linksAllowed;

  PaymentSession copyWith({PaymentPhase? phase, String? Function()? message}) => PaymentSession(
    phase: phase ?? this.phase,
    ticketGuid: ticketGuid,
    checkout: checkout,
    message: message == null ? this.message : message(),
    linksAllowed: linksAllowed,
  );
}

/// A payment on tPay's page, from opening it to its outcome, all shown on
/// one Payment screen that tPay opens over (28a, 28b).
///
/// * A return link (Android) is reported with `payments/result`; success
///   marks the payment as made (the card shows it as being booked) and ends
///   on Tickets, rejection says so on the Payment screen.
/// * The browser closing without one (Android: the app is back and no link
///   came within [returnWait]; iOS: Done, or the app back in front) asks
///   `payments/check` now, after 5 s and after 10 s, then gives up as
///   not booked. Leaving meanwhile doesn't stop the checks.
/// * A return link the app was started with after being killed is still
///   reported and marked.
///
/// The Payment screen never pays: going back hands over to Check and pay.
class PaymentSessionController extends Notifier<PaymentSession> {
  static const returnWait = Duration(seconds: 1);
  static const checkAfter = [Duration.zero, Duration(seconds: 5), Duration(seconds: 5)];

  Timer? _returnTimer;
  Timer? _checkTimer;
  var _run = 0;
  var _initialTaken = false;

  @override
  PaymentSession build() {
    final browser = ref.watch(paymentBrowserProvider);
    final events = browser.events.listen(_onEvent);
    final lifecycle = AppLifecycleListener(onResume: _onResume);
    ref.onDispose(() {
      unawaited(events.cancel());
      lifecycle.dispose();
      _returnTimer?.cancel();
      _checkTimer?.cancel();
    });
    ref.listen(authControllerProvider.select((state) => state.status == AuthStatus.authenticated), (_, signedIn) {
      if (signedIn) {
        unawaited(_takeInitialReturn());
      }
    }, fireImmediately: true);
    return const PaymentSession();
  }

  bool get _android => defaultTargetPlatform == TargetPlatform.android;

  /// Pushes the Payment screen and opens tPay's page over it, for
  /// [ticketGuid], bought or paid on [checkout].
  Future<void> open(
    Uri url, {
    required String ticketGuid,
    required CheckoutEntry checkout,
    required Color toolbarColor,
    required Color tintColor,
  }) async {
    _cancel();
    final router = ref.read(routerProvider);
    final browser = ref.read(paymentBrowserProvider);
    final settings = ref.read(linkSettingsProvider);
    final linksAllowed = settings.isSupported ? await settings.canOpenLinks() : null;
    if (!ref.mounted) {
      return;
    }
    state = PaymentSession(
      phase: PaymentPhase.opening,
      ticketGuid: ticketGuid,
      checkout: checkout,
      linksAllowed: linksAllowed,
    );
    unawaited(router.push(Routes.payment));
    await browser.open(url, toolbarColor: toolbarColor, tintColor: tintColor);
  }

  /// Asks `payments/check` three times again (Not booked's Check again).
  void checkAgain() => _startChecks();

  /// Back to Check and pay, which still holds the ticket and the method.
  void back() {
    _cancel();
    state = state.copyWith(phase: PaymentPhase.idle);
    final router = ref.read(routerProvider);
    if (router.canPop()) {
      router.pop();
    } else {
      router.go(Routes.tickets);
    }
  }

  /// To Tickets, where the ticket waits for its payment. Checks still
  /// running go on: a payment they find is said there.
  void leave() {
    if (state.phase != PaymentPhase.checking) {
      _cancel();
      state = state.copyWith(phase: PaymentPhase.idle);
    }
    ref.read(routerProvider).go(Routes.tickets);
  }

  bool get _onPayment => ref.read(routerProvider).state.uri.path == Routes.payment;

  void _cancel() {
    _run++;
    _returnTimer?.cancel();
    _checkTimer?.cancel();
  }

  void _onEvent(PaymentBrowserEvent event) {
    switch (event) {
      case PaymentReturned(:final url):
        _returnTimer?.cancel();
        unawaited(_onReturn(url));
      case PaymentBrowserClosed():
        if (state.phase == PaymentPhase.opening) {
          _startChecks();
        }
    }
  }

  void _onResume() {
    if (state.phase != PaymentPhase.opening) {
      return;
    }
    if (_android) {
      // The return link may be a moment behind the app coming back.
      _returnTimer?.cancel();
      _returnTimer = Timer(returnWait, _startChecks);
    } else {
      _startChecks();
    }
  }

  Future<void> _takeInitialReturn() async {
    if (_initialTaken) {
      return;
    }
    _initialTaken = true;
    final Uri? url;
    try {
      url = await ref.read(paymentBrowserProvider).initialReturn();
    } on Object {
      return;
    }
    if (url != null && ref.mounted) {
      await _onReturn(url);
    }
  }

  Future<void> _onReturn(Uri url) async {
    final success = url.path == '/payment/success';
    if (!success && url.path != '/payment/rejected') {
      return;
    }
    final id = url.queryParameters['id'] ?? state.ticketGuid;
    if (id == null) {
      return;
    }
    _cancel();
    final client = ref.read(ekpClientProvider);
    final router = ref.read(routerProvider);
    final fromSession = state.phase != PaymentPhase.idle;
    final type = url.queryParameters['type'] ?? '2';

    if (!success) {
      // Said at once; nothing waits for the report.
      if (fromSession) {
        state = state.copyWith(phase: PaymentPhase.rejected);
      } else {
        router.go(Routes.tickets);
      }
      await _report(client, id, type, 'Error');
      return;
    }

    state = PaymentSession(
      phase: PaymentPhase.finishing,
      ticketGuid: id,
      checkout: state.checkout,
      linksAllowed: state.linksAllowed,
    );
    final dao = ref.read(paymentsDaoProvider);
    final sync = ref.read(ticketSyncProvider.notifier);
    final notices = ref.read(purchaseNoticeProvider.notifier);
    await _report(client, id, type, 'Success');
    await dao.markMade(id, clock.now());
    if (!fromSession) {
      // A cold start: the tickets wait for the start-up.
      await ref.read(appStartupProvider.future).then<void>((_) {}, onError: (_) {});
    }
    await sync.refresh();
    if (!ref.mounted) {
      return;
    }
    notices.add(PurchaseNotice.paymentMade);
    final here = _onPayment;
    state = state.copyWith(phase: PaymentPhase.idle);
    if (!fromSession || here) {
      router.go(Routes.tickets);
    }
  }

  /// `payments/result`, as the official client posts it. A failure changes
  /// nothing here: the payment is checked on the list anyway.
  Future<void> _report(EkpClient client, String id, String type, String result) async {
    try {
      await client.payments.result(id: id, type: type, result: result);
    } on EkpApiException {
      // Reported by tPay too.
    }
  }

  void _startChecks() {
    final guid = state.ticketGuid;
    if (guid == null) {
      return;
    }
    _cancel();
    final run = _run;
    final router = ref.read(routerProvider);
    final onPayment = _onPayment;
    state = state.copyWith(phase: PaymentPhase.checking, message: () => null);
    if (!onPayment) {
      unawaited(router.push(Routes.payment));
    }
    _scheduleCheck(guid, run, 0);
  }

  void _scheduleCheck(String guid, int run, int attempt) {
    _checkTimer = Timer(checkAfter[attempt], () => unawaited(_check(guid, run, attempt)));
  }

  Future<void> _check(String guid, int run, int attempt) async {
    final client = ref.read(ekpClientProvider);
    PaymentCheckResult? result;
    try {
      result = await client.payments.check(guid);
    } on EkpApiException {
      // Counts as not booked yet.
    }
    if (!ref.mounted || run != _run) {
      return;
    }
    if (result?.status == PaymentCheckStatus.confirmed) {
      final router = ref.read(routerProvider);
      final notices = ref.read(purchaseNoticeProvider.notifier);
      unawaited(ref.read(paymentBrowserProvider).close().catchError((_) {}));
      ref.invalidate(ticketDetailProvider);
      await ref.read(ticketSyncProvider.notifier).refresh();
      if (!ref.mounted || run != _run) {
        return;
      }
      notices.add(PurchaseNotice.paymentConfirmed);
      // Left for Tickets meanwhile: the notice waits there.
      final here = _onPayment;
      state = state.copyWith(phase: PaymentPhase.idle);
      if (here) {
        router.go(Routes.tickets);
      }
      return;
    }
    if (attempt + 1 < checkAfter.length) {
      _scheduleCheck(guid, run, attempt + 1);
      return;
    }
    state = state.copyWith(phase: PaymentPhase.notBooked, message: () => result?.message);
  }
}

final paymentSessionProvider = NotifierProvider<PaymentSessionController, PaymentSession>(PaymentSessionController.new);
