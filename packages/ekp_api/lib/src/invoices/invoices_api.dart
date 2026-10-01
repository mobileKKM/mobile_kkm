import '../common/api_paths.dart';
import '../common/api_service.dart';
import 'invoice_models.dart';

/// Invoices domain.
class InvoicesApi extends EkpApiService {
  InvoicesApi(super.dio);

  /// `GET /invoices` — note the odd `request.`-prefixed query parameter
  /// names the backend expects.
  Future<InvoiceListResponse> list({
    int pageIndex = 1,
    int pageSize = 15,
    String orderBy = 'createDatetime',
    String sortDirection = 'DESC',
  }) async {
    return guard(() async {
      final response = await dio.get<Map<String, dynamic>>(
        EkpApiPaths.invoices,
        queryParameters: {
          'request.pageIndex': pageIndex,
          'request.pageSize': pageSize,
          'request.orderBy': orderBy,
          'request.sortDirection': sortDirection,
        },
      );
      return InvoiceListResponse.fromJson(
        response.data ?? const <String, dynamic>{},
      );
    });
  }
}
