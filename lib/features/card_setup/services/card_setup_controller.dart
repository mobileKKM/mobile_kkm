import 'dart:async';
import 'dart:typed_data';

import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/core/providers/platform_providers.dart';
import 'package:mobile_kkm/features/account/providers/user_data_provider.dart';
import 'package:mobile_kkm/features/auth/providers/auth_controller.dart';
import 'package:mobile_kkm/features/card_setup/models/card_gate.dart';
import 'package:mobile_kkm/features/card_setup/utils/photo_type.dart';

/// A photo the user chose for the card, not uploaded yet.
class PickedPhoto {
  const PickedPhoto(this.bytes, this.type);

  final Uint8List bytes;
  final PhotoType type;
}

/// The server refused `create-mkkm`, whose only content is the address.
class CardAddressRefused implements Exception {
  const CardAddressRefused(this.cause);

  final EkpApiException cause;
}

class CardSetupState {
  const CardSetupState({
    this.stage = CardSetupStage.idle,
    this.address,
    this.photo,
    this.photoSent = false,
    this.refusal,
  });

  final CardSetupStage stage;

  /// What step 1 was left with.
  final Address? address;

  /// What step 2 was left with; null to keep the account's photo.
  final PickedPhoto? photo;

  /// [photo] is on the server already, from an attempt that failed later.
  final bool photoSent;

  /// Why the server would not make the card, for step 1 to show.
  final EkpApiException? refusal;

  CardSetupState _with({CardSetupStage? stage, bool? photoSent, EkpApiException? refusal}) => CardSetupState(
    stage: stage ?? this.stage,
    address: address,
    photo: photo,
    photoSent: photoSent ?? this.photoSent,
    refusal: refusal ?? this.refusal,
  );
}

/// Makes the user's mKKM card, or attaches a detached one again, and waits
/// for it to show up in the user data.
///
/// The server makes the card after it has answered, so the user data is
/// loaded again until it has one, as the official client does: without a
/// limit, the button that asked staying busy meanwhile. Nothing here is
/// stored: an app closed while waiting starts from what the server says.
class CardSetupController extends Notifier<CardSetupState> {
  /// Between two looks for the card.
  static const checkEvery = Duration(seconds: 3);

  Timer? _nextCheck;

  @override
  CardSetupState build() {
    // Another session starts from nothing.
    ref
      ..watch(authControllerProvider.select((state) => state.status))
      ..onDispose(_stop);
    return const CardSetupState();
  }

  void setAddress(Address address) =>
      state = CardSetupState(stage: state.stage, address: address, photo: state.photo, photoSent: state.photoSent);

  void setPhoto(PickedPhoto photo) =>
      state = CardSetupState(stage: state.stage, address: state.address, photo: photo, refusal: state.refusal);

  /// Uploads the chosen photo, if any, and asks for the card with the
  /// address of step 1. Throws what the server or the network said;
  /// [CardAddressRefused] when it was the card request the server refused.
  Future<void> create() async {
    final client = ref.read(ekpClientProvider);
    final address = state.address;
    if (address == null) {
      throw StateError('no address');
    }
    final photo = state.photo;
    if (photo != null && !state.photoSent) {
      await client.account.uploadPhotoBytes(
        photo.bytes,
        filename: 'photo.${photo.type.extension}',
        contentType: photo.type.contentType,
      );
      if (!ref.mounted) {
        return;
      }
      state = state._with(photoSent: true);
      // The new picture may come under the address of the old one.
      try {
        await ref.read(photoCacheProvider).clear();
      } catch (_) {
        // Nothing was cached, or the cache could not be opened.
      }
    }
    try {
      await client.storageMediums.createMkkm(address);
    } on EkpHttpException catch (error) {
      final status = error.statusCode ?? 500;
      if (status >= 400 && status < 500 && ref.mounted) {
        state = state._with(refusal: error);
        throw CardAddressRefused(error);
      }
      rethrow;
    }
    _wait();
  }

  /// Attaches the card the account had, by its customer code.
  Future<void> reattach() async {
    final data = ref.read(userDataProvider).value;
    final customerCode = data?.mkkmData?.customerCode;
    if (customerCode == null) {
      throw StateError('no card to attach');
    }
    final pesel = data?.userData?.pesel;
    await ref
        .read(ekpClientProvider)
        .storageMediums
        .create(customerCode: customerCode, isWithoutPesel: pesel == null || pesel.isEmpty);
    _wait();
  }

  /// The user has seen that the card is ready: the gate opens.
  void finish() {
    _stop();
    state = const CardSetupState();
  }

  void _wait() {
    if (!ref.mounted) {
      return;
    }
    state = state._with(stage: CardSetupStage.waiting);
    unawaited(_check());
  }

  Future<void> _check() async {
    try {
      await ref.read(userDataProvider.notifier).refresh();
    } catch (_) {
      // Offline or server trouble: the next look may fare better.
    }
    if (!ref.mounted || state.stage != CardSetupStage.waiting) {
      return;
    }
    if (hasAttachedCard(ref.read(userDataProvider).value)) {
      _stop();
      state = state._with(stage: CardSetupStage.ready);
      return;
    }
    _nextCheck = Timer(checkEvery, () => unawaited(_check()));
  }

  void _stop() => _nextCheck?.cancel();
}

final cardSetupProvider = NotifierProvider<CardSetupController, CardSetupState>(CardSetupController.new);
