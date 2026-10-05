import 'package:freezed_annotation/freezed_annotation.dart';

part 'storage_medium_models.freezed.dart';
part 'storage_medium_models.g.dart';

/// A card / medium a ticket can be assigned to — plastic KKM, ELS/ELD,
/// mKKM etc. Note this response carries **no** `{code, message}` envelope.
@freezed
abstract class StorageMedium with _$StorageMedium {
  const factory StorageMedium({
    int? storageTypeId,

    /// 8 identifies the mobile mKKM medium.
    int? cityCardCode,
    int? cardNumber,
    int? customerCode,
    int? ccCustomerCode,
    int? ccCustomerId,
    String? firstName,
    String? lastName,
    bool? hasActiveInhabitantStatus,
    DateTime? inhabitantStatusDateFrom,
    DateTime? inhabitantStatusDateTo,
    String? deactivationDateToCommunique,
    int? blockPlannedStateId,
    String? blockPlannedStateDescription,
    bool? blocked,
    bool? issued,
    bool? canBuyTickets,
    bool? isDefault,
    String? storageTypeName,
  }) = _StorageMedium;

  const StorageMedium._();

  factory StorageMedium.fromJson(Map<String, dynamic> json) => _$StorageMediumFromJson(json);

  /// Whether this medium is the mobile Kraków City Card (`cityCardCode == 8`).
  bool get isMkkm => cityCardCode == 8;
}

/// `GET storage-medium/list` — note the `items` key (not `list`).
@freezed
abstract class StorageMediumListResponse with _$StorageMediumListResponse {
  const factory StorageMediumListResponse({@Default(<StorageMedium>[]) List<StorageMedium> items}) =
      _StorageMediumListResponse;

  const StorageMediumListResponse._();

  factory StorageMediumListResponse.fromJson(Map<String, dynamic> json) => _$StorageMediumListResponseFromJson(json);

  /// All media that are the mobile Kraków City Card.
  List<StorageMedium> get mkkmMedia => items.where((m) => m.isMkkm).toList(growable: false);
}
