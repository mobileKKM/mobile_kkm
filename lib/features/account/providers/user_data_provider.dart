import 'dart:async';

import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/features/account/services/user_data_cache.dart';
import 'package:mobile_kkm/features/auth/providers/auth_controller.dart';

/// Persistence for [userDataProvider], supplied in `main()`.
final userDataCacheProvider = Provider<UserDataCache>((ref) => throw UnimplementedError('overridden in main()'));

/// The signed-in user's account data: loaded once, held in memory for the
/// whole session and mirrored to [UserDataCache].
///
/// With a cached copy the value is available straight away (also offline)
/// and is refreshed from the server once in the background. Without one it
/// is fetched; that is the only case in which this provider can be in an
/// error state. Signing out clears both the memory and the cached copy.
class UserDataController extends AsyncNotifier<UserDataResponse?> {
  @override
  Future<UserDataResponse?> build() async {
    final status = ref.watch(authControllerProvider.select((state) => state.status));
    final cache = ref.watch(userDataCacheProvider);

    switch (status) {
      case AuthStatus.unknown:
        return null;
      case AuthStatus.unauthenticated:
        await cache.clear();
        return null;
      case AuthStatus.authenticated:
        final cached = await cache.read();
        if (cached == null) return _fetch();
        unawaited(_revalidate());
        return cached;
    }
  }

  /// Reloads from the server, e.g. after the profile was edited. Keeps the
  /// current value if the request fails and rethrows the error.
  Future<void> refresh() async {
    state = AsyncData(await _fetch());
  }

  Future<UserDataResponse> _fetch() async {
    final fresh = await ref.read(ekpClientProvider).account.userData();
    // Signed out while the request was in flight: do not resurrect the cache.
    if (ref.mounted) await ref.read(userDataCacheProvider).write(fresh);
    return fresh;
  }

  Future<void> _revalidate() async {
    try {
      final fresh = await _fetch();
      if (ref.mounted) state = AsyncData(fresh);
    } catch (_) {
      // Offline or server trouble: the cached copy stays in use.
    }
  }
}

final userDataProvider = AsyncNotifierProvider<UserDataController, UserDataResponse?>(
  UserDataController.new,
  retry: (_, _) => null,
);
