import 'dart:async';

import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_kkm/core/crypto/aztec_key.dart';
import 'package:mobile_kkm/core/crypto/aztec_key_relay.dart';
import 'package:mobile_kkm/core/crypto/aztec_key_store.dart';
import 'package:mobile_kkm/core/providers/app_startup_provider.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/core/providers/platform_providers.dart';
import 'package:mobile_kkm/features/auth/providers/auth_controller.dart';

/// Where the key comes from. It is told which app is asking, and in which
/// version. A provider so tests can answer in its place.
final aztecKeyRelayProvider = Provider<AztecKeyRelay>(
  (ref) => AztecKeyRelay.live(userAgent: 'mobileKKM/${ref.watch(packageInfoProvider).version}'),
);

/// Persistence for the key, supplied in `main()`.
final aztecKeyStoreProvider = Provider<AztecKeyStore>((ref) => throw UnimplementedError('overridden in main()'));

/// The key the encrypted ticket requests go out with.
///
/// It starts as the one the app was built with, then the one stored from an
/// earlier run. The relay is asked once per run, as soon as the user is
/// signed in and start-up is through (never behind the splash), and again
/// when the server refuses an encrypted request: see [guard]. A key the
/// relay could not deliver, or one that is no RSA key of 2048 bits, changes
/// nothing.
class AztecKeyController extends Notifier<AztecKey> {
  /// A refused request makes the relay look again only after this long.
  static const _refreshInterval = Duration(minutes: 1);

  late Future<void> _restored;
  Future<bool>? _loading;
  DateTime? _lastRefresh;
  bool _fetched = false;

  @override
  AztecKey build() {
    _restored = _restore();
    // Not from inside the listeners: the first call arrives during build().
    void reconsider() => unawaited(Future.microtask(_onConditionsChanged));
    ref.listen(authControllerProvider.select((state) => state.status), (_, _) => reconsider(), fireImmediately: true);
    ref.listen(appStartupProvider, (_, _) => reconsider());
    return AztecKey.bundled;
  }

  /// Asks the relay for the key it holds. Whether it answered with a usable
  /// one. Never throws; concurrent calls share one request.
  Future<bool> reload() => _load(() => ref.read(aztecKeyRelayProvider).current());

  /// Runs an encrypted request, and once more if it was refused and the
  /// relay turns out to have another key than the one it went out with.
  ///
  /// What the server answers to a request under an old key is not known, so
  /// any refusal counts: a reply that [refused] says so of, or an HTTP error.
  /// A refusal for another reason costs one call to the relay and no second
  /// request. [call] must read the key anew each time, as the client does.
  Future<T> guard<T>(Future<T> Function() call, {required bool Function(T result) refused}) async {
    final used = state;
    try {
      final result = await call();
      if (!refused(result) || !await _replacedSince(used)) {
        return result;
      }
    } on EkpHttpException {
      if (!await _replacedSince(used)) {
        rethrow;
      }
    }
    return call();
  }

  Future<bool> _replacedSince(AztecKey used) async {
    if (!ref.mounted) {
      return false;
    }
    // The start-up request may have brought the new key in the meantime.
    if (state.sameKeyAs(used)) {
      final last = _lastRefresh;
      if (last != null && DateTime.now().difference(last) < _refreshInterval) {
        return false;
      }
      _lastRefresh = DateTime.now();
      await _load(() => ref.read(aztecKeyRelayProvider).refresh());
    }
    return ref.mounted && !state.sameKeyAs(used);
  }

  Future<bool> _load(Future<AztecKey> Function() fetch) =>
      _loading ??= _fetch(fetch).whenComplete(() => _loading = null);

  Future<bool> _fetch(Future<AztecKey> Function() fetch) async {
    try {
      await _restored;
      final fresh = await fetch();
      if (!ref.mounted || !fresh.isUsable) {
        return false;
      }
      _fetched = true;
      final changed = fresh.pem != state.pem || fresh.fingerprint != state.fingerprint;
      _use(fresh);
      if (changed) {
        await _store(fresh);
      }
      return true;
    } catch (_) {
      // Offline or relay trouble: the key in use stays.
      return false;
    }
  }

  /// Also hands the key to the client: see [AztecKeyInUse].
  void _use(AztecKey key) {
    state = key;
    ref.read(aztecKeyInUseProvider).pem = key.pem;
  }

  Future<void> _restore() async {
    try {
      final stored = await ref.read(aztecKeyStoreProvider).read();
      if (stored != null && stored.isUsable && ref.mounted) {
        _use(stored);
      }
    } catch (_) {
      // Behave as if nothing was stored.
    }
  }

  Future<void> _store(AztecKey key) async {
    try {
      await ref.read(aztecKeyStoreProvider).write(key);
    } catch (_) {
      // No room or no access: the key is still good for this run.
    }
  }

  Future<void> _onConditionsChanged() async {
    if (!ref.mounted || _fetched) {
      return;
    }
    final signedIn = ref.read(authControllerProvider).status == AuthStatus.authenticated;
    if (signedIn && !ref.read(appStartupProvider).isLoading && ref.read(appStatusProvider).mode != AppMode.outdated) {
      await reload();
    }
  }
}

final aztecKeyProvider = NotifierProvider<AztecKeyController, AztecKey>(AztecKeyController.new);
