import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/router/app_router.dart';
import 'package:mobile_kkm/core/theme/app_theme.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

class MobileKkmApp extends ConsumerWidget {
  const MobileKkmApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'mobileKKM',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      // Not `AppLocalizations.localizationsDelegates`: gen-l10n still lists the
      // framework's legacy Material delegate there, which material_ui replaces.
      localizationsDelegates: const [AppLocalizations.delegate, ...GlobalMaterialLocalizations.delegates],
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: ref.watch(routerProvider),
    );
  }
}
