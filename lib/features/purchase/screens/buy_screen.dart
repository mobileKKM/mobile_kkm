import 'dart:async';
import 'dart:math' as math;

import 'package:clock/clock.dart';
import 'package:ekp_api/ekp_api.dart';
import 'package:flutter/rendering.dart' show RenderAbstractViewport;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/providers/app_startup_provider.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/core/widgets/app_status_banner.dart';
import 'package:mobile_kkm/core/widgets/empty_state_card.dart';
import 'package:mobile_kkm/core/widgets/message_banner.dart';
import 'package:mobile_kkm/core/widgets/skeleton_box.dart';
import 'package:mobile_kkm/features/purchase/models/purchase_selection.dart';
import 'package:mobile_kkm/features/purchase/models/sales_rules.dart';
import 'package:mobile_kkm/features/purchase/providers/purchase_providers.dart';
import 'package:mobile_kkm/features/purchase/services/checkout_controller.dart';
import 'package:mobile_kkm/features/purchase/utils/purchase_format.dart';
import 'package:mobile_kkm/features/purchase/widgets/price_bar.dart';
import 'package:mobile_kkm/features/purchase/widgets/purchase_form_widgets.dart';
import 'package:mobile_kkm/features/tickets/screens/line_search_screen.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// The text of the app configuration's sales announcement while it is due.
String? activeAnnouncement(MobileAppConfig? config, DateTime now) {
  final announcement = config?.salesViewAnnouncement;
  final text = announcement?.text;
  if (announcement == null || text == null || text.trim().isEmpty) {
    return null;
  }
  final start = announcement.startDate;
  final end = announcement.endDate;
  if ((start != null && now.isBefore(start)) || (end != null && now.isAfter(end))) {
    return null;
  }
  return text;
}

/// Choose a ticket (25a): one page, each section appearing once the one
/// above is answered, priced as soon as the choice is complete.
class BuyScreen extends ConsumerWidget {
  const BuyScreen({super.key, this.entry = const PurchaseEntry.fresh()});

  final PurchaseEntry entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final offline = ref.watch(appStatusProvider.select((status) => status.mode == AppMode.offline));
    final form = ref.watch(purchaseFormProvider(entry));
    final announcement = activeAnnouncement(ref.watch(mobileAppConfigProvider).value, clock.now());

    Future<void> refresh() async {
      if (ref.read(appStatusProvider).mode != AppMode.online) {
        await ref.read(appStatusProvider.notifier).check();
      }
      ref.invalidate(salesConfigurationProvider);
      await ref.read(purchaseFormProvider(entry).future).then<void>((_) {}, onError: (_) {});
    }

    final Widget body;
    Widget? bar;
    if (offline) {
      body = _Scroll(
        onRefresh: refresh,
        children: [
          const AppStatusBanner(),
          EmptyStateCard(icon: Symbols.cloud_off_rounded, title: l10n.buyOffline, quiet: true),
        ],
      );
    } else if (form.value case final value?) {
      body = _Form(entry: entry, form: value, announcement: announcement);
      bar = _Bar(entry: entry, form: value);
    } else if (form.hasError) {
      final error = form.error;
      final message = error is EkpApiException && (error.message?.isNotEmpty ?? false) ? error.message! : null;
      body = _Scroll(
        onRefresh: refresh,
        children: [
          if (announcement != null) _Announcement(announcement),
          EmptyStateCard(
            icon: Symbols.error_rounded,
            title: message ?? l10n.buyLoadFailed,
            quiet: true,
            tonal: true,
            actionIcon: Symbols.refresh_rounded,
            actionLabel: l10n.retry,
            onAction: () => ref.invalidate(salesConfigurationProvider),
          ),
        ],
      );
    } else {
      body = _Scroll(children: [if (announcement != null) _Announcement(announcement), const _FormSkeleton()]);
      bar = const PriceBar(price: PriceIdle(), hint: '', onContinue: null);
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
          icon: const Icon(Symbols.close_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text(entry.source == PurchaseSource.extend ? l10n.extendTitle : l10n.buyTitle),
      ),
      body: Column(
        children: [
          Expanded(child: body),
          ?bar,
        ],
      ),
    );
  }
}

class _Scroll extends StatelessWidget {
  const _Scroll({required this.children, this.onRefresh});

  final List<Widget> children;
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    final list = ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
      children: [
        for (final (index, child) in children.indexed) ...[if (index > 0) const SizedBox(height: 16), child],
      ],
    );
    final onRefresh = this.onRefresh;
    return onRefresh == null ? list : RefreshIndicator(onRefresh: onRefresh, child: list);
  }
}

class _Announcement extends StatelessWidget {
  const _Announcement(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => MessageBanner(text, kind: BannerKind.info, icon: Symbols.campaign_rounded);
}

/// The bottom bar: hint, price, Continue.
class _Bar extends ConsumerWidget {
  const _Bar({required this.entry, required this.form});

  final PurchaseEntry entry;
  final PurchaseForm form;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final price = ref.watch(priceProvider(entry));
    return PriceBar(
      price: price,
      hint: needHint(l10n, form),
      onContinue: switch (price) {
        PricePriced(:final calculation, :final choice) => () => unawaited(
          context.push(Routes.buyPay, extra: CheckoutEntry.buy(choice, calculation)),
        ),
        _ => null,
      },
    );
  }
}

class _Form extends ConsumerStatefulWidget {
  const _Form({required this.entry, required this.form, required this.announcement});

  final PurchaseEntry entry;
  final PurchaseForm form;
  final String? announcement;

  @override
  ConsumerState<_Form> createState() => _FormState();
}

class _FormState extends ConsumerState<_Form> {
  /// How much of a new section has to show: its heading and its first row
  /// (a tile; less where the whole section is lower).
  static const _firstRow = 64.0;

  final _headings = {for (final section in PurchaseSection.values) section: GlobalKey()};
  final _sectionKeys = {for (final section in PurchaseSection.values) section: GlobalKey()};
  final _scroll = ScrollController();

  PurchaseFormController get _controller => ref.read(purchaseFormProvider(widget.entry).notifier);

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(_Form old) {
    super.didUpdateWidget(old);
    final before = old.form.visibleSections.toSet();
    final added = widget.form.visibleSections.where((section) => !before.contains(section)).toList();
    if (added.isNotEmpty) {
      // Once laid out: the section is there at its full height.
      WidgetsBinding.instance.addPostFrameCallback((_) => _showSection(added.first));
    }
  }

  /// Scrolls just far enough to show [section]'s heading and first row
  /// above the bar, only if they are hidden, and not while the list is
  /// moving. A touch on the list stops the scroll.
  void _showSection(PurchaseSection section) {
    final box = _sectionKeys[section]?.currentContext?.findRenderObject();
    final heading = _headings[section]?.currentContext?.findRenderObject();
    if (!mounted || !_scroll.hasClients || box is! RenderBox || heading is! RenderBox) {
      return;
    }
    final position = _scroll.position;
    if (position.isScrollingNotifier.value) {
      return;
    }
    final shown = heading.size.height + math.min(box.size.height - heading.size.height, _firstRow);
    final viewport = RenderAbstractViewport.of(box);
    final target = math.min(
      viewport.getOffsetToReveal(box, 1, rect: Offset.zero & Size(box.size.width, shown)).offset,
      position.maxScrollExtent,
    );
    if (target <= position.pixels) {
      return;
    }
    if (MediaQuery.disableAnimationsOf(context)) {
      position.jumpTo(target);
    } else {
      unawaited(position.animateTo(target, duration: _Reveal.showDuration, curve: Easing.emphasizedDecelerate));
    }
  }

  Future<void> _pickLines(SalesLineOption option) async {
    final lines = await Navigator.of(context).push<List<TransportLine>>(
      MaterialPageRoute(
        builder: (_) =>
            LineSearchScreen.pick(max: option.sumLinesToSelection ?? 1, picked: widget.form.selection.lines),
      ),
    );
    if (lines != null) {
      _controller.setLines(lines);
    }
  }

  Future<void> _pickStart() async {
    final bounds = widget.form.bounds;
    final start = widget.form.selection.startDate ?? bounds.initial;
    final first = bounds.first ?? start;
    final last = bounds.last ?? DateTime(first.year + 1, first.month, first.day);
    final picked = await showDatePicker(
      context: context,
      initialDate: bounds.clamp(start),
      firstDate: first,
      lastDate: last.isBefore(first) ? first : last,
    );
    if (picked != null) {
      _controller.setStart(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toString();
    final form = widget.form;
    final rules = form.rules;
    final s = form.selection;
    final visible = form.visibleSections.toSet();
    final type = s.type;
    final kind = s.kind;
    final zones = rules.zonesIn(s);
    final fixed = rules.fixedZones(type);
    final product = rules.productOf(s);
    final controller = _controller;
    final typeIndex = rules.types.indexWhere((t) => t.specialTransportLine == type);

    Widget heading(PurchaseSection section, String title, {String? sub}) =>
        SectionHeading(key: _headings[section], title, sub: sub);

    final lineChoices = rules.lineChoices(type, zones);
    final lineProduct = lineChoices.where((option) => option.code == s.lineOption).firstOrNull;
    final scoped = lineProduct?.selectableLines == true;
    final maxLines = lineProduct?.sumLinesToSelection ?? 1;

    final sections = <PurchaseSection, Widget>{
      if (rules.showsTypes)
        PurchaseSection.type: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            heading(PurchaseSection.type, l10n.buyType),
            TypeRadioGroup(
              options: [for (final t in rules.types) (title: t.buttonName ?? t.name ?? '', sub: t.description)],
              selected: typeIndex < 0 ? null : typeIndex,
              onSelect: (index) => controller.setType(rules.types[index].specialTransportLine!),
            ),
          ],
        ),
      PurchaseSection.fare: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          heading(PurchaseSection.fare, l10n.buyFare),
          ChoiceTileGrid(
            children: [
              for (final k in rules.kinds)
                ChoiceTile(
                  label: k.description ?? '',
                  selected: k.code == kind,
                  enabled: rules.kindAvailable(type, k.code),
                  onTap: () => controller.setKind(k.code!),
                ),
            ],
          ),
        ],
      ),
      PurchaseSection.zone: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          heading(PurchaseSection.zone, l10n.buyZone, sub: fixed == null ? l10n.buyZoneSub : null),
          ChoiceTileGrid(
            children: [
              for (var zone = 0; zone < SalesRules.zoneCount; zone++)
                ChoiceTile(
                  label: rules.zoneLabel(zone),
                  selected: zones.contains(zone),
                  enabled: rules.zoneAvailable(type, kind, zone),
                  exclusive: false,
                  onTap: () {
                    if (fixed == null) {
                      controller.toggleZone(zone);
                    }
                  },
                ),
            ],
          ),
          for (final note in rules.notes(s)) ...[
            const SizedBox(height: 12),
            switch (note) {
              DiscountNote() => PurchaseCaption(icon: Symbols.percent_rounded, text: zoneNoteText(l10n, rules, note)),
              UnsoldZonesNote() => MessageBanner(
                zoneNoteText(l10n, rules, note),
                kind: BannerKind.info,
                icon: Symbols.info_rounded,
              ),
              FareZonesNote() => MessageBanner(
                zoneNoteText(l10n, rules, note),
                kind: BannerKind.info,
                icon: Symbols.block_rounded,
              ),
            },
          ],
        ],
      ),
      PurchaseSection.lines: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          heading(
            PurchaseSection.lines,
            l10n.buyLines,
            sub: !scoped
                ? null
                : s.lines.isEmpty
                ? l10n.buyLinesSub(maxLines)
                : l10n.buyLinesChosen(s.lines.length, maxLines),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final option in lineChoices)
                FilterChip(
                  label: Text(lineOptionLabel(l10n, option)),
                  selected: option.code == s.lineOption,
                  onSelected: rules.optionSold(type, kind, option)
                      ? (_) => controller.setLineOption(option.code!)
                      : null,
                ),
            ],
          ),
          if (scoped) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final line in s.lines) LineChip(line: line, onRemove: () => controller.removeLine(line)),
                if (s.lines.length < maxLines) AddLineButton(onPressed: () => unawaited(_pickLines(lineProduct!))),
              ],
            ),
          ],
        ],
      ),
      PurchaseSection.period: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          heading(PurchaseSection.period, l10n.buyDuration),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final period in rules.periodsFor(type))
                FilterChip(
                  label: Text(periodLabel(l10n, period)),
                  selected: period.code == s.period,
                  onSelected: rules.periodAvailable(type, kind, product?.code, period.code!)
                      ? (_) => controller.setPeriod(period.code!)
                      : null,
                ),
            ],
          ),
        ],
      ),
      PurchaseSection.start: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          heading(PurchaseSection.start, l10n.buyStarts),
          DateField(
            label: l10n.buyStarts,
            value: startDayLabel(locale, s.startDate ?? form.bounds.initial),
            helper: startRangeLabel(l10n, locale, form.bounds),
            onTap: () => unawaited(_pickStart()),
          ),
        ],
      ),
    };

    final announcement = widget.announcement;
    // Not lazy: a section further down than the list has built yet must
    // still be measured to be scrolled to.
    return SingleChildScrollView(
      controller: _scroll,
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (announcement != null) ...[_Announcement(announcement), const SizedBox(height: 16)],
          if (form.prefilled && form.bounds.extending) ...[
            MessageBanner(l10n.buyPrefilled, kind: BannerKind.info, icon: Symbols.event_repeat_rounded),
            const SizedBox(height: 16),
          ],
          for (final MapEntry(key: section, value: child) in sections.entries)
            _Reveal(
              visible: visible.contains(section),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: KeyedSubtree(key: _sectionKeys[section], child: child),
              ),
            ),
        ],
      ),
    );
  }
}

/// A section that fades in, 8 dp up, at its full height when it becomes
/// visible (so the list can scroll to it at once), and collapses when it no
/// longer applies. Shown at once on the first build (a prefilled form) and
/// with animations off.
class _Reveal extends StatefulWidget {
  const _Reveal({required this.visible, required this.child});

  static const showDuration = Duration(milliseconds: 250);
  static const hideDuration = Duration(milliseconds: 150);

  final bool visible;
  final Widget child;

  @override
  State<_Reveal> createState() => _RevealState();
}

class _RevealState extends State<_Reveal> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: _Reveal.showDuration,
    reverseDuration: _Reveal.hideDuration,
    value: widget.visible ? 1 : 0,
  );
  late final _curve = CurvedAnimation(
    parent: _controller,
    curve: Easing.emphasizedDecelerate,
    reverseCurve: Easing.emphasizedAccelerate,
  );

  @override
  void didUpdateWidget(_Reveal old) {
    super.didUpdateWidget(old);
    if (widget.visible == old.visible) {
      return;
    }
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.value = widget.visible ? 1 : 0;
    } else if (widget.visible) {
      unawaited(_controller.forward());
    } else {
      unawaited(_controller.reverse());
    }
  }

  @override
  void dispose() {
    _curve.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _curve,
      child: widget.child,
      builder: (context, child) {
        final t = _curve.value;
        if (_controller.isDismissed) {
          return const SizedBox.shrink();
        }
        if (_controller.isCompleted) {
          return child!;
        }
        return ClipRect(
          child: Align(
            alignment: Alignment.topCenter,
            // Grows only while collapsing; a new section is there at once.
            heightFactor: _controller.status == AnimationStatus.reverse ? t.clamp(0, 1) : 1,
            child: Opacity(
              opacity: t.clamp(0, 1),
              child: Transform.translate(offset: Offset(0, 8 * (1 - t)), child: child),
            ),
          ),
        );
      },
    );
  }
}

/// 25a/1: the form's shape while the configuration loads.
class _FormSkeleton extends StatelessWidget {
  const _FormSkeleton();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    Widget block(double height, double radius, {double? widthFactor}) => FractionallySizedBox(
      alignment: AlignmentDirectional.centerStart,
      widthFactor: widthFactor ?? 1,
      child: Container(
        height: height,
        decoration: BoxDecoration(color: scheme.surfaceContainer, borderRadius: BorderRadius.circular(radius)),
      ),
    );
    Widget label(double widthFactor, {bool first = false}) => Padding(
      padding: EdgeInsets.only(top: first ? 0 : 14),
      child: FractionallySizedBox(
        alignment: AlignmentDirectional.centerStart,
        widthFactor: widthFactor,
        child: const SkeletonBox(height: 14, radius: 7),
      ),
    );
    const gap = SizedBox(height: 10);
    return SkeletonPulse(
      label: l10n.buyTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          label(0.22, first: true),
          gap,
          block(64, 20),
          gap,
          label(0.28),
          gap,
          for (var i = 0; i < 4; i++) ...[block(64, 20), if (i < 3) const SizedBox(height: 2)],
          gap,
          label(0.30),
          gap,
          block(32, 8, widthFactor: 0.62),
          gap,
          label(0.24),
          gap,
          block(56, 6),
        ],
      ),
    );
  }
}
