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

/// Why the app signed the user out by itself.
enum SignOutReason {
  /// The session could not be renewed.
  sessionExpired,

  /// The account's data could not be loaded, and no copy of it was stored.
  userDataFailed,
}

class AuthState {
  const AuthState(this.status, {this.reason});

  final AuthStatus status;

  /// Set when the user did not sign out themselves.
  final SignOutReason? reason;
}

/// Mirrors the [EkpSessionManager] lifecycle for the router and the UI.
class AuthController extends Notifier<AuthState> {
  /// How long the splash waits for the renewal before going on regardless.
  static const _startupRecoveryTimeout = Duration(seconds: 10);

  /// Holds the splash for this many seconds, to look at it while developing:
  /// `flutter run --dart-define=SPLASH_DELAY_SECONDS=5`. Off by default.
  static const _splashDelaySeconds = int.fromEnvironment('SPLASH_DELAY_SECONDS');

  /// For the next [EkpSessionLoggedOut], which does not say why.
  SignOutReason? _signOutReason;

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
    if (_splashDelaySeconds > 0) {
      await Future<void>.delayed(const Duration(seconds: 1) * _splashDelaySeconds);
    }
    if (!ref.mounted || state.status != AuthStatus.unknown) {
      return;
    }
    state = AuthState(stored == null ? AuthStatus.unauthenticated : AuthStatus.authenticated);
  }

  /// Ends the session on this device because the user data could not be
  /// loaded. The server is not told: it may be the one that does not answer.
  Future<void> signOutAfterUserDataFailed() async {
    if (state.status != AuthStatus.authenticated) {
      return;
    }
    _signOutReason = SignOutReason.userDataFailed;
    await ref.read(ekpClientProvider).session.publishLoggedOut();
  }

  /// Ends the session on this device without a word to the server: for an
  /// account that was just deleted, whose token the server no longer knows.
  Future<void> signOutLocally() async {
    if (state.status != AuthStatus.authenticated) {
      return;
    }
    await ref.read(ekpClientProvider).session.publishLoggedOut();
  }

  void _onEvent(EkpSessionEvent event) {
    final reason = _signOutReason;
    _signOutReason = null;
    state = switch (event) {
      EkpSessionAuthenticated() || EkpSessionUpdated() => const AuthState(AuthStatus.authenticated),
      EkpSessionExpired() => const AuthState(AuthStatus.unauthenticated, reason: SignOutReason.sessionExpired),
      EkpSessionLoggedOut() => AuthState(AuthStatus.unauthenticated, reason: reason),
    };
  }
}

final authControllerProvider = NotifierProvider<AuthController, AuthState>(AuthController.new);
