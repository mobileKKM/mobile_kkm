import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_kkm/features/account/providers/user_data_provider.dart';
import 'package:mobile_kkm/features/card_setup/models/card_gate.dart';
import 'package:mobile_kkm/features/card_setup/services/card_setup_controller.dart';

/// Whether the signed-in user may go past the card set-up. The router sends
/// everything there while it is closed.
final cardGateProvider = Provider<CardGate>(
  (ref) => cardGateOf(ref.watch(userDataProvider), ref.watch(cardSetupProvider.select((state) => state.stage))),
);
