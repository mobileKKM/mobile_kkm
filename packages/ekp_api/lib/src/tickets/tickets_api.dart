import 'package:ekp_crypto/ekp_crypto.dart';

import '../common/api_paths.dart';
import '../common/api_service.dart';
import '../dictionary/dictionary_models.dart';
import '../session/device_identity.dart';
import 'ticket_models.dart';

/// Tickets domain: mKKM mobile tickets, purchase history, sales
/// configuration, price calculation, purchase initiation, returns and the
/// encrypted assign/contract (AZTEC) endpoints.
class TicketsApi extends EkpApiService {
  TicketsApi(super.dio, this._device, {EkpAztecCrypto? crypto})
    : _crypto = crypto ?? const EkpAztecCrypto();

  final EkpDeviceIdentity _device;
  final EkpAztecCrypto _crypto;

  /// `GET mkkm/tickets/list` — the mobile tickets shown in the app.
  Future<MkkmTicketsResponse> mkkmTickets() async {
    return guard(() async {
      final response = await dio.get<Map<String, dynamic>>(
        EkpApiPaths.mkkmTicketsList,
      );
      return MkkmTicketsResponse.fromJson(
        response.data ?? const <String, dynamic>{},
      );
    });
  }

  /// `GET /tickets?customerCode=...&validity=Current|Past` — purchase
  /// history. Returns a **bare array**; 400s use the
  /// `{exceptionCode, message, errorToken}` envelope (see
  /// [EkpHttpException.errorToken]) — observed transiently on identical
  /// requests that later succeed, so treat them as retryable.
  ///
  /// Lifecycle quirks observed on the wire: tickets auto-cancelled for
  /// non-payment (`transactionStateId` 5) linger under `Current` until
  /// their validity window passes, while a returned-before-start ticket
  /// disappears from both `Current` and `Past`.
  Future<List<TicketHistoryEntry>> history(
    String customerCode, {
    TicketValidity validity = TicketValidity.current,
  }) async {
    return guard(() async {
      final response = await dio.get<List<dynamic>>(
        EkpApiPaths.tickets,
        queryParameters: {
          'customerCode': customerCode,
          'validity': validity.wireValue,
        },
      );
      return (response.data ?? const <dynamic>[])
          .whereType<Map<String, dynamic>>()
          .map(TicketHistoryEntry.fromJson)
          .toList(growable: false);
    });
  }

  /// `GET /tickets/{transactionCode}` — full detail of one transaction.
  Future<TicketDetailResponse> detail(String transactionCode) async {
    return guard(() async {
      final response = await dio.get<Map<String, dynamic>>(
        '${EkpApiPaths.tickets}/${Uri.encodeComponent(transactionCode)}',
      );
      return TicketDetailResponse.fromJson(
        response.data ?? const <String, dynamic>{},
      );
    });
  }

  /// `GET tickets/ticket-sales-configuration/{customerCode}` — the options
  /// the purchase wizard offers this customer.
  Future<TicketSalesConfiguration> salesConfiguration(
    String customerCode,
  ) async {
    return guard(() async {
      final response = await dio.get<Map<String, dynamic>>(
        '${EkpApiPaths.ticketSalesConfiguration}/$customerCode',
      );
      return TicketSalesConfiguration.fromJson(
        response.data ?? const <String, dynamic>{},
      );
    });
  }

  /// Selection of a ticket for [calculate]/[buy] bodies.
  ///
  /// Mirrors the official client field-for-field. [specialTransportLine]
  /// carries the pseudo-line code from the sales configuration's
  /// `specialTransportLines` dictionary (`1001` = sieciowy/network,
  /// `1003` = metropolitalny/+rail) — the official app sends `1001`
  /// even for line-scoped selections, and the server then reflects the
  /// actual choice (response `specialTransportLine` may be null with
  /// `isNetwork: false`). [lines] carries the chosen transport lines as
  /// full [TransportLine] objects for line-scoped tickets (empty for
  /// network/metropolitan ones); they serialize to the snake_case wire
  /// shape (`line`, `second_zone`, `is_tram`, ...).
  static Map<String, dynamic> selectionBody({
    required DateTime validFrom,
    required int ticketNumberOfLineCode,
    required String customerCode,
    required int ticketKindCode,
    required int ticketPeriodCode,
    List<TransportLine> lines = const [],
    String? specialTransportLine,
  }) => {
    'validFrom': validFrom.toUtc().toIso8601String(),
    'ticketNumberOfLineCode': ticketNumberOfLineCode,
    'lines': [for (final line in lines) line.toJson()],
    'specialTransportLine': ?specialTransportLine,
    'customerCode': customerCode,
    'ticketKindCode': ticketKindCode,
    'ticketPeriodCode': ticketPeriodCode,
  };

  /// `POST tickets/calculate` — price preview without side effects.
  Future<TicketCalculation> calculate({
    required DateTime validFrom,
    required int ticketNumberOfLineCode,
    required String customerCode,
    required int ticketKindCode,
    required int ticketPeriodCode,
    List<TransportLine> lines = const [],
    String? specialTransportLine,
  }) async {
    return guard(() async {
      final response = await dio.post<Map<String, dynamic>>(
        EkpApiPaths.ticketsCalculate,
        data: selectionBody(
          validFrom: validFrom,
          ticketNumberOfLineCode: ticketNumberOfLineCode,
          customerCode: customerCode,
          ticketKindCode: ticketKindCode,
          ticketPeriodCode: ticketPeriodCode,
          lines: lines,
          specialTransportLine: specialTransportLine,
        ),
      );
      return TicketCalculation.fromJson(
        response.data ?? const <String, dynamic>{},
      );
    });
  }

  /// `POST tickets/buy` — creates a *pending* ticket + tpay payment
  /// session. Complete the payment out-of-band, then poll [PaymentsApi.check]
  /// and/or open [PurchaseUrls.paymentUrl].
  Future<TicketPurchaseResponse> buy({
    required String tPayPaymentGroupId,
    required DateTime validFrom,
    required int ticketNumberOfLineCode,
    required String customerCode,
    required int ticketKindCode,
    required int ticketPeriodCode,
    List<TransportLine> lines = const [],
    String? specialTransportLine,
  }) async {
    return guard(() async {
      final response = await dio.post<Map<String, dynamic>>(
        EkpApiPaths.ticketsBuy,
        data: {
          'tPayPaymentGroupId': tPayPaymentGroupId,
          ...selectionBody(
            validFrom: validFrom,
            ticketNumberOfLineCode: ticketNumberOfLineCode,
            customerCode: customerCode,
            ticketKindCode: ticketKindCode,
            ticketPeriodCode: ticketPeriodCode,
            lines: lines,
            specialTransportLine: specialTransportLine,
          ),
        },
      );
      return TicketPurchaseResponse.fromJson(
        response.data ?? const <String, dynamic>{},
      );
    });
  }

  /// `POST tickets/pay` — re-initiates payment for an existing pending
  /// ticket (same body as [buy] plus `id` = ticketGuid).
  Future<TicketPurchaseResponse> pay({
    required String ticketGuid,
    required String tPayPaymentGroupId,
    bool ignoreWarnings = true,
  }) async {
    return guard(() async {
      final response = await dio.post<Map<String, dynamic>>(
        EkpApiPaths.ticketsPay,
        data: {
          'id': ticketGuid,
          'ignoreWarnings': ignoreWarnings,
          'tPayPaymentGroupId': tPayPaymentGroupId,
        },
      );
      return TicketPurchaseResponse.fromJson(
        response.data ?? const <String, dynamic>{},
      );
    });
  }

  /// `POST mkkm/tickets/assign-e` — binds [ticketGuid] to this device so it
  /// can display the ticket's AZTEC code.
  ///
  /// Mirrors the official client exactly: the payload is the compact JSON
  /// `{"id":"<guid>","device_name":"<x-device-name>"}`, RSA-2048 encrypted
  /// with the `aztecKey` Remote Config key and sent as `{"message": …}`.
  /// [deviceName] defaults to [EkpDeviceIdentity.deviceName]. Crypto
  /// failures throw [EkpCryptoException]; business errors surface via the
  /// `{code, message}` envelope on [TicketAssignResponse].
  Future<TicketAssignResponse> assign(
    String ticketGuid, {
    String? deviceName,
  }) async {
    final message = _crypto.encryptJson({
      'id': ticketGuid,
      'device_name': deviceName ?? _device.deviceName,
    });
    return guard(() async {
      final response = await dio.post<Map<String, dynamic>>(
        EkpApiPaths.mkkmTicketsAssignE,
        data: {'message': message},
      );
      return TicketAssignResponse.fromJson(
        response.data ?? const <String, dynamic>{},
      );
    });
  }

  /// `POST mkkm/tickets/contract-e` — fetches the encrypted AZTEC contract
  /// for an assigned ticket (the official app fetches exactly once when the
  /// control screen opens; the token is valid for ~119 s).
  ///
  /// Decrypt with [TicketContractResponse.decodeAztec]. A non-null [code]
  /// in the response means the server rejected the request (envelope
  /// arrives even with HTTP 200).
  Future<TicketContractResponse> contract(String ticketGuid) async {
    final message = _crypto.encryptJson({'ticketGuid': ticketGuid});
    return guard(() async {
      final response = await dio.post<Map<String, dynamic>>(
        EkpApiPaths.mkkmTicketsContractE,
        data: {'message': message},
      );
      return TicketContractResponse.fromJson(
        response.data ?? const <String, dynamic>{},
      );
    });
  }

  /// `POST ticket-returns` — executes the return previewed by
  /// [calculateReturn].
  ///
  /// Wire quirk: the official client's calculate call sends a
  /// local-midnight-labelled-as-UTC date while the execute call sends the
  /// true UTC instant — the server accepts both, so the same convention as
  /// [calculateReturn] (true UTC) is used.
  Future<TicketReturnResult> returnTicket({
    required int transactionId,
    required DateTime returnDate,
  }) async {
    return guard(() async {
      final response = await dio.post<Map<String, dynamic>>(
        EkpApiPaths.ticketReturns,
        data: {
          'transactionId': transactionId,
          'returnDate': returnDate.toUtc().toIso8601String(),
        },
      );
      return TicketReturnResult.fromJson(
        response.data ?? const <String, dynamic>{},
      );
    });
  }

  /// `POST ticket-returns/calculate` — refund preview.
  /// (The actual return submission endpoint was never captured.)
  Future<TicketReturnCalculation> calculateReturn({
    required int transactionId,
    required DateTime returnDate,
  }) async {
    return guard(() async {
      final response = await dio.post<Map<String, dynamic>>(
        EkpApiPaths.ticketReturnsCalculate,
        data: {
          'transactionId': transactionId,
          'returnDate': returnDate.toUtc().toIso8601String(),
        },
      );
      return TicketReturnCalculation.fromJson(
        response.data ?? const <String, dynamic>{},
      );
    });
  }
}
