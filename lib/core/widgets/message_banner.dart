import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/theme/app_theme.dart';

enum BannerKind { error, success, info }

/// A notice at the top of a form or a screen: a failure, a confirmation or
/// a hint, optionally with one thing to do about it.
class MessageBanner extends StatelessWidget {
  const MessageBanner(
    this.message, {
    super.key,
    this.kind = BannerKind.error,
    this.icon,
    this.actionLabel,
    this.onAction,
  });

  final String message;
  final BannerKind kind;

  /// Instead of the kind's own icon.
  final IconData? icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final colors = AppColors.of(context);
    final (background, foreground, kindIcon) = switch (kind) {
      BannerKind.error => (scheme.errorContainer, scheme.onErrorContainer, Symbols.error_rounded),
      BannerKind.success => (colors.successContainer, colors.onSuccessContainer, Symbols.check_circle_rounded),
      BannerKind.info => (scheme.surfaceContainer, scheme.onSurfaceVariant, Symbols.info_rounded),
    };
    final style = theme.textTheme.bodyMedium?.copyWith(color: foreground);
    return Semantics(
      liveRegion: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(20)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon ?? kindIcon, color: foreground, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(message, style: style),
                  if (actionLabel != null)
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: foreground,
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(48, 40),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: AlignmentDirectional.centerStart,
                        textStyle: style?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      onPressed: onAction,
                      child: Text(actionLabel!),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
