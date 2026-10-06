import 'dart:async';

import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_kkm/core/dictionaries/dictionary.dart';
import 'package:mobile_kkm/core/dictionaries/dictionary_cache.dart';
import 'package:mobile_kkm/core/providers/app_startup_provider.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/features/auth/providers/auth_controller.dart';

/// Persistence for the dictionary providers below, supplied in `main()`.
final dictionaryCacheProvider = Provider<DictionaryCache>((ref) => throw UnimplementedError('overridden in main()'));

/// There is no stored copy of a dictionary and the server cannot be asked
/// for one right now: signed out, or the client is no longer served.
class DictionaryUnavailableException implements Exception {
  const DictionaryUnavailableException(this.name);

  final String name;

  @override
  String toString() => 'DictionaryUnavailableException: $name';
}

/// One `dictionary/*` list, from the [DictionaryCache] where possible.
///
/// The server marks these replies `no-cache` and sends nothing to revalidate
/// with (no `ETag`, no `Last-Modified`), so the age rule is the app's own: a
/// stored copy is used as it is for [maxAge]; an older one is still returned
/// at once and replaced in the background. Only without a stored copy does
/// the caller wait for the server, and only then can this end in an error.
///
/// The server is asked only while signed in (the endpoints want a session)
/// and after the start-up check. The stored copies outlive the session: they
/// are public reference data.
class DictionaryController<T> extends AsyncNotifier<T> {
  DictionaryController(this.dictionary);

  static const maxAge = Duration(hours: 24);

  final Dictionary<T> dictionary;

  Future<T>? _fetching;

  @override
  Future<T> build() async {
    // Watched so that a copy that could not be fetched is tried again once
    // the user is signed in.
    ref
      ..watch(authControllerProvider.select((state) => state.status))
      ..watch(appStatusProvider.select((status) => status.mode == AppMode.outdated));

    final cached = await _read();
    if (cached != null) {
      final (value, fetchedAt) = cached;
      if (DateTime.now().difference(fetchedAt) >= maxAge) {
        unawaited(_revalidate());
      }
      return value;
    }

    await _startupDone();
    if (!_mayAsk) {
      throw DictionaryUnavailableException(dictionary.name);
    }
    try {
      return await _fetch();
    } on EkpNetworkException {
      if (ref.mounted) {
        ref.read(appStatusProvider.notifier).markOffline();
      }
      rethrow;
    }
  }

  /// Signed in, and the server still talks to this client.
  bool get _mayAsk =>
      ref.read(authControllerProvider).status == AuthStatus.authenticated &&
      ref.read(appStatusProvider).mode != AppMode.outdated;

  /// The app config comes before anything else is asked of the server.
  Future<void> _startupDone() async {
    try {
      await ref.read(appStartupProvider.future);
    } catch (_) {
      // Start-up carries on regardless, and so does this.
    }
  }

  Future<(T, DateTime)?> _read() async {
    try {
      final stored = await ref.read(dictionaryCacheProvider).read(dictionary.name);
      return stored == null ? null : (dictionary.fromJson(stored.json), stored.fetchedAt);
    } catch (_) {
      // From an older model shape: behave as a cache miss.
      return null;
    }
  }

  /// Concurrent calls share one request.
  Future<T> _fetch() => _fetching ??= _load().whenComplete(() => _fetching = null);

  Future<T> _load() async {
    final fresh = await dictionary.fetch(ref.read(ekpClientProvider));
    if (ref.mounted) {
      try {
        await ref.read(dictionaryCacheProvider).write(dictionary.name, dictionary.toJson(fresh), DateTime.now());
      } catch (_) {
        // No room or no access: the list is still good for this run.
      }
    }
    return fresh;
  }

  Future<void> _revalidate() async {
    try {
      await _startupDone();
      if (!ref.mounted || !_mayAsk) {
        return;
      }
      final fresh = await _fetch();
      if (ref.mounted) {
        state = AsyncData(fresh);
      }
    } catch (_) {
      // Offline or server trouble: the stored copy stays in use.
    }
  }
}

/// `dictionary/ticket-kind-list`
final ticketKindsProvider = AsyncNotifierProvider<DictionaryController<TicketKindListResponse>, TicketKindListResponse>(
  () => DictionaryController(Dictionary.ticketKinds),
  retry: (_, _) => null,
);

/// `dictionary/ticket-number-of-line-list`
final ticketLineScopesProvider =
    AsyncNotifierProvider<DictionaryController<TicketNumberOfLineListResponse>, TicketNumberOfLineListResponse>(
      () => DictionaryController(Dictionary.ticketLineScopes),
      retry: (_, _) => null,
    );

/// `dictionary/ticket-period-list`
final ticketPeriodsProvider =
    AsyncNotifierProvider<DictionaryController<TicketPeriodListResponse>, TicketPeriodListResponse>(
      () => DictionaryController(Dictionary.ticketPeriods),
      retry: (_, _) => null,
    );

/// `dictionary/city-card-types`
final cityCardTypesProvider = AsyncNotifierProvider<DictionaryController<CityCardTypesResponse>, CityCardTypesResponse>(
  () => DictionaryController(Dictionary.cityCardTypes),
  retry: (_, _) => null,
);
