import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_kkm/features/card_setup/models/card_gate.dart';

import '../../../support/sample_data.dart';

void main() {
  AsyncValue<UserDataResponse?> data({bool card = true, bool detached = false}) =>
      AsyncData(UserDataResponse.fromJson(userDataJson(card: card, detached: detached)));

  test('the gate follows what the user data says about the card', () {
    expect(cardGateOf(data(), CardSetupStage.idle), CardGate.open);
    expect(cardGateOf(data(card: false), CardSetupStage.idle), CardGate.setUp);
    expect(cardGateOf(data(detached: true), CardSetupStage.idle), CardGate.detached);
  });

  test('user data that is not there never opens the gate', () {
    expect(cardGateOf(const AsyncLoading(), CardSetupStage.idle), CardGate.checking);
    expect(cardGateOf(const AsyncData(null), CardSetupStage.idle), CardGate.checking);
    expect(cardGateOf(AsyncError(Exception(), StackTrace.empty), CardSetupStage.idle), CardGate.checking);
  });

  test('a card that was just made stays behind the gate until the user goes on', () {
    // Still on the step that asked for it.
    expect(cardGateOf(data(card: false), CardSetupStage.waiting), CardGate.setUp);
    expect(cardGateOf(data(detached: true), CardSetupStage.waiting), CardGate.detached);
    expect(cardGateOf(data(), CardSetupStage.waiting), CardGate.settling);
    expect(cardGateOf(data(), CardSetupStage.ready), CardGate.settling);
  });
}
