import 'package:freezed_annotation/freezed_annotation.dart';

part 'invoice_models.freezed.dart';
part 'invoice_models.g.dart';

/// `GET /invoices` — paginated invoice list.
///
/// The element shape of `list` was never observed (always `[]`,
/// `rowCount: 0` in captures) — kept raw until real data becomes available.
@freezed
abstract class InvoiceListResponse with _$InvoiceListResponse {
  const factory InvoiceListResponse({
    @Default(<dynamic>[]) List<dynamic> list,
    int? rowCount,
  }) = _InvoiceListResponse;

  factory InvoiceListResponse.fromJson(Map<String, dynamic> json) =>
      _$InvoiceListResponseFromJson(json);
}
