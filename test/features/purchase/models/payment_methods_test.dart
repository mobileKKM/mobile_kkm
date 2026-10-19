import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_kkm/features/purchase/models/payment_methods.dart';

import '../../../support/sample_data.dart';

void main() {
  final list = BankListResponse.fromJson(apiFixture('banks'));

  test('tiles by group id in the server order, Google Pay on Android', () {
    final methods = PaymentMethods.from(list, ios: false);
    expect(methods.tiles.map((b) => b.id), ['103', '150', '166', '171']);
    expect(methods.banks.map((b) => b.id), isNot(contains('170')));
    expect(methods.banks.first.id, '113');
    expect(methods.banks, hasLength(list.list.length - 5));
  });

  test('Apple Pay instead on iOS', () {
    final methods = PaymentMethods.from(list, ios: true);
    expect(methods.tiles.map((b) => b.id), ['103', '150', '170', '171']);
    expect(methods.banks.map((b) => b.id), isNot(contains('166')));
  });

  test('finds a group among tiles and banks', () {
    final methods = PaymentMethods.from(list, ios: false);
    expect(methods.byId('150')?.name, 'BLIK');
    expect(methods.isBank('160'), isTrue);
    expect(methods.isBank('150'), isFalse);
    expect(methods.byId('170'), isNull);
  });
}
