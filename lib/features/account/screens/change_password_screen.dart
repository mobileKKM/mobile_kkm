import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/api/error_messages.dart';
import 'package:mobile_kkm/core/providers/app_startup_provider.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/core/widgets/app_snack_bar.dart';
import 'package:mobile_kkm/core/widgets/app_status_banner.dart';
import 'package:mobile_kkm/core/widgets/form_card.dart';
import 'package:mobile_kkm/core/widgets/message_banner.dart';
import 'package:mobile_kkm/core/widgets/submit_button.dart';
import 'package:mobile_kkm/features/auth/models/password_rule.dart';
import 'package:mobile_kkm/features/auth/providers/auth_form_providers.dart';
import 'package:mobile_kkm/features/auth/widgets/auth_page.dart';
import 'package:mobile_kkm/features/auth/widgets/password_checklist.dart';
import 'package:mobile_kkm/features/auth/widgets/password_field.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// A new password for the account, against the current one. The session
/// stays as it is.
class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _current = TextEditingController();
  final _password = TextEditingController();
  final _repeat = TextEditingController();
  final _repeatFocus = FocusNode();

  /// The repeat field was left: from then on it says when it differs.
  bool _repeatLeft = false;
  bool _submitting = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _repeatFocus.addListener(_onRepeatFocus);
  }

  void _onRepeatFocus() {
    if (!_repeatFocus.hasFocus && _repeat.text.isNotEmpty && !_repeatLeft) {
      setState(() => _repeatLeft = true);
    }
  }

  @override
  void dispose() {
    _current.dispose();
    _password.dispose();
    _repeat.dispose();
    _repeatFocus.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_submitting) {
      return;
    }
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    setState(() {
      _submitting = true;
      _error = null;
    });
    String? error;
    try {
      final reply = await ref
          .read(ekpClientProvider)
          .auth
          .changePassword(previousPassword: _current.text, newPassword: _password.text, repeatPassword: _repeat.text);
      // A refusal (the current password wrong, the new one used before) is
      // an HTTP 400, caught below; one in a reply that went through would
      // look like this.
      if (reply.code != null) {
        error = reply.message ?? l10n.errorGeneric;
      }
    } catch (failure) {
      error = describeError(l10n, failure);
    }
    if (!mounted) {
      return;
    }
    if (error != null) {
      setState(() {
        _submitting = false;
        _error = error;
      });
      return;
    }
    TextInput.finishAutofillContext();
    showAppSnackBar(messenger, l10n.passwordChanged, kind: SnackKind.success);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final rules = passwordRulesFor(ref.watch(passwordPolicyProvider).value);
    final online = ref.watch(appStatusProvider.select((status) => status.mode == AppMode.online));
    final matches = _repeat.text == _password.text;
    final ready =
        _current.text.isNotEmpty &&
        _password.text.isNotEmpty &&
        matches &&
        rules.every((rule) => rule.isSatisfiedBy(_password.text));

    return AuthPage(
      title: l10n.accountChangePassword,
      bottom: SubmitButton(
        label: l10n.accountChangePassword,
        icon: Symbols.key_rounded,
        loading: _submitting,
        onPressed: ready && online ? () => unawaited(_submit()) : null,
      ),
      child: AutofillGroup(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            const AppStatusBanner(),
            if (_error != null) MessageBanner(_error!),
            FormCard(
              children: [
                PasswordField(
                  controller: _current,
                  label: l10n.passwordCurrent,
                  autofillHints: const [AutofillHints.password],
                  textInputAction: TextInputAction.next,
                  onChanged: (_) => setState(() {}),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 10,
                  children: [
                    PasswordField(
                      controller: _password,
                      label: l10n.newPasswordLabel,
                      autofillHints: const [AutofillHints.newPassword],
                      textInputAction: TextInputAction.next,
                      onChanged: (_) => setState(() {}),
                    ),
                    PasswordChecklist(rules: rules, password: _password.text),
                  ],
                ),
                PasswordField(
                  controller: _repeat,
                  focusNode: _repeatFocus,
                  label: l10n.passwordRepeatNew,
                  autofillHints: const [AutofillHints.newPassword],
                  textInputAction: TextInputAction.done,
                  // Said once the field was left, not at the first letter.
                  errorText: _repeatLeft && !matches ? l10n.passwordsDontMatch : null,
                  onChanged: (_) => setState(() {}),
                  onSubmitted: ready && online ? () => unawaited(_submit()) : null,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                l10n.passwordStaySignedIn,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 13,
                  height: 18 / 13,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
