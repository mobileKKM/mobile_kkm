import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/core/theme/app_theme.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// Signs out, after asking: doing so by a slip of the finger costs a full
/// sign-in.
Future<void> confirmSignOut(BuildContext context, WidgetRef ref) async {
  final l10n = AppLocalizations.of(context);
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      icon: const Icon(Symbols.logout_rounded),
      title: Text(l10n.logoutConfirmTitle, textAlign: TextAlign.center),
      content: Text(l10n.logoutConfirmBody),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(l10n.cancel)),
        FilledButton(
          style: AppTheme.dialogAction,
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(l10n.logoutConfirmAction),
        ),
      ],
    ),
  );
  if (confirmed ?? false) {
    await ref.read(ekpClientProvider).auth.logout();
  }
}
