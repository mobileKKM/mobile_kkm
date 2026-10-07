import 'dart:async';
import 'dart:math' as math;

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/api/error_messages.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/core/widgets/load_problem.dart';
import 'package:mobile_kkm/features/account/providers/user_data_provider.dart';
import 'package:mobile_kkm/features/account/widgets/user_avatar.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// What an inspector is shown: whose ticket it is and its AZTEC code.
///
/// The code is fetched once and is good for [codeLifetime]; after that the
/// screen closes, as in the official client.
class TicketControlScreen extends ConsumerStatefulWidget {
  const TicketControlScreen({super.key, required this.ticketGuid});

  static const codeLifetime = Duration(seconds: 119);

  final String ticketGuid;

  @override
  ConsumerState<TicketControlScreen> createState() => _TicketControlScreenState();
}

class _TicketControlScreenState extends ConsumerState<TicketControlScreen> {
  String? _token;

  bool _failed = false;

  /// Why: the server's message, an exception, or nothing more specific.
  Object? _error;

  Timer? _timer;
  DateTime? _expiresAt;
  int _secondsLeft = TicketControlScreen.codeLifetime.inSeconds;

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() => _failed = false);
    String? token;
    Object? error;
    try {
      final response = await ref.read(ekpClientProvider).tickets.contract(widget.ticketGuid);
      // A refusal arrives as a reply like any other.
      if (response.code != null) {
        error = response.message;
      } else {
        token = response.decodeAztec();
      }
    } on Exception catch (exception) {
      error = exception;
    }
    if (!mounted) {
      return;
    }
    if (token == null) {
      setState(() {
        _failed = true;
        _error = error;
      });
      return;
    }
    setState(() {
      _token = token;
      _secondsLeft = TicketControlScreen.codeLifetime.inSeconds;
      _expiresAt = DateTime.now().add(TicketControlScreen.codeLifetime);
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() {
    // The clock too, not only the ticks: they stop while the app is in the
    // background.
    final byClock = _expiresAt!.difference(DateTime.now()).inSeconds;
    final left = math.min(_secondsLeft - 1, byClock);
    if (left <= 0) {
      _timer?.cancel();
      if (mounted) {
        context.pop();
      }
      return;
    }
    setState(() => _secondsLeft = left);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final token = _token;
    final Widget body;
    if (token != null) {
      body = _Code(token: token, secondsLeft: _secondsLeft);
    } else if (_failed) {
      final error = _error;
      body = Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: LoadProblem(
            message: switch (error) {
              // The server's own wording (Polish only).
              final String message when message.isNotEmpty => message,
              final Exception exception => describeError(l10n, exception),
              _ => l10n.ticketControlError,
            },
            onRetry: () => unawaited(_load()),
          ),
        ),
      );
    } else {
      body = const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(title: Text(l10n.ticketActionControl)),
      body: SafeArea(child: body),
    );
  }
}

class _Code extends ConsumerWidget {
  const _Code({required this.token, required this.secondsLeft});

  final String token;
  final int secondsLeft;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final data = ref.watch(userDataProvider).value;
    final user = data?.userData;
    final name = [user?.firstName, user?.lastName].whereType<String>().join(' ');
    final customerCode = data?.mkkmData?.customerCode;
    final time = '${secondsLeft ~/ 60}:${(secondsLeft % 60).toString().padLeft(2, '0')}';

    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      children: [
        Center(child: UserAvatar(user: user, radius: 48)),
        if (name.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(name, textAlign: TextAlign.center, style: theme.textTheme.headlineSmall),
        ],
        if (customerCode != null) ...[
          const SizedBox(height: 4),
          Text(
            '${l10n.ticketControlCustomerCode}: $customerCode',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
          ),
        ],
        const SizedBox(height: 24),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320),
            child: AspectRatio(
              aspectRatio: 1,
              // White in the dark theme too: a scanner needs the contrast.
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: BarcodeWidget(
                    key: const Key('ticket-code'),
                    barcode: Barcode.aztec(),
                    data: token,
                    color: Colors.black,
                    drawText: false,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(l10n.ticketControlTimeLeft(time), textAlign: TextAlign.center, style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: secondsLeft / TicketControlScreen.codeLifetime.inSeconds,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}
