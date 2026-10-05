import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/api/error_messages.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/core/widgets/message_banner.dart';
import 'package:mobile_kkm/features/auth/widgets/auth_page.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// Activates an account with the token from the activation e-mail.
class ActivateScreen extends ConsumerStatefulWidget {
  const ActivateScreen({super.key, required this.token});

  final String token;

  @override
  ConsumerState<ActivateScreen> createState() => _ActivateScreenState();
}

class _ActivateScreenState extends ConsumerState<ActivateScreen> {
  late Future<void> _activation;

  @override
  void initState() {
    super.initState();
    _activation = _activate();
  }

  Future<void> _activate() => ref.read(ekpClientProvider).auth.activate(widget.token);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return AuthPage(
      title: l10n.activateTitle,
      child: FutureBuilder<void>(
        future: _activation,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Column(
              children: [
                const SizedBox(height: 48),
                const CircularProgressIndicator(),
                const SizedBox(height: 24),
                Text(l10n.activateInProgress),
              ],
            );
          }
          final error = snapshot.error;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (error == null) ...[
                Icon(Icons.check_circle_outline, size: 64, color: theme.colorScheme.primary),
                const SizedBox(height: 24),
                Text(l10n.activateSuccess, style: theme.textTheme.bodyLarge, textAlign: TextAlign.center),
              ] else ...[
                MessageBanner(l10n.activateFailure),
                const SizedBox(height: 8),
                Text(
                  describeError(l10n, error),
                  style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
                const SizedBox(height: 8),
                OutlinedButton(onPressed: () => setState(() => _activation = _activate()), child: Text(l10n.retry)),
              ],
              const SizedBox(height: 24),
              FilledButton(onPressed: () => context.go(Routes.login), child: Text(l10n.continueToLogin)),
            ],
          );
        },
      ),
    );
  }
}
