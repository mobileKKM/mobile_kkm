import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/providers/platform_providers.dart';
import 'package:mobile_kkm/core/theme/app_theme.dart';
import 'package:mobile_kkm/core/widgets/icon_tile.dart';
import 'package:mobile_kkm/core/widgets/lead_header.dart';
import 'package:mobile_kkm/features/auth/widgets/auth_page.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// tPay's logo for a payment group: the one `payments/banks` names, else
/// tPay's own address for the group.
String logoUrlOf(Bank bank) => bank.img ?? 'https://secure.tpay.com/_/g/${bank.id}.png';

/// A payment logo on a white plate, white in both themes.
class LogoPlate extends ConsumerWidget {
  const LogoPlate({super.key, required this.bank, this.width = 56, this.height = 36});

  final Bank bank;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radius = BorderRadius.circular(8);
    return Container(
      width: width,
      height: height,
      // The logo within 48 × 28 on the small plate, 64 × 32 on the large;
      // the border lies over the plate's edge, not inside it.
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: const Color(0xFFFFFFFF), borderRadius: radius),
      foregroundDecoration: BoxDecoration(
        borderRadius: radius,
        border: Border.all(color: const Color(0x14000000)),
      ),
      child: Image(
        image: ref.watch(paymentLogosProvider).image(logoUrlOf(bank)),
        fit: BoxFit.contain,
        semanticLabel: bank.name,
        errorBuilder: (context, _, _) => const SizedBox.shrink(),
      ),
    );
  }
}

ShapeBorder _tileShape(ColorScheme scheme, {required bool selected, double radius = 20}) => RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(radius),
  side: selected ? BorderSide(color: scheme.primary, width: 2) : BorderSide.none,
);

/// A payment method in the 2-column grid.
class MethodTile extends StatelessWidget {
  const MethodTile({
    super.key,
    required this.bank,
    required this.selected,
    required this.lastUsed,
    required this.onTap,
  });

  final Bank bank;
  final bool selected;
  final bool lastUsed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Semantics(
      selected: selected,
      inMutuallyExclusiveGroup: true,
      child: Material(
        color: selected ? scheme.secondaryContainer : scheme.surfaceContainer,
        shape: _tileShape(scheme, selected: selected),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          // Stretched to a taller neighbour, the tile keeps its content in
          // the middle.
          child: Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 64),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Row(
                    children: [
                      ExcludeSemantics(child: LogoPlate(bank: bank)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(end: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                bank.name ?? '',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  height: 18 / 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (lastUsed)
                                Text(
                                  l10n.payLastUsed,
                                  style: theme.textTheme.labelMedium?.copyWith(color: scheme.primary),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (selected)
                PositionedDirectional(
                  top: 8,
                  end: 8,
                  child: Icon(Symbols.check_circle_rounded, fill: 1, size: 20, color: scheme.primary),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The method tiles, two per row.
class MethodGrid extends StatelessWidget {
  const MethodGrid({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var start = 0; start < children.length; start += 2) {
      if (rows.isNotEmpty) {
        rows.add(const SizedBox(height: 8));
      }
      rows.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: children[start]),
              const SizedBox(width: 8),
              Expanded(child: start + 1 < children.length ? children[start + 1] : const SizedBox.shrink()),
            ],
          ),
        ),
      );
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: rows);
  }
}

/// Bank transfer: opens the bank sheet; shows the bank once one is chosen.
class BankRow extends StatelessWidget {
  const BankRow({super.key, required this.bank, required this.lastUsed, required this.onTap});

  /// The chosen bank, if the choice is a bank.
  final Bank? bank;
  final bool lastUsed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final bank = this.bank;
    final selected = bank != null;
    final small = theme.textTheme.bodySmall?.copyWith(fontSize: 13, height: 18 / 13, color: scheme.onSurfaceVariant);
    return Semantics(
      selected: selected,
      button: true,
      child: Material(
        color: selected ? scheme.secondaryContainer : scheme.surfaceContainer,
        shape: _tileShape(scheme, selected: selected),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 64),
            child: Padding(
              padding: EdgeInsetsDirectional.only(start: 12, end: selected ? 8 : 4, top: 10, bottom: 10),
              child: Row(
                children: [
                  if (bank != null)
                    ExcludeSemantics(child: LogoPlate(bank: bank))
                  else
                    Container(
                      width: 56,
                      height: 36,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: scheme.surface, borderRadius: BorderRadius.circular(8)),
                      child: Icon(Symbols.account_balance_rounded, size: 22, color: scheme.primary),
                    ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bank?.name ?? l10n.payTransfer,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 15,
                            height: 20 / 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(bank == null ? l10n.payChooseBank : l10n.payTransfer, style: small),
                        if (lastUsed) ...[
                          const SizedBox(height: 2),
                          Text(l10n.payLastUsed, style: theme.textTheme.labelMedium?.copyWith(color: scheme.primary)),
                        ],
                      ],
                    ),
                  ),
                  if (bank == null)
                    Icon(Symbols.chevron_right_rounded, size: 24, color: scheme.onSurfaceVariant)
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(l10n.payChange, style: theme.textTheme.labelLarge?.copyWith(color: scheme.primary)),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// The banks of a transfer, in a sheet. Returns the one tapped.
Future<Bank?> showBankSheet(BuildContext context, {required List<Bank> banks, String? selected}) {
  return showModalBottomSheet<Bank>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    useSafeArea: true,
    builder: (context) {
      final l10n = AppLocalizations.of(context);
      final theme = Theme.of(context);
      final scheme = theme.colorScheme;
      final rows = <Widget>[];
      for (var start = 0; start < banks.length; start += 3) {
        if (rows.isNotEmpty) {
          rows.add(const SizedBox(height: 8));
        }
        rows.add(
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var i = start; i < start + 3; i++) ...[
                  if (i > start) const SizedBox(width: 8),
                  Expanded(
                    child: i < banks.length
                        ? _BankTile(
                            bank: banks[i],
                            selected: banks[i].id == selected,
                            onTap: () => Navigator.of(context).pop(banks[i]),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ],
            ),
          ),
        );
      }
      return SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 40 + MediaQuery.paddingOf(context).bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Semantics(header: true, child: Text(l10n.payBankSheetTitle, style: theme.textTheme.titleLarge)),
            const SizedBox(height: 4),
            Text(l10n.payBankSheetSub, style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 16),
            ...rows,
          ],
        ),
      );
    },
  );
}

class _BankTile extends StatelessWidget {
  const _BankTile({required this.bank, required this.selected, required this.onTap});

  final Bank bank;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Semantics(
      selected: selected,
      button: true,
      child: Material(
        color: selected ? scheme.secondaryContainer : scheme.surfaceContainerHigh,
        shape: _tileShape(scheme, selected: selected, radius: 16),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(6, 12, 6, 10),
            child: Column(
              children: [
                ExcludeSemantics(child: LogoPlate(bank: bank, width: 72, height: 40)),
                const SizedBox(height: 8),
                Text(bank.name ?? '', textAlign: TextAlign.center, style: theme.textTheme.labelMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// "Pay again?": an earlier payment of the ticket is unconfirmed.
Future<bool> showPayAgainDialog(BuildContext context) async {
  final l10n = AppLocalizations.of(context);
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      icon: const Icon(Symbols.sync_problem_rounded),
      title: Text(l10n.payRepeatTitle, textAlign: TextAlign.center),
      content: Text(l10n.payRepeatBody),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(l10n.cancel)),
        FilledButton(
          style: AppTheme.dialogAction,
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(l10n.payAgain),
        ),
      ],
    ),
  );
  return confirmed ?? false;
}

/// One key and value of the summary.
typedef SummaryField = ({String label, String value});

/// What is being paid for (25b).
class PurchaseSummaryCard extends StatelessWidget {
  const PurchaseSummaryCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.fields,
    required this.price,
  });

  final String title;
  final String subtitle;
  final List<SummaryField> fields;

  /// Already formatted.
  final String price;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final key = theme.textTheme.bodySmall?.copyWith(fontSize: 13, height: 18 / 13, color: scheme.onSurfaceVariant);
    final value = theme.textTheme.bodyMedium?.copyWith(fontSize: 15, height: 20 / 15, fontWeight: FontWeight.w500);
    final rows = <Widget>[];
    for (var start = 0; start < fields.length; start += 2) {
      if (rows.isNotEmpty) {
        rows.add(const SizedBox(height: 14));
      }
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = start; i < start + 2; i++) ...[
              if (i > start) const SizedBox(width: 20),
              Expanded(
                child: i < fields.length
                    ? MergeSemantics(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(fields[i].label, style: key),
                            Text(fields[i].value, style: value),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ],
        ),
      );
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                IconTile(
                  Symbols.directions_bus_rounded,
                  radius: 16,
                  iconSize: 24,
                  background: scheme.primaryContainer,
                  foreground: scheme.primaryFixed,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: theme.textTheme.titleMedium?.copyWith(fontSize: 17, height: 22 / 17)),
                      Text(subtitle, style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...rows,
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            MergeSemantics(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Expanded(
                    child: Text(
                      l10n.buyPrice,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Text(
                    price,
                    style: theme.textTheme.headlineMedium?.copyWith(fontFeatures: const [FontFeature.tabularFigures()]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A state of the Payment screen: its app bar over the activation
/// screens' centred layout.
class PaymentStatusView extends StatelessWidget {
  const PaymentStatusView({
    super.key,
    required this.title,
    this.body,
    this.icon,
    this.leading,
    this.notice,
    this.bottom,
  });

  final String title;
  final String? body;

  /// On the payment tone; without one a spinner on the waiting tone.
  final IconData? icon;

  /// The app bar's button; the slot stays empty without one, so the title
  /// keeps its place.
  final Widget? leading;
  final Widget? notice;
  final Widget? bottom;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final icon = this.icon;
    return AuthPage(
      title: AppLocalizations.of(context).payScreenTitle,
      leading: leading ?? const SizedBox.shrink(),
      centered: true,
      bottom: bottom,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (icon == null)
            LeadHeader.waiting(title: title, body: body)
          else
            LeadHeader(
              title: title,
              body: body,
              icon: icon,
              centered: true,
              tileColor: scheme.tertiaryFixed,
              iconColor: scheme.onTertiaryFixed,
            ),
          if (notice != null) ...[const SizedBox(height: 20), notice!],
        ],
      ),
    );
  }
}
