import 'dart:async';

import 'package:clock/clock.dart';
import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_kkm/core/providers/app_startup_provider.dart';
import 'package:mobile_kkm/core/providers/dictionary_providers.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/features/account/providers/user_data_provider.dart';
import 'package:mobile_kkm/features/auth/providers/auth_controller.dart';
import 'package:mobile_kkm/features/purchase/models/purchase_selection.dart';
import 'package:mobile_kkm/features/purchase/models/sales_rules.dart';
import 'package:mobile_kkm/features/tickets/providers/tickets_providers.dart';

/// How long the sales configuration is reused, as in the official client.
const salesConfigurationLifetime = Duration(minutes: 5);

/// The last sales configuration and when it came; replaced at sign-out.
class _SalesCache {
  String? customerCode;
  DateTime? fetchedAt;
  SalesRules? rules;

  SalesRules? freshFor(String customerCode, DateTime now) {
    final at = fetchedAt;
    if (this.customerCode != customerCode || at == null || now.difference(at) >= salesConfigurationLifetime) {
      return null;
    }
    return rules;
  }
}

final _salesCacheProvider = Provider<_SalesCache>((ref) {
  ref.watch(authControllerProvider.select((state) => state.status));
  return _SalesCache();
});

/// `tickets/ticket-sales-configuration/{customerCode}`: what can be bought.
/// An answer is reused for [salesConfigurationLifetime], also by the next
/// screen that asks, and forgotten at sign-out. A configuration without
/// types, sent with a message, is a refusal.
final salesConfigurationProvider = FutureProvider.autoDispose<SalesRules>((ref) async {
  final signedIn = ref.watch(authControllerProvider.select((state) => state.status == AuthStatus.authenticated));
  if (!signedIn) {
    throw StateError('signed out');
  }
  final cache = ref.watch(_salesCacheProvider);
  final customerCode = await ref.watch(userDataProvider.selectAsync((data) => data?.mkkmData?.customerCode));
  if (customerCode == null) {
    throw StateError('no customer code');
  }
  final cached = cache.freshFor(customerCode, clock.now());
  if (cached != null) {
    return cached;
  }
  final status = ref.read(appStatusProvider.notifier);
  final TicketSalesConfiguration config;
  try {
    config = await ref.watch(ekpClientProvider).tickets.salesConfiguration(customerCode);
  } on EkpNetworkException {
    status.markOffline();
    rethrow;
  }
  if (config.specialTransportLines.isEmpty && (config.message?.isNotEmpty ?? false)) {
    throw EkpHttpException(message: config.message, statusCode: 200, code: config.code);
  }
  final rules = SalesRules(config);
  cache
    ..customerCode = customerCode
    ..fetchedAt = clock.now()
    ..rules = rules;
  return rules;
}, retry: (_, _) => null);

/// The purchase form: the rules, what is chosen, and the start's range.
class PurchaseForm {
  const PurchaseForm({required this.rules, required this.selection, required this.bounds, this.prefilled = false});

  final SalesRules rules;
  final PurchaseSelection selection;
  final StartBounds bounds;

  /// Filled in from a ticket: all sections appear at once.
  final bool prefilled;

  PurchaseSection? get nextMissing => rules.nextMissing(selection);

  List<PurchaseSection> get visibleSections => rules.visibleSections(selection);

  /// The complete choice to price, or null.
  TicketChoice? get choice => rules.choiceOf(selection);

  PurchaseForm withSelection(PurchaseSelection selection) =>
      PurchaseForm(rules: rules, selection: selection, bounds: bounds, prefilled: prefilled);
}

/// The purchase form's answers. Each change is reconciled: answers that
/// stop being valid are dropped, the rest kept.
class PurchaseFormController extends AsyncNotifier<PurchaseForm> {
  PurchaseFormController(this.entry);

  final PurchaseEntry entry;

  @override
  Future<PurchaseForm> build() async {
    final rules = await ref.watch(salesConfigurationProvider.future);
    final source = await _sourceTicket();
    final now = clock.now();
    final bounds = rules.startBounds(now, extending: entry.source == PurchaseSource.extend ? source : null);
    if (source == null) {
      return PurchaseForm(
        rules: rules,
        selection: rules.reconcile(PurchaseSelection(startDate: bounds.initial)),
        bounds: bounds,
      );
    }
    final selection = rules.prefill(source, kindDictionary: await _kindDictionary(), startDate: bounds.initial);
    return PurchaseForm(rules: rules, selection: selection, bounds: bounds, prefilled: true);
  }

  /// The ticket to fill the form in from: its details' copy, else the
  /// stored one, else none (an empty form).
  Future<MkkmTicket?> _sourceTicket() async {
    final code = entry.transactionCode;
    if (code == null) {
      return null;
    }
    try {
      final detail = await ref.read(ticketDetailProvider(code).future);
      if (detail.ticketEkp != null) {
        return detail.ticketEkp;
      }
    } on Object {
      // Fall back to the stored copy.
    }
    return ref.read(storedTicketProvider(code))?.ticket;
  }

  Future<List<TicketKind>> _kindDictionary() async {
    try {
      return (await ref.read(ticketKindsProvider.future)).kinds;
    } on Object {
      // Without it only fares the configuration sells as they are are kept.
      return const [];
    }
  }

  void _update(PurchaseSelection Function(PurchaseSelection selection) change) {
    final form = state.value;
    if (form == null) {
      return;
    }
    state = AsyncData(form.withSelection(form.rules.reconcile(change(form.selection))));
  }

  void setType(String type) => _update((s) => s.copyWith(type: () => type));

  void setKind(int kind) => _update((s) => s.copyWith(kind: () => kind));

  /// Turns a zone tile on or off; fixed zones stay as they are.
  void toggleZone(int zone) => _update((s) {
    final zones = {...s.zones};
    if (!zones.remove(zone)) {
      zones.add(zone);
    }
    return s.copyWith(zones: zones);
  });

  void setLineOption(int option) => _update((s) => s.copyWith(lineOption: () => option));

  void setLines(List<TransportLine> lines) => _update((s) => s.copyWith(lines: lines));

  void removeLine(TransportLine line) => _update(
    (s) => s.copyWith(
      lines: [
        for (final picked in s.lines)
          if (picked.line != line.line) picked,
      ],
    ),
  );

  void setPeriod(int period) => _update((s) => s.copyWith(period: () => period));

  /// Sets the first day, moved into the allowed range.
  void setStart(DateTime day) {
    final bounds = state.value?.bounds;
    if (bounds == null) {
      return;
    }
    final clamped = bounds.clamp(DateTime(day.year, day.month, day.day));
    _update((s) => s.copyWith(startDate: () => clamped));
  }
}

final purchaseFormProvider = AsyncNotifierProvider.autoDispose
    .family<PurchaseFormController, PurchaseForm, PurchaseEntry>(PurchaseFormController.new, retry: (_, _) => null);

/// The price bar's state.
sealed class PriceState {
  const PriceState();
}

/// Nothing to price yet.
class PriceIdle extends PriceState {
  const PriceIdle();
}

class PriceCalculating extends PriceState {
  const PriceCalculating();
}

class PricePriced extends PriceState {
  const PricePriced(this.calculation, this.choice);

  final TicketCalculation calculation;

  /// What was priced, as `tickets/buy` is to send it.
  final TicketChoice choice;
}

/// The server refused the choice, or the call failed. Show, in this order:
/// the field-errors text when [fieldErrors], else [message] as sent, else
/// [error] through `describeError`.
class PriceRefused extends PriceState {
  const PriceRefused({this.message, this.fieldErrors = false, this.error});

  final String? message;
  final bool fieldErrors;
  final Object? error;
}

/// Prices the form's choice with `tickets/calculate` once it is complete,
/// 300 ms after the last change; answers to older choices are dropped.
class PriceController extends Notifier<PriceState> {
  PriceController(this.entry);

  final PurchaseEntry entry;

  static const debounce = Duration(milliseconds: 300);

  Timer? _timer;
  var _generation = 0;

  @override
  PriceState build() {
    ref.onDispose(() => _timer?.cancel());
    ref.listen(purchaseFormProvider(entry).select((form) => form.value?.choice), (_, choice) => _schedule(choice));
    final choice = ref.read(purchaseFormProvider(entry)).value?.choice;
    if (choice == null) {
      return const PriceIdle();
    }
    _start(choice);
    return const PriceCalculating();
  }

  void _schedule(TicketChoice? choice) {
    if (choice == null) {
      _timer?.cancel();
      _generation++;
      state = const PriceIdle();
      return;
    }
    _start(choice);
    state = const PriceCalculating();
  }

  void _start(TicketChoice choice) {
    _timer?.cancel();
    final generation = ++_generation;
    _timer = Timer(debounce, () => unawaited(_calculate(choice, generation)));
  }

  /// Asks again for the current choice (after a failed call).
  void retry() => _schedule(ref.read(purchaseFormProvider(entry)).value?.choice);

  Future<void> _calculate(TicketChoice choice, int generation) async {
    final client = ref.read(ekpClientProvider);
    final status = ref.read(appStatusProvider.notifier);
    final customerCode = ref.read(userDataProvider).value?.mkkmData?.customerCode;
    PriceState next;
    try {
      if (customerCode == null) {
        throw StateError('no customer code');
      }
      final calculation = await client.tickets.calculate(
        validFrom: choice.validFrom,
        ticketNumberOfLineCode: choice.ticketNumberOfLineCode,
        customerCode: customerCode,
        ticketKindCode: choice.ticketKindCode,
        ticketPeriodCode: choice.ticketPeriodCode,
        lines: choice.lines,
        specialTransportLine: choice.specialTransportLine,
      );
      next = calculation.isRefused
          ? PriceRefused(message: calculation.message, fieldErrors: calculation.fields != null)
          : PricePriced(calculation, choice);
    } on EkpHttpException catch (error) {
      next = PriceRefused(message: error.message, fieldErrors: error.fields != null, error: error);
    } on Object catch (error) {
      if (error is EkpNetworkException) {
        status.markOffline();
      }
      next = PriceRefused(error: error);
    }
    if (!ref.mounted || generation != _generation) {
      return;
    }
    state = next;
  }
}

final priceProvider = NotifierProvider.autoDispose.family<PriceController, PriceState, PurchaseEntry>(
  PriceController.new,
);
