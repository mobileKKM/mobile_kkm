import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

/// A single mocked response: HTTP status + JSON-encodable body
/// (`null`/`''` for an empty body).
typedef MockReply = (int, Object?);

class _Route {
  _Route(this.method, this.fragment, this.replies, this.responseHeaders);
  final String method;
  final String fragment;
  final List<MockReply> replies;
  final Map<String, List<String>>? responseHeaders;
  int cursor = 0;
}

/// Minimal deterministic [HttpClientAdapter] for tests.
///
/// Routes are matched by HTTP method + path fragment and serve their
/// replies as a FIFO queue (exhausted routes repeat the last reply).
/// Every request is recorded in [requests]. Pass [responseHeaders] to
/// simulate response headers such as `set-cookie`.
class MockAdapter implements HttpClientAdapter {
  final List<_Route> _routes = [];
  final List<RequestOptions> requests = [];

  void on(
    String method,
    String pathFragment,
    List<MockReply> replies, {
    Map<String, List<String>>? responseHeaders,
  }) {
    _routes.add(_Route(method, pathFragment, replies, responseHeaders));
  }

  void onGet(
    String pathFragment,
    List<MockReply> replies, {
    Map<String, List<String>>? responseHeaders,
  }) => on('GET', pathFragment, replies, responseHeaders: responseHeaders);

  void onPost(
    String pathFragment,
    List<MockReply> replies, {
    Map<String, List<String>>? responseHeaders,
  }) => on('POST', pathFragment, replies, responseHeaders: responseHeaders);

  void onPut(
    String pathFragment,
    List<MockReply> replies, {
    Map<String, List<String>>? responseHeaders,
  }) => on('PUT', pathFragment, replies, responseHeaders: responseHeaders);

  Iterable<RequestOptions> requestsTo(String fragment) =>
      requests.where((r) => r.path.contains(fragment));

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    final route = _routes.where(
      (r) => r.method == options.method && options.path.contains(r.fragment),
    );
    if (route.isEmpty) {
      throw StateError(
        'No mock registered for ${options.method} ${options.path}',
      );
    }
    final r = route.first;
    final index = r.cursor < r.replies.length
        ? r.cursor++
        : r.replies.length - 1;
    final (status, body) = r.replies[index];
    final data = switch (body) {
      null => '',
      String s => s,
      _ => jsonEncode(body),
    };
    return ResponseBody.fromString(
      data,
      status,
      headers: {
        Headers.contentTypeHeader: ['application/json'],
        ...?r.responseHeaders,
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
