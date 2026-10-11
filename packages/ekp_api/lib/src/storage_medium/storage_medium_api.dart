import 'package:dio/dio.dart';

import '../account/account_models.dart';
import '../common/api_paths.dart';
import '../common/api_service.dart';
import 'storage_medium_models.dart';

/// Storage media (cards) the customer can hold tickets on.
class StorageMediumApi extends EkpApiService {
  StorageMediumApi(super.dio);

  /// `GET storage-medium/list`
  Future<StorageMediumListResponse> list() async {
    return guard(() async {
      final response = await dio.get<Map<String, dynamic>>(EkpApiPaths.storageMediumList);
      return StorageMediumListResponse.fromJson(response.data ?? const <String, dynamic>{});
    });
  }

  /// `POST storage-medium/create` — attaches the mKKM that was detached
  /// from the account again. Returns HTTP 200 with an empty body.
  ///
  /// [customerCode] is `mkkmData.customerCode` as `account/user-data` gives
  /// it, a string. [isWithoutPesel]: the account has no PESEL number. The
  /// official client also sends `universityId: null`.
  Future<void> create({required String customerCode, required bool isWithoutPesel}) async {
    return guard(() async {
      await dio.post<dynamic>(
        EkpApiPaths.storageMediumCreate,
        data: {
          'customerCode': customerCode,
          'cityCardCode': StorageMedium.mkkmCityCardCode,
          'universityId': null,
          'isWithoutPesel': isWithoutPesel,
        },
        options: Options(responseType: ResponseType.plain),
      );
    });
  }

  /// `POST storage-medium/create-mkkm` — creates a mobile Kraków City Card
  /// for the logged in user. Returns HTTP 200 with an empty body.
  Future<void> createMkkm(Address registeredAddress) async {
    return guard(() async {
      await dio.post<dynamic>(
        EkpApiPaths.storageMediumCreateMkkm,
        data: registeredAddress.toJson(),
        options: Options(responseType: ResponseType.plain),
      );
    });
  }
}
