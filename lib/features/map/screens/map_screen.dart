import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/platform/location_service.dart';
import 'package:mobile_kkm/core/providers/platform_providers.dart';
import 'package:mobile_kkm/features/account/widgets/link_sheet.dart';
import 'package:mobile_kkm/features/map/constants/map_credits.dart';
import 'package:mobile_kkm/features/map/models/map_view_controller.dart';
import 'package:mobile_kkm/features/map/providers/map_providers.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// The map of Kraków, which shows and follows the user's position on request. Vehicles, stops
/// with their departures and the stop search are still to come; the search
/// bar is a stand-in.
class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final _map = MapViewController();
  bool _showLocation = false;
  bool _following = false;
  bool _locating = false;

  @override
  void initState() {
    super.initState();
    // Granted on an earlier visit: the map goes to the user's position
    // without being asked.
    unawaited(
      ref.read(locationServiceProvider).hasAccess().then((granted) {
        if (granted && mounted) {
          return _follow();
        }
      }),
    );
  }

  /// Draws the position, moves the map there and keeps it there. Access to
  /// the location has to be granted already.
  Future<void> _follow() async {
    setState(() {
      _showLocation = true;
      _locating = true;
    });
    final position = await ref.read(locationServiceProvider).current();
    // Close in first: following keeps the zoom the map already has.
    if (position != null) {
      await _map.moveTo(position);
    }
    // Without a position yet, the map goes there as soon as there is one.
    if (mounted) {
      setState(() {
        _following = true;
        _locating = false;
      });
    }
  }

  Future<void> _goToMyLocation() async {
    final l10n = AppLocalizations.of(context);
    final location = ref.read(locationServiceProvider);
    // Already there, and staying there.
    if (_following) {
      return;
    }
    setState(() => _locating = true);
    try {
      final access = await location.requestAccess();
      if (!mounted) {
        return;
      }
      if (access != LocationAccess.granted) {
        _say(
          access == LocationAccess.serviceOff ? l10n.mapLocationServiceOff : l10n.mapLocationDenied,
          // Asking again does nothing any more; the settings are the way.
          action: access == LocationAccess.deniedForever
              ? SnackBarAction(label: l10n.mapLocationSettings, onPressed: () => unawaited(location.openSettings()))
              : null,
        );
        return;
      }
      await _follow();
    } finally {
      if (mounted) {
        setState(() => _locating = false);
      }
    }
  }

  void _say(String message, {SnackBarAction? action}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message), action: action));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    const fabShape = RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16)));
    return Scaffold(
      // The location button last: nearest the thumb.
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Not built yet: what the map shows (lines, kinds of vehicle).
          FloatingActionButton(
            heroTag: 'map-filters',
            tooltip: l10n.mapFilters,
            shape: fabShape,
            backgroundColor: scheme.surfaceContainerHigh,
            foregroundColor: scheme.primary,
            onPressed: () => _say(l10n.comingSoon),
            child: const Icon(Symbols.filter_alt_rounded),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: 'my-location',
            tooltip: l10n.mapMyLocation,
            shape: fabShape,
            backgroundColor: scheme.primaryContainer,
            foregroundColor: scheme.onPrimaryContainer,
            onPressed: _locating ? null : _goToMyLocation,
            child: _locating
                ? SizedBox.square(
                    dimension: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      strokeCap: StrokeCap.round,
                      color: scheme.onPrimaryContainer,
                    ),
                  )
                // Filled while the map follows the position.
                : Icon(
                    _showLocation ? Symbols.my_location_rounded : Symbols.location_searching_rounded,
                    fill: _following ? 1 : 0,
                  ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: ref.watch(mapViewProvider)(
              context,
              controller: _map,
              showLocation: _showLocation,
              followLocation: _following,
              onFollowEnded: () => setState(() => _following = false),
            ),
          ),
          // The map runs up behind the status bar; this keeps the clock and
          // the icons there readable.
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 120,
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      scheme.surface.withValues(alpha: 0.94),
                      scheme.surface.withValues(alpha: 0.6),
                      scheme.surface.withValues(alpha: 0),
                    ],
                    stops: const [0, 0.45, 1],
                  ),
                ),
              ),
            ),
          ),
          // In place of the map view's own attribution button.
          Positioned(
            left: 8,
            bottom: 8,
            child: IconButton.filledTonal(
              tooltip: l10n.mapCredits,
              style: IconButton.styleFrom(
                fixedSize: const Size.square(40),
                iconSize: 22,
                elevation: 1,
                shadowColor: Colors.black,
                tapTargetSize: MaterialTapTargetSize.padded,
              ),
              icon: const Icon(Symbols.info_rounded, fill: 1),
              onPressed: () => unawaited(
                showLinkSheet(
                  context,
                  title: l10n.mapCredits,
                  links: [
                    for (final credit in MapCredits.all)
                      SheetLink(
                        icon: Symbols.map_rounded,
                        label: credit.name,
                        subtitle: credit.site,
                        uri: Uri.parse('https://${credit.site}'),
                        external: true,
                      ),
                  ],
                ),
              ),
            ),
          ),
          // Positioned as well: a stack takes the size of its children that
          // are not, and the map has to fill the screen.
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(28)),
                    boxShadow: [
                      BoxShadow(color: Color(0x29000000), offset: Offset(0, 1), blurRadius: 3),
                      BoxShadow(color: Color(0x1A181C50), offset: Offset(0, 4), blurRadius: 10),
                    ],
                  ),
                  child: SearchBar(
                    enabled: false,
                    hintText: l10n.mapSearchHint,
                    elevation: const WidgetStatePropertyAll(0),
                    backgroundColor: WidgetStatePropertyAll(scheme.surfaceContainerHigh),
                    leading: Icon(Symbols.search_rounded, color: scheme.onSurface),
                    padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 16)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
