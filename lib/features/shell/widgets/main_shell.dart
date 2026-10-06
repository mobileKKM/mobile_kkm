import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// The signed-in frame: one of the four sections above the navigation bar.
class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        // Tapping the current section again returns to its first screen.
        onDestinationSelected: (index) =>
            navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex),
        destinations: [
          NavigationDestination(
            icon: const Icon(Symbols.home_rounded),
            selectedIcon: const Icon(Symbols.home_rounded, fill: 1),
            label: l10n.navHome,
          ),
          NavigationDestination(
            icon: const Icon(Symbols.confirmation_number_rounded),
            selectedIcon: const Icon(Symbols.confirmation_number_rounded, fill: 1),
            label: l10n.navTickets,
          ),
          NavigationDestination(
            icon: const Icon(Symbols.map_rounded),
            selectedIcon: const Icon(Symbols.map_rounded, fill: 1),
            label: l10n.navMap,
          ),
          NavigationDestination(
            icon: const Icon(Symbols.person_rounded),
            selectedIcon: const Icon(Symbols.person_rounded, fill: 1),
            label: l10n.navAccount,
          ),
        ],
      ),
    );
  }
}
