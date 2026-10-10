import 'package:maplibre_gl/maplibre_gl.dart';

/// Where the map opens and what it draws.
abstract final class MapDefaults {
  /// Rynek Główny, the middle of Kraków.
  static const center = LatLng(50.0617, 19.9373);
  static const double zoom = 12;

  /// How close the map goes to the user's position, at the least.
  static const double locationZoom = 15;

  // OpenFreeMap: vector tiles from OpenStreetMap data, no key and no limit.
  static const lightStyle = 'https://tiles.openfreemap.org/styles/positron';
  static const darkStyle = 'https://tiles.openfreemap.org/styles/dark';
}
