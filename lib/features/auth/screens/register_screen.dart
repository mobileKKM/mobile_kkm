import 'package:ekp_api/ekp_api.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/api/error_messages.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/core/providers/platform_providers.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/core/widgets/message_banner.dart';
import 'package:mobile_kkm/core/widgets/submit_button.dart';
import 'package:mobile_kkm/features/auth/models/password_rule.dart';
import 'package:mobile_kkm/features/auth/providers/auth_form_providers.dart';
import 'package:mobile_kkm/features/auth/utils/pesel.dart';
import 'package:mobile_kkm/features/auth/utils/validators.dart';
import 'package:mobile_kkm/features/auth/widgets/auth_page.dart';
import 'package:mobile_kkm/features/auth/widgets/consent_field.dart';
import 'package:mobile_kkm/features/auth/widgets/data_notice.dart';
import 'package:mobile_kkm/features/auth/widgets/password_checklist.dart';
import 'package:mobile_kkm/features/auth/widgets/password_field.dart';
import 'package:mobile_kkm/features/auth/widgets/section_heading.dart';
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final rules = passwordRulesFor(ref.watch(passwordPolicyProvider).value);
    final consents = ref.watch(marketingConsentsProvider);
    final regulationsUrl = ref.watch(mobileAppConfigProvider).value?.regulationsUrl;

    return AuthPage(
      title: l10n.registerTitle,
      child: AutofillGroup(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_error != null) ...[MessageBanner(_error!), const SizedBox(height: 16)],
              SectionHeading(l10n.sectionPersonal),
              TextFormField(
                controller: _firstName,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.givenName],
                decoration: InputDecoration(labelText: l10n.firstNameLabel),
                validator: (value) => validateRequired(l10n, value),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _lastName,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.familyName],
                decoration: InputDecoration(labelText: l10n.lastNameLabel),
                validator: (value) => validateRequired(l10n, value),
              ),
              const SizedBox(height: 16),
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
                title: Text(l10n.noPeselCheckbox),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _birthDateText,
                readOnly: true,
                enabled: _noPesel,
                onTap: _noPesel ? _pickBirthDate : null,
                decoration: InputDecoration(
                  labelText: l10n.birthDateLabel,
                  helperText: _noPesel ? null : l10n.birthDateFromPeselHelper,
                  suffixIcon: const Icon(Icons.calendar_today_outlined),
                ),
                validator: (_) => _noPesel && _birthDate == null ? l10n.birthDateRequired : null,
              ),
              const SizedBox(height: 24),
              SectionHeading(l10n.sectionContact),
              TextFormField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autocorrect: false,
                autofillHints: const [AutofillHints.email],
                decoration: InputDecoration(labelText: l10n.emailLabel),
                validator: (value) => validateEmail(l10n, value),
              ),
              const SizedBox(height: 16),
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
              const SizedBox(height: 24),
              SectionHeading(l10n.sectionPassword),
              PasswordField(
                controller: _password,
                label: l10n.passwordLabel,
                autofillHints: const [AutofillHints.newPassword],
                textInputAction: TextInputAction.next,
                onChanged: (_) => setState(() {}),
                validator: (value) => validateNewPassword(l10n, rules, value),
              ),
              const SizedBox(height: 8),
              PasswordChecklist(rules: rules, password: _password.text),
              const SizedBox(height: 16),
              PasswordField(
                controller: _repeatPassword,
                label: l10n.repeatPasswordLabel,
                autofillHints: const [AutofillHints.newPassword],
                textInputAction: TextInputAction.done,
                validator: (value) => value == _password.text ? null : l10n.passwordsDontMatch,
              ),
              const SizedBox(height: 16),
              ...switch (consents) {
                AsyncData(:final value) => [
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
                AsyncError(:final error) => [
                  MessageBanner('${l10n.consentsLoadError} ${describeError(l10n, error)}'),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextButton(
                      onPressed: () => ref.invalidate(marketingConsentsProvider),
                      child: Text(l10n.retry),
                    ),
                  ),
                ],
                _ => const [LinearProgressIndicator()],
              },
              const SizedBox(height: 16),
              const DataNotice(),
              const SizedBox(height: 24),
              SubmitButton(
                label: l10n.registerSubmit,
                loading: _submitting,
                // The consents are part of the request, so wait for them.
                onPressed: consents.hasValue ? () => _submit(consents.requireValue) : null,
              ),
              const SizedBox(height: 8),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(l10n.alreadyHaveAccountPrompt),
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
