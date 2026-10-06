import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/router/routes.dart';
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
    return AuthPage(
      title: l10n.inboxTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(Symbols.mark_email_unread_rounded, size: 64, color: theme.colorScheme.primary),
          const SizedBox(height: 24),
          Text(switch (kind) {
            InboxKind.registration => l10n.inboxRegistrationBody(email),
            InboxKind.passwordReset => l10n.inboxResetBody(email),
          }, style: theme.textTheme.bodyLarge),
          const SizedBox(height: 16),
          const LinkHint(),
          const SizedBox(height: 24),
          FilledButton(onPressed: () => context.go(Routes.login), child: Text(l10n.backToLogin)),
        ],
      ),
    );
  }
}
