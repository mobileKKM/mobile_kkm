import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/api/error_messages.dart';
import 'package:mobile_kkm/core/platform/photo_picker.dart';
import 'package:mobile_kkm/core/providers/platform_providers.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/core/widgets/bullet_card.dart';
import 'package:mobile_kkm/core/widgets/dashed_border.dart';
import 'package:mobile_kkm/core/widgets/icon_tile.dart';
import 'package:mobile_kkm/core/widgets/lead_header.dart';
import 'package:mobile_kkm/core/widgets/message_banner.dart';
import 'package:mobile_kkm/core/widgets/row_group.dart';
import 'package:mobile_kkm/core/widgets/submit_button.dart';
import 'package:mobile_kkm/features/account/providers/user_data_provider.dart';
import 'package:mobile_kkm/features/account/widgets/link_sheet.dart';
import 'package:mobile_kkm/features/account/widgets/user_avatar.dart';
import 'package:mobile_kkm/features/auth/widgets/auth_page.dart';
import 'package:mobile_kkm/features/card_setup/models/card_gate.dart';
import 'package:mobile_kkm/features/card_setup/services/card_setup_controller.dart';
import 'package:mobile_kkm/features/card_setup/utils/photo_type.dart';
import 'package:mobile_kkm/features/card_setup/widgets/step_bar.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// Step 2 of the card set-up: the photo on the card, which is the
/// account's. Then the card is asked for.
class CardPhotoScreen extends ConsumerStatefulWidget {
  const CardPhotoScreen({super.key});

  @override
  ConsumerState<CardPhotoScreen> createState() => _CardPhotoScreenState();
}

class _CardPhotoScreenState extends ConsumerState<CardPhotoScreen> {
  static const _photoSize = 128.0;

  bool _submitting = false;
  String? _error;

  Future<void> _choose() async {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final source = await showModalBottomSheet<PhotoSource>(
      context: context,
      showDragHandle: true,
      builder: (context) => LinkSheet(
        title: l10n.cardPhotoAdd,
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
    if (source == null || !mounted) {
      return;
    }

    Uint8List? bytes;
    try {
      bytes = await ref.read(photoPickerProvider).pick(source);
    } catch (_) {
      // No camera, no permission for it, or a file that could not be read.
      if (mounted) {
        setState(() => _error = l10n.cardPhotoUnavailable);
      }
      return;
    }
    if (bytes == null || !mounted) {
      return;
    }
    final type = photoTypeOf(bytes);
    if (type == null || bytes.length > maxPhotoBytes) {
      setState(() => _error = type == null ? l10n.cardPhotoWrongType : l10n.cardPhotoTooLarge);
      return;
    }
    ref.read(cardSetupProvider.notifier).setPhoto(PickedPhoto(bytes, type));
    setState(() => _error = null);
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    setState(() {
      _submitting = true;
      _error = null;
    });
    String? error;
    try {
      await ref.read(cardSetupProvider.notifier).create();
    } on CardAddressRefused {
      // The request is the address: step 1 shows what the server said.
      if (mounted) {
        context.go(Routes.cardSetupAddress);
      }
      return;
    } catch (failure) {
      error = describeError(l10n, failure);
    }
    if (mounted) {
      setState(() {
        _submitting = false;
        _error = error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final setup = ref.watch(cardSetupProvider);
    final user = ref.watch(userDataProvider).value?.userData;
    final picked = setup.photo;
    final hasAccountPhoto = user?.photoUrl?.isNotEmpty ?? false;
    final hasPhoto = picked != null || hasAccountPhoto;
    final busy = _submitting || setup.stage == CardSetupStage.waiting;

    final Widget photo;
    if (picked != null) {
      // The ring marks it as the new one.
      photo = Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: scheme.primary, width: 3),
        ),
        child: ClipOval(
          child: Image.memory(
            picked.bytes,
            width: _photoSize,
            height: _photoSize,
            fit: BoxFit.cover,
            gaplessPlayback: true,
            errorBuilder: (context, _, _) => SizedBox.square(
              dimension: _photoSize,
              child: Icon(Symbols.broken_image_rounded, size: 48, color: scheme.onSurfaceVariant),
            ),
          ),
        ),
      );
    } else if (hasAccountPhoto) {
      photo = UserAvatar(user: user, size: _photoSize);
    } else {
      photo = DashedBorder(
        radius: _photoSize / 2,
        background: scheme.surfaceContainerHigh,
        child: SizedBox.square(
          dimension: _photoSize,
          child: Icon(Symbols.add_a_photo_rounded, size: 48, color: scheme.onSurfaceVariant),
        ),
      );
    }

    return AuthPage(
      title: l10n.cardTitle,
      bottom: SubmitButton(
        label: l10n.cardSetupSubmit,
        icon: Symbols.add_card_rounded,
        loading: busy,
        loadingLabel: l10n.cardChipCreating,
        onPressed: hasPhoto ? () => unawaited(_submit()) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          StepBar(step: 2, name: l10n.cardSetupStepPhoto),
          LeadHeader(title: l10n.cardSetupPhotoTitle, body: l10n.cardSetupPhotoHint, titleSize: 24),
          if (_error != null) MessageBanner(_error!),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              spacing: 14,
              children: [
                photo,
                Text(
                  picked != null ? l10n.cardPhotoNew : l10n.cardPhotoFormats,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 13,
                    height: 18 / 13,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                if (hasPhoto)
                  TextButton.icon(
                    style: _actionStyle,
                    onPressed: busy ? null : () => unawaited(_choose()),
                    icon: const Icon(Symbols.photo_camera_rounded),
                    label: Text(l10n.cardPhotoChange),
                  )
                else
                  FilledButton.tonalIcon(
                    style: _actionStyle,
                    onPressed: busy ? null : () => unawaited(_choose()),
                    icon: const Icon(Symbols.add_a_photo_rounded),
                    label: Text(l10n.cardPhotoAdd),
                  ),
              ],
            ),
          ),
          BulletCard(
            items: [
              BulletItem(icon: Symbols.badge_rounded, title: l10n.cardPhotoRuleIdTitle, body: l10n.cardPhotoRuleIdBody),
              BulletItem(
                icon: Symbols.light_mode_rounded,
                title: l10n.cardPhotoRuleLightTitle,
                body: l10n.cardPhotoRuleLightBody,
              ),
              BulletItem(
                icon: Symbols.face_rounded,
                title: l10n.cardPhotoRuleFaceTitle,
                body: l10n.cardPhotoRuleFaceBody,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// The smaller button under the photo; the global minimum is 56.
  static const _actionStyle = ButtonStyle(
    minimumSize: WidgetStatePropertyAll(Size(0, 48)),
    padding: WidgetStatePropertyAll(EdgeInsetsDirectional.only(start: 16, end: 20)),
    iconSize: WidgetStatePropertyAll(20),
  );
}
