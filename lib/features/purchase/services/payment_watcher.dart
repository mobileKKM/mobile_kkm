import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_kkm/core/providers/app_startup_provider.dart';
import 'package:mobile_kkm/features/auth/providers/auth_controller.dart';
import 'package:mobile_kkm/features/purchase/providers/purchase_notice_provider.dart';
import 'package:mobile_kkm/features/purchase/services/payments_dao.dart';
import 'package:mobile_kkm/features/tickets/providers/tickets_providers.dart';
import 'package:mobile_kkm/features/tickets/services/ticket_sync.dart';

/// Follows the payments marked as made until the server lists them as
/// paid: asks for the tickets every [interval] while there are any (signed
/// in and online), then drops each mark and says the ticket is ready.
///
/// Beyond the official client, which keeps a mark whose ticket is missing
/// from the list for good: such a mark is dropped after a sync, since the
/// poll runs while any mark is kept.
class PaymentWatcher extends Notifier<void> {
  static const interval = Duration(seconds: 10);

  @override
  void build() {
    final marks = ref.watch(paymentMarksProvider).value ?? const <String, DateTime>{};
    final online = ref.watch(appStatusProvider.select((status) => status.mode == AppMode.online));
    final signedIn = ref.watch(authControllerProvider.select((state) => state.status == AuthStatus.authenticated));
    ref.listen(storedTicketsProvider, (_, _) => unawaited(_review()));
    if (marks.isEmpty || !online || !signedIn) {
      return;
    }
    final timer = Timer.periodic(interval, (_) => unawaited(ref.read(ticketSyncProvider.notifier).refresh()));
    ref.onDispose(timer.cancel);
    unawaited(Future.microtask(_review));
  }

  Future<void> _review() async {
    if (!ref.mounted) {
      return;
    }
    final marks = ref.read(paymentMarksProvider).value;
    final tickets = ref.read(storedTicketsProvider).value;
    if (marks == null || marks.isEmpty || tickets == null) {
      return;
    }
    final dao = ref.read(paymentsDaoProvider);
    final notices = ref.read(purchaseNoticeProvider.notifier);
    final synced = ref.read(ticketSyncProvider).lastSyncedAt;
    for (final MapEntry(key: guid, value: madeAt) in marks.entries) {
      final stored = tickets.where((stored) => stored.ticket.ticketGuid == guid).firstOrNull;
      final status = stored?.ticket.status;
      if (stored != null && status != 'pending') {
        await dao.remove(guid);
        if (status == 'active') {
          notices.add(PurchaseNotice.ticketReady);
        }
      } else if (stored == null && synced != null && synced.isAfter(madeAt)) {
        await dao.remove(guid);
      }
    }
  }
}

final paymentWatcherProvider = NotifierProvider<PaymentWatcher, void>(PaymentWatcher.new);
