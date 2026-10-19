import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_kkm/core/providers/platform_providers.dart';
import 'package:mobile_kkm/features/purchase/services/checkout_controller.dart';

/// A payment on tPay's page, from opening it to its outcome.
class PaymentSessionController extends Notifier<void> {
  @override
  void build() {}

  /// Opens tPay's page for [ticketGuid], bought or paid on [checkout].
  Future<void> open(Uri url, {required String ticketGuid, required CheckoutEntry checkout}) async {
    await ref.read(urlOpenerProvider)(url);
  }
}

final paymentSessionProvider = NotifierProvider<PaymentSessionController, void>(PaymentSessionController.new);
