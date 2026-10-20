import 'dart:async';

import 'package:ekp_api/ekp_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/api/error_messages.dart';
import 'package:mobile_kkm/core/providers/dictionary_providers.dart';
import 'package:mobile_kkm/core/providers/platform_providers.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/core/widgets/bottom_action_bar.dart';
import 'package:mobile_kkm/core/widgets/empty_state_card.dart';
import 'package:mobile_kkm/core/widgets/message_banner.dart';
import 'package:mobile_kkm/core/widgets/skeleton_box.dart';
import 'package:mobile_kkm/core/widgets/submit_button.dart';
import 'package:mobile_kkm/features/purchase/models/payment_methods.dart';
import 'package:mobile_kkm/features/purchase/providers/purchase_notice_provider.dart';
import 'package:mobile_kkm/features/purchase/providers/purchase_providers.dart';
import 'package:mobile_kkm/features/purchase/services/checkout_controller.dart';
import 'package:mobile_kkm/features/purchase/services/payment_session.dart';
import 'package:mobile_kkm/features/purchase/widgets/payment_widgets.dart';
import 'package:mobile_kkm/features/purchase/widgets/purchase_form_widgets.dart';
import 'package:mobile_kkm/features/tickets/providers/tickets_providers.dart';
import 'package:mobile_kkm/features/tickets/utils/ticket_format.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// Pay for a ticket that waits for its payment ("Pay for ticket"), found by
/// its transaction code among the stored tickets. Continue payment loads the
/// ticket's [details] first, so the screen opens complete.
class TicketPayScreen extends ConsumerWidget {
  const TicketPayScreen({super.key, required this.transactionCode, required this.details});

  final String transactionCode;
  final TicketDetailResponse details;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final guid = ref.watch(storedTicketProvider(transactionCode))?.ticket.ticketGuid;
    if (guid == null) {
      final l10n = AppLocalizations.of(context);
      return Scaffold(
        appBar: AppBar(title: Text(l10n.payTicketTitle)),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
          children: [EmptyStateCard(icon: Symbols.error_rounded, title: l10n.ticketDetailsFailed, quiet: true)],
        ),
      );
    }
    return CheckoutScreen(entry: CheckoutEntry.pay(guid), transactionCode: transactionCode, details: details);
  }
}

/// Check and pay (25b): what is bought, how it is paid, and Pay.
class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key, required this.entry, this.transactionCode, this.details});

  final CheckoutEntry entry;

  /// The ticket paid for, when it was bought before, and its details.
  final String? transactionCode;
  final TicketDetailResponse? details;

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  CheckoutController get _controller => ref.read(checkoutProvider(widget.entry).notifier);

  Future<void> _pay({bool ignoreWarnings = false}) async {
    final outcome = await _controller.pay(ignoreWarnings: ignoreWarnings);
    if (!mounted) {
      return;
    }
    switch (outcome) {
      case CheckoutOpen(:final paymentUrl, :final ticketGuid):
        final scheme = Theme.of(context).colorScheme;
        await ref
            .read(paymentSessionProvider.notifier)
            .open(
              Uri.parse(paymentUrl),
              ticketGuid: ticketGuid,
              checkout: widget.entry,
              toolbarColor: scheme.surfaceContainer,
              tintColor: scheme.primary,
            );
      case CheckoutConfirmRepeat():
        if (await showPayAgainDialog(context) && mounted) {
          await _pay(ignoreWarnings: true);
        }
      case CheckoutAlreadyPaid():
        ref.read(purchaseNoticeProvider.notifier).add(PurchaseNotice.alreadyPaid);
        context.go(Routes.tickets);
      case CheckoutFailed() || null:
        break;
    }
  }

  Future<void> _chooseBank(PaymentMethods methods, String? selected) async {
    final bank = await showBankSheet(context, banks: methods.banks, selected: selected);
    final id = bank?.id;
    if (id != null) {
      _controller.select(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(checkoutProvider(widget.entry));
    final buying = widget.entry.choice != null;
    final summary = _Summary(entry: widget.entry, transactionCode: widget.transactionCode, details: widget.details);
    final price = summary.price(ref);
    final methods = state.methods;
    final failure = state.failure;
    final calculation = widget.entry.calculation;

    final children = <Widget>[
      const _ReturnLinkHint(),
      if (calculation?.hasSimilarTicket ?? false)
        MessageBanner(l10n.paySimilar, kind: BannerKind.info, icon: Symbols.warning_rounded),
      if (failure != null) MessageBanner(describeError(l10n, failure)),
      summary,
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionHeading(l10n.payMethod),
          switch (methods) {
            AsyncData(:final value) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MethodGrid(
                  children: [
                    for (final bank in value.tiles)
                      MethodTile(
                        bank: bank,
                        selected: bank.id == state.selected,
                        lastUsed: bank.id == state.lastUsed,
                        onTap: () => _controller.select(bank.id!),
                      ),
                  ],
                ),
                if (value.banks.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  BankRow(
                    bank: value.isBank(state.selected) ? value.byId(state.selected) : null,
                    lastUsed: value.isBank(state.lastUsed) && state.lastUsed == state.selected,
                    onTap: () => unawaited(_chooseBank(value, state.selected)),
                  ),
                ],
              ],
            ),
            AsyncError() => EmptyStateCard(
              icon: Symbols.cloud_off_rounded,
              title: l10n.payMethodsFailed,
              quiet: true,
              tonal: true,
              actionIcon: Symbols.refresh_rounded,
              actionLabel: l10n.retry,
              onAction: _controller.retryMethods,
            ),
            _ => SkeletonPulse(
              label: l10n.payMethod,
              child: const Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: SkeletonBox(height: 64, radius: 20)),
                      SizedBox(width: 8),
                      Expanded(child: SkeletonBox(height: 64, radius: 20)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(child: SkeletonBox(height: 64, radius: 20)),
                      SizedBox(width: 8),
                      Expanded(child: SkeletonBox(height: 64, radius: 20)),
                    ],
                  ),
                  SizedBox(height: 8),
                  SkeletonBox(height: 64, radius: 20),
                ],
              ),
            ),
          },
        ],
      ),
      PurchaseCaption(
        icon: Symbols.open_in_browser_rounded,
        text: defaultTargetPlatform == TargetPlatform.iOS ? l10n.payHowIos : l10n.payHowAndroid,
      ),
    ];

    final canPay = methods.hasValue && state.selected != null;
    final scaffold = Scaffold(
      appBar: AppBar(
        leading: buying
            ? null
            : IconButton(
                tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                icon: const Icon(Symbols.close_rounded),
                onPressed: state.busy ? null : () => context.pop(),
              ),
        title: Text(buying ? l10n.payTitle : l10n.payTicketTitle),
      ),
      body: Column(
        children: [
          Expanded(
            // While the order goes out, the screen stays as it is.
            child: AbsorbPointer(
              absorbing: state.busy,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                children: [
                  for (final (index, child) in children.indexed) ...[if (index > 0) const SizedBox(height: 16), child],
                ],
              ),
            ),
          ),
          BottomActionBar(
            child: SubmitButton(
              label: price == null ? l10n.payAgain : l10n.payButton(price),
              loading: state.busy,
              loadingLabel: l10n.payOpening,
              onPressed: canPay ? () => unawaited(_pay()) : null,
            ),
          ),
        ],
      ),
    );
    // Back is ignored while the order goes out. Once bought, the ticket
    // waits in Tickets: leaving goes there, not back to the form that would
    // buy it again.
    final bought = buying && state.bought;
    return PopScope(
      canPop: !state.busy && !bought,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && bought && !ref.read(checkoutProvider(widget.entry)).busy) {
          context.go(Routes.tickets);
        }
      },
      child: scaffold,
    );
  }
}

/// The ticket summary: from the calculation for a new ticket, from the
/// stored ticket and its details for one bought before.
class _Summary extends ConsumerWidget {
  const _Summary({required this.entry, this.transactionCode, this.details});

  final CheckoutEntry entry;
  final String? transactionCode;
  final TicketDetailResponse? details;

  /// The price on the Pay button.
  String? price(WidgetRef ref) {
    final value = entry.calculation?.price ?? _ticket(ref)?.price;
    return value == null ? null : formatPrice(value);
  }

  MkkmTicket? _ticket(WidgetRef ref) {
    final code = transactionCode;
    return code == null ? null : ref.watch(storedTicketProvider(code))?.ticket;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toString();
    final kinds = ref.watch(ticketKindsProvider).value;
    final periods = ref.watch(ticketPeriodsProvider).value;
    String daysLabel(int? days) => days == null || days == 7 ? l10n.payEveryDay : l10n.payDaysAWeek(days);

    final calculation = entry.calculation;
    final choice = entry.choice;
    if (calculation != null && choice != null) {
      final rules = ref.watch(salesConfigurationProvider).value;
      final option = rules?.config.ticketNumberOfLines
          .where((o) => o.code == choice.ticketNumberOfLineCode)
          .firstOrNull;
      final zone = (option?.description ?? '').split(' - ').last.trim();
      final lines = [for (final line in choice.lines) ?line.line];
      final scope = lines.isEmpty ? l10n.buyAllLines : l10n.payTicketLines(lines.length, lines.join(', '));
      final kind =
          kinds?.kinds.where((k) => k.code == calculation.ticketKindCode).firstOrNull?.description ??
          rules?.kinds.where((k) => k.code == choice.ticketKindCode).firstOrNull?.description;
      final period = rules?.config.ticketPeriods.where((p) => p.code == choice.ticketPeriodCode).firstOrNull;
      return PurchaseSummaryCard(
        title: zone.isEmpty ? scope : '$scope · $zone',
        subtitle: [?kind, ?period?.description].join(' · '),
        fields: [
          (label: l10n.payValidFrom, value: _when(locale, calculation.validFrom)),
          (label: l10n.payValidUntil, value: _when(locale, calculation.validTo)),
          (label: l10n.payProduct, value: calculation.commodityName ?? ''),
          (label: l10n.payValidOn, value: daysLabel(calculation.daysPeriod)),
        ],
        price: formatPrice(calculation.price ?? 0),
      );
    }

    final ticket = _ticket(ref);
    if (ticket == null) {
      return const SizedBox.shrink();
    }
    final scopes = ref.watch(ticketLineScopesProvider).value;
    final product = details?.ticketEkp?.productName;
    return PurchaseSummaryCard(
      title: ticketScope(l10n, ticket, zone: ticketZone(ticket.ticketNumberOfLineCode, scopes)),
      subtitle: [?ticketFare(ticket, kinds), ?ticketPeriod(ticket, periods)].join(' · '),
      fields: [
        (label: l10n.payValidFrom, value: _when(locale, ticket.startDate)),
        (label: l10n.payValidUntil, value: _when(locale, ticket.endDate)),
        if (product != null && product.isNotEmpty) (label: l10n.payProduct, value: product),
        (label: l10n.payValidOn, value: daysLabel(ticket.daysPeriod)),
      ],
      price: formatPrice(ticket.price ?? 0),
    );
  }

  static String _when(String locale, DateTime? date) => date == null ? '' : formatDateTime(locale, date);
}

/// Android, where return links are not allowed: how to let tPay's last
/// page bring the app back. Checked again on every return to the app.
class _ReturnLinkHint extends ConsumerStatefulWidget {
  const _ReturnLinkHint();

  @override
  ConsumerState<_ReturnLinkHint> createState() => _ReturnLinkHintState();
}

class _ReturnLinkHintState extends ConsumerState<_ReturnLinkHint> with WidgetsBindingObserver {
  bool? _canOpenLinks;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    unawaited(_refresh());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      unawaited(_refresh());
    }
  }

  Future<void> _refresh() async {
    final settings = ref.read(linkSettingsProvider);
    if (!settings.isSupported) {
      return;
    }
    final canOpen = await settings.canOpenLinks();
    if (mounted) {
      setState(() => _canOpenLinks = canOpen);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_canOpenLinks != false) {
      return const SizedBox.shrink();
    }
    final l10n = AppLocalizations.of(context);
    return MessageBanner(
      l10n.payLinkHint,
      kind: BannerKind.info,
      icon: Symbols.link_rounded,
      actionLabel: l10n.openLinkSettings,
      actionIcon: Symbols.open_in_new_rounded,
      onAction: () => unawaited(ref.read(linkSettingsProvider).openSettings()),
    );
  }
}
