import 'dart:async';

import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';

enum AuthStatus {
  /// The stored session has not been read yet (app start).
  unknown,
  authenticated,
  unauthenticated,
}

class AuthState {
  const AuthState(this.status, {this.sessionExpired = false});

  final AuthStatus status;

  /// The user was signed out because the session could not be renewed.
  final bool sessionExpired;
}

/// Mirrors the [EkpSessionManager] lifecycle for the router and the UI.
class AuthController extends Notifier<AuthState> {
  /// How long the splash waits for the renewal before going on regardless.
  static const _startupRecoveryTimeout = Duration(seconds: 10);

  @override
  AuthState build() {
    final session = ref.watch(ekpClientProvider).session;
    final subscription = session.events.listen(_onEvent);
    ref.onDispose(subscription.cancel);
    unawaited(_bootstrap(session));
    return const AuthState(AuthStatus.unknown);
  }

  Future<void> _bootstrap(EkpSessionManager session) async {
    var stored = await session.currentSession();
    if (stored != null && stored.isExpired) {
      // Renew before entering the app, so the first screen does not start
      // with a stale token. A rejected refresh token signs the user out via
      // the event stream; being offline keeps the session as it is.
      await session.recover().timeout(_startupRecoveryTimeout, onTimeout: () => false);
      stored = await session.currentSession();
    }
    if (!ref.mounted || state.status != AuthStatus.unknown) return;
    state = AuthState(stored == null ? AuthStatus.unauthenticated : AuthStatus.authenticated);
  }

  void _onEvent(EkpSessionEvent event) {
    state = switch (event) {
      EkpSessionAuthenticated() || EkpSessionUpdated() => const AuthState(AuthStatus.authenticated),
      EkpSessionExpired() => const AuthState(AuthStatus.unauthenticated, sessionExpired: true),
      EkpSessionLoggedOut() => const AuthState(AuthStatus.unauthenticated),
    };
  }
}

final authControllerProvider = NotifierProvider<AuthController, AuthState>(AuthController.new);
