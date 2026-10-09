import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/core/widgets/lead_header.dart';
import 'package:mobile_kkm/features/auth/widgets/auth_page.dart';
import 'package:mobile_kkm/features/auth/widgets/link_hint.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

enum InboxKind { registration, passwordReset }

/// "Check your inbox" confirmation after registering or requesting a
/// password reset.
class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key, required this.kind, required this.email});

  final InboxKind kind;
  final String email;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final body = switch (kind) {
      InboxKind.registration => l10n.inboxRegistrationBody(email),
      InboxKind.passwordReset => l10n.inboxResetBody(email),
    };
    // The address stands out, wherever the sentence puts it.
    final at = email.isEmpty ? -1 : body.indexOf(email);
    return AuthPage(
      showAppBar: false,
      centered: true,
      bottom: FilledButton.tonalIcon(
        onPressed: () => context.go(Routes.login),
        icon: const Icon(Symbols.arrow_back_rounded),
        label: Text(l10n.backToLogin),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          LeadHeader(icon: Symbols.mark_email_unread_rounded, title: l10n.inboxTitle),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text.rich(
              at < 0
                  ? TextSpan(text: body)
                  : TextSpan(
                      text: body.substring(0, at),
                      children: [
                        TextSpan(
                          text: email,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        TextSpan(text: body.substring(at + email.length)),
                      ],
                    ),
              style: theme.textTheme.bodyLarge,
            ),
          ),
          const LinkHint(),
        ],
      ),
    );
  }
}
