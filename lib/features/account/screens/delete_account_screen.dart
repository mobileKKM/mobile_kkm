import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/api/error_messages.dart';
import 'package:mobile_kkm/core/platform/link_settings.dart';
import 'package:mobile_kkm/core/providers/app_startup_provider.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/core/providers/platform_providers.dart';
import 'package:mobile_kkm/core/theme/app_theme.dart';
import 'package:mobile_kkm/core/widgets/app_snack_bar.dart';
import 'package:mobile_kkm/core/widgets/app_status_banner.dart';
import 'package:mobile_kkm/core/widgets/bullet_card.dart';
import 'package:mobile_kkm/core/widgets/lead_header.dart';
import 'package:mobile_kkm/features/auth/providers/auth_controller.dart';
import 'package:mobile_kkm/features/auth/widgets/auth_page.dart';
import 'package:mobile_kkm/features/auth/widgets/password_field.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// Deletes the eKP account, after saying what goes with it.
///
/// As in the official client, the account's cards are looked at first: one
/// that is still attached can only be detached on the website, and the
/// server is not asked to delete anything before that.
class DeleteAccountScreen extends ConsumerStatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  ConsumerState<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends ConsumerState<DeleteAccountScreen> {
  bool _checking = false;

  Future<void> _delete() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _checking = true);
    final bool hasCards;
    try {
      hasCards = (await ref.read(ekpClientProvider).storageMediums.list()).items.isNotEmpty;
    } catch (failure) {
      if (mounted) {
        setState(() => _checking = false);
        showAppSnackBar(messenger, describeError(l10n, failure), kind: SnackKind.error);
      }
      return;
    }
    if (!mounted) {
      return;
    }
    setState(() => _checking = false);
    if (hasCards) {
      await _sendToWebsite();
      return;
    }

    // The server's word on the deletion, once it went through.
    final done = await showDialog<String>(context: context, builder: (context) => const _PasswordDialog());
    if (done == null || !mounted) {
      return;
    }
    await showDialog<void>(
      context: context,
      // There is no account to go back to.
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          icon: const Icon(Symbols.check_circle_rounded),
          title: Text(l10n.deleteDoneTitle, textAlign: TextAlign.center),
          content: done.isEmpty ? null : Text(done),
          actions: [
            FilledButton(
              style: AppTheme.dialogAction,
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.logoutConfirmAction),
            ),
          ],
        ),
      ),
    );
    // Not through the server: it no longer knows the token.
    await ref.read(authControllerProvider.notifier).signOutLocally();
  }

  Future<void> _sendToWebsite() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final open = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Symbols.credit_card_off_rounded),
        title: Text(l10n.deleteCardsTitle, textAlign: TextAlign.center),
        content: Text(l10n.deleteCardsBody),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(l10n.cancel)),
          FilledButton(
            style: AppTheme.dialogAction,
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.deleteCardsAction),
          ),
        ],
      ),
    );
    if (!(open ?? false)) {
      return;
    }
    final site = ref.read(mobileAppConfigProvider).value?.customerPageUrl;
    var opened = false;
    try {
      opened = await ref.read(urlOpenerProvider)(
        Uri.parse(site == null || site.isEmpty ? 'https://$ekpLinkHost' : Uri.encodeFull(site)),
      );
    } catch (_) {
      // No browser, or an address that is none.
    }
    if (!opened) {
      showAppSnackBar(messenger, l10n.linkOpenFailed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final online = ref.watch(appStatusProvider.select((status) => status.mode == AppMode.online));

    return AuthPage(
      title: l10n.accountDelete,
      // At work it keeps its colours, says so and ignores taps.
      bottom: FilledButton.icon(
        style: FilledButton.styleFrom(
          backgroundColor: scheme.error,
          foregroundColor: scheme.onError,
          disabledBackgroundColor: _checking ? scheme.error.withValues(alpha: 0.72) : null,
          disabledForegroundColor: _checking ? scheme.onError : null,
        ),
        onPressed: _checking || !online ? null : () => unawaited(_delete()),
        icon: _checking
            ? SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2, color: scheme.onError))
            : const Icon(Symbols.delete_rounded),
        label: Text(_checking ? l10n.deleteChecking : l10n.accountDelete),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          const AppStatusBanner(),
          LeadHeader(
            icon: Symbols.person_remove_rounded,
            tileColor: scheme.errorContainer,
            iconColor: scheme.onErrorContainer,
            title: l10n.deleteTitle,
          ),
          BulletCard(
            iconColor: scheme.onSurfaceVariant,
            items: [
              BulletItem(
                icon: Symbols.language_rounded,
                title: l10n.deleteAccountGoesTitle,
                body: l10n.deleteAccountGoesBody,
              ),
              BulletItem(
                icon: Symbols.confirmation_number_rounded,
                title: l10n.deleteTicketsLostTitle,
                body: l10n.deleteTicketsLostBody,
              ),
              BulletItem(
                icon: Symbols.credit_card_rounded,
                title: l10n.deletePlasticTitle,
                body: l10n.deletePlasticBody,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Asks for the password and deletes the account with it. Pops with the
/// server's message once the account is gone.
class _PasswordDialog extends ConsumerStatefulWidget {
  const _PasswordDialog();

  @override
  ConsumerState<_PasswordDialog> createState() => _PasswordDialogState();
}

class _PasswordDialogState extends ConsumerState<_PasswordDialog> {
  final _password = TextEditingController();
  bool _deleting = false;
  String? _error;

  @override
  void dispose() {
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_deleting || _password.text.isEmpty) {
      return;
    }
    final l10n = AppLocalizations.of(context);
    final navigator = Navigator.of(context);
    setState(() {
      _deleting = true;
      _error = null;
    });
    String? error;
    String? message;
    try {
      final reply = await ref.read(ekpClientProvider).account.anonymise(password: _password.text);
      // A wrong password is an HTTP 400 with the server's message, caught
      // below. A reply that went through with a code would be one as well.
      if (reply.code != null) {
        error = reply.message ?? l10n.errorGeneric;
      } else {
        message = reply.message ?? '';
      }
    } catch (failure) {
      error = describeError(l10n, failure);
    }
    if (!mounted) {
      return;
    }
    if (message != null) {
      navigator.pop(message);
      return;
    }
    setState(() {
      _deleting = false;
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return PopScope(
      // Not out from under a deletion that is on its way.
      canPop: !_deleting,
      child: AlertDialog(
        icon: Icon(Symbols.lock_rounded, color: scheme.error),
        title: Text(l10n.deletePasswordTitle, textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            Text(l10n.deletePasswordBody),
            // Typed out, as in the official client: nothing to paste from.
            PasswordField(
              controller: _password,
              label: l10n.passwordLabel,
              allowPaste: false,
              autofocus: true,
              enabled: !_deleting,
              errorText: _error,
              textInputAction: TextInputAction.done,
              onChanged: (_) => setState(() => _error = null),
              onSubmitted: () => unawaited(_submit()),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: _deleting ? null : () => Navigator.of(context).pop(), child: Text(l10n.cancel)),
          FilledButton.icon(
            style: AppTheme.dialogAction.merge(
              FilledButton.styleFrom(
                backgroundColor: scheme.error,
                foregroundColor: scheme.onError,
                disabledBackgroundColor: _deleting ? scheme.error.withValues(alpha: 0.72) : null,
                disabledForegroundColor: _deleting ? scheme.onError : null,
              ),
            ),
            onPressed: _deleting || _password.text.isEmpty ? null : () => unawaited(_submit()),
            icon: _deleting
                ? SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2, color: scheme.onError),
                  )
                : null,
            label: Text(l10n.deleteAction),
          ),
        ],
      ),
    );
  }
}
