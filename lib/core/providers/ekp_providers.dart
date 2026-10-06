import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Device identity, resolved in `main()` before the app starts.
final deviceIdentityProvider = Provider<EkpDeviceIdentity>((ref) => throw UnimplementedError('overridden in main()'));

/// Session persistence, supplied in `main()`.
final tokenStoreProvider = Provider<TokenStore>((ref) => throw UnimplementedError('overridden in main()'));

final ekpClientProvider = Provider<EkpClient>((ref) {
  final client = EkpClient(device: ref.watch(deviceIdentityProvider), tokenStore: ref.watch(tokenStoreProvider));
  ref.onDispose(client.dispose);
  return client;
});

/// `client/mobile-app/config` — document URLs (regulations etc.).
///
/// Loaded once behind the splash (see `appStartupProvider`) and kept for the
/// whole run; only a failed load is ever repeated.
final mobileAppConfigProvider = FutureProvider<MobileAppConfig>(
  (ref) => ref.watch(ekpClientProvider).misc.mobileAppConfig(),
  retry: (_, _) => null,
);
