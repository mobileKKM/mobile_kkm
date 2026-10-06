import 'dart:async';

import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';

enum AppMode {
  online,

  /// The server could not be reached; the app shows what it has stored.
  offline,

  /// The server answered that the service is switched off (maintenance).
  unavailable,

  /// The server no longer accepts the client version the app speaks
  /// (`minAppVersion` in the app config). Nothing works until an update.
  outdated,
}

class AppStatus {
  const AppStatus(this.mode, {this.message});

  final AppMode mode;

  /// The server's explanation while [AppMode.unavailable], if it gave one.
  final String? message;
}

/// Whether the EKP service can be used right now.
class AppStatusController extends Notifier<AppStatus> {
  Future<void>? _running;

  @override
  AppStatus build() => const AppStatus(AppMode.online);

  /// Asks `service-status`, then makes sure the app config is loaded.
  ///
  /// The config is skipped only when the server is unreachable. Like the
  /// official client, it is still fetched while the service reports itself
  /// unavailable, and failing to get it never stops the app.
  Future<void> check() => _running ??= _check().whenComplete(() => _running = null);

  Future<void> _check() async {
    var next = const AppStatus(AppMode.online);
    try {
      final status = await ref.read(ekpClientProvider).misc.serviceStatus();
      if (status.isAvailable == false) {
        next = AppStatus(AppMode.unavailable, message: status.customMessage);
      }
    } on EkpNetworkException {
      state = const AppStatus(AppMode.offline);
      return;
    } catch (_) {
      // An answer the app does not understand is still an answer.
    }

    if (ref.read(mobileAppConfigProvider).hasError) {
      ref.invalidate(mobileAppConfigProvider);
    }
    try {
      final config = await ref.read(mobileAppConfigProvider.future);
      // The config comes before anything else is asked of the server: it
      // says whether the server still talks to this client at all.
      if (!config.supportsClient()) {
        next = const AppStatus(AppMode.outdated);
      }
    } catch (_) {
      // Screens that need a URL from it offer a retry.
    }
    // Only now, in one step: what waits for the mode waits for the config.
    state = next;
  }

  /// A request to the server just failed without an answer.
  void markOffline() {
    if (state.mode != AppMode.offline) {
      state = const AppStatus(AppMode.offline);
    }
  }
}

final appStatusProvider = NotifierProvider<AppStatusController, AppStatus>(AppStatusController.new);

/// The first [AppStatusController.check], which the splash waits for. Gives
/// up after [_startupTimeout] and carries on offline.
final appStartupProvider = FutureProvider<void>((ref) {
  final status = ref.read(appStatusProvider.notifier);
  return status.check().timeout(_startupTimeout, onTimeout: status.markOffline);
}, retry: (_, _) => null);

const _startupTimeout = Duration(seconds: 8);
