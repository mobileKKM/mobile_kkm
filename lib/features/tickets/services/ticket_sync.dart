import 'dart:async';

import 'package:ekp_api/ekp_api.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_kkm/core/providers/app_startup_provider.dart';
import 'package:mobile_kkm/core/providers/database_provider.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/features/auth/providers/auth_controller.dart';
import 'package:mobile_kkm/features/tickets/services/tickets_dao.dart';

final ticketsDaoProvider = Provider<TicketsDao>((ref) => TicketsDao(ref.watch(appDatabaseProvider)));

enum TicketSyncStatus { idle, syncing, failed }

class TicketSyncState {
  const TicketSyncState({this.status = TicketSyncStatus.idle, this.error, this.lastSyncedAt});

  final TicketSyncStatus status;

  /// Why the last sync failed, while [TicketSyncStatus.failed].
  final Object? error;

  /// When the stored tickets last matched the server, in this app run.
  final DateTime? lastSyncedAt;
}

/// Keeps the stored tickets in step with `mkkm/tickets/list`.
///
/// The list is only asked for once the user is signed in, the start-up
/// check is through and the service is available: then at once, again when
/// the app comes back to the foreground, and on request. It waits for
/// nothing else, the user data included. Signing out empties the store. The
/// screens only ever read the database, so none of this holds them up.
class TicketSyncController extends Notifier<TicketSyncState> {
  /// A return to the foreground syncs again only after this long.
  static const _resumeInterval = Duration(minutes: 1);

  Future<void>? _running;
  DateTime? _lastAttempt;
  bool _wasReady = false;

  @override
  TicketSyncState build() {
    // Not from inside the listeners: the first call arrives during build().
    void reconsider() => unawaited(Future.microtask(_onConditionsChanged));
    ref.listen(authControllerProvider.select((state) => state.status), (_, _) => reconsider(), fireImmediately: true);
    ref.listen(appStartupProvider, (_, _) => reconsider());
    ref.listen(appStatusProvider.select((status) => status.mode), (_, _) => reconsider());

    final lifecycle = AppLifecycleListener(onResume: _onResume);
    ref.onDispose(lifecycle.dispose);

    return const TicketSyncState();
  }

  bool get _signedIn => ref.read(authControllerProvider).status == AuthStatus.authenticated;

  /// Signed in, past the start-up check, and the service is there.
  bool get _ready =>
      _signedIn && !ref.read(appStartupProvider).isLoading && ref.read(appStatusProvider).mode == AppMode.online;

  /// Fetches the ticket list and stores it, unless the conditions above are
  /// not met. Never throws: the outcome is in the state. Concurrent calls
  /// share one request.
  Future<void> sync() {
    if (!_ready) {
      return Future.value();
    }
    return _running ??= _sync().whenComplete(() => _running = null);
  }

  /// A sync the user asked for. Finds out first whether the server is back
  /// when the app was offline, or still lacks its config.
  Future<void> refresh() async {
    final attemptBefore = _lastAttempt;
    if (ref.read(appStatusProvider).mode != AppMode.online || ref.read(mobileAppConfigProvider).hasError) {
      await ref.read(appStatusProvider.notifier).check();
    }
    // Coming back online has already started a sync of its own.
    final running = _running;
    if (running != null) {
      await running;
    } else if (_lastAttempt == attemptBefore) {
      await sync();
    }
  }

  Future<void> _sync() async {
    _lastAttempt = DateTime.now();
    state = TicketSyncState(status: TicketSyncStatus.syncing, lastSyncedAt: state.lastSyncedAt);
    try {
      final response = await ref.read(ekpClientProvider).tickets.mkkmTickets();
      // Signed out while the request was in flight: do not refill the store.
      if (!ref.mounted || !_signedIn) {
        return;
      }
      await ref.read(ticketsDaoProvider).replaceWith(response.tickets);
      state = TicketSyncState(lastSyncedAt: DateTime.now());
    } catch (error) {
      if (!ref.mounted) {
        return;
      }
      state = TicketSyncState(status: TicketSyncStatus.failed, error: error, lastSyncedAt: state.lastSyncedAt);
      if (error is EkpNetworkException) {
        ref.read(appStatusProvider.notifier).markOffline();
      }
    }
  }

  Future<void> _onConditionsChanged() async {
    if (!ref.mounted) {
      return;
    }
    final status = ref.read(authControllerProvider).status;
    final ready = _ready;
    final becameReady = ready && !_wasReady;
    _wasReady = ready;
    if (becameReady) {
      await sync();
    } else if (status == AuthStatus.unauthenticated) {
      await ref.read(ticketsDaoProvider).clear();
      if (ref.mounted) {
        state = const TicketSyncState();
      }
    }
  }

  void _onResume() {
    final last = _lastAttempt;
    if (last == null || DateTime.now().difference(last) >= _resumeInterval) {
      unawaited(sync());
    }
  }
}

final ticketSyncProvider = NotifierProvider<TicketSyncController, TicketSyncState>(TicketSyncController.new);
