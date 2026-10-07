import 'package:ekp_crypto/ekp_crypto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../common/code_message.dart';
import '../dictionary/dictionary_models.dart';

part 'ticket_models.freezed.dart';
part 'ticket_models.g.dart';

/// Validity filter for `GET /tickets` history queries.
enum TicketValidity {
  current('Current'),
  past('Past');

  const TicketValidity(this.wireValue);
  final String wireValue;
}

/// Status of a mobile ticket as reported by `mkkm/tickets/list`.
enum MkkmTicketStatus {
  active,
  pending,

  /// A payment is being booked. Never captured: the official client checks
  /// for it and shows a disabled "processing payment" button.
  processing,
  returned,
  unknown;

  static MkkmTicketStatus fromWire(String? value) => switch (value) {
    'active' => MkkmTicketStatus.active,
    'pending' => MkkmTicketStatus.pending,
    'processing' => MkkmTicketStatus.processing,
    'returned' => MkkmTicketStatus.returned,
    _ => MkkmTicketStatus.unknown,
  };
}

/// A mobile ticket as returned by `mkkm/tickets/list` and (as a superset,
/// including `fivePlusOneTicket`, `customerCode`, `cityCardTypeCode`,
/// `productName`, payment fields and `cityCardTypeName`) inside the
/// `ticketEkp` node of `GET /tickets/{transactionCode}`.
///
/// Status semantics (verified across captures): `active` means *paid/live*
/// — a paid future-dated ticket is already `active` (and `canAssign`
/// flips to true) right after payment; `pending` means *awaiting payment*
/// (buy response, or bank-transfer limbo). A returned-but-unstarted
/// ticket shows `returned` while its transaction state id stays 9 (same
/// as normal completion) — the mkkm `status` field is the only "returned"
/// signal.
@freezed
abstract class MkkmTicket with _$MkkmTicket {
  const factory MkkmTicket({
    String? ticketGuid,

    /// Base64 transaction code — the id used by `GET /tickets/{id}`.
    String? transactionCode,
    String? status,
    DateTime? datePurchase,
    DateTime? startDate,
    DateTime? endDate,
    int? monthsPeriod,
    int? daysPeriod,
    double? price,
    bool? isAnyAssigned,
    bool? assigned,
    bool? canAssign,
    bool? forCitizen,
    int? ticketKindCode,
    int? ticketNumberOfLineCode,
    int? ticketPeriodCode,
    String? specialTransportLine,
    bool? isNetwork,
    bool? isMetropolitan,

    /// Selected transport lines for line-scoped tickets, as full
    /// [TransportLine] objects (snake_case wire shape, same as the
    /// `dictionary/transport-line` response).
    @Default(<TransportLine>[]) List<TransportLine> lines,
    bool? fivePlusOneTicket,

    /// Numeric customer code — only present in ticket detail responses.
    int? customerId,
    int? customerCode,
    int? cityCardTypeCode,
    String? productName,
    int? paymentStateId,
    String? paymentStateDescription,
    int? paymentTypeCode,
    String? paymentDescription,
    String? promotionName,
    String? cityCardTypeName,
  }) = _MkkmTicket;

  const MkkmTicket._();

  factory MkkmTicket.fromJson(Map<String, dynamic> json) => _$MkkmTicketFromJson(json);

  MkkmTicketStatus get statusEnum => MkkmTicketStatus.fromWire(status);
}

/// `GET mkkm/tickets/list`
@freezed
abstract class MkkmTicketsResponse with EkpCodeMessage, _$MkkmTicketsResponse {
  const MkkmTicketsResponse._();

  const factory MkkmTicketsResponse({
    @Default(<MkkmTicket>[]) List<MkkmTicket> tickets,
    Object? code,
    String? message,
  }) = _MkkmTicketsResponse;

  factory MkkmTicketsResponse.fromJson(Map<String, dynamic> json) => _$MkkmTicketsResponseFromJson(json);
}

/// Element of the bare array returned by `GET /tickets?customerCode=&validity=`.
@freezed
abstract class TicketHistoryEntry with _$TicketHistoryEntry {
  const factory TicketHistoryEntry({
    int? transactionId,
    String? transactionCode,
    bool? imported,
    DateTime? transactionDate,
    DateTime? ticketStartDate,
    DateTime? ticketExpiryDate,
    String? specialTransportLine,
    bool? isNetwork,
    bool? isMetropolitan,
    int? cityLine1,
    int? zoneLine1,
    int? cityLine2,
    int? zoneLine2,
    double? price,
    int? transactionStateId,
    String? transactionStateDescription,
    int? paymentTypeCode,
    String? paymentDescription,
    int? paymentStateId,
    String? paymentStateDescription,
    DateTime? paymentAccepted,
    String? productIndex,
    String? productName,
    int? productType,
    String? productTypeName,
    String? promotionName,
    bool? isPayed,
    int? ticketKindCode,
    int? ticketPeriodCode,
    int? ticketNumberOfLineCode,
  }) = _TicketHistoryEntry;

  factory TicketHistoryEntry.fromJson(Map<String, dynamic> json) => _$TicketHistoryEntryFromJson(json);
}

/// Entry of the `transactionStateList` / `paymentStateList` /
/// `refundStateList` / `changeLineList` history arrays in ticket detail.
@freezed
abstract class TicketStateChange with _$TicketStateChange {
  const factory TicketStateChange({int? nextNumber, DateTime? createDate, String? stateDescription}) =
      _TicketStateChange;

  factory TicketStateChange.fromJson(Map<String, dynamic> json) => _$TicketStateChangeFromJson(json);
}

/// Entry of `ticketReturns` in ticket detail: one return of the ticket.
///
/// [returnQty] is the number of days given back, [unitPriceReturn] the
/// amount refunded for them. Only tpay refunds were ever captured.
@freezed
abstract class TicketReturn with _$TicketReturn {
  const factory TicketReturn({
    DateTime? returnDate,
    int? returnQty,
    double? unitPriceReturn,
    String? paymentTypeDescription,
  }) = _TicketReturn;

  factory TicketReturn.fromJson(Map<String, dynamic> json) => _$TicketReturnFromJson(json);
}

/// `GET /tickets/{transactionCode}` — note: no `{code, message}` envelope.
@freezed
abstract class TicketDetailResponse with _$TicketDetailResponse {
  const factory TicketDetailResponse({
    int? customerId,
    TicketHistoryEntry? ticket,
    MkkmTicket? ticketEkp,
    bool? canChangeLine,
    bool? canReturn,
    bool? canEditByInternet,
    bool? canChangeStorageMedium,
    bool? canGenerateInvoice,
    bool? canBuyTheSame,
    bool? possibleRefundViaTpay,
    DateTime? minExpireReturnDate,
    int? invoiceHeaderId,
    List<TicketStateChange>? transactionStateList,
    List<TicketStateChange>? paymentStateList,
    List<TicketStateChange>? refundStateList,
    List<TicketStateChange>? changeLineList,

    /// Null unless the ticket was returned; one entry in every capture.
    List<TicketReturn>? ticketReturns,

    /// Shapes never observed (always null in captures) — kept raw.
    dynamic storageMediumChanges,
    dynamic downloads,
  }) = _TicketDetailResponse;

  factory TicketDetailResponse.fromJson(Map<String, dynamic> json) => _$TicketDetailResponseFromJson(json);
}

/// Element of `ticketNumberOfLines` in the sales configuration.
@freezed
abstract class SalesLineOption with _$SalesLineOption {
  const factory SalesLineOption({
    int? code,
    String? description,
    int? urbanLineQty,
    int? suburbanLineQty,
    int? suburban2LineQty,
    bool? isMetropolitan,
    bool? isNetwork,
    bool? selectableLines,
    int? sumLinesToSelection,
  }) = _SalesLineOption;

  factory SalesLineOption.fromJson(Map<String, dynamic> json) => _$SalesLineOptionFromJson(json);
}

/// Element of `ticketPeriods` in the sales configuration.
@freezed
abstract class SalesPeriodOption with _$SalesPeriodOption {
  const factory SalesPeriodOption({
    int? code,
    String? description,
    int? value,

    /// 2 = months, 3 = days.
    int? unit,
    bool? isMetropolitan,
    bool? isNetwork,
    bool? useDescription,
  }) = _SalesPeriodOption;

  factory SalesPeriodOption.fromJson(Map<String, dynamic> json) => _$SalesPeriodOptionFromJson(json);
}

/// Element of `ticketKinds` in the sales configuration.
@freezed
abstract class SalesKindOption with _$SalesKindOption {
  const factory SalesKindOption({int? code, String? description}) = _SalesKindOption;

  factory SalesKindOption.fromJson(Map<String, dynamic> json) => _$SalesKindOptionFromJson(json);
}

/// Element of `specialTransportLines` in the sales configuration —
/// the metropolitan (rail) flavour of a ticket.
@freezed
abstract class SpecialTransportLine with _$SpecialTransportLine {
  const factory SpecialTransportLine({
    String? specialTransportLine,
    String? name,
    String? description,
    String? buttonName,
    bool? isNetwork,
    bool? isMetropolitan,
  }) = _SpecialTransportLine;

  factory SpecialTransportLine.fromJson(Map<String, dynamic> json) => _$SpecialTransportLineFromJson(json);
}

/// Element of `priceListConfigurations` — the valid (kind, lineOption,
/// period) combinations.
@freezed
abstract class PriceListConfiguration with _$PriceListConfiguration {
  const factory PriceListConfiguration({int? ticketKindCode, int? ticketNumberOfLineCode, int? ticketPeriodCode}) =
      _PriceListConfiguration;

  factory PriceListConfiguration.fromJson(Map<String, dynamic> json) => _$PriceListConfigurationFromJson(json);
}

/// `GET tickets/ticket-sales-configuration/{customerCode}`.
///
/// Note: this endpoint returns `code: 1` (int) **on success** — a non-null
/// code does not imply an error here.
@freezed
abstract class TicketSalesConfiguration with EkpCodeMessage, _$TicketSalesConfiguration {
  const TicketSalesConfiguration._();

  const factory TicketSalesConfiguration({
    bool? hasCracovCardPrivilege,
    DateTime? firstDayOfValidity,
    DateTime? lastDayOfValidity,
    @Default(<SalesLineOption>[]) List<SalesLineOption> ticketNumberOfLines,
    @Default(<SalesPeriodOption>[]) List<SalesPeriodOption> ticketPeriods,
    @Default(<SalesKindOption>[]) List<SalesKindOption> ticketKinds,
    @Default(<SpecialTransportLine>[]) List<SpecialTransportLine> specialTransportLines,
    @Default(<PriceListConfiguration>[]) List<PriceListConfiguration> priceListConfigurations,
    Object? code,
    String? message,
  }) = _TicketSalesConfiguration;

  factory TicketSalesConfiguration.fromJson(Map<String, dynamic> json) => _$TicketSalesConfigurationFromJson(json);
}

/// `POST tickets/calculate` — price preview for a ticket selection.
/// Note: no `{code, message}` envelope. The echoed `ticketKindCode` may
/// differ from the request (e.g. requested 2 → effective 21 for inhabitants).
@freezed
abstract class TicketCalculation with _$TicketCalculation {
  const factory TicketCalculation({
    String? commodityIndex,
    String? commodityName,
    String? symbol,
    double? price,
    DateTime? validFrom,
    DateTime? validTo,
    int? daysPeriod,
    bool? forCitizen,
    int? ticketKindCode,
    int? ticketNumberOfLineCode,
    int? ticketPeriodCode,
    String? specialTransportLine,
    bool? isNetwork,
    bool? isMetropolitan,
    @Default(<dynamic>[]) List<dynamic> lines,
    bool? hasSimilarTicket,
    int? commodityId,
    int? priceListPeriodId,
    int? customerCode,

    /// Element shape unverified (always `[]` in captures) — kept raw.
    @Default(<dynamic>[]) List<dynamic> similarTickets,
  }) = _TicketCalculation;

  factory TicketCalculation.fromJson(Map<String, dynamic> json) => _$TicketCalculationFromJson(json);
}

/// `urls` node of `tickets/buy` / `tickets/pay`.
@freezed
abstract class PurchaseUrls with _$PurchaseUrls {
  const factory PurchaseUrls({
    /// tpay hosted payment page — open in a browser/webview.
    String? paymentUrl,

    /// Landing pages the payment provider redirects to afterwards.
    String? returnUrl,
    String? returnErrorUrl,
  }) = _PurchaseUrls;

  factory PurchaseUrls.fromJson(Map<String, dynamic> json) => _$PurchaseUrlsFromJson(json);
}

/// `POST tickets/buy` and `POST tickets/pay`.
///
/// [code] and [message] were never captured on these endpoints: they are
/// the envelope the official client reads from a `tickets/pay` reply
/// before it looks at [urls].
@freezed
abstract class TicketPurchaseResponse with EkpCodeMessage, _$TicketPurchaseResponse {
  const TicketPurchaseResponse._();

  const factory TicketPurchaseResponse({MkkmTicket? ticket, PurchaseUrls? urls, Object? code, String? message}) =
      _TicketPurchaseResponse;

  factory TicketPurchaseResponse.fromJson(Map<String, dynamic> json) => _$TicketPurchaseResponseFromJson(json);

  /// `tickets/pay` only: the ticket needs no payment any more
  /// (`code: 'AlreadyPaid'`). There is nothing to open — reload the
  /// ticket list.
  bool get isAlreadyPaid => code == 'AlreadyPaid';

  /// `tickets/pay` only: an earlier payment of this ticket is still
  /// unconfirmed (`code: 5`). Only expected when the call was made with
  /// `ignoreWarnings: false`; repeat it with `true` once the user agrees
  /// to pay again.
  bool get needsRepaymentConfirmation => codeAsInt == 5;
}

/// `POST ticket-returns/calculate`.
///
/// Note the suspicious `ticketStartDate` (holds the *expiry of the returned
/// period*) vs `newTicketExpiryDate` naming in the raw response.
@freezed
abstract class TicketReturnCalculation with EkpCodeMessage, _$TicketReturnCalculation {
  const TicketReturnCalculation._();

  const factory TicketReturnCalculation({
    double? returnPrice,
    DateTime? ticketStartDate,
    DateTime? newTicketExpiryDate,
    Object? code,
    String? message,
  }) = _TicketReturnCalculation;

  factory TicketReturnCalculation.fromJson(Map<String, dynamic> json) => _$TicketReturnCalculationFromJson(json);
}

/// `POST ticket-returns` — return submission result.
@freezed
abstract class TicketReturnResult with _$TicketReturnResult {
  const factory TicketReturnResult({bool? createdCorrectionInvoice, bool? success}) = _TicketReturnResult;

  factory TicketReturnResult.fromJson(Map<String, dynamic> json) => _$TicketReturnResultFromJson(json);
}

/// `POST mkkm/tickets/assign-e` — binds a purchased ticket to the device
/// that will display its AZTEC code.
///
/// Success is `{"assigned": true}`; failures come back as the
/// `{code, message}` envelope (observed with HTTP 200 — do not rely on the
/// status code alone, see [EkpCodeMessage]).
@freezed
abstract class TicketAssignResponse with EkpCodeMessage, _$TicketAssignResponse {
  const TicketAssignResponse._();

  const factory TicketAssignResponse({bool? assigned, Object? code, String? message}) = _TicketAssignResponse;

  factory TicketAssignResponse.fromJson(Map<String, dynamic> json) => _$TicketAssignResponseFromJson(json);
}

/// `POST mkkm/tickets/contract-e` — the encrypted AZTEC contract of an
/// assigned ticket (single fetch per display in the official app).
///
/// [contract] is base64: 16 IV bytes followed by AES-128-CBC ciphertext
/// (PKCS#7). Decrypt with [decodeAztec] to get the ~119 s hex token.
@freezed
abstract class TicketContractResponse with EkpCodeMessage, _$TicketContractResponse {
  const TicketContractResponse._();

  const factory TicketContractResponse({String? contract, Object? code, String? message}) = _TicketContractResponse;

  factory TicketContractResponse.fromJson(Map<String, dynamic> json) => _$TicketContractResponseFromJson(json);

  /// Decrypts [contract] into the 512-char hex AZTEC token, or `null` when
  /// absent/unparseable — mirroring the official client's catch-and-null
  /// (it then shows a generic error). Precedent:
  /// [InhabitantContract.decodeContractPng].
  String? decodeAztec({
    String? secret,

    /// Production keys differ from development ones (see
    /// [EkpCryptoEnvironment]).
    EkpCryptoEnvironment environment = EkpCryptoEnvironment.production,
  }) {
    if (contract == null) {
      return null;
    }
    return EkpAztecCrypto(secret: secret ?? cppSecret, environment: environment).decryptContract(contract!);
  }
}
