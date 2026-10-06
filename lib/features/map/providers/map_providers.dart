import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/features/map/models/map_view_controller.dart';
import 'package:mobile_kkm/features/map/widgets/transit_map.dart';

/// [showLocation]: draw the device's position; only once access was granted.
/// [followLocation]: keep the map centred on it, until the user moves the
/// map themselves, which [onFollowEnded] reports.
typedef MapViewBuilder = Widget Function(
  BuildContext context, {
  required MapViewController controller,
  required bool showLocation,
  required bool followLocation,
  required VoidCallback onFollowEnded,
});

/// Builds the map view. A provider so tests can do without the native view.
final mapViewProvider = Provider<MapViewBuilder>(
  (ref) =>
      (context, {required controller, required showLocation, required followLocation, required onFollowEnded}) =>
          TransitMap(
            controller: controller,
            showLocation: showLocation,
            followLocation: followLocation,
            onFollowEnded: onFollowEnded,
          ),
);
