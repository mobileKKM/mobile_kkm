import 'package:material_ui/material_ui.dart';

enum BannerKind { error, info }

class MessageBanner extends StatelessWidget {
  const MessageBanner(this.message, {super.key, this.kind = BannerKind.error});

  final String message;
  final BannerKind kind;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final (background, foreground, icon) = switch (kind) {
      BannerKind.error => (scheme.errorContainer, scheme.onErrorContainer, Icons.error_outline),
      BannerKind.info => (scheme.secondaryContainer, scheme.onSecondaryContainer, Icons.info_outline),
    };
    return Semantics(
      liveRegion: true,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(12)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: foreground, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(message, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: foreground)),
            ),
          ],
        ),
      ),
    );
  }
}
