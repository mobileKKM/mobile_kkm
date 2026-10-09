import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/widgets/icon_tile.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// A failed load, with a way to try again.
class LoadProblem extends StatelessWidget {
  const LoadProblem({super.key, required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconTile(
          Symbols.cloud_off_rounded,
          size: 64,
          radius: 22,
          iconSize: 32,
          background: scheme.errorContainer,
          foreground: scheme.onErrorContainer,
        ),
        const SizedBox(height: 12),
        Text(
          message,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(fontSize: 15, height: 22 / 15),
        ),
        const SizedBox(height: 20),
        FilledButton.icon(
          style: FilledButton.styleFrom(minimumSize: const Size(64, 48), iconSize: 20),
          onPressed: onRetry,
          icon: const Icon(Symbols.refresh_rounded),
          label: Text(AppLocalizations.of(context).retry),
        ),
      ],
    );
  }
}
