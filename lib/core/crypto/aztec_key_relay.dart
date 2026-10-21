import 'package:dio/dio.dart';
import 'package:mobile_kkm/core/crypto/aztec_key.dart';

/// The service that hands out the current [AztecKey], so the app need not
/// ask Firebase for it (see the aztec-key-relay project).
///
/// Deliberately not the eKP client: nothing that identifies the device or
/// the session is sent here.
class AztecKeyRelay {
  /// [userAgent] names the app to the relay, whose firewall turns away
  /// anything that does not start with `mobileKKM`.
  AztecKeyRelay(this._dio, {required String userAgent, String token = AztecKeyRelay.token}) {
    _dio.options.headers.addAll({'User-Agent': userAgent, if (token.isNotEmpty) 'Authorization': 'Bearer $token'});
  }

  /// The relay with its real address.
  factory AztecKeyRelay.live({required String userAgent}) => AztecKeyRelay(
    Dio(
      BaseOptions(
        baseUrl: apiUrl(address),
        // A refused ticket request waits for this: keep it short.
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        headers: {Headers.acceptHeader: Headers.jsonContentType},
      ),
    ),
    userAgent: userAgent,
  );

  /// Where the relay is, without a path. Set at build time for an instance
  /// of one's own: `--dart-define=AZTEC_KEY_RELAY_URL=https://relay.example.org`.
  static const address = String.fromEnvironment('AZTEC_KEY_RELAY_URL', defaultValue: 'https://relay.mobilekkm.app');

  /// The relay's `RELAY_API_TOKEN`, for an instance that asks for one:
  /// `--dart-define=AZTEC_KEY_RELAY_TOKEN=…`. Empty: none is sent. Anyone
  /// can read it out of the built app, so it keeps strangers off a relay,
  /// not users out.
  static const token = String.fromEnvironment('AZTEC_KEY_RELAY_TOKEN');

  /// The base URL of the relay's API at [address], with or without a slash
  /// at its end.
  static String apiUrl(String address) => '${address.replaceFirst(RegExp(r'/+$'), '')}/api/v1/';

  final Dio _dio;

  /// The key the relay holds. It does not ask its source for this.
  Future<AztecKey> current() async => _parse(await _dio.get<Map<String, dynamic>>('aztec-key'));

  /// Makes the relay ask its source again, for when a request was refused
  /// and the key may have been replaced. The relay limits how often it does
  /// that; the key it holds is the answer then, as it is when its source
  /// fails.
  Future<AztecKey> refresh() async {
    try {
      return _parse(await _dio.post<Map<String, dynamic>>('aztec-key/refresh'));
    } on DioException catch (exception) {
      if (const {429, 502}.contains(exception.response?.statusCode)) {
        return current();
      }
      rethrow;
    }
  }

  AztecKey _parse(Response<Map<String, dynamic>> response) => AztecKey.fromJson(response.data!);
}
