import 'dart:typed_data';

import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

/// The round photo above a photo's buttons: [child] (the account's avatar or
/// a placeholder) until a picked photo's [bytes] take its place, which they
/// do once decoded, so there is no empty frame in between.
///
/// Always [size] across, ring or not: the ring of a [pending] photo is drawn
/// around the circle, as the design's shadow is, so nothing under it moves
/// when a photo is picked, dropped or saved.
class PhotoPreview extends StatelessWidget {
  const PhotoPreview({super.key, required this.size, required this.child, this.bytes, this.pending = false});

  final double size;
  final Widget child;
  final Uint8List? bytes;

  /// Picked and not saved yet: the ring marks it as the new one.
  final bool pending;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final bytes = this.bytes;
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // 3 dp of surface, then 3 dp of primary; the later one is on top.
        boxShadow: pending
            ? [BoxShadow(color: scheme.primary, spreadRadius: 6), BoxShadow(color: scheme.surface, spreadRadius: 3)]
            : null,
      ),
      child: SizedBox.square(
        dimension: size,
        child: bytes == null
            ? child
            : ClipOval(
                child: Image.memory(
                  bytes,
                  fit: BoxFit.cover,
                  gaplessPlayback: true,
                  frameBuilder: (context, image, frame, _) => frame == null ? child : image,
                  errorBuilder: (context, _, _) => ColoredBox(
                    color: scheme.surfaceContainerHigh,
                    child: Icon(
                      Symbols.broken_image_rounded,
                      size: (size * 0.375).roundToDouble(),
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
