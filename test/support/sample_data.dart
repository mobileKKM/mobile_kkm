/// Synthetic server replies for the signed-in screens, shaped like the
/// sanitized fixtures of `ekp_api`.
library;

const networkGuid = 'feedfacefeedfacefeedfacefeedface';
const metropolitanGuid = 'cafebabecafebabecafebabecafebabe';

Map<String, dynamic> ticketJson({
  String guid = networkGuid,
  String status = 'active',
  required DateTime start,
  required DateTime end,
  double price = 99,
  bool metropolitan = false,
  List<int> lines = const [],
}) => {
  'ticketGuid': guid,
  'transactionCode': 'NDAwMDAxIzE',
  'status': status,
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
Map<String, dynamic> validTicket({String guid = networkGuid, int daysAgo = 3, bool metropolitan = false}) {
  final start = DateTime.now().subtract(Duration(days: daysAgo));
  return ticketJson(guid: guid, start: start, end: start.add(const Duration(days: 30)), metropolitan: metropolitan);
}

/// A paid ticket that starts in [inDays] days.
Map<String, dynamic> upcomingTicket({String guid = metropolitanGuid, int inDays = 10, bool metropolitan = true}) {
  final start = DateTime.now().add(Duration(days: inDays));
  return ticketJson(guid: guid, start: start, end: start.add(const Duration(days: 30)), metropolitan: metropolitan);
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

Map<String, dynamic> userDataJson({bool? resident = true, String? photoUrl}) => {
  'userData': {
    'firstName': 'Jan',
    'lastName': 'Testowy',
    'email': 'jan@example.com',
    'birthDate': '2000-01-03T00:00:00',
    'photoUrl': photoUrl,
  },
  'mkkmData': {'customerCode': '100001', 'hasInhabitantPrivilege': resident},
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
    'transactionStateDescription': 'Transakcja zakończona pomyślnie',
    'productName': 'Bilet norm. 1-mies. sieciowy',
  },
];
