import 'package:dio/dio.dart';

import '../auth/auth_models.dart';
import '../common/api_exception.dart';
import '../common/api_paths.dart';
import '../common/api_service.dart';
import 'subscription_models.dart';

/// Subscriptions (5+1 / Bilet Półroczny) domain.
class SubscriptionsApi extends EkpApiService {
  SubscriptionsApi(super.dio);

  /// `GET subscriptions/details`
  Future<SubscriptionDetails> details() async {
    return guard(() async {
      final response = await dio.get<Map<String, dynamic>>(EkpApiPaths.subscriptionsDetails);
      return SubscriptionDetails.fromJson(response.data ?? const <String, dynamic>{});
    });
  }

  /// `GET subscriptions/available-actions`
  Future<SubscriptionAvailableActions> availableActions() async {
    return guard(() async {
      final response = await dio.get<Map<String, dynamic>>(EkpApiPaths.subscriptionsAvailableActions);
      return SubscriptionAvailableActions.fromJson(response.data ?? const <String, dynamic>{});
    });
  }

  /// `GET subscriptions/marketing-consents`
  Future<SubscriptionMarketingConsentsResponse> marketingConsents() async {
    return guard(() async {
      final response = await dio.get<Map<String, dynamic>>(EkpApiPaths.subscriptionsMarketingConsents);
      return SubscriptionMarketingConsentsResponse.fromJson(response.data ?? const <String, dynamic>{});
    });
  }

  /// `POST subscriptions/sign-in` — signs the customer into the 5+1
  /// programme. Success is HTTP 200 with an empty body; the signed-in
  /// state is observable afterwards via [details] (and [availableActions]
  /// flips `changeCard`/`buyTicket` to true).
  ///
  /// Wire quirks, mirrored from the official client:
  /// * [firstName]/[lastName] are the UPPERCASED names from
  ///   `customerDetail` (sign the values as returned by [details]).
  /// * Exactly one of [pesel] and [birthDate] is sent: the official client
  ///   sends `pesel` when the account has one and otherwise `birthDate`,
  ///   taken unchanged from the user data. The [birthDate] variant was
  ///   never captured.
  /// * [ccCustomerId] is the internal id (int on the wire), not the
  ///   public customer code.
  /// * [marketingConsents] entries are serialized WITH their `content`
  ///   (unlike `auth/register`, which sends only `id` + `isChecked`).
  /// * [isCycleRefreshEnabled] pairs with the `isCycleRefreshEnabled`
  ///   flag of [SubscriptionDetails].
  Future<void> signIn({
    required String firstName,
    required String lastName,
    required String email,
    String? pesel,
    String? birthDate,
    required int ccCustomerId,
    List<MarketingConsent> marketingConsents = const [],
    bool isCycleRefreshEnabled = false,
  }) async {
    if ((pesel == null) == (birthDate == null)) {
      throw ArgumentError('Exactly one of pesel and birthDate must be given.');
    }
    return guard(() async {
      await dio.post<dynamic>(
        EkpApiPaths.subscriptionsSignIn,
        data: {
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'pesel': ?pesel,
          'birthDate': ?birthDate,
          'ccCustomerId': ccCustomerId,
          'marketingConsents': [
            for (final c in marketingConsents) {'id': c.id, 'content': c.content, 'isChecked': c.isChecked},
          ],
          'isCycleRefreshEnabled': isCycleRefreshEnabled,
        },
        options: Options(responseType: ResponseType.plain),
      );
    });
  }

  /// `POST subscriptions/cancel` — cancels the 5+1 subscription. The
  /// official client sends the literal 4-byte body `null`; success is
  /// HTTP 200 with an empty body. Afterwards [details] reports
  /// `isSubscriptionSignedIn: false` and [availableActions] loses the
  /// `changeCard`/`buyTicket` flags.
  Future<void> cancel() async {
    return guard(() async {
      await dio.post<dynamic>(
        EkpApiPaths.subscriptionsCancel,
        // Literal "null" — byte-for-byte parity with the official client
        // (its content-length is 4).
        data: 'null',
        options: Options(responseType: ResponseType.plain),
      );
    });
  }

  // The endpoints below were never captured. Paths, verbs and request
  // bodies are those of the official client; the responses are typed from
  // the fields it reads.

  /// `PUT subscriptions/edit` — turns automatic renewal into a new 5+1
  /// cycle on or off. The body is `{isCycleRefreshEnabled}` alone; the new
  /// value is observable afterwards via [details].
  Future<void> setCycleRefresh({required bool enabled}) async {
    return guard(() async {
      await dio.put<dynamic>(
        EkpApiPaths.subscriptionsEdit,
        data: {'isCycleRefreshEnabled': enabled},
        options: Options(responseType: ResponseType.plain),
      );
    });
  }

  /// `GET subscriptions/tickets/buying-ticket-details?ticketKind=…` — name
  /// and price of the 5+1 ticket of [kind], plus any ticket the customer
  /// already holds. The official client fetches it when the purchase screen
  /// opens and again on every kind change.
  Future<SubscriptionBuyingTicketDetails> buyingTicketDetails({
    SubscriptionTicketKind kind = SubscriptionTicketKind.normal,
  }) async {
    return guard(() async {
      final response = await dio.get<Map<String, dynamic>>(
        EkpApiPaths.subscriptionsTicketsBuyingDetails,
        queryParameters: {'ticketKind': kind.wireValue},
      );
      return SubscriptionBuyingTicketDetails.fromJson(response.data ?? const <String, dynamic>{});
    });
  }

  /// `POST subscriptions/tickets/buy` — buys the first ticket of a 5+1
  /// cycle (available once [availableActions] reports `buyTicket: true`).
  /// Open [SubscriptionTicketBuyResponse.tpayRedirectUrl] in a webview to
  /// pay; the ticket shows up as `pendingTicket` in [details].
  ///
  /// * [isAutomaticSubscriptionEnabled] is the customer's consent to the
  ///   monthly card debit — not the renewal flag, which is
  ///   [setCycleRefresh].
  /// * [validFrom] is sent as a UTC instant. The official client always
  ///   sends the start of tomorrow in local time: a 5+1 ticket becomes
  ///   valid the day after its purchase.
  Future<SubscriptionTicketBuyResponse> buyTicket({
    required SubscriptionTicketKind kind,
    required bool isAutomaticSubscriptionEnabled,
    required DateTime validFrom,
  }) async {
    return guard(() async {
      final response = await dio.post<Map<String, dynamic>>(
        EkpApiPaths.subscriptionsTicketsBuy,
        data: {
          'kind': kind.wireValue,
          'isAutomaticSubscriptionEnabled': isAutomaticSubscriptionEnabled,
          'validFrom': validFrom.toUtc().toIso8601String(),
        },
      );
      return SubscriptionTicketBuyResponse.fromJson(response.data ?? const <String, dynamic>{});
    });
  }

  /// `POST subscriptions/tickets/pay` — starts the payment of an unpaid
  /// subscription ticket ([SubscriptionTicket.canBePaid]).
  ///
  /// * HTTP 200 → the response carries `tpayRedirectUrl`
  /// * body `code: 2` → returned, not thrown, with
  ///   [SubscriptionTicketPayResponse.needsRepaymentConfirmation] set: an
  ///   earlier payment is still unconfirmed. Repeat with
  ///   [ignoreWarnings] `true` once the user agrees to pay again. The HTTP
  ///   status carrying this code is unknown, so any status is accepted.
  /// * anything else → thrown as [EkpApiException]
  Future<SubscriptionTicketPayResponse> payTicket({required String ticketGuid, bool ignoreWarnings = false}) async {
    try {
      final response = await dio.post<Map<String, dynamic>>(
        EkpApiPaths.subscriptionsTicketsPay,
        data: {'ticketGuid': ticketGuid, 'ignoreWarnings': ignoreWarnings},
      );
      return SubscriptionTicketPayResponse.fromJson(response.data ?? const <String, dynamic>{});
    } on DioException catch (e) {
      final body = e.response?.data;
      if (body is Map<String, dynamic>) {
        final code = body['code'];
        if (code is num && code.toInt() == 2) {
          return SubscriptionTicketPayResponse(
            code: code,
            message: body['message'] is String ? body['message'] as String : null,
          );
        }
      }
      throw EkpApiException.fromDio(e);
    }
  }

  /// `POST subscriptions/tickets/{ticketGuid}/remove` — deletes a
  /// subscription ticket ([SubscriptionTicket.canRemove]). Like [cancel],
  /// the official client sends the literal body `null`.
  Future<void> removeTicket(String ticketGuid) async {
    return guard(() async {
      await dio.post<dynamic>(
        '${EkpApiPaths.subscriptionsTickets}/${Uri.encodeComponent(ticketGuid)}/remove',
        data: 'null',
        options: Options(responseType: ResponseType.plain),
      );
    });
  }
}
