import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_models.freezed.dart';
part 'payment_models.g.dart';

/// `GET payments/banks` element — a tpay payment channel.
/// Wire field names are snake_case (`main_bank_id`, `available_via_webview`).
@freezed
abstract class Bank with _$Bank {
  const Bank._();

  const factory Bank({
    /// tpay group id, e.g. `150` = BLIK, `103` = card.
    String? id,
    String? name,
    String? banks,
    String? img,
    @JsonKey(name: 'main_bank_id') String? mainBankId,
    @JsonKey(name: 'available_via_webview') bool? availableViaWebview,
  }) = _Bank;

  factory Bank.fromJson(Map<String, dynamic> json) => _$BankFromJson(json);

  bool get isBlik => id == '150';
}

/// `GET payments/banks`
@freezed
abstract class BankListResponse with _$BankListResponse {
  const factory BankListResponse({@Default(<Bank>[]) List<Bank> list}) =
      _BankListResponse;

  factory BankListResponse.fromJson(Map<String, dynamic> json) =>
      _$BankListResponseFromJson(json);
}

enum PaymentCheckStatus {
  /// Payment booked — the ticket transitions to active.
  confirmed,

  /// No payment booked yet (`HTTP 400`, body code `2`) — retry later.
  pending,
}

/// Result of [PaymentsApi.check] — deliberately a value, not an exception:
/// "pending" is a normal intermediate state.
@freezed
abstract class PaymentCheckResult with _$PaymentCheckResult {
  const factory PaymentCheckResult({
    required PaymentCheckStatus status,
    String? message,
    Object? code,
  }) = _PaymentCheckResult;
}
