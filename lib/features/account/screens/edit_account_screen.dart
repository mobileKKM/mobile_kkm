import 'dart:async';

import 'package:ekp_api/ekp_api.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/api/error_messages.dart';
import 'package:mobile_kkm/core/providers/app_startup_provider.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/core/providers/platform_providers.dart';
import 'package:mobile_kkm/core/theme/app_theme.dart';
import 'package:mobile_kkm/core/widgets/app_snack_bar.dart';
import 'package:mobile_kkm/core/widgets/app_status_banner.dart';
import 'package:mobile_kkm/core/widgets/form_card.dart';
import 'package:mobile_kkm/core/widgets/message_banner.dart';
import 'package:mobile_kkm/core/widgets/submit_button.dart';
import 'package:mobile_kkm/features/account/providers/user_data_provider.dart';
import 'package:mobile_kkm/features/account/widgets/address_fields.dart';
import 'package:mobile_kkm/features/account/widgets/photo_source_sheet.dart';
import 'package:mobile_kkm/features/account/widgets/user_avatar.dart';
import 'package:mobile_kkm/features/auth/utils/validators.dart';
import 'package:mobile_kkm/features/auth/widgets/auth_page.dart';
import 'package:mobile_kkm/features/card_setup/services/card_setup_controller.dart';
import 'package:mobile_kkm/features/tickets/utils/ticket_format.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// The account's photo, name, phone number and address. The photo is a
/// request of its own and is saved by itself, right under the picture; the
/// rest goes in one, so it shares one Save.
class EditAccountScreen extends ConsumerStatefulWidget {
  const EditAccountScreen({super.key});

  @override
  ConsumerState<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends ConsumerState<EditAccountScreen> {
  static const _photoSize = 120.0;

  final _formKey = GlobalKey<FormState>();
  final _bannerKey = GlobalKey();
  late final TextEditingController _firstName;
  late final TextEditingController _lastName;
  late final TextEditingController _phone;
  late final TextEditingController _street;
  late final TextEditingController _building;
  late final TextEditingController _flat;
  late final TextEditingController _postcode;
  late final TextEditingController _town;

  /// What the account has, as the fields would show it: Save has something
  /// to do once they say otherwise.
  late List<String> _saved;

  /// A photo that was chosen and waits for its own Save.
  PickedPhoto? _photo;
  bool _saving = false;
  bool _savingPhoto = false;
  String? _error;

  List<TextEditingController> get _fields => [
    _firstName,
    _lastName,
    _phone,
    _street,
    _building,
    _flat,
    _postcode,
    _town,
  ];

  List<String> get _typed => [for (final field in _fields) field.text.trim()];

  bool get _changed {
    final typed = _typed;
    for (var i = 0; i < typed.length; i++) {
      if (typed[i] != _saved[i]) {
        return true;
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    final user = ref.read(userDataProvider).value?.userData;
    final address = user?.registeredAddress;
    _firstName = TextEditingController(text: user?.firstName);
    _lastName = TextEditingController(text: user?.lastName);
    _phone = TextEditingController(text: user?.phoneNumber);
    _street = TextEditingController(text: address?.street);
    _building = TextEditingController(text: address?.buildingNumber);
    _flat = TextEditingController(text: address?.apartmentNumber);
    _postcode = TextEditingController(text: address?.postalCode);
    _town = TextEditingController(text: address?.city);
    _saved = _typed;
    // Save, and whether leaving asks first, follow every keystroke.
    for (final field in _fields) {
      field.addListener(_onTyped);
    }
  }

  void _onTyped() => setState(() {});

  @override
  void dispose() {
    for (final field in _fields) {
      field.dispose();
    }
    super.dispose();
  }

  Future<void> _choosePhoto() async {
    final l10n = AppLocalizations.of(context);
    final choice = await choosePhoto(context, ref, title: l10n.photoSheetTitle, subtitle: l10n.photoSheetRules);
    if (choice == null || !mounted) {
      return;
    }
    setState(() {
      _photo = choice.photo ?? _photo;
      _error = choice.problem;
    });
    if (choice.problem != null) {
      _showBanner();
    }
  }

  Future<void> _savePhoto(PickedPhoto photo) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    setState(() {
      _savingPhoto = true;
      _error = null;
    });
    try {
      await ref
          .read(ekpClientProvider)
          .account
          .uploadPhotoBytes(
            photo.bytes,
            filename: 'photo.${photo.type.extension}',
            contentType: photo.type.contentType,
          );
    } catch (failure) {
      if (mounted) {
        setState(() {
          _savingPhoto = false;
          _error = describeError(l10n, failure);
        });
        _showBanner();
      }
      return;
    }
    // The new picture may come under the address of the old one.
    try {
      await ref.read(photoCacheProvider).clear();
    } catch (_) {
      // Nothing was cached, or the cache could not be opened.
    }
    await _reload();
    if (!mounted) {
      return;
    }
    setState(() {
      _savingPhoto = false;
      _photo = null;
    });
    showAppSnackBar(messenger, l10n.editPhotoSaved, kind: SnackKind.success);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final typed = _typed;
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      // Everything, as the official client sends it: there is one form.
      await ref
          .read(ekpClientProvider)
          .account
          .updateUserData(
            phoneNumber: _phone.text.trim(),
            firstName: _firstName.text.trim(),
            lastName: _lastName.text.trim(),
            registeredAddress: Address(
              city: _town.text.trim(),
              postalCode: _postcode.text.trim(),
              street: _street.text.trim(),
              buildingNumber: _building.text.trim(),
              // Empty when there is none, as the official client sends it.
              apartmentNumber: _flat.text.trim(),
            ),
          );
    } catch (failure) {
      if (mounted) {
        setState(() {
          _saving = false;
          _error = describeError(l10n, failure);
        });
        _showBanner();
      }
      return;
    }
    await _reload();
    if (!mounted) {
      return;
    }
    setState(() {
      _saving = false;
      _saved = typed;
    });
    showAppSnackBar(messenger, l10n.editSaved, kind: SnackKind.success);
  }

  /// The user data as the server has it now, for this screen's photo and
  /// for the Account header.
  Future<void> _reload() async {
    try {
      await ref.read(userDataProvider.notifier).refresh();
    } catch (_) {
      // Saved all the same; the next start brings it.
    }
  }

  /// The banner is the first thing on the screen, which may be scrolled.
  void _showBanner() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final banner = _bannerKey.currentContext;
      if (banner != null) {
        unawaited(Scrollable.ensureVisible(banner, duration: const Duration(milliseconds: 200), alignment: 0.1));
      }
    });
  }

  Future<void> _leave() async {
    final l10n = AppLocalizations.of(context);
    final navigator = Navigator.of(context);
    final discard = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Symbols.edit_off_rounded),
        title: Text(l10n.editDiscardTitle, textAlign: TextAlign.center),
        content: Text(l10n.editDiscardBody),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(l10n.editKeep)),
          FilledButton(
            style: AppTheme.dialogAction,
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.editDiscard),
          ),
        ],
      ),
    );
    if (discard ?? false) {
      navigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final user = ref.watch(userDataProvider).value?.userData;
    // Nothing here works without the server: off, with the reason on top.
    final online = ref.watch(appStatusProvider.select((status) => status.mode == AppMode.online));
    final photo = _photo;
    final busy = _saving || _savingPhoto;
    final dirty = _changed || photo != null;
    final quiet = theme.textTheme.bodySmall?.copyWith(fontSize: 13, height: 18 / 13, color: scheme.onSurfaceVariant);
    final birthDate = user?.birthDate;

    return PopScope(
      canPop: !dirty,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          unawaited(_leave());
        }
      },
      child: AuthPage(
        title: l10n.accountEdit,
        bottom: SubmitButton(
          label: l10n.editSave,
          icon: Symbols.check_rounded,
          loading: _saving,
          loadingLabel: l10n.editSaving,
          onPressed: _changed && online && !busy ? () => unawaited(_save()) : null,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
              AppStatusBanner(offlineDetail: l10n.offlineSaveKept),
              if (_error != null) MessageBanner(_error!, key: _bannerKey),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 4),
                child: Column(
                  spacing: 14,
                  children: [
                    if (photo != null)
                      // The ring marks it as the new one.
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: scheme.primary, width: 3),
                        ),
                        child: ClipOval(
                          child: Image.memory(
                            photo.bytes,
                            width: _photoSize,
                            height: _photoSize,
                            fit: BoxFit.cover,
                            gaplessPlayback: true,
                            errorBuilder: (context, _, _) => SizedBox.square(
                              dimension: _photoSize,
                              child: Icon(Symbols.broken_image_rounded, size: 44, color: scheme.onSurfaceVariant),
                            ),
                          ),
                        ),
                      )
                    else
                      UserAvatar(user: user, size: _photoSize, fontSize: 42),
                    Text(
                      photo != null ? l10n.editPhotoPending : l10n.cardPhotoFormats,
                      textAlign: TextAlign.center,
                      style: quiet,
                    ),
                    if (photo != null)
                      // One under the other where they do not fit side by side.
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          TextButton(
                            style: _photoAction,
                            onPressed: busy ? null : () => setState(() => _photo = null),
                            child: Text(l10n.cancel),
                          ),
                          SubmitButton(
                            style: _photoAction,
                            label: l10n.editPhotoSave,
                            icon: Symbols.check_rounded,
                            loading: _savingPhoto,
                            loadingLabel: l10n.editSaving,
                            onPressed: online && !busy ? () => unawaited(_savePhoto(photo)) : null,
                          ),
                        ],
                      )
                    else
                      FilledButton.tonalIcon(
                        style: _photoAction,
                        onPressed: online && !busy ? () => unawaited(_choosePhoto()) : null,
                        icon: const Icon(Symbols.photo_camera_rounded),
                        label: Text(l10n.cardPhotoChange),
                      ),
                  ],
                ),
              ),
              FormCard(
                title: l10n.editPersonal,
                children: [
                  TextFormField(
                    controller: _firstName,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    autofillHints: const [AutofillHints.givenName],
                    decoration: InputDecoration(labelText: l10n.firstNameLabel),
                    validator: (value) => validateRequired(l10n, value),
                  ),
                  TextFormField(
                    controller: _lastName,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    autofillHints: const [AutofillHints.familyName],
                    decoration: InputDecoration(labelText: l10n.lastNameLabel),
                    validator: (value) => validateRequired(l10n, value),
                  ),
                  TextFormField(
                    controller: _phone,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.telephoneNumber],
                    // Digits only, as in the official client.
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(labelText: l10n.editPhone),
                  ),
                  // What the app cannot change is text, not greyed-out fields.
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 16,
                    children: [
                      Divider(height: 1, thickness: 1, color: scheme.outlineVariant),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: 14,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 20,
                            children: [
                              Expanded(child: _Fact(l10n.editPesel, user?.pesel)),
                              Expanded(
                                child: _Fact(
                                  l10n.birthDateLabel,
                                  birthDate == null ? null : formatDate(l10n.localeName, birthDate),
                                ),
                              ),
                            ],
                          ),
                          _Fact(l10n.emailLabel, user?.email),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Symbols.lock_rounded, size: 18, color: scheme.onSurfaceVariant),
                          const SizedBox(width: 8),
                          Expanded(child: Text(l10n.editLockedNote, style: quiet)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              // Always asked for: every account that gets this far has an
              // mKKM card (the card set-up sees to it), and the card needs it.
              FormCard(
                title: l10n.editAddress,
                subtitle: l10n.editAddressHint,
                children: [
                  AddressFields(street: _street, building: _building, flat: _flat, postcode: _postcode, town: _town),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// The smaller buttons under the photo; the global minimum is 56.
  static const _photoAction = ButtonStyle(
    minimumSize: WidgetStatePropertyAll(Size(0, 48)),
    padding: WidgetStatePropertyAll(EdgeInsetsDirectional.only(start: 16, end: 20)),
    iconSize: WidgetStatePropertyAll(20),
    textStyle: WidgetStatePropertyAll(TextStyle(fontFamily: 'Inter', fontSize: 15, fontWeight: FontWeight.w600)),
  );
}

/// A detail of the account that is only shown.
class _Fact extends StatelessWidget {
  const _Fact(this.label, this.value);

  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final value = this.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(fontSize: 13, height: 18 / 13, color: scheme.onSurfaceVariant),
        ),
        Text(
          value == null || value.isEmpty ? '–' : value,
          style: theme.textTheme.bodyLarge?.copyWith(fontSize: 15, height: 20 / 15, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
