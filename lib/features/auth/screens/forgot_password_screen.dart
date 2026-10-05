import 'package:ekp_api/ekp_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_kkm/core/api/error_messages.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/core/widgets/message_banner.dart';
import 'package:mobile_kkm/core/widgets/submit_button.dart';
import 'package:mobile_kkm/features/auth/utils/validators.dart';
import 'package:mobile_kkm/features/auth/widgets/auth_page.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  bool _submitting = false;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
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
      await ref.read(ekpClientProvider).auth.requestPasswordReset(email);
    } on EkpHttpException catch (error) {
      // A rejected request (e.g. unknown address) gets the same
      // confirmation as a sent e-mail, so the screen does not reveal
      // which addresses have an account. Server faults are still shown.
      if ((error.statusCode ?? 500) >= 500) {
        _fail(describeError(l10n, error));
        return;
      }
    } catch (error) {
      _fail(describeError(l10n, error));
      return;
    }
    if (!mounted) {
      return;
    }
    context.go(Routes.sent(Routes.forgotPasswordSent, email));
  }

  void _fail(String message) {
    if (!mounted) {
      return;
    }
    setState(() {
      _submitting = false;
      _error = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AuthPage(
      title: l10n.forgotTitle,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.forgotBody),
            const SizedBox(height: 24),
            if (_error != null) ...[MessageBanner(_error!), const SizedBox(height: 16)],
            TextFormField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              autocorrect: false,
              autofillHints: const [AutofillHints.email],
              decoration: InputDecoration(labelText: l10n.emailLabel),
              validator: (value) => validateEmail(l10n, value),
              onFieldSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 24),
            SubmitButton(label: l10n.forgotSubmit, loading: _submitting, onPressed: _submit),
          ],
        ),
      ),
    );
  }
}
