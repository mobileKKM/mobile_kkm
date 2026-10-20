import 'package:ekp_api/ekp_api.dart';

/// The tPay payment groups of `payments/banks`, split into the method tiles
/// and the banks of the transfer sheet.
class PaymentMethods {
  const PaymentMethods({required this.tiles, required this.banks});

  /// Sorts [list] for a phone that offers Apple Pay ([ios]) or Google Pay:
  /// the tiles in [tileOrder], the banks in the server's order.
  factory PaymentMethods.from(BankListResponse list, {required bool ios}) {
    final hidden = ios ? googlePay : applePay;
    final tiles = <Bank>[];
    final banks = <Bank>[];
    for (final bank in list.list) {
      final id = bank.id;
      if (id == null || id == hidden) {
        continue;
      }
      (tileOrder.contains(id) ? tiles : banks).add(bank);
    }
    tiles.sort((a, b) => tileOrder.indexOf(a.id!).compareTo(tileOrder.indexOf(b.id!)));
    return PaymentMethods(tiles: tiles, banks: banks);
  }

  static const blik = '150';
  static const card = '103';
  static const visaMobile = '171';

  /// Android only.
  static const googlePay = '166';

  /// iOS only.
  static const applePay = '170';

  /// The groups shown as tiles, in the design's order (the wallet second);
  /// every other group is a bank.
  static const tileOrder = [blik, googlePay, applePay, card, visaMobile];

  final List<Bank> tiles;
  final List<Bank> banks;

  /// The group with [id], tile or bank.
  Bank? byId(String? id) {
    if (id == null) {
      return null;
    }
    for (final bank in [...tiles, ...banks]) {
      if (bank.id == id) {
        return bank;
      }
    }
    return null;
  }

  bool isBank(String? id) => banks.any((bank) => bank.id == id);
}
