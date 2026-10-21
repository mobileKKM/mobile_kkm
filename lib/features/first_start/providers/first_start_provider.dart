import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_kkm/features/first_start/services/first_start_store.dart';

/// Whether the first start notice was seen. Read from the store in `main()`,
/// before the app runs, so that the router can decide at once.
class FirstStartController extends Notifier<bool> {
  FirstStartController(this._store, {required bool seen}) : _initial = seen;

  final bool _initial;
  final FirstStartStore _store;

  @override
  bool build() => _initial;

  /// Moves on at once; if the flag can't be written, the notice only shows
  /// again at the next start.
  Future<void> accept() async {
    state = true;
    try {
      await _store.markSeen();
    } catch (_) {
      // See above.
    }
  }
}

final firstStartSeenProvider = NotifierProvider<FirstStartController, bool>(
  () => throw UnimplementedError('overridden in main()'),
);
