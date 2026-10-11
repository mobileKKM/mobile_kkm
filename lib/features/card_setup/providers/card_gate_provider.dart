import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_kkm/features/account/providers/user_data_provider.dart';
import 'package:mobile_kkm/features/card_setup/models/card_gate.dart';
import 'package:mobile_kkm/features/card_setup/services/card_setup_controller.dart';

/// Whether the first load of the user data has been waited for long enough.
///
/// The request has no time limit of its own, and a gate that stays shut for
/// as long as it hangs would block the whole app.
class CardCheckPatience extends Notifier<bool> {
  /// As long as start-up waits for the app config.
  static const limit = Duration(seconds: 8);

  @override
  bool build() {
    final waiting = ref.watch(userDataProvider.select((data) => data.isLoading && data.value == null));
    if (waiting) {
      final timer = Timer(limit, () => state = true);
      ref.onDispose(timer.cancel);
    }
    return false;
  }
}

final _cardCheckPatienceProvider = NotifierProvider<CardCheckPatience, bool>(CardCheckPatience.new);

/// Whether the signed-in user may go past the card set-up. The router sends
/// everything there while it is closed.
final cardGateProvider = Provider<CardGate>((ref) {
  final gate = cardGateOf(ref.watch(userDataProvider), ref.watch(cardSetupProvider.select((state) => state.stage)));
  // Unknown for too long counts as unknown: the app opens, and closes again
  // should the answer be that there is no card.
  return gate == CardGate.checking && ref.watch(_cardCheckPatienceProvider) ? CardGate.open : gate;
});
