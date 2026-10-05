import '../common/api_paths.dart';
import '../common/api_service.dart';
import 'dictionary_models.dart';

/// Dictionary endpoints backing the purchase wizard.
class DictionaryApi extends EkpApiService {
  DictionaryApi(super.dio);

  /// `GET dictionary/ticket-kind-list`
  Future<TicketKindListResponse> ticketKindList() async {
    return guard(() async {
      final response = await dio.get<Map<String, dynamic>>(EkpApiPaths.ticketKindList);
      return TicketKindListResponse.fromJson(response.data ?? const <String, dynamic>{});
    });
  }

  /// `GET dictionary/ticket-number-of-line-list`
  Future<TicketNumberOfLineListResponse> ticketNumberOfLineList() async {
    return guard(() async {
      final response = await dio.get<Map<String, dynamic>>(EkpApiPaths.ticketNumberOfLineList);
      return TicketNumberOfLineListResponse.fromJson(response.data ?? const <String, dynamic>{});
    });
  }

  /// `GET dictionary/ticket-period-list`
  Future<TicketPeriodListResponse> ticketPeriodList() async {
    return guard(() async {
      final response = await dio.get<Map<String, dynamic>>(EkpApiPaths.ticketPeriodList);
      return TicketPeriodListResponse.fromJson(response.data ?? const <String, dynamic>{});
    });
  }

  /// `GET dictionary/transport-line?number=...` — selectable lines for
  /// line-scoped tickets. [number] is a PREFIX search: `1` returns 1,
  /// 10–19 and 100–199; works with regular line numbers as well as the
  /// special transport line codes (`1001`, `1003`).
  Future<TransportLineResponse> transportLines(String number) async {
    return guard(() async {
      final response = await dio.get<Map<String, dynamic>>(
        EkpApiPaths.transportLine,
        queryParameters: {'number': number},
      );
      return TransportLineResponse.fromJson(response.data ?? const <String, dynamic>{});
    });
  }

  /// `GET dictionary/city-card-types`
  Future<CityCardTypesResponse> cityCardTypes() async {
    return guard(() async {
      final response = await dio.get<Map<String, dynamic>>(EkpApiPaths.cityCardTypes);
      return CityCardTypesResponse.fromJson(response.data ?? const <String, dynamic>{});
    });
  }
}
