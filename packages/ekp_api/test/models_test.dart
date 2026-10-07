import 'package:ekp_api/ekp_api.dart';
import 'package:test/test.dart';

import 'fixtures.dart';

void main() {
  group('auth models', () {
    test('AuthSession parses login response', () {
      final session = AuthSession.fromJson(fixture('login_response'));
      expect(session.token, 'aaa.bbb.ccc');
      expect(session.refresh, 'feedfacefeedfacefeedfacefeedface');
      expect(session.expires!.isUtc, isTrue, reason: 'Z-suffixed dates are UTC');
      expect(session.isExpired, isTrue, reason: 'the fixture expiry lies in the past');
    });

    test('PasswordPolicy parses', () {
      final policy = PasswordPolicy.fromJson(fixture('password_policy'));
      expect(policy.minLength, 8);
      expect(policy.requiredUppercase, 1);
      expect(policy.requiredDigits, 1);
    });

    test('CodeMessageResponse exposes string code accessors', () {
      final res = CodeMessageResponse.fromJson(fixture('change_password_error'));
      expect(res.codeAsString, 'PasswordInHistory');
      expect(res.message, 'Hasło zostało już użyte w przeszłości');
    });

    test('MarketingConsentsResponse parses', () {
      final res = MarketingConsentsResponse.fromJson(fixture('auth_consents'));
      expect(res.marketingConsents, hasLength(1));
      expect(res.marketingConsents.first.id, 4);
      expect(res.marketingConsents.first.isChecked, isFalse);
    });
  });

  group('account models', () {
    test('UserDataResponse parses full user data', () {
      final res = UserDataResponse.fromJson(fixture('user_data'));
      final user = res.userData!;
      expect(user.firstName, 'Jan');
      expect(user.lastName, 'Testowy');
      expect(user.pesel, '90010112345');
      expect(user.email, 'test@example.com');
      expect(user.registeredAddress!.city, 'Kraków');
      expect(res.mkkmData!.customerCode, '100001', reason: 'mkkmData.customerCode is sanitized numeric-as-string');
      expect(res.mkkmData!.hasInhabitantPrivilege, isTrue);
      expect(res.canIssueInvoice, isFalse);
    });

    test('InhabitantStatus parses', () {
      final res = InhabitantStatus.fromJson(fixture('inhabitant_status'));
      expect(res.isActive, isTrue);
      expect(res.firstName, 'Jan');
      expect(res.dateFromUtc, isNotNull);
    });

    test('InhabitantContract parses epoch-ms expiration and decodes PNG', () {
      final res = InhabitantContract.fromJson(fixture('inhabitant_contract'));
      expect(res.expirationDate!.isUtc, isTrue);
      expect(res.contract, isNotEmpty);
      expect(res.decodeContractPng(), isNotEmpty);
    });

    test('StreetAutocompleteResponse parses', () {
      final res = StreetAutocompleteResponse.fromJson(fixture('street_autocomplete'));
      expect(res.streets, ['TESTOWA']);
    });
  });

  group('storage medium models', () {
    test('StorageMediumListResponse parses and filters mKKM', () {
      final res = StorageMediumListResponse.fromJson(fixture('storage_medium_list'));
      expect(res.items, hasLength(2));
      expect(res.items.every((m) => m.canBuyTickets == true), isTrue);
      final mkkm = res.mkkmMedia;
      expect(mkkm, hasLength(1));
      expect(mkkm.single.isMkkm, isTrue);
      expect(mkkm.single.cityCardCode, 8);
      expect(mkkm.single.storageTypeName, 'mobilna Krakowska Karta Miejska');
    });
  });

  group('dictionary models', () {
    test('TicketKindListResponse parses', () {
      final res = TicketKindListResponse.fromJson(fixture('ticket_kind_list'));
      expect(res.kinds, isNotEmpty);
      final normal = res.kinds.firstWhere((k) => k.code == 2);
      expect(normal.description, 'Normalny');
      expect(normal.availableForSell, isTrue);
    });

    test('TicketNumberOfLineListResponse parses', () {
      final res = TicketNumberOfLineListResponse.fromJson(fixture('ticket_number_of_line_list'));
      final all = res.list.firstWhere((l) => l.code == 3);
      expect(all.description, 'Wszystkie linie - Strefa I');
      expect(all.selectableLines, isFalse);
      expect(all.sumLinesToSelection, 0);
    });

    test('TicketPeriodListResponse parses', () {
      final res = TicketPeriodListResponse.fromJson(fixture('ticket_period_list'));
      final one = res.list.firstWhere((p) => p.code == 1);
      expect(one.value, 1);
      expect(one.unit, 2, reason: '2 = months');
    });

    test('TransportLineResponse parses populated prefix-search results', () {
      final res = TransportLineResponse.fromJson(fixture('transport_line'));
      expect(res.lines, hasLength(90));

      // Typed element access (wire fields are snake_case — see the model).
      final first = res.lines.first;
      expect(first.line, 1);
      expect(first.isTram, isTrue);
      expect(first.isBus, isFalse);
      expect(first.secondZone, isFalse);
      expect(first.hasSecondZone, isFalse);

      // Every entry is exactly one of tram/bus …
      for (final line in res.lines) {
        expect(line.isTram != line.isBus, isTrue, reason: 'line ${line.line}');
      }
      // … trams are the 1xx-less lines (1, 10–19), buses the 1xx range.
      final trams = res.lines.where((l) => l.isTram!).map((l) => l.line);
      expect(trams, const [1, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19]);

      // The endpoint is a PREFIX search: number=1 -> 1, 10–19, 100–199.
      for (final line in res.lines) {
        expect(line.line.toString().startsWith('1'), isTrue);
      }
    });

    test('CityCardTypesResponse parses raw map and resolves names', () {
      final res = CityCardTypesResponse.fromJson(fixture('city_card_types'));
      expect(res.types.containsKey('8'), isTrue);
      expect(res.nameForCode(8), 'mKKM', reason: 'values arrive padded');
      expect(res.nameForCode(1), 'ELS');
      expect(res.nameForCode(999), isNull);
    });

    test('CityCardTypesResponse serializes back to the raw map', () {
      final json = fixture('city_card_types');
      final res = CityCardTypesResponse.fromJson(json);
      expect(res.toJson(), json);
      expect(CityCardTypesResponse.fromJson(res.toJson()), res);
    });
  });

  group('ticket models', () {
    test('MkkmTicketsResponse parses active ticket with 7-digit fractions', () {
      final res = MkkmTicketsResponse.fromJson(fixture('mkkm_tickets'));
      expect(res.tickets, hasLength(1));
      final ticket = res.tickets.single;
      expect(ticket.statusEnum, MkkmTicketStatus.active);
      expect(ticket.ticketGuid, 'feedfacefeedfacefeedfacefeedface');
      expect(ticket.transactionCode, isNotNull);
      expect(ticket.price, 99.0);
      expect(ticket.datePurchase!.microsecond, greaterThan(0), reason: 'sub-millisecond fractions survive parsing');
      expect(ticket.forCitizen, isTrue);
      expect(ticket.canAssign, isTrue);
    });

    test('tickets history parses bare array', () {
      final list = fixtureList('tickets_current')
          .whereType<Map<String, dynamic>>()
          .map(TicketHistoryEntry.fromJson)
          .toList();
      expect(list, hasLength(1));
      final entry = list.single;
      expect(entry.transactionId, 400001);
      expect(entry.isPayed, isTrue);
      expect(entry.productName, contains('mies.'));
      expect(entry.transactionStateId, 9);
    });

    test('cancelled history entries keep state 5, linger in Current', () {
      final list = fixtureList('tickets_current_cancelled')
          .whereType<Map<String, dynamic>>()
          .map(TicketHistoryEntry.fromJson)
          .toList();
      expect(list, hasLength(2));
      for (final entry in list) {
        // Auto-cancelled for non-payment: transaction AND payment both 5.
        expect(entry.transactionStateId, 5);
        expect(entry.paymentStateId, 5);
        expect(entry.isPayed, isFalse);
        expect(entry.transactionStateDescription, 'Transakcja anulowana');
        expect(entry.paymentStateDescription, contains('anulowana'));
      }
    });

    test('paid future-dated ticket is active, assignable, unassigned', () {
      final res = MkkmTicketsResponse.fromJson(fixture('mkkm_tickets_paid_future'));
      final ticket = res.tickets.single;
      // Paid = active, even before startDate (2025-10-01T00:00 local).
      expect(ticket.statusEnum, MkkmTicketStatus.active);
      expect(ticket.assigned, isFalse);
      expect(ticket.isAnyAssigned, isFalse);
      expect(ticket.canAssign, isTrue); // flips true on payment
      expect(ticket.startDate, DateTime.utc(2025, 9, 30, 22));
    });

    test('pending ticket list parses typed transport lines', () {
      final res = MkkmTicketsResponse.fromJson(fixture('mkkm_tickets_pending'));
      expect(res.tickets, hasLength(2));
      expect(res.tickets.first.statusEnum, MkkmTicketStatus.active);
      final pending = res.tickets.last;
      expect(pending.statusEnum, MkkmTicketStatus.pending);
      expect(pending.copyWith(status: 'processing').statusEnum, MkkmTicketStatus.processing);
      expect(pending.canAssign, isFalse); // awaiting payment
      // Line-scoped ticket: full TransportLine objects, snake_case wire.
      expect(pending.lines, hasLength(1));
      final line = pending.lines.single;
      expect(line.line, 12);
      expect(line.isTram, isTrue);
      expect(line.isBus, isFalse);
      expect(line.hasSecondZone, isFalse);
    });

    test('TicketDetailResponse parses state history lists', () {
      final res = TicketDetailResponse.fromJson(fixture('ticket_detail_returned'));
      expect(res.ticket!.transactionCode, isNotNull);
      expect(res.ticketEkp!.statusEnum, MkkmTicketStatus.returned);
      expect(res.canReturn, isFalse, reason: 'already returned');
      expect(res.transactionStateList, isNotNull);
      expect(res.transactionStateList!.first.stateDescription, contains('zakończona'));
      expect(res.paymentStateList, hasLength(2));
      expect(res.downloads, isNull);
    });

    test('TicketDetailResponse parses the return of a returned ticket', () {
      final res = TicketDetailResponse.fromJson(fixture('ticket_detail_returned'));
      final entry = res.ticketReturns!.single;
      expect(entry.returnDate, DateTime.utc(2025, 9, 20, 21, 45, 49));
      expect(entry.returnQty, 28);
      expect(entry.unitPriceReturn, 92.4);
      expect(entry.paymentTypeDescription, contains('TPay'));

      expect(TicketDetailResponse.fromJson(fixture('ticket_detail_active')).ticketReturns, isNull);
    });

    test('TicketDetailResponse parses active ticket as returnable', () {
      final res = TicketDetailResponse.fromJson(fixture('ticket_detail_active'));
      expect(res.ticketEkp!.statusEnum, MkkmTicketStatus.active);
      expect(res.canReturn, isTrue);
      expect(res.possibleRefundViaTpay, isNotNull);
      expect(res.minExpireReturnDate, isNotNull);
    });

    test('TicketSalesConfiguration parses with non-null success code', () {
      final res = TicketSalesConfiguration.fromJson(fixture('sales_config'));
      expect(res.codeAsInt, 1, reason: 'code 1 on HTTP 200 success!');
      expect(res.ticketKinds, isNotEmpty);
      expect(res.ticketPeriods, isNotEmpty);
      expect(res.priceListConfigurations, isNotEmpty);
      expect(res.firstDayOfValidity, isNotNull);
      expect(res.hasCracovCardPrivilege, isNotNull);
    });

    test('TicketCalculation parses echoed effective kind', () {
      final res = TicketCalculation.fromJson(fixture('tickets_calculate'));
      expect(res.price, 99.0);
      expect(res.commodityName, 'Bilet norm. mieszk. 1-mies. sieciowy st. I');
      expect(res.ticketKindCode, 21, reason: 'server maps requested kind 2 → effective 21 for residents');
      expect(res.hasSimilarTicket, isFalse);
    });

    test('TicketPurchaseResponse parses pending buy + tpay urls', () {
      final res = TicketPurchaseResponse.fromJson(fixture('buy_response'));
      expect(res.ticket!.statusEnum, MkkmTicketStatus.pending);
      expect(res.urls!.paymentUrl, contains('tpay.com'));
      expect(res.urls!.returnUrl, contains('/payment/success'));
    });

    test('TicketReturnCalculation parses refund preview', () {
      final res = TicketReturnCalculation.fromJson(fixture('ticket_returns_calculate'));
      expect(res.returnPrice, 92.4);
      expect(res.newTicketExpiryDate, isNotNull);
    });

    test('TicketReturnResult parses submission outcome', () {
      final res = TicketReturnResult.fromJson(fixture('ticket_return'));
      expect(res.createdCorrectionInvoice, isFalse);
      expect(res.success, isTrue);
    });
  });

  group('payment models', () {
    test('BankListResponse parses snake_case fields', () {
      final res = BankListResponse.fromJson(fixture('banks'));
      expect(res.list, isNotEmpty);
      final blik = res.list.firstWhere((b) => b.isBlik);
      expect(blik.id, '150');
      expect(blik.name, 'BLIK');
      final card = res.list.firstWhere((b) => b.id == '103');
      expect(card.mainBankId, '53');
      expect(card.availableViaWebview, isTrue);
    });
  });

  group('subscription models', () {
    test('SubscriptionDetails parses unsigned state', () {
      final res = SubscriptionDetails.fromJson(fixture('subscriptions_details'));
      expect(res.isSubscriptionSignedIn, isFalse);
      expect(res.counter, 0);
      expect(res.activeTicket, isNull);
      expect(res.customerDetail, isNull);
    });

    test('SubscriptionDetails parses the signed-in shape', () {
      final res = SubscriptionDetails.fromJson(fixture('subscriptions_details_signed'));
      expect(res.isSubscriptionSignedIn, isTrue);
      expect(res.maskedCardNumber, '****1234');
      expect(res.isAutomaticSubscriptionEnabled, isFalse);
      expect(res.isCycleRefreshEnabled, isFalse);
      // Local time WITHOUT a UTC offset on the wire.
      expect(res.subscriptionSignedInDate!.toIso8601String(), '2025-10-01T15:43:39.107');
      final detail = res.customerDetail!;
      expect(detail.firstName, 'JAN');
      expect(detail.lastName, 'TESTOWY');
      expect(detail.pesel, '90010112345');
      expect(detail.email, 'test@example.com');
      expect(detail.cityCardCode, 8); // 8 = mKKM in city-card-types
      expect(detail.clientCode, 100001);
    });

    test('SubscriptionDetails parses a pending ticket', () {
      final res = SubscriptionDetails.fromJson(fixture('subscriptions_details_ticket'));
      expect(res.activeTicket, isNull);
      final ticket = res.pendingTicket!;
      expect(ticket.ticketGuid, 'feedfacefeedfacefeedfacefeedface');
      expect(ticket.transactionCode, isNull);
      expect(ticket.startDate, DateTime(2025, 10, 2));
      expect(ticket.endDate, DateTime(2025, 11, 1, 23, 59, 59));
      expect(ticket.commodityName, 'Bilet 5+1 normalny');
      expect(ticket.monthsPeriod, 1);
      expect(ticket.price, 80.0);
      expect(ticket.canBePaid, isTrue);
      expect(ticket.canRemove, isTrue);
    });

    test('SubscriptionBuyingTicketDetails parses', () {
      final res = SubscriptionBuyingTicketDetails.fromJson(fixture('subscriptions_buying_ticket_details'));
      expect(res.commodityName, 'Bilet 5+1 normalny');
      expect(res.price, 80.0);
      expect(res.ticketSavedOnCard!.dateStart, DateTime(2025, 9));
      expect(res.ticketSavedOnCard!.dateEnd, DateTime(2025, 9, 30, 23, 59, 59));
    });

    test('SubscriptionTicketBuyResponse parses', () {
      final res = SubscriptionTicketBuyResponse.fromJson(fixture('subscriptions_ticket_buy'));
      expect(res.commodityName, 'Bilet 5+1 normalny');
      expect(res.ticketStartDate, DateTime(2025, 10, 2));
      expect(res.ticketEndDate, DateTime(2025, 11, 1, 23, 59, 59));
      expect(res.tpayRedirectUrl, 'https://secure.tpay.com/?id=deadbeef');
      expect(res.codeAsInt, isNull);
    });

    test('SubscriptionTicketPayResponse flags the repayment warning on code 2 only', () {
      final paid = SubscriptionTicketPayResponse.fromJson(fixture('subscriptions_ticket_pay'));
      expect(paid.needsRepaymentConfirmation, isFalse);
      expect(const SubscriptionTicketPayResponse(code: 2).needsRepaymentConfirmation, isTrue);
      expect(const SubscriptionTicketPayResponse(code: '2').needsRepaymentConfirmation, isFalse);
    });

    test('SubscriptionAvailableActions parses', () {
      final res = SubscriptionAvailableActions.fromJson(fixture('subscriptions_actions'));
      expect(res.buyTicket, isFalse);
      expect(res.newCard, isFalse);
    });

    test('SubscriptionAvailableActions parses signed-in actions', () {
      final res = SubscriptionAvailableActions.fromJson(fixture('subscriptions_actions_signed'));
      expect(res.changeCard, isTrue);
      expect(res.buyTicket, isTrue);
      expect(res.newCard, isFalse);
      expect(res.changeStorageMedium, isFalse);
    });
  });

  group('invoice + misc models', () {
    test('InvoiceListResponse parses empty list', () {
      final res = InvoiceListResponse.fromJson(fixture('invoices'));
      expect(res.list, isEmpty);
      expect(res.rowCount, 0);
    });

    test('ServiceStatus parses', () {
      final res = ServiceStatus.fromJson(fixture('service_status'));
      expect(res.isAvailable, isTrue);
      expect(res.customMessage, '');
    });

    test('MobileAppConfig.supportsClient compares dotted versions numerically', () {
      bool supports(String? minimum, [String client = '1.6.10']) =>
          MobileAppConfig(minAppVersion: minimum).supportsClient(client);

      expect(supports('1.6.10'), isTrue);
      expect(supports('1.6.9'), isTrue);
      expect(supports('1.5.99'), isTrue);
      expect(supports('1.6'), isTrue);
      expect(supports('1.6.11'), isFalse);
      expect(supports('1.7'), isFalse);
      expect(supports('1.10.0', '1.9.0'), isFalse);
      expect(supports('2.0.0'), isFalse);
      // Nothing to compare against gates nothing.
      expect(supports(null), isTrue);
      expect(supports(''), isTrue);
      expect(supports('latest'), isTrue);
    });

    test('the mimicked client version passes the captured minimum', () {
      expect(MobileAppConfig.fromJson(fixture('app_config')).supportsClient(), isTrue);
    });

    test('MobileAppConfig parses urls and announcement', () {
      final res = MobileAppConfig.fromJson(fixture('app_config'));
      expect(res.minAppVersion, '1.6.10');
      expect(res.busTimetableEnabled, isTrue);
      expect(res.tramTimetableEnabled, isFalse);
      expect(res.salesViewAnnouncement!.text, contains('CO2'));
    });
  });
}
