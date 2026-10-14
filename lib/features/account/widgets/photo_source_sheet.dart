import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/platform/photo_picker.dart';
import 'package:mobile_kkm/core/providers/platform_providers.dart';
import 'package:mobile_kkm/core/widgets/icon_tile.dart';
import 'package:mobile_kkm/core/widgets/row_group.dart';
import 'package:mobile_kkm/features/account/widgets/link_sheet.dart';
import 'package:mobile_kkm/features/card_setup/services/card_setup_controller.dart';
import 'package:mobile_kkm/features/card_setup/utils/photo_type.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// What came of choosing a photo: the picture, or why it cannot be used.
typedef PhotoChoice = ({PickedPhoto? photo, String? problem});

/// Asks where the profile photo is to come from, the camera or the gallery,
/// and takes it from there. Null when the user backed out; a problem when
/// the picture is none the server would take.
Future<PhotoChoice?> choosePhoto(BuildContext context, WidgetRef ref, {required String title, String? subtitle}) async {
  final l10n = AppLocalizations.of(context);
  final scheme = Theme.of(context).colorScheme;
  final picker = ref.read(photoPickerProvider);
  final source = await showModalBottomSheet<PhotoSource>(
    context: context,
    showDragHandle: true,
    builder: (context) => LinkSheet(
      title: title,
      subtitle: subtitle,
      children: [
        for (final (source, icon, label) in [
          (PhotoSource.camera, Symbols.photo_camera_rounded, l10n.cardPhotoTake),
          (PhotoSource.gallery, Symbols.photo_library_rounded, l10n.cardPhotoChoose),
        ])
          GroupRow(
            minHeight: 64,
            dense: true,
            color: scheme.surfaceContainerHigh,
            leading: IconTile(icon, size: 40, background: scheme.surfaceContainerLow),
            label: label,
            showChevron: false,
            onTap: () => Navigator.of(context).pop(source),
          ),
      ],
    ),
  );
  if (source == null) {
    return null;
  }

  Uint8List? bytes;
  try {
    bytes = await picker.pick(source);
  } catch (_) {
    // No camera, no permission for it, or a file that could not be read.
    return (photo: null, problem: l10n.cardPhotoUnavailable);
  }
  if (bytes == null) {
    return null;
  }
  final type = photoTypeOf(bytes);
  if (type == null) {
    return (photo: null, problem: l10n.cardPhotoWrongType);
  }
  if (bytes.length > maxPhotoBytes) {
    return (photo: null, problem: l10n.cardPhotoTooLarge);
  }
  return (photo: PickedPhoto(bytes, type), problem: null);
}
