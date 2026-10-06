import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// A failed load, with a way to try again.
class LoadProblem extends StatelessWidget {
  const LoadProblem({super.key, required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Symbols.cloud_off_rounded, size: 40, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(height: 12),
        Text(message, textAlign: TextAlign.center, style: theme.textTheme.bodyMedium),
        const SizedBox(height: 8),
        TextButton(onPressed: onRetry, child: Text(AppLocalizations.of(context).retry)),
      ],
    );
  }
}
