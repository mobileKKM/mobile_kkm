import 'package:ekp_api/ekp_api.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/api/error_messages.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/core/providers/platform_providers.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/core/theme/app_theme.dart';
import 'package:mobile_kkm/core/widgets/form_card.dart';
import 'package:mobile_kkm/core/widgets/message_banner.dart';
import 'package:mobile_kkm/core/widgets/submit_button.dart';
import 'package:mobile_kkm/features/auth/models/password_rule.dart';
import 'package:mobile_kkm/features/auth/providers/auth_form_providers.dart';
import 'package:mobile_kkm/features/auth/utils/minor_registration.dart';
import 'package:mobile_kkm/features/auth/utils/pesel.dart';
import 'package:mobile_kkm/features/auth/utils/validators.dart';
import 'package:mobile_kkm/features/auth/widgets/auth_page.dart';
import 'package:mobile_kkm/features/auth/widgets/consent_field.dart';
import 'package:mobile_kkm/features/auth/widgets/data_notice.dart';
import 'package:mobile_kkm/features/auth/widgets/password_checklist.dart';
import 'package:mobile_kkm/features/auth/widgets/password_field.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _repeatEmail = TextEditingController();
  final _password = TextEditingController();
  final _repeatPassword = TextEditingController();
  final _pesel = TextEditingController();
  final _birthDateText = TextEditingController();

  /// Without a PESEL the birth date is picked by hand; with one it is
  /// derived from the number (as the official client does).
  bool _noPesel = false;
  DateTime? _birthDate;

  /// Consent id → checked, for the boxes the user has touched.
  final _consentChoices = <int, bool>{};

  bool _submitting = false;
  String? _error;

  @override
  void dispose() {
    for (final controller in [
      _firstName,
      _lastName,
      _email,
      _repeatEmail,
      _password,
      _repeatPassword,
      _pesel,
      _birthDateText,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  void _setBirthDate(DateTime? date) {
    final locale = AppLocalizations.of(context).localeName;
    setState(() {
      _birthDate = date;
      _birthDateText.text = date == null ? '' : DateFormat.yMd(locale).format(date);
    });
  }

  void _setNoPesel(bool value) {
    setState(() => _noPesel = value);
    if (value) {
      _pesel.clear();
    }
    // Either way the previous date no longer applies: a hand-picked one is
    // dropped when switching back, a derived one when switching away.
    _setBirthDate(value ? null : Pesel.birthDate(_pesel.text));
  }

  Future<void> _pickBirthDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime(now.year - 30),
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null && mounted) {
      _setBirthDate(picked);
    }
  }

  bool _isChecked(MarketingConsent consent) => _consentChoices[consent.id] ?? consent.isChecked ?? false;

  Future<void> _submit(List<MarketingConsent> consents) async {
    if (_submitting || !_formKey.currentState!.validate()) {
      return;
    }
    final l10n = AppLocalizations.of(context);
    final email = _email.text.trim();
    // As in the official client: a minor can only register on the website,
    // so nothing is sent from here.
    if (isUnder16(_birthDate!, DateTime.now())) {
      await _handOverToWebsite();
      return;
    }
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      await ref
          .read(ekpClientProvider)
          .auth
          .register(
            firstName: _firstName.text.trim(),
            lastName: _lastName.text.trim(),
            email: email,
            password: _password.text,
            birthDate: _birthDate!,
            pesel: _noPesel ? null : _pesel.text,
            marketingConsents: [for (final consent in consents) consent.copyWith(isChecked: _isChecked(consent))],
          );
      if (!mounted) {
        return;
      }
      TextInput.finishAutofillContext();
      context.go(Routes.sent(Routes.registerSent, email));
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _submitting = false;
        _error = describeError(l10n, error);
      });
    }
  }

  /// Offers to finish on the website, which opens with what was typed here.
  Future<void> _handOverToWebsite() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final uri = websiteRegistrationUri(
      customerPageUrl: ref.read(mobileAppConfigProvider).value?.customerPageUrl,
      firstName: _firstName.text.trim(),
      lastName: _lastName.text.trim(),
      email: _email.text.trim(),
      repeatEmail: _repeatEmail.text.trim(),
      pesel: _noPesel ? null : _pesel.text,
      birthDate: _birthDate,
    );
    final open = ref.read(urlOpenerProvider);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Symbols.open_in_browser_rounded),
        title: Text(l10n.under16Title, textAlign: TextAlign.center),
        content: Text(l10n.under16Body),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(l10n.cancel)),
          FilledButton(
            style: AppTheme.dialogAction,
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.under16Action),
          ),
        ],
      ),
    );
    if (!(confirmed ?? false)) {
      return;
    }
    var opened = false;
    try {
      opened = await open(uri);
    } catch (_) {
      // No browser to open it.
    }
    if (!opened) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.linkOpenFailed)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final rules = passwordRulesFor(ref.watch(passwordPolicyProvider).value);
    final consents = ref.watch(marketingConsentsProvider);
    final regulationsUrl = ref.watch(mobileAppConfigProvider).value?.regulationsUrl;

    return AuthPage(
      title: l10n.registerTitle,
      bottom: SubmitButton(
        label: l10n.registerSubmit,
        icon: Symbols.person_add_rounded,
        loading: _submitting,
        loadingLabel: l10n.registerSubmitting,
        // The consents are part of the request, so wait for them.
        onPressed: consents.hasValue ? () => _submit(consents.requireValue) : null,
      ),
      child: AutofillGroup(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
              if (_error != null) MessageBanner(_error!),
              FormCard(
                title: l10n.sectionPersonal,
                children: [
                  TextFormField(
                    controller: _firstName,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.givenName],
                    decoration: InputDecoration(labelText: l10n.firstNameLabel),
                    validator: (value) => validateRequired(l10n, value),
                  ),
                  TextFormField(
                    controller: _lastName,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.familyName],
                    decoration: InputDecoration(labelText: l10n.lastNameLabel),
                    validator: (value) => validateRequired(l10n, value),
                  ),
                  // The choice belongs to the number above it.
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _pesel,
                        enabled: !_noPesel,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(11)],
                        decoration: InputDecoration(labelText: l10n.peselLabel),
                        onChanged: (value) => _setBirthDate(Pesel.birthDate(value)),
                        validator: (value) => _noPesel || Pesel.isValid(value ?? '') ? null : l10n.peselInvalid,
                      ),
                      CheckboxListTile(
                        value: _noPesel,
                        onChanged: (value) => _setNoPesel(value ?? false),
                        title: Text(l10n.noPeselCheckbox, style: theme.textTheme.bodyMedium?.copyWith(fontSize: 15)),
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: _birthDateText,
                    readOnly: true,
                    enabled: _noPesel,
                    onTap: _noPesel ? _pickBirthDate : null,
                    decoration: InputDecoration(
                      labelText: l10n.birthDateLabel,
                      helperText: _noPesel ? null : l10n.birthDateFromPeselHelper,
                      suffixIcon: const Icon(Symbols.calendar_today_rounded),
                    ),
                    validator: (_) => _noPesel && _birthDate == null ? l10n.birthDateRequired : null,
                  ),
                ],
              ),
              FormCard(
                title: l10n.sectionContact,
                children: [
                  TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autocorrect: false,
                    autofillHints: const [AutofillHints.email],
                    decoration: InputDecoration(labelText: l10n.emailLabel),
                    validator: (value) => validateEmail(l10n, value),
                  ),
                  TextFormField(
                    controller: _repeatEmail,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autocorrect: false,
                    autofillHints: const [AutofillHints.email],
                    decoration: InputDecoration(labelText: l10n.repeatEmailLabel),
                    validator: (value) => (value ?? '').trim().toLowerCase() == _email.text.trim().toLowerCase()
                        ? null
                        : l10n.emailsDontMatch,
                  ),
                ],
              ),
              FormCard(
                title: l10n.sectionPassword,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 10,
                    children: [
                      PasswordField(
                        controller: _password,
                        label: l10n.passwordLabel,
                        autofillHints: const [AutofillHints.newPassword],
                        textInputAction: TextInputAction.next,
                        onChanged: (_) => setState(() {}),
                        validator: (value) => validateNewPassword(l10n, rules, value),
                      ),
                      PasswordChecklist(rules: rules, password: _password.text),
                    ],
                  ),
                  PasswordField(
                    controller: _repeatPassword,
                    label: l10n.repeatPasswordLabel,
                    autofillHints: const [AutofillHints.newPassword],
                    textInputAction: TextInputAction.done,
                    validator: (value) => value == _password.text ? null : l10n.passwordsDontMatch,
                  ),
                ],
              ),
              switch (consents) {
                // Shown as the server sends them (Polish only).
                AsyncData(:final value) when value.isNotEmpty => FormCard(
                  children: [
                    for (final consent in value)
                      ConsentField(
                        label: consent.content ?? '',
                        initialValue: _isChecked(consent),
                        onChanged: (checked) => _consentChoices[consent.id ?? -1] = checked,
                        onOpenRegulations: regulationsUrl == null
                            ? null
                            : () => ref.read(urlOpenerProvider)(
                                // The server's URL contains raw spaces.
                                Uri.parse(Uri.encodeFull(regulationsUrl)),
                              ),
                      ),
                  ],
                ),
                AsyncData() => const SizedBox.shrink(),
                AsyncError(:final error) => MessageBanner(
                  '${l10n.consentsLoadError} ${describeError(l10n, error)}',
                  actionLabel: l10n.retry,
                  onAction: () => ref.invalidate(marketingConsentsProvider),
                ),
                _ => const LinearProgressIndicator(),
              },
              const DataNotice(),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(l10n.alreadyHaveAccountPrompt, style: TextStyle(color: theme.colorScheme.onSurfaceVariant)),
                  TextButton(onPressed: () => context.go(Routes.login), child: Text(l10n.signInLink)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
