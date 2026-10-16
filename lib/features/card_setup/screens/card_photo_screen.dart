import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/api/error_messages.dart';
import 'package:mobile_kkm/core/providers/demo_mode_provider.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/core/widgets/bullet_card.dart';
import 'package:mobile_kkm/core/widgets/dashed_border.dart';
import 'package:mobile_kkm/core/widgets/lead_header.dart';
import 'package:mobile_kkm/core/widgets/message_banner.dart';
import 'package:mobile_kkm/core/widgets/submit_button.dart';
import 'package:mobile_kkm/features/account/providers/user_data_provider.dart';
import 'package:mobile_kkm/features/account/widgets/photo_preview.dart';
import 'package:mobile_kkm/features/account/widgets/photo_source_sheet.dart';
import 'package:mobile_kkm/features/account/widgets/user_avatar.dart';
import 'package:mobile_kkm/features/auth/widgets/auth_page.dart';
import 'package:mobile_kkm/features/card_setup/models/card_gate.dart';
import 'package:mobile_kkm/features/card_setup/services/card_setup_controller.dart';
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
    final choice = await choosePhoto(context, ref, title: AppLocalizations.of(context).cardPhotoAdd);
    if (choice == null || !mounted) {
      return;
    }
    final photo = choice.photo;
    if (photo != null) {
      ref.read(cardSetupProvider.notifier).setPhoto(photo);
    }
    setState(() => _error = choice.problem);
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
    final user = ref.watch(shownUserDataProvider).value?.userData;
    final picked = setup.photo;
    // From the real data: whether a photo is needed does not change in demo mode.
    final accountPhoto = ref.watch(userDataProvider).value?.userData?.photoUrl;
    final hasAccountPhoto = accountPhoto?.isNotEmpty ?? false;
    final hasPhoto = picked != null || hasAccountPhoto;
    final busy = _submitting || setup.stage == CardSetupStage.waiting;

    final photo = PhotoPreview(
      size: _photoSize,
      bytes: picked?.bytes,
      pending: picked != null,
      child: hasAccountPhoto
          ? UserAvatar(user: user, size: _photoSize)
          : DashedBorder(
              radius: _photoSize / 2,
              background: scheme.surfaceContainerHigh,
              child: SizedBox.square(
                dimension: _photoSize,
                child: Icon(Symbols.add_a_photo_rounded, size: 48, color: scheme.onSurfaceVariant),
              ),
            ),
    );

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
