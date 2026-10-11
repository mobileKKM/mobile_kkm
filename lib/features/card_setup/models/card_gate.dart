import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// What stands between a signed-in user and the app: the mKKM card that
/// every ticket is stored on.
enum CardGate {
  /// The user data is on its way for the first time. Nothing is shown for
  /// it: the sign-in screen or the splash stays until it is known.
  checking,

  /// There is an attached card, or nothing is known: the app is open.
  open,

  /// The account has no card yet.
  setUp,

  /// The card was detached from the account on the website.
  detached,

  /// The card was just made or attached; the set-up has yet to say so.
  settling,
}

/// How far the set-up itself is, once the server took the request.
enum CardSetupStage {
  /// The set-up has not started yet.
  idle,

  /// The request went through and the card is being looked for.
  waiting,

  /// The card is there; the user has not gone on yet.
  ready,
}

/// Whether [data] has a card that is attached to the account.
bool hasAttachedCard(UserDataResponse? data) {
  final mkkm = data?.mkkmData;
  return mkkm != null && mkkm.detached != true;
}

/// The gate for [userData], [stage] into the set-up.
///
/// It closes only on what the server said. User data that could not be
/// loaded leaves the app open, as everything else works from stored data.
CardGate cardGateOf(AsyncValue<UserDataResponse?> userData, CardSetupStage stage) {
  if (stage == CardSetupStage.ready) {
    return CardGate.settling;
  }
  final data = userData.value;
  if (data == null) {
    return userData.isLoading ? CardGate.checking : CardGate.open;
  }
  final mkkm = data.mkkmData;
  if (mkkm == null) {
    return CardGate.setUp;
  }
  if (mkkm.detached == true) {
    return CardGate.detached;
  }
  // The card has arrived, the set-up is about to notice.
  return stage == CardSetupStage.waiting ? CardGate.settling : CardGate.open;
}
