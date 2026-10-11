/// Synthetic server replies for the signed-in screens, shaped like the
/// sanitized fixtures of `ekp_api`.
library;

const networkGuid = 'feedfacefeedfacefeedfacefeedface';
const metropolitanGuid = 'cafebabecafebabecafebabecafebabe';
const transactionCode = 'NDAwMDAxIzE';

Map<String, dynamic> ticketJson({
  String guid = networkGuid,
  String status = 'active',
  required DateTime start,
  required DateTime end,
  double price = 99,
  bool metropolitan = false,
  List<int> lines = const [],
  bool? assigned,
  bool? canAssign,
  String? productName,
  int? lineScope,
}) => {
  'ticketGuid': guid,
  'transactionCode': transactionCode,
  'status': status,
  'assigned': ?assigned,
  'canAssign': ?canAssign,
  'productName': ?productName,
  'ticketNumberOfLineCode': ?lineScope,
  'startDate': start.toUtc().toIso8601String(),
  'endDate': end.toUtc().toIso8601String(),
  'price': price,
  'isNetwork': !metropolitan && lines.isEmpty,
  'isMetropolitan': metropolitan,
  'lines': [
    for (final line in lines) {'line': line, 'is_tram': true},
  ],
};

/// A ticket that started [daysAgo] days ago and runs for 30 days.
Map<String, dynamic> validTicket({
  String guid = networkGuid,
  int daysAgo = 3,
  bool metropolitan = false,
  bool? assigned,
  bool? canAssign,
}) {
  final start = DateTime.now().subtract(Duration(days: daysAgo));
  return ticketJson(
    guid: guid,
    start: start,
    end: start.add(const Duration(days: 30)),
    metropolitan: metropolitan,
    assigned: assigned,
    canAssign: canAssign,
  );
}

/// A paid ticket that starts in [inDays] days.
Map<String, dynamic> upcomingTicket({
  String guid = metropolitanGuid,
  int inDays = 10,
  bool metropolitan = true,
  bool? assigned,
  bool? canAssign,
}) {
  final start = DateTime.now().add(Duration(days: inDays));
  return ticketJson(
    guid: guid,
    start: start,
    end: start.add(const Duration(days: 30)),
    metropolitan: metropolitan,
    assigned: assigned,
    canAssign: canAssign,
  );
}

Map<String, dynamic> expiredTicket({String guid = metropolitanGuid, bool metropolitan = true}) {
  final end = DateTime.now().subtract(const Duration(days: 2));
  return ticketJson(guid: guid, start: end.subtract(const Duration(days: 30)), end: end, metropolitan: metropolitan);
}

Map<String, dynamic> ticketsReply(List<Map<String, dynamic>> tickets) => {
  'tickets': tickets,
  'code': null,
  'message': null,
};

Map<String, dynamic> userDataJson({bool? resident = true, bool? activeSubscription, String? photoUrl}) => {
  'userData': {
    'firstName': 'Jan',
    'lastName': 'Testowy',
    'email': 'jan@example.com',
    'birthDate': '2000-01-03T00:00:00',
    'photoUrl': photoUrl,
  },
  'mkkmData': {
    'customerCode': '100001',
    'hasInhabitantPrivilege': resident,
    'hasActiveSubscription': ?activeSubscription,
  },
};

const appConfigJson = {
  'regulationsUrl': 'https://ekp.test/documents/Regulamin konta.pdf',
  'regulationsPurchaseUrl': 'https://ekp.test/documents/Regulamin sprzedazy.pdf',
  'regulations5plus1Url': 'https://ekp.test/documents/Regulamin polroczny.pdf',
  // In the real config too, but not offered by the app.
  'informationObligationUrl': 'https://ekp.test/documents/Obowiazek informacyjny.pdf',
  'declarationOfAccessibilityUrl': 'https://ekp.test/documents/deklaracja_dostepnosci.html',
};

const historyJson = [
  {
    'transactionId': 400001,
    'transactionCode': 'NDAwMDAxIzE',
    'ticketStartDate': '2025-03-01T00:00:00Z',
    'ticketExpiryDate': '2025-03-30T22:59:59Z',
    'price': 80.0,
    'transactionStateId': 9,
    'transactionStateDescription': 'Transakcja zakończona pomyślnie',
    'productName': 'Bilet norm. 1-mies. sieciowy',
  },
];

/// `GET /tickets/{transactionCode}` for [ticket], a ticket from above.
Map<String, dynamic> ticketDetailJson(
  Map<String, dynamic> ticket, {
  bool canReturn = false,
  bool canBuyTheSame = false,
  bool canChangeLine = false,
  bool paid = true,
  List<Map<String, dynamic>>? returns,
}) => {
  'ticket': {
    'transactionId': 400001,
    'transactionCode': ticket['transactionCode'],
    'transactionDate': '2025-03-01T10:15:00Z',
    'ticketStartDate': ticket['startDate'],
    'ticketExpiryDate': ticket['endDate'],
    'price': ticket['price'],
    'transactionStateDescription': 'Transakcja zakończona pomyślnie',
    'paymentDescription': 'ePłatność - przelew elektroniczny',
    'paymentStateDescription': paid ? 'Płatność potwierdzona i zakończona' : 'Płatność niezrealizowana',
    'productName': 'Bilet norm. 1-mies. sieciowy',
    'promotionName': null,
    'isPayed': paid,
  },
  'ticketEkp': {...ticket, 'productName': 'Bilet norm. 1-mies. sieciowy'},
  'canReturn': canReturn,
  'canChangeLine': canChangeLine,
  'canBuyTheSame': canBuyTheSame,
  'minExpireReturnDate': null,
  'transactionStateList': [
    {'nextNumber': 2, 'createDate': '2025-03-01T10:16:00Z', 'stateDescription': 'Transakcja zapłacona'},
    {'nextNumber': 1, 'createDate': '2025-03-01T10:15:00Z', 'stateDescription': 'Transakcja dodana'},
  ],
  'paymentStateList': [
    {'nextNumber': 1, 'createDate': '2025-03-01T10:15:00Z', 'stateDescription': 'Płatność rozpoczęta'},
  ],
  'refundStateList': [
    if (returns != null)
      {'nextNumber': 1, 'createDate': '2025-03-10T09:00:00Z', 'stateDescription': 'Zwrot rozpoczęty'},
  ],
  'ticketReturns': returns,
};

/// `dictionary/ticket-kind-list` and `…/ticket-period-list`, for a ticket
/// with [productCodes].
const ticketKindsJson = {
  'kinds': [
    {'code': 2, 'description': 'Normalny'},
  ],
};

const ticketPeriodsJson = {
  'list': [
    {'code': 1, 'description': 'Jeden miesiąc'},
  ],
};

/// Added to a ticket: the fare and period the dictionaries above name.
const productCodes = {'ticketKindCode': 2, 'ticketPeriodCode': 1};

const lineScopesJson = {
  'list': [
    {'code': 3, 'description': 'Wszystkie linie - Strefa I'},
  ],
};

/// A second, synthetic key for the encrypted requests: what the relay hands
/// out after a rotation. Nobody holds its private half.
const rotatedAztecKeyPem = '''
-----BEGIN RSA PUBLIC KEY-----
MIIBCgKCAQEAp9ygk89XucoHQjin7eK3q0RAcUaPYP14lOzKw1qmwx2aEjrzuuHE
MOtkVCFvrz7dXXW/4ltStERl4MINEDLBPIG//FfjdIYA3/zyR8p27F3xgVlkjQkR
iSaNftAtAh3e8QO2P9gPxb/SJhr8Bb8l8QlXto+tdR61V9ofHcvr4TlZ2pEHh17U
+g4oCrt79Ifglx5jCakEvPieT8/FdmCj6TGJru0W1ojA0SCO0MI0bsUv/97CNXVm
RdUVh5jE7evQOCV3Cq2PeME/iH31e39D+sTOF1Mnf5FufiguZTGImwZB1ObLk9nS
UY2QXMc/WAbze5vyWr7CFwkCYeq7+FkIjwIDAQAB
-----END RSA PUBLIC KEY-----
''';

/// The relay's reply for [pem]. The fingerprint is made up: the app only
/// shows it.
Map<String, dynamic> relayKeyJson(String pem, {int version = 1, String fingerprint = 'c0ffee00c0ffee00'}) => {
  'pem': pem,
  'fingerprint_sha256': fingerprint,
  'fetched_at': '2026-06-01T04:00:00+00:00',
  'age_seconds': 60,
  'version': version,
  'stale': false,
  'bits': 2048,
};
