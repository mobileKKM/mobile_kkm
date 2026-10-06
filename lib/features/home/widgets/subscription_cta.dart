import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// Leads to the 5+1 half-year ticket programme.
class SubscriptionCta extends StatelessWidget {
  const SubscriptionCta({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: scheme.tertiaryContainer,
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        iconColor: scheme.onTertiaryContainer,
        textColor: scheme.onTertiaryContainer,
        leading: const Icon(Symbols.event_repeat_rounded),
        title: Text(l10n.subscriptionTitle),
        subtitle: Text(l10n.subscriptionCtaBody),
        trailing: const Icon(Symbols.chevron_right_rounded),
        onTap: () => context.push(Routes.subscription),
      ),
    );
  }
}
