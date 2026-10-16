import 'dart:async';
import 'dart:math' as math;

import 'package:barcode_widget/barcode_widget.dart';
import 'package:clock/clock.dart';
import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/platform/scan_display.dart';
import 'package:mobile_kkm/core/platform/screen_security.dart';
import 'package:mobile_kkm/core/providers/aztec_key_provider.dart';
import 'package:mobile_kkm/core/providers/dictionary_providers.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/core/providers/platform_providers.dart';
import 'package:mobile_kkm/core/widgets/code_screen/code_screen.dart';
import 'package:mobile_kkm/core/widgets/code_screen/code_state.dart';
import 'package:mobile_kkm/features/account/providers/user_data_provider.dart';
import 'package:mobile_kkm/features/tickets/providers/tickets_providers.dart';
import 'package:mobile_kkm/features/tickets/utils/ticket_format.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// What an inspector is shown: whose ticket it is, what kind, and its AZTEC
/// code.
///
/// A code is shown for [codeLifetime], less than the server gives it. The
/// screen stays open: the next code is fetched [renewAhead] before the
/// current one's time is up and takes its place then, with the whole
/// [codeLifetime] of its own, so there is normally always a code to scan.
/// Only when that fails is the code dropped, for the reason and a way to
/// try again.
///
/// While the app is away (hidden) the time is not counted and nothing is
/// fetched: the phone may have frozen the app, and a request from there
/// fails. Back on the screen the code goes on if it still has time, and is
/// replaced otherwise.
class TicketControlScreen extends ConsumerStatefulWidget {
  const TicketControlScreen({super.key, required this.ticketGuid});

  /// How long an inspector's scanner takes a code for, counted from when the
  /// server made it. The server's reply no longer says so.
  static const codeValidity = Duration(minutes: 2);

  /// How long a code is shown for: well inside [codeValidity], which leaves
  /// room for a code that waited before it was shown.
  static const codeLifetime = Duration(seconds: 90);

  /// How long before the end of a code the next one is asked for.
  static const renewAhead = Duration(seconds: 10);

  final String ticketGuid;

  @override
  ConsumerState<TicketControlScreen> createState() => _TicketControlScreenState();
}

/// A code on the screen and the moment it leaves it.
typedef _Code = ({String token, DateTime expiresAt});

/// A code as it came from the server.
typedef _Fetched = ({String token, DateTime fetchedAt});

class _TicketControlScreenState extends ConsumerState<TicketControlScreen> {
  _Code? _code;

  /// Fetched ahead, waiting for [_code] to run out.
  _Fetched? _next;

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

  /// When [_secondsLeft] was counted.
  DateTime _countedAt = clock.now();

  /// The app is hidden: the timer stands, and a fetch that ends meanwhile
  /// is kept for the return.
  bool _away = false;
  late final AppLifecycleListener _lifecycle;

  late final ScanDisplay _display;
  late final ScreenSecurity _security;
  StreamSubscription<bool>? _captureChanges;

  /// The screen is being recorded or mirrored (iOS).
  bool _captured = false;

  /// What the code area shows, and the enlarged code with it.
  final _state = ValueNotifier<CodeState>(const CodeLoading());

  @override
  void initState() {
    super.initState();
    // For as long as the screen is open, not per code: there is normally
    // always one to scan.
    _display = ref.read(scanDisplayProvider);
    unawaited(_display.setActive(true));
    _security = ref.read(screenSecurityProvider);
    unawaited(_security.setSecure(true));
    _captureChanges = _security.captured.listen((captured) {
      if (mounted) {
        _captured = captured;
        _publish();
      }
    });
    // Hidden, not inactive: the notification shade or a glance at the app
    // switcher leaves the code running.
    _lifecycle = AppLifecycleListener(onHide: _leave, onShow: _return);
    unawaited(_fetch());
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    _timer?.cancel();
    unawaited(_captureChanges?.cancel());
    unawaited(_security.setSecure(false));
    unawaited(_display.setActive(false));
    _state.dispose();
    super.dispose();
  }

  /// Puts what the fields say on the screen.
  void _publish() {
    final code = _code;
    if (_failed) {
      _state.value = CodeFailed(codeProblem(AppLocalizations.of(context), _error));
    } else if (code == null) {
      _state.value = const CodeLoading();
    } else if (_captured) {
      _state.value = CodeHidden(
        id: code.token,
        secondsLeft: _secondsLeft,
        lifetime: TicketControlScreen.codeLifetime.inSeconds,
        since: _countedAt,
      );
    } else {
      _state.value = CodeShown(
        id: code.token,
        secondsLeft: _secondsLeft,
        lifetime: TicketControlScreen.codeLifetime.inSeconds,
        since: _countedAt,
        code: BarcodeWidget(
          key: const Key('ticket-code'),
          barcode: Barcode.aztec(),
          data: code.token,
          color: Colors.black,
          drawText: false,
        ),
      );
    }
  }

  /// Asks for a code. It is shown at once when there is none on the screen,
  /// and kept as [_next] otherwise.
  Future<void> _fetch() async {
    if (_fetching) {
      return;
    }
    _fetching = true;
    _fetchFailed = false;
    _failed = false;
    _publish();
    _Fetched? code;
    Object? error;
    try {
      final response = await _contract();
      // A refusal arrives as a reply like any other.
      if (response.code != null) {
        error = response.message;
      } else if (response.decodeAztec() case final token?) {
        code = (token: token, fetchedAt: clock.now());
      }
    } on Exception catch (exception) {
      error = exception;
    }
    if (!mounted) {
      return;
    }
    _fetching = false;
    if (code == null) {
      // The code on the screen stays until its time is up; see _advance.
      _error = error;
      _fetchFailed = true;
      // Away, it is asked again on the return instead.
      _failed = _code == null && !_away;
    } else if (_code == null && !_away) {
      _show(code);
    } else {
      // Away, it is shown on the return if it is still fresh then.
      _next = code;
    }
    _publish();
  }

  /// The pauses before a request without an answer is sent again. The first
  /// one after the app was away often goes out on a connection that died
  /// meanwhile, or before the phone is back on the network.
  static const _retryAfter = [Duration(seconds: 1), Duration(seconds: 2)];

  /// Asks for the contract, again after each of [_retryAfter] while there is
  /// no answer. What the server says is not asked again.
  Future<TicketContractResponse> _contract() async {
    for (var attempt = 0; ; attempt++) {
      try {
        return await ref
            .read(aztecKeyProvider.notifier)
            .guard(
              () => ref.read(ekpClientProvider).tickets.contract(widget.ticketGuid),
              refused: (response) => response.code != null || response.decodeAztec() == null,
            );
      } on EkpNetworkException catch (error, stack) {
        if (attempt >= _retryAfter.length) {
          rethrow;
        }
        await Future<void>.delayed(_retryAfter[attempt]);
        // Gone meanwhile: nobody is waiting for another try.
        if (!mounted) {
          Error.throwWithStackTrace(error, stack);
        }
      }
    }
  }

  /// Whether [code] can still be shown for a whole [TicketControlScreen.codeLifetime]
  /// before an inspector's scanner stops taking it.
  static bool _fresh(_Fetched code) =>
      clock.now().difference(code.fetchedAt) <= TicketControlScreen.codeValidity - TicketControlScreen.codeLifetime;

  /// Puts [code] on the screen. Its time there runs from now, also for one
  /// that was fetched ahead.
  void _show(_Fetched code) {
    _code = (token: code.token, expiresAt: clock.now().add(TicketControlScreen.codeLifetime));
    _next = null;
    _error = null;
    _fetchFailed = false;
    _secondsLeft = TicketControlScreen.codeLifetime.inSeconds;
    _countedAt = clock.now();
    _startTimer();
  }

  /// Ticks a full second apart from now on, so the first one does not land
  /// part-way through the ring's second and make it skip.
  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _leave() {
    _away = true;
    _timer?.cancel();
  }

  /// Back from being away: the code goes on with the time it still has, or
  /// makes way for the one fetched ahead or a new one. Whatever failed
  /// before is asked again, as on opening the screen.
  void _return() {
    _away = false;
    _fetchFailed = false;
    _failed = false;
    final code = _code;
    if (code == null) {
      _advance(0);
      return;
    }
    _startTimer();
    _advance(math.min(_secondsLeft, _remaining(code)));
  }

  /// The seconds [code] still has on the screen. By the clock, not by
  /// counting ticks: they stop while the app is in the background. Rounded
  /// up: a fresh code has its whole lifetime, and 0 means over.
  static int _remaining(_Code code) =>
      (code.expiresAt.difference(clock.now()).inMicroseconds / Duration.microsecondsPerSecond).ceil();

  void _tick() {
    final code = _code;
    if (code == null) {
      return;
    }
    _advance(math.min(_secondsLeft - 1, _remaining(code)));
  }

  /// Moves the code on the screen to [left] seconds; at 0, or without a
  /// code, the next one takes over or is fetched.
  void _advance(int left) {
    if (_code != null && left > 0) {
      _secondsLeft = left;
      _countedAt = clock.now();
      _publish();
      // One attempt per code: a failed one is reported when the time is up.
      if (left <= TicketControlScreen.renewAhead.inSeconds && _next == null && !_fetchFailed) {
        unawaited(_fetch());
      }
      return;
    }
    final next = _next;
    if (next != null && _fresh(next)) {
      // In the old one's place at once: a scan is not interrupted.
      _show(next);
    } else {
      // Out of time without a successor, or with one that waited too long
      // (the app was in the background): nothing to scan any more.
      _code = null;
      _next = null;
      _secondsLeft = 0;
      _failed = !_fetching && _fetchFailed;
    }
    _publish();
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

    return CodeScreen(
      title: l10n.ticketActionControl,
      user: data?.userData,
      customerCode: data?.mkkmData?.customerCode,
      customerCodeLabel: l10n.ticketControlCustomerCode,
      state: _state,
      codeLabel: l10n.ticketControlCodeLabel,
      onRetry: () => unawaited(_fetch()),
      details: ticket == null ? null : _TicketFacts(ticket),
    );
  }
}

/// What kind of ticket it is, a fact to a row. The fare matters most:
/// whether a discount applies decides what else the inspector asks for. It
/// and the zone come from the dictionaries, and show once those are there.
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
    final facts = [
      (l10n.ticketControlTicket, ticketScope(l10n, ticket, zone: zone)),
      if (fare != null) (l10n.ticketControlFare, fare),
      if (ticket.endDate case final end?) (l10n.ticketControlValidUntil, formatDateTime(l10n.localeName, end)),
    ];
    final label = theme.textTheme.bodyMedium?.copyWith(fontSize: 13, height: 20 / 13, color: scheme.onSurfaceVariant);
    final value = theme.textTheme.labelLarge?.copyWith(fontSize: 15, height: 20 / 15);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(color: scheme.surfaceContainer, borderRadius: BorderRadius.circular(20)),
      // The labels as wide as the widest, the values in what is left.
      child: Table(
        columnWidths: const {0: IntrinsicColumnWidth(), 1: FlexColumnWidth()},
        defaultVerticalAlignment: TableCellVerticalAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          for (final (index, (name, fact)) in facts.indexed)
            TableRow(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(top: index == 0 ? 0 : 6, end: 16),
                  child: Text(name, style: label),
                ),
                Padding(
                  padding: EdgeInsets.only(top: index == 0 ? 0 : 6),
                  child: Text(fact, style: value),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
