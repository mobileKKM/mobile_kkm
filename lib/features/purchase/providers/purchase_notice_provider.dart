import 'package:flutter_riverpod/flutter_riverpod.dart';

/// How a payment ended, said on the Tickets list where it lands.
enum PurchaseNotice {
  /// tPay's success link came back; the ticket waits for the booking.
  paymentMade,

  /// A payment the app saw being made is now booked.
  ticketReady,

  /// `payments/check` found the payment.
  paymentConfirmed,

  /// `tickets/pay` said there was nothing to pay.
  alreadyPaid,
}

/// Snackbars waiting for the Tickets list, which has a messenger of its
/// own: it takes them when it shows.
class PurchaseNoticeQueue extends Notifier<List<PurchaseNotice>> {
  @override
  List<PurchaseNotice> build() => const [];

  void add(PurchaseNotice notice) => state = [...state, notice];

  /// Hands out the waiting notices, oldest first, and forgets them.
  List<PurchaseNotice> take() {
    final taken = state;
    if (taken.isNotEmpty) {
      state = const [];
    }
    return taken;
  }
}

final purchaseNoticeProvider = NotifierProvider<PurchaseNoticeQueue, List<PurchaseNotice>>(PurchaseNoticeQueue.new);
