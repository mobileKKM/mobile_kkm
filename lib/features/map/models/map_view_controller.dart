import 'dart:async';

import 'package:mobile_kkm/core/platform/location_service.dart';

/// Lets the screen move the map without knowing what draws it.
class MapViewController {
  var _attached = Completer<Future<void> Function(Coordinates target)>();

  /// Called by the map view once it can be moved, and with null when it is gone.
  void attach(Future<void> Function(Coordinates target)? moveTo) {
    if (moveTo == null || _attached.isCompleted) {
      _attached = Completer();
    }
    if (moveTo != null) {
      _attached.complete(moveTo);
    }
  }

  /// Centres the map on [target], close enough to make out the streets.
  /// Waits for the map view if it is not there yet.
  Future<void> moveTo(Coordinates target) async => (await _attached.future)(target);
}
