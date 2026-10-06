import 'package:geolocator/geolocator.dart';

enum LocationAccess {
  granted,

  /// Refused this time; asking again is possible.
  denied,

  /// Refused for good; only the system settings can change it.
  deniedForever,

  /// Location is switched off for the whole device.
  serviceOff,
}

typedef Coordinates = ({double latitude, double longitude});

/// The device's position, for the map. Nothing leaves the device.
class LocationService {
  const LocationService();

  /// Whether the position may be read, without asking the user anything.
  Future<bool> hasAccess() async {
    try {
      return _granted(await Geolocator.checkPermission()) && await Geolocator.isLocationServiceEnabled();
    } catch (_) {
      return false;
    }
  }

  /// Asks the user for the permission unless it was already decided.
  Future<LocationAccess> requestAccess() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      return LocationAccess.serviceOff;
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return switch (permission) {
      LocationPermission.deniedForever => LocationAccess.deniedForever,
      _ => _granted(permission) ? LocationAccess.granted : LocationAccess.denied,
    };
  }

  /// Where the device is, or null when no position could be had in time.
  Future<Coordinates?> current() async {
    try {
      final position =
          await Geolocator.getLastKnownPosition() ??
          await Geolocator.getCurrentPosition(locationSettings: const LocationSettings(timeLimit: _fixTimeout));
      return (latitude: position.latitude, longitude: position.longitude);
    } catch (_) {
      return null;
    }
  }

  /// The app's page in the system settings, where the permission is.
  Future<void> openSettings() => Geolocator.openAppSettings();

  static bool _granted(LocationPermission permission) =>
      permission == LocationPermission.whileInUse || permission == LocationPermission.always;

  static const _fixTimeout = Duration(seconds: 10);
}
