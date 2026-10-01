import 'package:dio/dio.dart';

import '../auth/auth_models.dart';
import '../common/api_paths.dart';
import '../common/api_service.dart';
import 'subscription_models.dart';

/// Subscriptions (5+1 / Bilet Półroczny) domain.
class SubscriptionsApi extends EkpApiService {
  SubscriptionsApi(super.dio);

  /// `GET subscriptions/details`
  Future<SubscriptionDetails> details() async {
    return guard(() async {
      final response = await dio.get<Map<String, dynamic>>(
        EkpApiPaths.subscriptionsDetails,
      );
      return SubscriptionDetails.fromJson(
        response.data ?? const <String, dynamic>{},
      );
    });
  }

  /// `GET subscriptions/available-actions`
  Future<SubscriptionAvailableActions> availableActions() async {
    return guard(() async {
      final response = await dio.get<Map<String, dynamic>>(
        EkpApiPaths.subscriptionsAvailableActions,
      );
      return SubscriptionAvailableActions.fromJson(
        response.data ?? const <String, dynamic>{},
      );
    });
  }

  /// `GET subscriptions/marketing-consents`
  Future<SubscriptionMarketingConsentsResponse> marketingConsents() async {
    return guard(() async {
      final response = await dio.get<Map<String, dynamic>>(
        EkpApiPaths.subscriptionsMarketingConsents,
      );
      return SubscriptionMarketingConsentsResponse.fromJson(
        response.data ?? const <String, dynamic>{},
      );
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
    required String pesel,
    required int ccCustomerId,
    List<MarketingConsent> marketingConsents = const [],
    bool isCycleRefreshEnabled = false,
  }) async {
    return guard(() async {
      await dio.post<dynamic>(
        EkpApiPaths.subscriptionsSignIn,
        data: {
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'pesel': pesel,
          'ccCustomerId': ccCustomerId,
          'marketingConsents': [
            for (final c in marketingConsents)
              {'id': c.id, 'content': c.content, 'isChecked': c.isChecked},
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
}
