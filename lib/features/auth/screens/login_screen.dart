import 'dart:math' as math;

import 'package:ekp_api/ekp_api.dart';
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
    final sessionExpired = ref.watch(authControllerProvider.select((state) => state.sessionExpired));

    final keyboardHeight = MediaQuery.viewInsetsOf(context).bottom;
    final skylineHeight = LoginSkyline.heightFor(MediaQuery.sizeOf(context));
    // The app is edge to edge, so the system navigation bar overlaps the
    // bottom of the screen: the illustration sits above it.
    final navigationHeight = MediaQuery.viewPaddingOf(context).bottom;

    return Scaffold(
      // The illustration stays glued to the bottom edge so the keyboard
      // slides over it; the form is kept clear of both by the padding below.
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          if (skylineHeight > 0)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: LoginSkyline(height: skylineHeight, bottomInset: navigationHeight),
            ),
          Padding(
            padding: EdgeInsets.only(bottom: math.max(keyboardHeight, skylineHeight + navigationHeight)),
            child: SafeArea(
              bottom: false,
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: AutofillGroup(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const BrandHeader(),
                            const SizedBox(height: 16),
                            LeadHeader(title: l10n.loginTitle, body: l10n.loginSubtitle),
                            const SizedBox(height: 16),
                            // The server's answer first; else why the user is here.
                            if (_error != null) ...[
                              MessageBanner(_error!),
                              const SizedBox(height: 16),
                            ] else if (widget.passwordResetDone) ...[
                              MessageBanner(l10n.passwordResetDoneNotice, kind: BannerKind.success),
                              const SizedBox(height: 16),
                            ] else if (sessionExpired) ...[
                              MessageBanner(
                                l10n.sessionExpiredNotice,
                                kind: BannerKind.info,
                                icon: Symbols.schedule_rounded,
                              ),
                              const SizedBox(height: 16),
                            ],
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _email,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              autocorrect: false,
                              autofillHints: const [AutofillHints.username, AutofillHints.email],
                              decoration: InputDecoration(labelText: l10n.emailLabel),
                              validator: (value) => validateEmail(l10n, value),
                            ),
                            const SizedBox(height: 20),
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
                            SubmitButton(
                              label: l10n.loginSubmit,
                              icon: Symbols.login_rounded,
                              loading: _submitting,
                              loadingLabel: l10n.loginSubmitting,
                              onPressed: _submit,
                            ),
                            const SizedBox(height: 16),
                            Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                  l10n.noAccountPrompt,
                                  style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                                ),
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
