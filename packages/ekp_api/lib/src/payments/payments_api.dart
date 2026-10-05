import 'package:dio/dio.dart';

import '../common/api_exception.dart';
import '../common/api_paths.dart';
import '../common/api_service.dart';
import 'payment_models.dart';

/// Payments domain (tpay integration).
class PaymentsApi extends EkpApiService {
  PaymentsApi(super.dio);

  /// `GET payments/banks`
  Future<BankListResponse> banks() async {
    return guard(() async {
      final response = await dio.get<Map<String, dynamic>>(EkpApiPaths.paymentsBanks);
      return BankListResponse.fromJson(response.data ?? const <String, dynamic>{});
    });
  }

  /// `POST payments/change-payment-card` — starts a tpay card change for
  /// the subscription's recurring payment (available once
  /// `subscriptions/available-actions` reports `changeCard: true`).
  ///
  /// The official client sends the literal 4-byte body `null`; the
  /// response carries [ChangePaymentCardResponse.tPayRedirectUrl], which
  /// opens in a webview and completes through the same
  /// `/payment/{success,rejected}` → `payments/result` sequence as a
  /// ticket purchase.
  Future<ChangePaymentCardResponse> changePaymentCard() async {
    return guard(() async {
      final response = await dio.post<Map<String, dynamic>>(
        EkpApiPaths.paymentsChangePaymentCard,
        // Literal "null" — byte-for-byte parity with the official client
        // (its content-length is 4).
        data: 'null',
      );
      return ChangePaymentCardResponse.fromJson(response.data ?? const <String, dynamic>{});
    });
  }

  /// `POST payments/check` with `{id: ticketGuid}`.
  ///
  /// * HTTP 200 → [PaymentCheckStatus.confirmed]
  /// * HTTP 400 + body `code: 2` → [PaymentCheckStatus.pending] with the
  ///   server message ("Brak zaksięgowanej płatności...")
  /// * anything else → thrown as [EkpApiException]
  Future<PaymentCheckResult> check(String ticketGuid) async {
    try {
      await dio.post<dynamic>(EkpApiPaths.paymentsCheck, data: {'id': ticketGuid});
      return const PaymentCheckResult(status: PaymentCheckStatus.confirmed);
    } on DioException catch (e) {
      final response = e.response;
      final body = response?.data;
      final fields = body is Map<String, dynamic> ? body : <String, dynamic>{};
      final code = fields['code'];
      final codeInt = switch (code) {
        final int v => v,
        final num v => v.toInt(),
        _ => null,
      };
      final message = fields['message'] is String ? fields['message'] as String : null;
      if (response?.statusCode == 400 && codeInt == 2) {
        return PaymentCheckResult(status: PaymentCheckStatus.pending, message: message, code: code);
      }
      throw EkpApiException.fromDio(e);
    }
  }

  /// `POST payments/result` — reports the tpay webview outcome to the
  /// backend. The official app calls it natively right after the payment
  /// WebView lands on `/payment/success?id=…&type=2` (result `'Success'`)
  /// or `/payment/rejected?id=…&type=2` (result `'Error'`), then reloads
  /// the ticket list.
  ///
  /// [id] and [type] come from that redirect's query string; every body
  /// field is a STRING on the wire
  /// (`{"id":"…","type":"2","result":"Success"|"Error"}`).
  /// Success is HTTP 200 with an empty body.
  Future<void> result({required String id, required String type, String result = 'Success'}) async {
    return guard(() async {
      await dio.post<dynamic>(
        EkpApiPaths.paymentsResult,
        data: {'id': id, 'type': type, 'result': result},
        options: Options(responseType: ResponseType.plain),
      );
    });
  }
}
