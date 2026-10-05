import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_kkm/core/api/error_messages.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/core/router/routes.dart';
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
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
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
    if (_submitting || !_formKey.currentState!.validate()) return;
    final l10n = AppLocalizations.of(context);
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      await ref
          .read(ekpClientProvider)
          .auth
          .resetPassword(token: widget.token, newPassword: _password.text);
      if (!mounted) return;
      TextInput.finishAutofillContext();
      context.go(Routes.loginAfterPasswordReset());
    } catch (error) {
      if (!mounted) return;
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
    return AuthPage(
      title: l10n.resetTitle,
      child: AutofillGroup(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_error != null) ...[
                MessageBanner(_error!),
                const SizedBox(height: 16),
              ],
              PasswordField(
                controller: _password,
                label: l10n.newPasswordLabel,
                autofillHints: const [AutofillHints.newPassword],
                textInputAction: TextInputAction.next,
                onChanged: (_) => setState(() {}),
                validator: (value) => validateNewPassword(l10n, rules, value),
              ),
              const SizedBox(height: 8),
              PasswordChecklist(rules: rules, password: _password.text),
              const SizedBox(height: 16),
              PasswordField(
                controller: _repeat,
                label: l10n.repeatPasswordLabel,
                autofillHints: const [AutofillHints.newPassword],
                textInputAction: TextInputAction.done,
                onSubmitted: _submit,
                validator: (value) =>
                    value == _password.text ? null : l10n.passwordsDontMatch,
              ),
              const SizedBox(height: 24),
              SubmitButton(
                label: l10n.resetSubmit,
                loading: _submitting,
                onPressed: _submit,
              ),
              const SizedBox(height: 8),
              // Opened from a link there is no screen to go back to.
              TextButton(
                onPressed: () => context.go(Routes.login),
                child: Text(l10n.backToLogin),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
