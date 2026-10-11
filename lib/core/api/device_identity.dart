import 'dart:math';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:ekp_api/ekp_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _deviceIdKey = 'ekp.device_id';
const _deviceNameKey = 'ekp.device_name';

/// Builds the [EkpDeviceIdentity] sent with every request.
///
/// The device id is a random per-installation value (16 hex chars, the
/// shape the official client sends). It is kept across logouts because the
/// server binds refresh tokens to it.
///
/// The device name is the hardware's, returned as `hardwareName` as well,
/// unless the debug menu stored another.
Future<({EkpDeviceIdentity identity, String hardwareName})> loadDeviceIdentity(
  FlutterSecureStorage storage, {
  DeviceInfoPlugin? deviceInfo,
}) async {
  final deviceId = await _loadOrCreateDeviceId(storage);
  final info = deviceInfo ?? DeviceInfoPlugin();

  final String platform;
  final String hardwareName;
  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      final android = await info.androidInfo;
      platform = 'android ${android.version.sdkInt}';
      hardwareName = '${android.manufacturer} ${android.model}';
    case TargetPlatform.iOS:
      final ios = await info.iosInfo;
      platform = 'ios ${ios.systemVersion}';
      // The official iOS client's format is unknown (no capture); the
      // model name is the closest analogue to Android's value.
      hardwareName = ios.modelName;
    default:
      throw UnsupportedError('mobileKKM supports Android and iOS only');
  }

  return (
    identity: EkpDeviceIdentity(
      deviceId: deviceId,
      platform: platform,
      deviceName: await _loadDeviceName(storage) ?? hardwareName,
    ),
    hardwareName: hardwareName,
  );
}

/// Stores what the debug menu set. Without a [deviceName] the hardware's is
/// back at the next start.
Future<void> saveDeviceIdentity(
  FlutterSecureStorage storage, {
  required String deviceId,
  required String? deviceName,
}) async {
  await storage.write(key: _deviceIdKey, value: deviceId);
  if (deviceName == null) {
    await storage.delete(key: _deviceNameKey);
  } else {
    await storage.write(key: _deviceNameKey, value: deviceName);
  }
}

Future<String?> _loadDeviceName(FlutterSecureStorage storage) async {
  try {
    final stored = await storage.read(key: _deviceNameKey);
    return stored == null || stored.isEmpty ? null : stored;
  } catch (_) {
    // Unreadable entry: the hardware's name, as if none were stored.
    return null;
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

/// A fresh id in the official client's shape. Also behind the debug menu's
/// "Generate".
String generateDeviceId([Random? random]) {
  final rng = random ?? Random.secure();
  return List.generate(8, (_) => rng.nextInt(256).toRadixString(16).padLeft(2, '0')).join();
}
