import 'dart:async';
import 'dart:math' as math;

import 'package:barcode_widget/barcode_widget.dart';
import 'package:ekp_api/ekp_api.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/api/error_messages.dart';
import 'package:mobile_kkm/core/platform/screen_security.dart';
import 'package:mobile_kkm/core/providers/dictionary_providers.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/core/providers/platform_providers.dart';
import 'package:mobile_kkm/core/widgets/icon_tile.dart';
import 'package:mobile_kkm/features/account/providers/user_data_provider.dart';
import 'package:mobile_kkm/features/account/widgets/user_avatar.dart';
import 'package:mobile_kkm/features/tickets/providers/tickets_providers.dart';
import 'package:mobile_kkm/features/tickets/utils/ticket_format.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// What an inspector is shown: whose ticket it is, what kind, and its AZTEC
/// code.
///
/// A code is good for [codeLifetime]. The screen stays open: the next code
/// is fetched [renewAhead] before the current one runs out and takes its
/// place then, so there is normally always a code to scan. Only when that
/// fails is the code dropped, for the reason and a way to try again.
class TicketControlScreen extends ConsumerStatefulWidget {
  const TicketControlScreen({super.key, required this.ticketGuid});

  static const codeLifetime = Duration(seconds: 119);

  /// How long before the end of a code the next one is asked for.
  static const renewAhead = Duration(seconds: 10);

  /// From here on the countdown is drawn as a warning.
  static const lowSeconds = 15;

  final String ticketGuid;

  @override
  ConsumerState<TicketControlScreen> createState() => _TicketControlScreenState();
}

/// A fetched code and the moment it stops being good.
typedef _Code = ({String token, DateTime expiresAt});

class _TicketControlScreenState extends ConsumerState<TicketControlScreen> {
  _Code? _code;

  /// Fetched ahead, waiting for [_code] to run out.
  _Code? _next;

  /// A fetch is under way: the first one, or the one for [_next].
  bool _fetching = false;

  /// The last fetch brought no code. With a code still on the screen that
  /// only shows once its time is up.
  bool _fetchFailed = false;

  /// There is no code and none on its way.
  bool _failed = false;

  /// Why: the server's message, an exception, or nothing more specific.
  Object? _error;

  Timer? _timer;
  int _secondsLeft = 0;

  late final ScreenSecurity _security;
  StreamSubscription<bool>? _captureChanges;

  /// The screen is being recorded or mirrored (iOS).
  bool _captured = false;

  @override
  void initState() {
    super.initState();
    _security = ref.read(screenSecurityProvider);
    unawaited(_security.setSecure(true));
    _captureChanges = _security.captured.listen((captured) {
      if (mounted) {
        setState(() => _captured = captured);
      }
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
    unawaited(_fetch());
  }

  @override
  void dispose() {
    _timer?.cancel();
    unawaited(_captureChanges?.cancel());
    unawaited(_security.setSecure(false));
    super.dispose();
  }

  /// Asks for a code. It is shown at once when there is none on the screen,
  /// and kept as [_next] otherwise.
  Future<void> _fetch() async {
    if (_fetching) {
      return;
    }
    setState(() {
      _fetching = true;
      _fetchFailed = false;
      _failed = false;
    });
    _Code? code;
    Object? error;
    try {
      final response = await ref.read(ekpClientProvider).tickets.contract(widget.ticketGuid);
      // A refusal arrives as a reply like any other.
      if (response.code != null) {
        error = response.message;
      } else if (response.decodeAztec() case final token?) {
        // Its time runs from now, not from when it is first shown.
        code = (token: token, expiresAt: DateTime.now().add(TicketControlScreen.codeLifetime));
      }
    } on Exception catch (exception) {
      error = exception;
    }
    if (!mounted) {
      return;
    }
    setState(() {
      _fetching = false;
      if (code == null) {
        // The code on the screen stays until its time is up; see _tick.
        _error = error;
        _fetchFailed = true;
        _failed = _code == null;
      } else if (_code == null) {
        _show(code);
      } else {
        _next = code;
      }
    });
  }

  void _show(_Code code) {
    _code = code;
    _next = null;
    _error = null;
    _fetchFailed = false;
    _secondsLeft = _remaining(code);
  }

  // By the clock, not by counting ticks: they stop while the app is in the
  // background.
  // Rounded up: a fresh code has its whole lifetime, and 0 means over.
  static int _remaining(_Code code) =>
      (code.expiresAt.difference(DateTime.now()).inMicroseconds / Duration.microsecondsPerSecond).ceil();

  void _tick() {
    final code = _code;
    if (code == null) {
      return;
    }
    final left = math.min(_secondsLeft - 1, _remaining(code));
    if (left > 0) {
      setState(() => _secondsLeft = left);
      // One attempt per code: a failed one is reported when the time is up.
      if (left <= TicketControlScreen.renewAhead.inSeconds && _next == null && !_fetchFailed) {
        unawaited(_fetch());
      }
      return;
    }
    final next = _next;
    setState(() {
      if (next != null && _remaining(next) > 0) {
        _show(next);
      } else {
        // Out of time without a successor: nothing to scan any more.
        _code = null;
        _next = null;
        _secondsLeft = 0;
        _failed = !_fetching && _fetchFailed;
      }
    });
    // Also after a long time in the background, when nothing was fetched.
    if (_code == null && !_failed) {
      unawaited(_fetch());
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final data = ref.watch(userDataProvider).value;
    final stored = ref.watch(mkkmTicketsProvider).value;
    MkkmTicket? ticket;
    for (final entry in stored ?? const []) {
      if (entry.ticket.ticketGuid == widget.ticketGuid) {
        ticket = entry.ticket;
      }
    }
    final error = _error;
    final top = MediaQuery.viewPaddingOf(context).top;

    final identity = Column(
      children: [
        _Identity(user: data?.userData, customerCode: data?.mkkmData?.customerCode),
        if (ticket != null) ...[const SizedBox(height: 16), _TicketFacts(ticket)],
      ],
    );
    final code = _CodeBox(
      token: _code?.token,
      secondsLeft: _secondsLeft,
      captured: _captured,
      problem: _failed
          ? switch (error) {
              // The server's own wording (Polish only).
              final String message when message.isNotEmpty => message,
              final Exception exception => describeError(l10n, exception),
              _ => l10n.ticketControlError,
            }
          : null,
      onRetry: () => unawaited(_fetch()),
    );

    return Scaffold(
      body: Stack(
        children: [
          // The brand colour in both themes, down to the middle of the photo.
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: top + _barHeight + _photoOverlap,
            child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.dark,
              ),
              child: ColoredBox(color: scheme.primaryContainer),
            ),
          ),
          Column(
            children: [
              SizedBox(height: top),
              SizedBox(
                height: _barHeight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    children: [
                      IconButton(
                        tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                        color: _onHeader,
                        icon: const Icon(Symbols.close_rounded),
                        onPressed: () => unawaited(Navigator.of(context).maybePop()),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Semantics(
                          header: true,
                          child: Text(
                            l10n.ticketActionControl,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: _onHeader),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SafeArea(
                  top: false,
                  minimum: const EdgeInsets.only(bottom: 16),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // The code keeps its place at the bottom, where a
                      // scanner is held to it; only who it belongs to
                      // scrolls. A screen too short for that scrolls as a
                      // whole.
                      if (constraints.maxHeight < 620) {
                        return SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(children: [identity, const SizedBox(height: 16), code]),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            Expanded(child: SingleChildScrollView(child: identity)),
                            const SizedBox(height: 12),
                            code,
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

const _barHeight = 64.0;

/// How far the photo reaches up into the header.
const _photoOverlap = 52.0;

// The header is the brand colour in both themes, and the code's panel white,
// so what lies on them does not follow the theme either.
const _onHeader = Color(0xFFFFFFFF);
const _codePanel = Color(0xFFFFFFFF);

/// Whose ticket it is: photo, name and customer number, to compare with an
/// identity document.
class _Identity extends StatelessWidget {
  const _Identity({required this.user, required this.customerCode});

  final UserData? user;
  final String? customerCode;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final name = [user?.firstName, user?.lastName].whereType<String>().join(' ');
    // A long name gets smaller letters, never an ellipsis.
    final long = name.characters.length > 24;
    return Column(
      children: [
        // Half on the header. On a short phone the photo gives way first.
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(color: scheme.surface, shape: BoxShape.circle),
          child: UserAvatar(user: user, size: MediaQuery.sizeOf(context).height < 760 ? 72 : 96),
        ),
        if (name.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 3,
            style: theme.textTheme.headlineMedium?.copyWith(fontSize: long ? 20 : 24, height: long ? 26 / 20 : 32 / 24),
          ),
        ],
        if (customerCode != null) ...[
          const SizedBox(height: 6),
          Text(
            l10n.ticketControlCustomerCode,
            textAlign: TextAlign.center,
            style: theme.textTheme.labelMedium?.copyWith(letterSpacing: 0.4, color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: 2),
          Text(
            customerCode!,
            textAlign: TextAlign.center,
            style: theme.textTheme.labelLarge?.copyWith(
              fontSize: 16,
              height: 22 / 16,
              letterSpacing: 0.5,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ],
    );
  }
}

/// What kind of ticket it is, from the dictionaries; each part shows once
/// its dictionary is there. The fare matters most: whether a discount
/// applies decides what else the inspector asks for.
class _TicketFacts extends ConsumerWidget {
  const _TicketFacts(this.ticket);

  final MkkmTicket ticket;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final zone = ticketZone(ticket.ticketNumberOfLineCode, ref.watch(ticketLineScopesProvider).value);
    final fare = ticketFare(ticket, ref.watch(ticketKindsProvider).value);
    final period = ticketPeriod(ticket, ref.watch(ticketPeriodsProvider).value);
    final facts = [
      if (zone != null) (l10n.ticketControlZone, zone),
      if (fare != null) (l10n.ticketControlFare, fare),
      if (period != null) (l10n.ticketControlPeriod, period),
    ];
    final value = theme.textTheme.labelLarge?.copyWith(fontSize: 16, height: 22 / 16);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: scheme.surfaceContainer, borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              IconTile(
                isTramTicket(ticket) ? Symbols.tram_rounded : Symbols.directions_bus_rounded,
                size: 40,
                background: scheme.primaryContainer,
                foreground: scheme.primaryFixed,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ticketScope(l10n, ticket), style: value),
                    if (ticket.endDate case final end?)
                      Text(
                        l10n.ticketControlValidUntil(formatDateTime(l10n.localeName, end)),
                        style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                      ),
                  ],
                ),
              ),
            ],
          ),
          if (facts.isNotEmpty) ...[
            const SizedBox(height: 14),
            Divider(height: 1, thickness: 1, color: scheme.outlineVariant),
            const SizedBox(height: 14),
            // Spread out while they fit on a line, wrapped where not.
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              spacing: 12,
              runSpacing: 8,
              children: [
                for (final (label, fact) in facts)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: theme.textTheme.labelMedium?.copyWith(
                          letterSpacing: 0.4,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      Text(fact, style: value),
                    ],
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// The code inside its draining ring, and under it the time it has left.
class _CodeBox extends StatelessWidget {
  const _CodeBox({
    required this.token,
    required this.secondsLeft,
    required this.captured,
    required this.problem,
    required this.onRetry,
  });

  /// Null while there is no code to show.
  final String? token;
  final int secondsLeft;
  final bool captured;

  /// Why there is no code; null while one is shown or on its way.
  final String? problem;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final token = this.token;
    final problem = this.problem;
    final low = token != null && secondsLeft <= TicketControlScreen.lowSeconds;
    final time = '${secondsLeft ~/ 60}:${(secondsLeft % 60).toString().padLeft(2, '0')}';

    final Widget box;
    if (problem != null) {
      // Neither ring nor time: there is nothing to count down.
      box = Container(
        decoration: BoxDecoration(color: scheme.surfaceContainer, borderRadius: BorderRadius.circular(34)),
        padding: const EdgeInsets.all(24),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              Icon(Symbols.cloud_off_rounded, size: 32, color: scheme.onSurfaceVariant),
              Text(problem, textAlign: TextAlign.center, style: theme.textTheme.bodyMedium),
              FilledButton.tonalIcon(
                style: FilledButton.styleFrom(
                  minimumSize: const Size(0, 40),
                  padding: const EdgeInsetsDirectional.only(start: 14, end: 18),
                  iconSize: 18,
                  textStyle: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w500),
                ),
                onPressed: onRetry,
                icon: const Icon(Symbols.refresh_rounded),
                label: Text(l10n.retry),
              ),
            ],
          ),
        ),
      );
    } else {
      final Widget panel;
      if (token == null) {
        panel = Center(
          child: SizedBox.square(
            dimension: 48,
            child: CircularProgressIndicator(strokeWidth: 4, color: scheme.primary),
          ),
        );
      } else if (captured) {
        panel = Padding(
          padding: const EdgeInsets.all(6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 12,
            children: [
              const Icon(Symbols.visibility_off_rounded, size: 40, color: Colors.black54),
              Text(
                l10n.ticketControlCaptureHidden,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black87),
              ),
            ],
          ),
        );
      } else {
        panel = BarcodeWidget(
          key: const Key('ticket-code'),
          barcode: Barcode.aztec(),
          data: token,
          color: Colors.black,
          drawText: false,
        );
      }
      // The ring is the code's lifetime: full at the start, its end drawing
      // back towards twelve o'clock.
      box = TweenAnimationBuilder<double>(
        tween: Tween(end: token == null ? 0 : secondsLeft / TicketControlScreen.codeLifetime.inSeconds),
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
        builder: (context, left, child) => CustomPaint(
          painter: _RingPainter(
            left: left,
            track: scheme.secondaryContainer,
            color: low ? scheme.error : scheme.primary,
          ),
          child: child,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          // White in the dark theme too: a scanner needs the contrast.
          child: Container(
            decoration: BoxDecoration(color: _codePanel, borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.all(18),
            child: panel,
          ),
        ),
      );
    }

    final (pillBackground, pillForeground) = low
        ? (scheme.errorContainer, scheme.onErrorContainer)
        : (scheme.secondaryContainer, scheme.onSecondaryContainer);
    return Column(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 340),
          child: AspectRatio(aspectRatio: 1, child: box),
        ),
        SizedBox(
          height: 52,
          child: problem != null
              ? null
              : Align(
                  alignment: Alignment.bottomCenter,
                  child: Semantics(
                    container: true,
                    liveRegion: low,
                    label: token == null ? l10n.ticketControlGettingCode : l10n.ticketControlTimeLeft(time),
                    child: ExcludeSemantics(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: 40,
                        padding: const EdgeInsetsDirectional.only(start: 12, end: 16),
                        decoration: BoxDecoration(color: pillBackground, borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 8,
                          children: [
                            // Filled as well as red: never the colour alone.
                            Icon(
                              token == null ? Symbols.hourglass_top_rounded : Symbols.timer_rounded,
                              size: 20,
                              fill: low ? 1 : 0,
                              color: pillForeground,
                            ),
                            Text(
                              token == null ? l10n.ticketControlGettingCode : time,
                              style: token == null
                                  ? theme.textTheme.labelLarge?.copyWith(color: pillForeground)
                                  : theme.textTheme.labelLarge?.copyWith(
                                      fontSize: 17,
                                      height: 22 / 17,
                                      color: pillForeground,
                                      fontFeatures: const [FontFeature.tabularFigures()],
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter({required this.left, required this.track, required this.color});

  /// The share of the code's time still ahead.
  final double left;
  final Color track;
  final Color color;

  static const _width = 10.0;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = (Offset.zero & size).deflate(_width / 2);
    // The box's own corner, less half the stroke.
    const radius = 34.0 - _width / 2;
    // From twelve o'clock, clockwise: what is left of the time is what is
    // left of the outline, counted from its start.
    final outline = Path()
      ..moveTo(rect.center.dx, rect.top)
      ..lineTo(rect.right - radius, rect.top)
      ..arcToPoint(Offset(rect.right, rect.top + radius), radius: const Radius.circular(radius))
      ..lineTo(rect.right, rect.bottom - radius)
      ..arcToPoint(Offset(rect.right - radius, rect.bottom), radius: const Radius.circular(radius))
      ..lineTo(rect.left + radius, rect.bottom)
      ..arcToPoint(Offset(rect.left, rect.bottom - radius), radius: const Radius.circular(radius))
      ..lineTo(rect.left, rect.top + radius)
      ..arcToPoint(Offset(rect.left + radius, rect.top), radius: const Radius.circular(radius))
      ..close();
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = _width
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(outline, stroke..color = track);
    if (left <= 0) {
      return;
    }
    final metric = outline.computeMetrics().first;
    canvas.drawPath(metric.extractPath(0, metric.length * left.clamp(0, 1)), stroke..color = color);
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.left != left || old.track != track || old.color != color;
}
