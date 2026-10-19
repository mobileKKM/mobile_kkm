import 'dart:async';

import 'package:flutter/services.dart';

/// What the payment browser reports.
sealed class PaymentBrowserEvent {
  const PaymentBrowserEvent();
}

/// Android: tPay's last page led to a return link (`/payment/success` or
/// `/payment/rejected`), which brought the app back and closed the tab.
class PaymentReturned extends PaymentBrowserEvent {
  const PaymentReturned(this.url);

  final Uri url;
}

/// iOS: the user closed the Safari view (Done).
class PaymentBrowserClosed extends PaymentBrowserEvent {
  const PaymentBrowserClosed();
}

/// tPay's payment page in the platform's in-app browser: a Custom Tab on
/// Android, an `SFSafariViewController` on iOS. Our own code on both sides
/// (`MainActivity`, `PaymentReturnActivity`, `PaymentBrowser.swift`), over
/// one channel.
class PaymentBrowser {
  PaymentBrowser() {
    _channel.setMethodCallHandler(_onCall);
  }

  static const _channel = MethodChannel('de.codebucket.mkkm/payment');

  final _events = StreamController<PaymentBrowserEvent>.broadcast();

  Stream<PaymentBrowserEvent> get events => _events.stream;

  Future<Object?> _onCall(MethodCall call) async {
    switch (call.method) {
      case 'returned':
        final url = Uri.tryParse(call.arguments as String? ?? '');
        if (url != null) {
          _events.add(PaymentReturned(url));
        }
      case 'closed':
        _events.add(const PaymentBrowserClosed());
    }
    return null;
  }

  /// Opens [url]; [toolbarColor] is the Custom Tab's bar, [tintColor] the
  /// Safari view's controls.
  Future<void> open(Uri url, {required Color toolbarColor, required Color tintColor}) => _channel.invokeMethod<void>(
    'open',
    {'url': url.toString(), 'toolbarColor': toolbarColor.toARGB32(), 'tintColor': tintColor.toARGB32()},
  );

  /// Closes the Safari view; on Android the return link already did.
  Future<void> close() => _channel.invokeMethod<void>('close');

  /// Android: the return link the app was started with after it had been
  /// killed, once.
  Future<Uri?> initialReturn() async {
    final url = await _channel.invokeMethod<String>('initialReturn');
    return url == null ? null : Uri.tryParse(url);
  }
}
