import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/api/error_messages.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/core/theme/app_theme.dart';
import 'package:mobile_kkm/core/widgets/lead_header.dart';
import 'package:mobile_kkm/core/widgets/message_banner.dart';
import 'package:mobile_kkm/features/auth/widgets/auth_page.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// Activates an account with the token from the activation e-mail, straight
/// away: opening the link was the decision.
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

  // A failure is the builder's to show; without `ignore` one that arrives
  // before the builder listens would also count as unhandled.
  Future<void> _activate() => ref.read(ekpClientProvider).auth.activate(widget.token)..ignore();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final colors = AppColors.of(context);
    return FutureBuilder<void>(
      future: _activation,
      builder: (context, snapshot) {
        final done = snapshot.connectionState == ConnectionState.done;
        final error = snapshot.error;
        final Widget body;
        if (!done) {
          body = LeadHeader(
            busy: true,
            centered: true,
            title: l10n.activateInProgress,
            titleSize: 22,
            tileColor: scheme.secondaryContainer,
            iconColor: scheme.onSecondaryContainer,
          );
        } else if (error == null) {
          body = LeadHeader(
            icon: Symbols.check_circle_rounded,
            fill: 1,
            centered: true,
            title: l10n.activateSuccessTitle,
            body: l10n.activateSuccessBody,
            tileColor: colors.successContainer,
            iconColor: colors.onSuccessContainer,
          );
        } else {
          body = Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
              LeadHeader(
                icon: Symbols.link_off_rounded,
                centered: true,
                title: l10n.activateFailureTitle,
                body: l10n.activateFailureBody,
                tileColor: scheme.errorContainer,
                iconColor: scheme.onErrorContainer,
              ),
              // The server's own wording (Polish only), where it gave one.
              MessageBanner(describeError(l10n, error)),
              OutlinedButton.icon(
                // A block: an arrow would hand the future to setState.
                onPressed: () => setState(() {
                  _activation = _activate();
                }),
                icon: const Icon(Symbols.refresh_rounded),
                label: Text(l10n.retry),
              ),
            ],
          );
        }
        return AuthPage(
          showAppBar: false,
          centered: true,
          bottom: done
              ? FilledButton.icon(
                  onPressed: () => context.go(Routes.login),
                  icon: const Icon(Symbols.login_rounded),
                  label: Text(l10n.continueToLogin),
                )
              : null,
          child: body,
        );
      },
    );
  }
}
