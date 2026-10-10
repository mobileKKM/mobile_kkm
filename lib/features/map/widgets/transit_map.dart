import 'dart:math';

import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/features/map/constants/map_defaults.dart';
import 'package:mobile_kkm/features/map/models/map_view_controller.dart';

/// The map itself: a native MapLibre view on Kraków, in the theme's colours.
class TransitMap extends StatefulWidget {
  const TransitMap({
    super.key,
    required this.controller,
    required this.showLocation,
    required this.followLocation,
    required this.onFollowEnded,
  });

  final MapViewController controller;

  /// Draws the device's position. Needs the location permission.
  final bool showLocation;

  /// Keeps the map centred on the position as it changes.
  final bool followLocation;

  /// The user moved the map away while it was following.
  final VoidCallback onFollowEnded;

  @override
  State<TransitMap> createState() => _TransitMapState();
}

class _TransitMapState extends State<TransitMap> {
  @override
  void dispose() {
    widget.controller.attach(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return MapLibreMap(
      styleString: dark ? MapDefaults.darkStyle : MapDefaults.lightStyle,
      initialCameraPosition: const CameraPosition(target: MapDefaults.center, zoom: MapDefaults.zoom),
      onMapCreated: (map) => widget.controller.attach((target) async {
        // Closer in, never back out: a map already nearer stays so.
        final zoom = (await map.queryCameraPosition())?.zoom ?? 0;
        await map.animateCamera(
          CameraUpdate.newLatLngZoom(LatLng(target.latitude, target.longitude), max(zoom, MapDefaults.locationZoom)),
        );
      }),
      myLocationEnabled: widget.showLocation,
      myLocationTrackingMode: widget.showLocation && widget.followLocation
          ? MyLocationTrackingMode.tracking
          : MyLocationTrackingMode.none,
      onCameraTrackingDismissed: widget.onFollowEnded,
      // North stays up and the view flat: there is no compass to put either back.
      // Also disable tilt gestures to keep the view flat.
      compassEnabled: false,
      rotateGesturesEnabled: false,
      tiltGesturesEnabled: false,
      // The screen has its own button for the credits. The plugin cannot
      // switch this one off, so it is pushed far out of the view. The tint
      // is almost, not fully, transparent: MapLibre on Android replaces a
      // fully transparent one with its default blue.
      attributionButtonPosition: AttributionButtonPosition.bottomLeft,
      attributionButtonMargins: const Point(10000, 10000),
      attributionButtonColor: const Color(0x01000000),
    );
  }
}
