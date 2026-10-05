import 'package:dio/dio.dart';

import '../auth/auth_models.dart';
import '../common/api_paths.dart';
import '../common/api_service.dart';
import 'account_models.dart';

/// Account domain: personal data, inhabitant (Karta Krakowska) status,
/// photo management.
class AccountApi extends EkpApiService {
  AccountApi(super.dio);

  /// `GET account/user-data`
  Future<UserDataResponse> userData() async {
    return guard(() async {
      final response = await dio.get<Map<String, dynamic>>(EkpApiPaths.userData);
      return UserDataResponse.fromJson(response.data ?? const <String, dynamic>{});
    });
  }

  /// `POST account/user-data` — returns HTTP 204 (no body) on success.
  ///
  /// Only the provided fields are sent; the observed official client always
  /// sends the full object.
  Future<void> updateUserData({
    String? phoneNumber,
    String? firstName,
    String? lastName,
    Address? registeredAddress,
  }) async {
    return guard(() async {
      await dio.post<dynamic>(
        EkpApiPaths.userData,
        data: {
          'phoneNumber': ?phoneNumber,
          'firstName': ?firstName,
          'lastName': ?lastName,
          if (registeredAddress != null) 'registeredAddress': registeredAddress.toJson(),
        },
        options: Options(responseType: ResponseType.plain),
      );
    });
  }

  /// `GET account/inhabitant-status`
  Future<InhabitantStatus> inhabitantStatus() async {
    return guard(() async {
      final response = await dio.get<Map<String, dynamic>>(EkpApiPaths.inhabitantStatus);
      return InhabitantStatus.fromJson(response.data ?? const <String, dynamic>{});
    });
  }

  /// `GET account/inhabitant-contract` — the contract's AZTEC barcode as
  /// a base64-encoded PNG (decode via
  /// [InhabitantContract.decodeContractPng]).
  Future<InhabitantContract> inhabitantContract() async {
    return guard(() async {
      final response = await dio.get<Map<String, dynamic>>(EkpApiPaths.inhabitantContract);
      return InhabitantContract.fromJson(response.data ?? const <String, dynamic>{});
    });
  }

  /// `GET account/street-autocomplete/{cityId}/{query}`.
  ///
  /// [cityId] `15` was observed for Kraków.
  Future<StreetAutocompleteResponse> streetAutocomplete(int cityId, String query) async {
    return guard(() async {
      final response = await dio.get<Map<String, dynamic>>(
        '${EkpApiPaths.streetAutocomplete}/$cityId'
        '/${Uri.encodeComponent(query)}',
      );
      return StreetAutocompleteResponse.fromJson(response.data ?? const <String, dynamic>{});
    });
  }

  /// `POST account/photo` — multipart upload of the profile photo
  /// (form field `photo`, JPEG).
  Future<void> uploadPhotoBytes(List<int> bytes, {String filename = 'photo.jpg'}) async {
    return guard(() async {
      final form = FormData();
      form.files.add(
        MapEntry(
          'photo',
          MultipartFile.fromBytes(bytes, filename: filename, contentType: DioMediaType.parse('image/jpeg')),
        ),
      );
      await dio.post<dynamic>(
        EkpApiPaths.accountPhoto,
        data: form,
        options: Options(responseType: ResponseType.plain),
      );
    });
  }

  /// `PUT account/anonymise` — irreversible GDPR account removal.
  ///
  /// Requires the account password as confirmation; the server answers
  /// HTTP 200 with the `{code, message}` envelope (`code: null` and
  /// "Twoje konto zostanie wkrótce usunięte." on success). The token is
  /// invalidated server-side immediately — the capture shows the very
  /// next `auth/logout` returning 401 — so callers should clear the local
  /// session right after a successful call.
  Future<CodeMessageResponse> anonymise({required String password}) async {
    return guard(() async {
      final response = await dio.put<Map<String, dynamic>>(EkpApiPaths.accountAnonymise, data: {'password': password});
      return CodeMessageResponse.fromJson(response.data ?? const <String, dynamic>{});
    });
  }
}
