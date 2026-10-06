import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/router/app_router.dart';
import 'package:mobile_kkm/core/theme/app_theme.dart';
import 'package:mobile_kkm/features/tickets/services/ticket_sync.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

class MobileKkmApp extends ConsumerWidget {
  const MobileKkmApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Alive in every auth state, not only behind the signed-in screens: it
    // is also what empties the ticket store when the session ends.
    ref.listen(ticketSyncProvider, (_, _) {});
    return MaterialApp.router(
      title: 'mobileKKM',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      // Not `AppLocalizations.localizationsDelegates`: gen-l10n still lists the
      // framework's legacy Material delegate there, which material_ui replaces.
      localizationsDelegates: const [AppLocalizations.delegate, ...GlobalMaterialLocalizations.delegates],
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: ref.watch(routerProvider),
      // The app draws behind transparent system bars (see `main()`); their
      // icons follow the theme on screens without an app bar.
      builder: (context, child) {
        final icons = Theme.of(context).brightness == Brightness.dark ? Brightness.light : Brightness.dark;
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: icons,
            statusBarBrightness: Theme.of(context).brightness,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarIconBrightness: icons,
            systemNavigationBarContrastEnforced: false,
          ),
          child: child!,
        );
      },
    );
  }
}
