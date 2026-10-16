import 'dart:async';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:clock/clock.dart';
import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/demo/demo_data.dart';
import 'package:mobile_kkm/core/platform/scan_display.dart';
import 'package:mobile_kkm/core/platform/screen_security.dart';
import 'package:mobile_kkm/core/providers/app_startup_provider.dart';
import 'package:mobile_kkm/core/providers/demo_mode_provider.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/core/providers/platform_providers.dart';
import 'package:mobile_kkm/core/widgets/code_screen/code_screen.dart';
import 'package:mobile_kkm/core/widgets/code_screen/code_state.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// The code that proves the Karta Krakowska status: whose it is, and the
/// code as the server draws it (`account/inhabitant-contract`, a picture).
///
/// Nothing is checked before asking: whether there is a code to be had is
/// for the server to say, and what it says when there is none is shown as
/// it is. A code is good until the moment the server names, about five
/// minutes. Unlike the ticket's there is no next one: when the time is up
/// the screen closes, and the status screen's button asks for a fresh code.
class CityCardCodeScreen extends ConsumerStatefulWidget {
  const CityCardCodeScreen({super.key});

  /// What the server gives a code, and the most one is shown for: with a
  /// device clock that is behind, the server's moment would seem further
  /// off than it is.
  static const maxLifetime = Duration(minutes: 5);

  @override
  ConsumerState<CityCardCodeScreen> createState() => _CityCardCodeScreenState();
}

/// A fetched code, the moment it stops being good and how long it had.
typedef _Code = ({Uint8List png, DateTime expiresAt, int lifetime});

class _CityCardCodeScreenState extends ConsumerState<CityCardCodeScreen> {
  _Code? _code;
  bool _fetching = false;

  /// There is no code and none on its way.
  bool _failed = false;

  /// Why: the server's message, an exception, or nothing more specific.
  Object? _error;

  Timer? _timer;
  int _secondsLeft = 0;

  /// When [_secondsLeft] was counted.
  DateTime _countedAt = clock.now();

  /// The time ran out and the screen is on its way out.
  bool _closed = false;

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
    unawaited(_fetch());
  }

  @override
  void dispose() {
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
      _state.value = CodeHidden(id: code.png, secondsLeft: _secondsLeft, lifetime: code.lifetime, since: _countedAt);
    } else {
      _state.value = CodeShown(
        id: code.png,
        secondsLeft: _secondsLeft,
        lifetime: code.lifetime,
        since: _countedAt,
        code: ref.read(demoModeProvider)
            ? BarcodeWidget(
                key: const Key('status-code'),
                barcode: Barcode.qrCode(),
                data: demoCityCardCode,
                color: Colors.black,
                drawText: false,
              )
            : Image.memory(
                code.png,
                key: const Key('status-code'),
                // Squares, not a photograph: kept sharp at any size.
                filterQuality: FilterQuality.none,
                gaplessPlayback: true,
                errorBuilder: (context, error, stackTrace) {
                  // Not a picture after all: nothing anyone could scan.
                  WidgetsBinding.instance.addPostFrameCallback((_) => _fail(null));
                  return const SizedBox.shrink();
                },
              ),
      );
    }
  }

  Future<void> _fetch() async {
    if (_fetching) {
      return;
    }
    _fetching = true;
    _failed = false;
    _publish();
    _Code? code;
    Object? error;
    try {
      final response = await ref.read(ekpClientProvider).account.inhabitantContract();
      final png = Uint8List.fromList(response.decodeContractPng());
      if (png.isNotEmpty) {
        final now = clock.now();
        var life = response.expirationDate?.difference(now);
        // Missing, already over or too far off: the device's clock is not
        // the server's, and the code is good for what the server gives one.
        if (life == null || life <= Duration.zero || life > CityCardCodeScreen.maxLifetime) {
          life = CityCardCodeScreen.maxLifetime;
        }
        code = (png: png, expiresAt: now.add(life), lifetime: (life.inMilliseconds / 1000).ceil());
      } else {
        // A refusal arrives as a reply like any other.
        error = response.message;
      }
    } on EkpNetworkException catch (exception) {
      error = exception;
      if (mounted) {
        ref.read(appStatusProvider.notifier).markOffline();
      }
    } on Exception catch (exception) {
      // Also a code that is not Base64.
      error = exception;
    }
    if (!mounted) {
      return;
    }
    _fetching = false;
    if (code == null) {
      _fail(error);
    } else {
      _code = code;
      _error = null;
      _secondsLeft = _remaining(code);
      _countedAt = clock.now();
      // Ticks a full second apart from here on, so the first one does not
      // land part-way through the ring's first second and make it skip.
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
      _publish();
    }
  }

  void _fail(Object? error) {
    if (!mounted || _closed) {
      return;
    }
    _code = null;
    _error = error;
    _failed = true;
    _publish();
  }

  /// The seconds [code] is still good for. By the clock, not by counting
  /// ticks: they stop while the app is in the background. Rounded up: 0
  /// means over.
  static int _remaining(_Code code) =>
      (code.expiresAt.difference(clock.now()).inMicroseconds / Duration.microsecondsPerSecond).ceil();

  void _tick() {
    final code = _code;
    if (code == null || _closed) {
      return;
    }
    final left = math.min(_secondsLeft - 1, _remaining(code));
    if (left > 0) {
      _secondsLeft = left;
      _countedAt = clock.now();
      _publish();
      return;
    }
    // Over: back to the status. The enlarged code, if it is up, goes first,
    // as soon as there is no code to show.
    _closed = true;
    _code = null;
    _state.value = const CodeLoading();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final data = ref.watch(shownUserDataProvider).value;

    return CodeScreen(
      title: l10n.cityCardTitle,
      user: data?.userData,
      customerCode: data?.mkkmData?.customerCode,
      customerCodeLabel: l10n.accountCustomerCode,
      state: _state,
      codeLabel: l10n.cityCardCodeLabel,
      onRetry: () => unawaited(_fetch()),
    );
  }
}
