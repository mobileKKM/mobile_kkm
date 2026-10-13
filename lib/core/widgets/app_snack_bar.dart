import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

enum SnackKind {
  plain,

  /// Something the user asked for went through.
  success,

  /// It did not. Stays longer and can be closed, for the reason to be read.
  error,
}

/// Shows [message] in place of any snackbar still up, not after it.
void showAppSnackBar(ScaffoldMessengerState messenger, String message, {SnackKind kind = SnackKind.plain}) {
  messenger.hideCurrentSnackBar();
  if (kind == SnackKind.plain) {
    messenger.showSnackBar(SnackBar(content: Text(message)));
    return;
  }
  final error = kind == SnackKind.error;
  messenger.showSnackBar(
    SnackBar(
      duration: Duration(seconds: error ? 6 : 4),
      padding: error ? const EdgeInsetsDirectional.fromSTEB(16, 4, 4, 4) : null,
      content: Builder(
        builder: (context) {
          final color = Theme.of(context).colorScheme.onInverseSurface;
          return Row(
            children: [
              Icon(error ? Symbols.error_rounded : Symbols.check_circle_rounded, size: 20, fill: 1, color: color),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: error ? 10 : 0),
                  child: Text(message, maxLines: error ? 2 : null, overflow: error ? TextOverflow.ellipsis : null),
                ),
              ),
              // The snackbar's own close icon is not a Material Symbol.
              if (error)
                IconButton(
                  tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                  visualDensity: VisualDensity.compact,
                  iconSize: 20,
                  color: color,
                  icon: const Icon(Symbols.close_rounded),
                  onPressed: messenger.hideCurrentSnackBar,
                ),
            ],
          );
        },
      ),
    ),
  );
}
