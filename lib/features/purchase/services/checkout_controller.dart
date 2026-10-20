import 'dart:async';

import 'package:ekp_api/ekp_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_kkm/core/providers/app_startup_provider.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/features/account/providers/user_data_provider.dart';
import 'package:mobile_kkm/features/purchase/models/payment_methods.dart';
import 'package:mobile_kkm/features/purchase/models/sales_rules.dart';
import 'package:mobile_kkm/features/purchase/services/last_payment_method_store.dart';
import 'package:mobile_kkm/features/tickets/providers/tickets_providers.dart';
import 'package:mobile_kkm/features/tickets/services/ticket_sync.dart';

/// What Check and pay is for: a new ticket, priced on the form, or one
/// already bought that waits for its payment.
class CheckoutEntry {
  const CheckoutEntry.buy(TicketChoice this.choice, TicketCalculation this.calculation) : ticketGuid = null;

  const CheckoutEntry.pay(String this.ticketGuid) : choice = null, calculation = null;

  final TicketChoice? choice;
  final TicketCalculation? calculation;

  /// The ticket to pay for; null for a new ticket.
  final String? ticketGuid;

  @override
  bool operator ==(Object other) =>
      other is CheckoutEntry &&
      other.choice == choice &&
      other.calculation == calculation &&
      other.ticketGuid == ticketGuid;

  @override
  int get hashCode => Object.hash(choice, calculation, ticketGuid);
}

/// Check and pay (25b).
class CheckoutState {
  const CheckoutState({
    this.methods = const AsyncLoading(),
    this.selected,
    this.lastUsed,
    this.ticketGuid,
    this.busy = false,
    this.failure,
  });

  /// `payments/banks`, sorted for this platform.
  final AsyncValue<PaymentMethods> methods;

  /// The chosen tPay group.
  final String? selected;

  /// The group used last, if this list has it.
  final String? lastUsed;

  /// Null until `tickets/buy` made the ticket; from then on every payment
  /// is `tickets/pay`.
  final String? ticketGuid;

  final bool busy;

  /// Why the last buy or pay failed, for the notice on top.
  final Object? failure;

  /// The ticket exists on the server.
  bool get bought => ticketGuid != null;

  CheckoutState copyWith({
    AsyncValue<PaymentMethods>? methods,
    String? Function()? selected,
    String? Function()? lastUsed,
    String? Function()? ticketGuid,
    bool? busy,
    Object? Function()? failure,
  }) => CheckoutState(
    methods: methods ?? this.methods,
    selected: selected == null ? this.selected : selected(),
    lastUsed: lastUsed == null ? this.lastUsed : lastUsed(),
    ticketGuid: ticketGuid == null ? this.ticketGuid : ticketGuid(),
    busy: busy ?? this.busy,
    failure: failure == null ? this.failure : failure(),
  );
}

/// What a tap on Pay came to.
sealed class CheckoutOutcome {
  const CheckoutOutcome();
}

/// Open tPay's page for [ticketGuid].
class CheckoutOpen extends CheckoutOutcome {
  const CheckoutOpen(this.paymentUrl, this.ticketGuid);

  final String paymentUrl;
  final String ticketGuid;
}

/// An earlier payment is unconfirmed (`code: 5`): ask, then call
/// [CheckoutController.pay] again with `ignoreWarnings: true`.
class CheckoutConfirmRepeat extends CheckoutOutcome {
  const CheckoutConfirmRepeat();
}

/// The ticket needs no payment; the tickets have been reloaded.
class CheckoutAlreadyPaid extends CheckoutOutcome {
  const CheckoutAlreadyPaid();
}

/// Nothing to open: [CheckoutState.failure] says why.
class CheckoutFailed extends CheckoutOutcome {
  const CheckoutFailed();
}

/// Check and pay: the payment methods, the choice of one, and the buy /
/// pay requests. Buy once, pay many times.
class CheckoutController extends Notifier<CheckoutState> {
  CheckoutController(this.entry);

  final CheckoutEntry entry;

  @override
  CheckoutState build() {
    unawaited(_loadMethods());
    return CheckoutState(ticketGuid: entry.ticketGuid);
  }

  Future<void> _loadMethods() async {
    final client = ref.read(ekpClientProvider);
    final store = ref.read(lastPaymentMethodStoreProvider);
    final status = ref.read(appStatusProvider.notifier);
    try {
      final list = await client.payments.banks();
      final last = await store.read();
      if (!ref.mounted) {
        return;
      }
      final methods = PaymentMethods.from(list, ios: defaultTargetPlatform == TargetPlatform.iOS);
      final known = methods.byId(last) == null ? null : last;
      state = state.copyWith(
        methods: AsyncData(methods),
        lastUsed: () => known,
        selected: () => state.selected ?? known,
      );
    } on Object catch (error, stack) {
      if (error is EkpNetworkException) {
        status.markOffline();
      }
      if (ref.mounted) {
        state = state.copyWith(methods: AsyncError(error, stack));
      }
    }
  }

  /// Loads the payment methods again after a failure.
  void retryMethods() {
    state = state.copyWith(methods: const AsyncLoading());
    unawaited(_loadMethods());
  }

  void select(String groupId) => state = state.copyWith(selected: () => groupId);

  /// Buys the ticket the first time, pays for it after that.
  /// [ignoreWarnings] only after the user agreed to pay again.
  Future<CheckoutOutcome?> pay({bool ignoreWarnings = false}) async {
    final group = state.selected;
    if (group == null || state.busy) {
      return null;
    }
    final client = ref.read(ekpClientProvider);
    final store = ref.read(lastPaymentMethodStoreProvider);
    final status = ref.read(appStatusProvider.notifier);
    final sync = ref.read(ticketSyncProvider.notifier);
    state = state.copyWith(busy: true, failure: () => null);
    CheckoutOutcome outcome;
    try {
      final guid = state.ticketGuid;
      if (guid == null) {
        outcome = await _buy(client, group);
      } else {
        final response = await client.tickets.pay(
          ticketGuid: guid,
          tPayPaymentGroupId: group,
          ignoreWarnings: ignoreWarnings,
        );
        if (response.needsRepaymentConfirmation) {
          outcome = const CheckoutConfirmRepeat();
        } else if (response.isAlreadyPaid) {
          ref.invalidate(ticketDetailProvider);
          await sync.refresh();
          outcome = const CheckoutAlreadyPaid();
        } else {
          final url = response.urls?.paymentUrl;
          outcome = url == null ? _failed(EkpHttpException(message: response.message)) : CheckoutOpen(url, guid);
        }
      }
      if (outcome is CheckoutOpen) {
        await store.write(group);
      }
    } on EkpApiException catch (error) {
      if (error is EkpNetworkException) {
        status.markOffline();
      }
      outcome = _failed(error);
    }
    if (ref.mounted) {
      state = state.copyWith(busy: false);
    }
    return outcome;
  }

  Future<CheckoutOutcome> _buy(EkpClient client, String group) async {
    final choice = entry.choice;
    final customerCode = ref.read(userDataProvider).value?.mkkmData?.customerCode;
    if (choice == null || customerCode == null) {
      return _failed(StateError('nothing to buy'));
    }
    final response = await client.tickets.buy(
      tPayPaymentGroupId: group,
      validFrom: choice.validFrom,
      ticketNumberOfLineCode: choice.ticketNumberOfLineCode,
      customerCode: customerCode,
      ticketKindCode: choice.ticketKindCode,
      ticketPeriodCode: choice.ticketPeriodCode,
      lines: choice.lines,
      specialTransportLine: choice.specialTransportLine,
    );
    final guid = response.ticket?.ticketGuid;
    final url = response.urls?.paymentUrl;
    // The official client judges a buy by its status and its urls alone.
    if (guid == null || url == null) {
      return _failed(EkpHttpException(message: response.message));
    }
    if (ref.mounted) {
      state = state.copyWith(ticketGuid: () => guid);
    }
    // The ticket now waits for its payment in the Tickets list.
    unawaited(ref.read(ticketSyncProvider.notifier).refresh());
    return CheckoutOpen(url, guid);
  }

  CheckoutOutcome _failed(Object error) {
    if (ref.mounted) {
      state = state.copyWith(failure: () => error);
    }
    return const CheckoutFailed();
  }
}

final checkoutProvider = NotifierProvider.autoDispose.family<CheckoutController, CheckoutState, CheckoutEntry>(
  CheckoutController.new,
);
