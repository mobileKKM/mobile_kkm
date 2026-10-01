import 'package:dio/dio.dart';

import '../session/device_identity.dart';

/// Adds the `x-*` device headers (and `accept: application/json`) that the
/// official client sends on every call — including `auth/token/recover`
/// (verified in the captured traffic).
///
/// Also completes the transport-level mimicry: the `user-agent` (okhttp in
/// the official app — dart:io would advertise `Dart/x.y`) and a
/// `content-type: application/json` on bodyless requests, which okhttp
/// always sends.
class DeviceHeadersInterceptor extends Interceptor {
  DeviceHeadersInterceptor(this.device);

  final EkpDeviceIdentity device;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[Headers.acceptHeader] = 'application/json';
    // okhttp sends content-type on every request, even GETs; only fill in
    // when unset so JSON bodies and multipart uploads keep their own value.
    options.headers.putIfAbsent(
      Headers.contentTypeHeader,
      () => 'application/json',
    );
    options.headers['x-device-id'] = device.deviceId;
    options.headers['x-platform'] = device.platform;
    options.headers['x-device-name'] = device.deviceName;
    options.headers['x-client-version'] = device.clientVersion;
    options.headers['user-agent'] = device.userAgent;
    handler.next(options);
  }
}
