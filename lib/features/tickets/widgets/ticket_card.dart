import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/theme/app_theme.dart';
import 'package:mobile_kkm/core/widgets/icon_tile.dart';
import 'package:mobile_kkm/core/widgets/status_chip.dart';
import 'package:mobile_kkm/features/tickets/utils/ticket_format.dart';

/// Which colours a ticket's state label takes.
enum TicketPillKind {
  /// "Valid" on a card in the ticket's own colour.
  validOnTone,

  /// "Valid" on a neutral card.
  valid,

  /// Any other state.
  plain,

  /// A state that is the card's whole point, such as an open payment.
  emphasis,
}

/// The state label of a [TicketCard].
class TicketPill {
  const TicketPill(this.label, this.icon, [this.kind = TicketPillKind.plain]);

  final String label;
  final IconData icon;
  final TicketPillKind kind;
}

/// The large line of a [TicketCard]: how long the ticket still runs.
class TicketHero {
  const TicketHero({required this.big, required this.unit, this.sub});

  /// A number, or a word such as "Today".
  final String big;
  final String unit;
  final String? sub;
}

/// The colours of one [TicketCard], for the card and whatever sits on it.
class TicketPalette {
  const TicketPalette({
    required this.background,
    required this.high,
    required this.medium,
    required this.tile,
    required this.onTile,
    required this.button,
    required this.onButton,
    required this.accent,
    required this.pill,
    required this.onPill,
  });

  /// [calm] keeps the card neutral and leaves the state to the icon tile,
  /// the label, the bar and the button.
  factory TicketPalette.of(BuildContext context, TicketTone tone, {required bool calm}) {
    final s = Theme.of(context).colorScheme;
    if (calm) {
      final (tile, onTile, button, onButton, accent, pill, onPill) = switch (tone) {
        TicketTone.valid => (
          s.primaryContainer,
          s.primaryFixed,
          s.primary,
          s.onPrimary,
          s.primary,
          s.primaryFixed,
          s.onPrimaryFixed,
        ),
        TicketTone.wait => (
          s.secondaryContainer,
          s.onSecondaryContainer,
          s.secondary,
          s.onSecondary,
          s.secondary,
          s.secondaryContainer,
          s.onSecondaryContainer,
        ),
        TicketTone.action => (
          s.tertiaryContainer,
          s.tertiaryFixed,
          s.tertiaryContainer,
          s.tertiaryFixed,
          s.tertiary,
          s.tertiaryFixed,
          s.onTertiaryFixed,
        ),
        TicketTone.over => (
          s.surface,
          s.onSurfaceVariant,
          s.secondary,
          s.onSecondary,
          s.onSurfaceVariant,
          s.surfaceContainerHighest,
          s.onSurface,
        ),
      };
      return TicketPalette(
        background: s.surfaceContainer,
        high: s.onSurface,
        medium: s.onSurfaceVariant,
        tile: tile,
        onTile: onTile,
        button: button,
        onButton: onButton,
        accent: accent,
        pill: pill,
        onPill: onPill,
      );
    }
    final (background, high, medium, tile, onTile, button, onButton) = switch (tone) {
      // Fixed roles on the brand surface: the same card day and night.
      TicketTone.valid => (
        s.primaryContainer,
        s.primaryFixed,
        s.onPrimaryContainer,
        s.primaryFixed,
        s.onPrimaryFixed,
        s.primaryFixed,
        s.onPrimaryFixed,
      ),
      TicketTone.wait => (
        s.secondaryContainer,
        s.onSurface,
        s.onSecondaryContainer,
        s.secondary,
        s.onSecondary,
        s.secondary,
        s.onSecondary,
      ),
      TicketTone.action => (
        s.tertiaryContainer,
        s.tertiaryFixed,
        s.onTertiaryContainer,
        s.tertiaryFixed,
        s.onTertiaryFixed,
        s.tertiaryFixed,
        s.onTertiaryFixed,
      ),
      TicketTone.over => (
        s.surfaceContainerHigh,
        s.onSurface,
        s.onSurfaceVariant,
        s.surface,
        s.onSurfaceVariant,
        s.secondary,
        s.onSecondary,
      ),
    };
    return TicketPalette(
      background: background,
      high: high,
      medium: medium,
      tile: tile,
      onTile: onTile,
      button: button,
      onButton: onButton,
      accent: high,
      pill: s.surface,
      onPill: s.onSurface,
    );
  }

  final Color background;

  /// Titles and figures.
  final Color high;

  /// Everything quieter.
  final Color medium;
  final Color tile;
  final Color onTile;
  final Color button;
  final Color onButton;

  /// The bar that shows the time left.
  final Color accent;
  final Color pill;
  final Color onPill;
}

/// Hands a card's [TicketPalette] to the buttons placed on it.
class TicketCardColors extends InheritedWidget {
  const TicketCardColors({super.key, required this.palette, required super.child});

  final TicketPalette palette;

  static TicketPalette of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<TicketCardColors>()!.palette;

  @override
  bool updateShouldNotify(TicketCardColors old) => old.palette != palette;
}

/// One ticket: what it covers, its state, how long it still runs, and on a
/// perforated stub the one thing to do with it.
class TicketCard extends StatelessWidget {
  const TicketCard({
    super.key,
    required this.title,
    this.subtitle,
    this.subtitleLoading = false,
    this.icon = Symbols.directions_bus_rounded,
    this.tone = TicketTone.over,
    this.calm = true,
    this.pill,
    this.hero,
    this.range,
    this.left,
    this.meta,
    this.price,
    this.trailing,
    this.stub,
    this.onTap,
  });

  final String title;

  /// The product's name, under what it covers.
  final String? subtitle;

  /// A grey bar in the place of a [subtitle] still on its way, so that the
  /// card does not jump when it arrives.
  final bool subtitleLoading;
  final IconData icon;
  final TicketTone tone;

  /// A neutral card; otherwise the whole card takes the tone's colour.
  final bool calm;
  final TicketPill? pill;
  final TicketHero? hero;

  /// The validity in full, for a ticket without a [hero].
  final String? range;

  /// The share of the time still ahead, drawn as a bar; none when null.
  final double? left;

  /// A quiet line above the stub, opposite the [price].
  final String? meta;
  final String? price;

  /// Beside the title, e.g. the pin.
  final Widget? trailing;

  /// Below the perforation.
  final Widget? stub;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final colors = AppColors.of(context);
    final palette = TicketPalette.of(context, tone, calm: calm);
    final quiet = theme.textTheme.bodyMedium?.copyWith(color: palette.medium);
    final note = quiet?.copyWith(fontSize: 15, height: 22 / 15);
    final pill = this.pill;
    final hero = this.hero;
    final range = this.range;
    final left = this.left;

    final (pillBackground, pillForeground) = switch (pill?.kind) {
      TicketPillKind.validOnTone => (colors.successFixed, colors.onSuccessFixed),
      TicketPillKind.valid => (colors.successContainer, colors.onSuccessContainer),
      TicketPillKind.emphasis when !calm => (palette.high, palette.background),
      _ => (palette.pill, palette.onPill),
    };

    return TicketCardColors(
      palette: palette,
      child: Material(
        color: palette.background,
        borderRadius: BorderRadius.circular(28),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 16, 8, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 48),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: IconTile(
                              icon,
                              radius: 16,
                              iconSize: 24,
                              background: palette.tile,
                              foreground: palette.onTile,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 1),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(title, style: theme.textTheme.titleMedium?.copyWith(color: palette.high)),
                                  if (subtitle != null) ...[
                                    const SizedBox(height: 2),
                                    Text(subtitle!, style: quiet),
                                  ] else if (subtitleLoading)
                                    Container(
                                      key: const Key('ticket-subtitle-loading'),
                                      height: 20,
                                      margin: const EdgeInsets.only(top: 2),
                                      alignment: AlignmentDirectional.centerStart,
                                      child: Container(
                                        width: 148,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          color: palette.pill,
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          trailing ?? const SizedBox(width: 4),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: 10,
                        children: [
                          if (pill != null)
                            Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: StatusChip(
                                pill.label,
                                icon: pill.icon,
                                background: pillBackground,
                                foreground: pillForeground,
                              ),
                            ),
                          if (hero != null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: hero.big,
                                    style: theme.textTheme.displayLarge?.copyWith(
                                      color: palette.high,
                                      fontFeatures: const [FontFeature.tabularFigures()],
                                    ),
                                    children: [
                                      TextSpan(
                                        text: '  ${hero.unit}',
                                        style: theme.textTheme.titleLarge?.copyWith(
                                          fontSize: 20,
                                          height: 26 / 20,
                                          letterSpacing: 0,
                                          color: palette.high,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (hero.sub != null) ...[const SizedBox(height: 2), Text(hero.sub!, style: note)],
                              ],
                            )
                          else if (range != null && range.isNotEmpty)
                            Text(range, style: note),
                          if (left != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: LinearProgressIndicator(
                                  value: left,
                                  minHeight: 10,
                                  color: palette.accent,
                                  backgroundColor: palette.medium.withValues(alpha: 0.32),
                                  // The track's own gap and end dot belong to a loading bar.
                                  stopIndicatorColor: Colors.transparent,
                                  trackGap: 0,
                                ),
                              ),
                            ),
                          if ((meta != null && meta!.isNotEmpty) || price != null)
                            Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              crossAxisAlignment: WrapCrossAlignment.end,
                              spacing: 12,
                              children: [
                                Text(meta ?? '', style: quiet?.copyWith(fontSize: 13, height: 18 / 13)),
                                if (price != null)
                                  Text(
                                    price!,
                                    style: theme.textTheme.labelLarge?.copyWith(
                                      fontSize: 15,
                                      color: palette.high,
                                      fontFeatures: const [FontFeature.tabularFigures()],
                                    ),
                                  ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (stub != null) ...[
                // The card always lies on the surface, so the notches are
                // drawn in its colour.
                _Perforation(line: palette.medium.withValues(alpha: 0.55), notch: scheme.surface),
                Padding(padding: const EdgeInsets.fromLTRB(16, 8, 16, 16), child: stub),
              ] else
                const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}

/// The tear-off line between a ticket and its stub: a notch at either edge
/// and a dashed line between them.
class _Perforation extends StatelessWidget {
  const _Perforation({required this.line, required this.notch});

  final Color line;
  final Color notch;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 24,
    child: CustomPaint(
      painter: _PerforationPainter(line: line, notch: notch),
    ),
  );
}

class _PerforationPainter extends CustomPainter {
  const _PerforationPainter({required this.line, required this.notch});

  final Color line;
  final Color notch;

  @override
  void paint(Canvas canvas, Size size) {
    final y = size.height / 2;
    final fill = Paint()..color = notch;
    canvas
      ..drawCircle(Offset(0, y), 12, fill)
      ..drawCircle(Offset(size.width, y), 12, fill);
    final stroke = Paint()
      ..color = line
      ..strokeWidth = 2;
    for (var x = 22.0; x < size.width - 22; x += 10) {
      canvas.drawLine(Offset(x, y), Offset(x + 6 > size.width - 22 ? size.width - 22 : x + 6, y), stroke);
    }
  }

  @override
  bool shouldRepaint(_PerforationPainter old) => old.line != line || old.notch != notch;
}
