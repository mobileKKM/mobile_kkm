import 'dart:async';
import 'dart:math' as math;

import 'package:barcode_widget/barcode_widget.dart';
import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/api/error_messages.dart';
import 'package:mobile_kkm/core/platform/screen_security.dart';
import 'package:mobile_kkm/core/providers/dictionary_providers.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/core/providers/platform_providers.dart';
import 'package:mobile_kkm/core/widgets/load_problem.dart';
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
    final data = ref.watch(userDataProvider).value;
    final stored = ref.watch(mkkmTicketsProvider).value;
    MkkmTicket? ticket;
    for (final entry in stored ?? const []) {
      if (entry.ticket.ticketGuid == widget.ticketGuid) {
        ticket = entry.ticket;
      }
    }
    final error = _error;

    final identity = _Identity(user: data?.userData, customerCode: data?.mkkmData?.customerCode);
    final card = _ControlTicket(
      ticket: ticket,
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
      appBar: AppBar(title: Text(l10n.ticketActionControl)),
      body: SafeArea(
        minimum: const EdgeInsets.only(bottom: 16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // The code keeps its place at the bottom, where a scanner is
            // held to it; only who it belongs to scrolls. A screen too short
            // for that scrolls as a whole.
            if (constraints.maxHeight < 620) {
              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 4, 24, 0),
                child: Column(children: [identity, const SizedBox(height: 16), card]),
              );
            }
            return Padding(
              padding: const EdgeInsets.fromLTRB(24, 4, 24, 0),
              child: Column(
                children: [
                  Expanded(child: SingleChildScrollView(child: identity)),
                  const SizedBox(height: 12),
                  card,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

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
    final nameSize = name.characters.length > 24 ? 24.0 : 28.0;
    return Column(
      children: [
        // On a short phone the photo gives way first.
        Center(
          child: UserAvatar(user: user, size: MediaQuery.sizeOf(context).height < 760 ? 80 : 112),
        ),
        if (name.isNotEmpty) ...[
          const SizedBox(height: 10),
          Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 3,
            style: theme.textTheme.headlineMedium?.copyWith(fontSize: nameSize, height: (nameSize + 6) / nameSize),
          ),
        ],
        if (customerCode != null) ...[
          const SizedBox(height: 2),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            children: [
              Text(
                l10n.ticketControlCustomerCode,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 13,
                  height: 18 / 13,
                  color: scheme.onSurfaceVariant,
                ),
              ),
              Text(
                customerCode!,
                style: theme.textTheme.headlineSmall?.copyWith(
                  height: 30 / 24,
                  letterSpacing: 1,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

// The ticket is the brand colour in both themes, so what lies on it does not
// follow the theme either.
const _onTicket = Color(0xFFFFFFFF);
const _quietOnTicket = Color(0xFFC7CBF5);
const _lowBackground = Color(0xFFFFDAD6);
const _lowForeground = Color(0xFF410002);
const _lowRing = Color(0xFFFFB4AB);

/// The ticket itself: what it is, the code inside its draining ring, and
/// the time the code has left.
class _ControlTicket extends ConsumerWidget {
  const _ControlTicket({
    required this.ticket,
    required this.token,
    required this.secondsLeft,
    required this.captured,
    required this.problem,
    required this.onRetry,
  });

  /// Null when the stored list does not have it (any more).
  final MkkmTicket? ticket;

  /// Null while there is no code to show.
  final String? token;
  final int secondsLeft;
  final bool captured;

  /// Why there is no code; null while one is shown or on its way.
  final String? problem;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final locale = l10n.localeName;
    final ticket = this.ticket;
    final token = this.token;
    final low = token != null && secondsLeft <= TicketControlScreen.lowSeconds;
    final time = '${secondsLeft ~/ 60}:${(secondsLeft % 60).toString().padLeft(2, '0')}';

    // What kind of ticket it is, from the dictionaries; each part shows once
    // its dictionary is there. The fare matters most: whether a discount
    // applies decides what else the inspector asks for.
    final fare = ticket == null ? null : ticketFare(ticket, ref.watch(ticketKindsProvider).value);
    final period = ticket == null ? null : ticketPeriod(ticket, ref.watch(ticketPeriodsProvider).value);
    final zone = ticket == null
        ? null
        : ticketZone(ticket.ticketNumberOfLineCode, ref.watch(ticketLineScopesProvider).value);
    final facts = [
      if (fare != null) (l10n.ticketControlFare, fare),
      if (zone != null) (l10n.ticketControlZone, zone.replaceFirst(RegExp('^strefa ', caseSensitive: false), '')),
      if (ticket?.endDate case final end?) (l10n.ticketControlValidUntil, formatDateTime(locale, end)),
    ];

    final Widget panel;
    if (problem != null) {
      panel = Container(
        decoration: BoxDecoration(color: scheme.surfaceContainerLow, borderRadius: BorderRadius.circular(18)),
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: LoadProblem(message: problem!, onRetry: onRetry),
        ),
      );
    } else if (token == null) {
      panel = Container(
        decoration: BoxDecoration(color: _onTicket.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(18)),
        alignment: Alignment.center,
        child: const SizedBox.square(dimension: 48, child: CircularProgressIndicator(strokeWidth: 4, color: _onTicket)),
      );
    } else if (captured) {
      panel = Container(
        decoration: BoxDecoration(color: _onTicket, borderRadius: BorderRadius.circular(18)),
        padding: const EdgeInsets.all(24),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
      // White in the dark theme too: a scanner needs the contrast.
      panel = Container(
        decoration: BoxDecoration(color: _onTicket, borderRadius: BorderRadius.circular(18)),
        padding: const EdgeInsets.all(12),
        child: BarcodeWidget(
          key: const Key('ticket-code'),
          barcode: Barcode.aztec(),
          data: token,
          color: Colors.black,
          drawText: false,
        ),
      );
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 364),
      child: Material(
        color: scheme.primaryContainer,
        elevation: 2,
        shadowColor: const Color(0x331C2050),
        borderRadius: BorderRadius.circular(28),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (ticket != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Text(
                      [ticketScope(l10n, ticket), ?period].join(' · '),
                      style: theme.textTheme.titleMedium?.copyWith(color: _onTicket),
                    ),
                    Wrap(
                      spacing: 20,
                      runSpacing: 8,
                      children: [
                        for (final (label, value) in facts)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 2,
                            children: [
                              Text(label, style: theme.textTheme.labelMedium?.copyWith(color: _quietOnTicket)),
                              Text(value, style: theme.textTheme.labelLarge?.copyWith(color: _onTicket)),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              )
            else
              const SizedBox(height: 14),
            // The ring is the code's lifetime: full at the start, draining
            // clockwise from the top.
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: AspectRatio(
                aspectRatio: 1,
                child: TweenAnimationBuilder<double>(
                  tween: Tween(end: token == null ? 0 : secondsLeft / TicketControlScreen.codeLifetime.inSeconds),
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOut,
                  builder: (context, left, child) => CustomPaint(
                    painter: _RingPainter(
                      left: problem == null ? left : null,
                      track: _onTicket.withValues(alpha: 0.18),
                      color: low ? _lowRing : _onTicket,
                    ),
                    child: child,
                  ),
                  child: Padding(padding: const EdgeInsets.all(14), child: panel),
                ),
              ),
            ),
            if (problem == null)
              Semantics(
                container: true,
                liveRegion: low,
                label: token == null ? l10n.ticketControlGettingCode : l10n.ticketControlTimeLeft(time),
                child: ExcludeSemantics(
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 60),
                    padding: const EdgeInsetsDirectional.fromSTEB(18, 8, 20, 8),
                    decoration: BoxDecoration(
                      color: low ? _lowBackground : null,
                      border: low ? null : Border(top: BorderSide(color: _onTicket.withValues(alpha: 0.18))),
                    ),
                    child: Row(
                      children: [
                        // Filled as well as red: never the colour alone.
                        Icon(
                          token == null ? Symbols.autorenew_rounded : Symbols.timer_rounded,
                          fill: low ? 1 : 0,
                          color: low ? _lowForeground : scheme.onPrimaryContainer,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            token == null ? l10n.ticketControlGettingCode : l10n.ticketControlCodeFor,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: low ? _lowForeground : _onTicket,
                            ),
                          ),
                        ),
                        Text(
                          token == null ? '–:––' : time,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            height: 30 / 24,
                            color: low ? _lowForeground : _onTicket,
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter({required this.left, required this.track, required this.color});

  /// The share of the code's time still ahead; no ring at all when null.
  final double? left;
  final Color track;
  final Color color;

  static const _width = 6.0;

  @override
  void paint(Canvas canvas, Size size) {
    final left = this.left;
    if (left == null) {
      return;
    }
    final rect = (Offset.zero & size).deflate(_width / 2);
    const radius = 30.0;
    // From twelve o'clock, clockwise: what is left of the time is what is
    // left of the outline, counted from its far end.
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
