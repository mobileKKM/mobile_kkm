import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/api/error_messages.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/core/widgets/lead_header.dart';
import 'package:mobile_kkm/core/widgets/message_banner.dart';
import 'package:mobile_kkm/core/widgets/submit_button.dart';
import 'package:mobile_kkm/features/auth/models/password_rule.dart';
import 'package:mobile_kkm/features/auth/providers/auth_form_providers.dart';
import 'package:mobile_kkm/features/auth/utils/validators.dart';
import 'package:mobile_kkm/features/auth/widgets/auth_page.dart';
import 'package:mobile_kkm/features/auth/widgets/password_checklist.dart';
import 'package:mobile_kkm/features/auth/widgets/password_field.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// Sets a new password with the token from the reset e-mail.
class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key, required this.token});

  final String token;

  @override
  ConsumerState<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _password = TextEditingController();
  final _repeat = TextEditingController();
  bool _submitting = false;
  String? _error;

  @override
  void dispose() {
    _password.dispose();
    _repeat.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_submitting || !_formKey.currentState!.validate()) {
      return;
    }
    final l10n = AppLocalizations.of(context);
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      await ref.read(ekpClientProvider).auth.resetPassword(token: widget.token, newPassword: _password.text);
      if (!mounted) {
        return;
      }
      TextInput.finishAutofillContext();
      context.go(Routes.loginAfterPasswordReset());
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
    // Nothing to send until the password is one the server will take and
    // was typed a second time; whether the two match is said on sending.
    final ready =
        _password.text.isNotEmpty &&
        _repeat.text.isNotEmpty &&
        rules.every((rule) => rule.isSatisfiedBy(_password.text));
    return AuthPage(
      // Opened from a link there is no screen to go back to.
      leading: IconButton(
        tooltip: l10n.backToLogin,
        icon: const Icon(Symbols.close_rounded),
        onPressed: () => context.go(Routes.login),
      ),
      centered: true,
      bottom: SubmitButton(
        label: l10n.resetSubmit,
        icon: Symbols.key_rounded,
        loading: _submitting,
        onPressed: ready ? _submit : null,
      ),
      child: AutofillGroup(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
              LeadHeader(icon: Symbols.password_rounded, title: l10n.resetTitle, body: l10n.resetBody),
              if (_error != null)
                // The usual reason is a link that has run out: offer a new one.
                MessageBanner(
                  _error!,
                  actionLabel: l10n.forgotTitle,
                  onAction: () => context.go(Routes.forgotPassword),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: PasswordField(
                  controller: _password,
                  label: l10n.newPasswordLabel,
                  autofillHints: const [AutofillHints.newPassword],
                  textInputAction: TextInputAction.next,
                  onChanged: (_) => setState(() {}),
                  validator: (value) => validateNewPassword(l10n, rules, value),
                ),
              ),
              PasswordChecklist(rules: rules, password: _password.text),
              PasswordField(
                controller: _repeat,
                label: l10n.repeatPasswordLabel,
                autofillHints: const [AutofillHints.newPassword],
                textInputAction: TextInputAction.done,
                onChanged: (_) => setState(() {}),
                onSubmitted: _submit,
                validator: (value) => value == _password.text ? null : l10n.passwordsDontMatch,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
