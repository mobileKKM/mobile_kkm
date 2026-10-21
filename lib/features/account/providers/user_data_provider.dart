import 'dart:async';

import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_kkm/core/providers/app_startup_provider.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/core/providers/platform_providers.dart';
import 'package:mobile_kkm/features/account/services/user_data_cache.dart';
import 'package:mobile_kkm/features/auth/providers/auth_controller.dart';
import 'package:mobile_kkm/features/purchase/services/last_payment_method_store.dart';

/// Persistence for [userDataProvider], supplied in `main()`.
final userDataCacheProvider = Provider<UserDataCache>((ref) => throw UnimplementedError('overridden in main()'));

/// The signed-in user's account data: loaded once, held in memory for the
/// whole session and mirrored to [UserDataCache].
///
/// With a cached copy the value is available straight away (also offline)
/// and is refreshed from the server once in the background. Without one it
/// is fetched; that is the only case in which this provider can be in an
/// error state, and it ends the session: the app does not run without user
/// data. Signing out clears the memory, the cached copy and the stored photo.
class UserDataController extends AsyncNotifier<UserDataResponse?> {
  /// How long the first load may take. The client has no request timeout,
  /// and the sign-in screen or the splash waits for this.
  static const firstLoadLimit = Duration(seconds: 8);

  @override
  Future<UserDataResponse?> build() async {
    final status = ref.watch(authControllerProvider.select((state) => state.status));
    final cache = ref.watch(userDataCacheProvider);
    // The server is asked only after the start-up check: the app config
    // comes first, and may say that this client is no longer served.
    final starting = ref.watch(appStartupProvider.select((startup) => startup.isLoading));
    final outdated = ref.watch(appStatusProvider.select((status) => status.mode == AppMode.outdated));

    switch (status) {
      case AuthStatus.unknown:
        return null;
      case AuthStatus.unauthenticated:
        await cache.clear();
        // The photo is personal data too, and must not outlive the session.
        try {
          await ref.read(photoCacheProvider).clear();
        } catch (_) {
          // Nothing was cached, or the cache could not be opened.
        }
        try {
          await ref.read(lastPaymentMethodStoreProvider).clear();
        } catch (_) {
          // The keystore could not be reached; the next sign-out tries again.
        }
        return null;
      case AuthStatus.authenticated:
        final cached = await cache.read();
        if (starting || outdated) {
          return cached;
        }
        if (cached == null) {
          return _firstLoad();
        }
        unawaited(_revalidate());
        return cached;
    }
  }

  /// Reloads from the server, e.g. after the profile was edited. Keeps the
  /// current value if the request fails and rethrows the error.
  Future<void> refresh() async {
    final fresh = await _fetch();
    if (fresh != null) {
      state = AsyncData(fresh);
    }
  }

  /// The load nothing stands in for. When it fails or takes too long, the
  /// user is signed out on this device.
  Future<UserDataResponse> _firstLoad() async {
    final ref = this.ref;
    try {
      // An answer that comes after the limit is dropped, not stored: the
      // session it was for is over by then.
      final fresh = await ref.read(ekpClientProvider).account.userData().timeout(firstLoadLimit);
      if (_stillFor(ref)) {
        await ref.read(userDataCacheProvider).write(fresh);
      }
      return fresh;
    } catch (_) {
      if (_stillFor(ref)) {
        unawaited(ref.read(authControllerProvider.notifier).signOutAfterUserDataFailed());
      }
      rethrow;
    }
  }

  /// The user data from the server, stored. Null when the session it was
  /// asked for ended while the request was in flight: then nothing is stored,
  /// and there is nothing to show.
  Future<UserDataResponse?> _fetch() async {
    final ref = this.ref;
    final fresh = await ref.read(ekpClientProvider).account.userData();
    if (!_stillFor(ref)) {
      return null;
    }
    await ref.read(userDataCacheProvider).write(fresh);
    return fresh;
  }

  Future<void> _revalidate() async {
    try {
      final fresh = await _fetch();
      if (fresh != null) {
        state = AsyncData(fresh);
      }
    } catch (_) {
      // Offline or server trouble: the cached copy stays in use.
    }
  }

  /// Whether the session that [ref] started a request in is still the one.
  ///
  /// [ref] must be the one taken before the request: after an `await`,
  /// `this.ref` is that of the latest build and always mounted, so it does
  /// not notice a sign-out.
  bool _stillFor(Ref ref) => ref.mounted && ref.read(authControllerProvider).status == AuthStatus.authenticated;
}

final userDataProvider = AsyncNotifierProvider<UserDataController, UserDataResponse?>(
  UserDataController.new,
  retry: (_, _) => null,
);
