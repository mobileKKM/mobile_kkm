import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

/// In-memory [HttpClientAdapter]: canned replies keyed by method and path
/// suffix, plus a log of the requests that were made.
class FakeAdapter implements HttpClientAdapter {
  final _replies = <(String, String), ResponseBody Function()>{};
  final requests = <RequestOptions>[];

  void reply(String method, String pathSuffix, int status, [Object? body]) {
    _replies[(method, pathSuffix)] = () => ResponseBody.fromString(
      body == null ? '' : jsonEncode(body),
      status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  /// Makes the call fail without a response, like a dropped connection.
  void fail(String method, String pathSuffix) {
    _replies[(method, pathSuffix)] = () => throw const FormatException('offline');
  }

  RequestOptions requestTo(String pathSuffix) => requests.singleWhere((request) => request.path.endsWith(pathSuffix));

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    for (final MapEntry(key: (method, suffix), value: build) in _replies.entries) {
      if (options.method == method && options.path.endsWith(suffix)) {
        try {
          return build();
        } on FormatException {
          throw DioException.connectionError(requestOptions: options, reason: 'offline');
        }
      }
    }
    return ResponseBody.fromString('', 404);
  }

  @override
  void close({bool force = false}) {}
}
