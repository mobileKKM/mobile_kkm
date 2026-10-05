import 'dart:math' as math;

import 'package:ekp_api/ekp_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_kkm/core/api/error_messages.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/core/widgets/message_banner.dart';
import 'package:mobile_kkm/core/widgets/submit_button.dart';
import 'package:mobile_kkm/features/auth/providers/auth_controller.dart';
import 'package:mobile_kkm/features/auth/utils/validators.dart';
import 'package:mobile_kkm/features/auth/widgets/brand_header.dart';
import 'package:mobile_kkm/features/auth/widgets/login_skyline.dart';
import 'package:mobile_kkm/features/auth/widgets/password_field.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key, this.passwordResetDone = false});

  /// Arrived here after a successful password reset.
  final bool passwordResetDone;

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _submitting = false;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
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
      await ref.read(ekpClientProvider).auth.login(_email.text.trim(), _password.text);
      TextInput.finishAutofillContext();
      // The router redirects to home once the session event arrives.
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _submitting = false;
        _error = error is EkpUnauthorizedException ? l10n.errorInvalidCredentials : describeError(l10n, error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final sessionExpired = ref.watch(authControllerProvider.select((state) => state.sessionExpired));
    final notice = widget.passwordResetDone
        ? l10n.passwordResetDoneNotice
        : sessionExpired
        ? l10n.sessionExpiredNotice
        : null;

    final keyboardHeight = MediaQuery.viewInsetsOf(context).bottom;
    final skylineHeight = LoginSkyline.heightFor(MediaQuery.sizeOf(context));

    return Scaffold(
      // The illustration stays glued to the bottom edge so the keyboard
      // slides over it; the form is kept clear of both by the padding below.
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          if (skylineHeight > 0) Positioned(left: 0, right: 0, bottom: 0, child: LoginSkyline(height: skylineHeight)),
          Padding(
            padding: EdgeInsets.only(bottom: math.max(keyboardHeight, skylineHeight)),
            child: SafeArea(
              bottom: false,
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: AutofillGroup(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const BrandHeader(),
                            const SizedBox(height: 32),
                            Text(l10n.loginTitle, style: theme.textTheme.headlineSmall),
                            const SizedBox(height: 4),
                            Text(
                              l10n.loginSubtitle,
                              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                            ),
                            const SizedBox(height: 24),
                            if (_error != null) ...[
                              MessageBanner(_error!),
                              const SizedBox(height: 16),
                            ] else if (notice != null) ...[
                              MessageBanner(notice, kind: BannerKind.info),
                              const SizedBox(height: 16),
                            ],
                            TextFormField(
                              controller: _email,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              autocorrect: false,
                              autofillHints: const [AutofillHints.username, AutofillHints.email],
                              decoration: InputDecoration(labelText: l10n.emailLabel),
                              validator: (value) => validateEmail(l10n, value),
                            ),
                            const SizedBox(height: 16),
                            PasswordField(
                              controller: _password,
                              label: l10n.passwordLabel,
                              autofillHints: const [AutofillHints.password],
                              textInputAction: TextInputAction.done,
                              onSubmitted: _submit,
                              validator: (value) => (value == null || value.isEmpty) ? l10n.fieldRequired : null,
                            ),
                            Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: TextButton(
                                onPressed: () => context.push(Routes.forgotPassword),
                                child: Text(l10n.forgotPasswordLink),
                              ),
                            ),
                            const SizedBox(height: 8),
                            SubmitButton(label: l10n.loginSubmit, loading: _submitting, onPressed: _submit),
                            const SizedBox(height: 16),
                            Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(l10n.noAccountPrompt),
                                TextButton(
                                  onPressed: () => context.push(Routes.register),
                                  child: Text(l10n.registerLink),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
