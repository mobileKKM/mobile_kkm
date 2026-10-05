import 'dart:math';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:ekp_api/ekp_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _deviceIdKey = 'ekp.device_id';

/// Builds the [EkpDeviceIdentity] sent with every request.
///
/// The device id is a random per-installation value (16 hex chars, the
/// shape the official client sends). It is kept across logouts because the
/// server binds refresh tokens to it.
Future<EkpDeviceIdentity> loadDeviceIdentity(FlutterSecureStorage storage, {DeviceInfoPlugin? deviceInfo}) async {
  final deviceId = await _loadOrCreateDeviceId(storage);
  final info = deviceInfo ?? DeviceInfoPlugin();

  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      final android = await info.androidInfo;
      return EkpDeviceIdentity(
        deviceId: deviceId,
        platform: 'android ${android.version.sdkInt}',
        deviceName: '${android.manufacturer} ${android.model}',
      );
    case TargetPlatform.iOS:
      final ios = await info.iosInfo;
      return EkpDeviceIdentity(
        deviceId: deviceId,
        platform: 'ios ${ios.systemVersion}',
        // The official iOS client's format is unknown (no capture); the
        // model name is the closest analogue to Android's value.
        deviceName: ios.modelName,
      );
    default:
      throw UnsupportedError('mobileKKM supports Android and iOS only');
  }
}

Future<String> _loadOrCreateDeviceId(FlutterSecureStorage storage) async {
  try {
    final existing = await storage.read(key: _deviceIdKey);
    if (existing != null && existing.length == 16) {
      return existing;
    }
  } catch (_) {
    // Unreadable entry — fall through and replace it.
  }
  final id = generateDeviceId();
  await storage.write(key: _deviceIdKey, value: id);
  return id;
}

@visibleForTesting
String generateDeviceId([Random? random]) {
  final rng = random ?? Random.secure();
  return List.generate(8, (_) => rng.nextInt(256).toRadixString(16).padLeft(2, '0')).join();
}
