import 'dart:async';

import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/core/providers/platform_providers.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/core/widgets/status_chip.dart';
import 'package:mobile_kkm/features/account/constants/contacts.dart';
import 'package:mobile_kkm/features/account/providers/user_data_provider.dart';
import 'package:mobile_kkm/features/account/widgets/link_sheet.dart';
import 'package:mobile_kkm/features/account/widgets/user_avatar.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// Who is signed in, and everything about the account and the app itself.
class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  /// Asks first: signing out by a slip of the finger costs a full sign-in.
  Future<void> _confirmLogout(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Symbols.logout_rounded),
        title: Text(l10n.logoutConfirmTitle),
        content: Text(l10n.logoutConfirmBody),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(l10n.cancel)),
          TextButton(onPressed: () => Navigator.of(context).pop(true), child: Text(l10n.logoutConfirmAction)),
        ],
      ),
    );
    if (confirmed ?? false) {
      await ref.read(ekpClientProvider).auth.logout();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final data = ref.watch(userDataProvider).value;
    final resident = data?.mkkmData?.hasInhabitantPrivilege;
    final version = ref.watch(appVersionProvider).value;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navAccount)),
      body: SafeArea(
        top: false,
        bottom: false,
        // A column, not a lazy list: it is short, and every entry stays findable.
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: _Header(user: data?.userData, customerCode: data?.mkkmData?.customerCode),
              ),
              _SectionTitle(l10n.accountSectionProfile),
              _Entry(
                icon: Symbols.edit_rounded,
                label: l10n.accountEdit,
                onTap: () => context.push(Routes.accountEdit),
              ),
              _Entry(
                icon: Symbols.badge_rounded,
                label: l10n.cityCardTitle,
                // Unknown until the user data is there: no claim either way.
                trailing: switch (resident) {
                  true => StatusChip(l10n.cityCardActive, tone: StatusTone.positive),
                  false => StatusChip(l10n.cityCardInactive),
                  null => null,
                },
                onTap: () => context.push(Routes.cityCard),
              ),
              _SectionTitle(l10n.accountSectionHelp),
              _Entry(
                icon: Symbols.gavel_rounded,
                label: l10n.accountRegulations,
                subtitle: l10n.accountRegulationsHint,
                onTap: () => unawaited(showRegulationsSheet(context)),
              ),
              _Entry(
                icon: Symbols.support_agent_rounded,
                label: l10n.accountContactMpk,
                subtitle: l10n.accountContactMpkHint,
                onTap: () => unawaited(
                  showLinkSheet(
                    context,
                    title: l10n.accountContactMpk,
                    links: [
                      SheetLink(
                        icon: Symbols.call_rounded,
                        label: l10n.contactCall,
                        subtitle: Contacts.mpkPhone,
                        uri: Contacts.mpkPhoneUri,
                      ),
                      SheetLink(
                        icon: Symbols.mail_rounded,
                        label: l10n.contactEmail,
                        subtitle: Contacts.mpkEmail,
                        uri: Contacts.mailto(Contacts.mpkEmail),
                      ),
                    ],
                  ),
                ),
              ),
              _Entry(
                icon: Symbols.code_rounded,
                label: l10n.accountContactDeveloper,
                subtitle: l10n.accountContactDeveloperHint,
                onTap: () => unawaited(
                  showLinkSheet(
                    context,
                    title: l10n.accountContactDeveloper,
                    links: [
                      SheetLink(
                        icon: Symbols.bug_report_rounded,
                        label: l10n.contactReportIssue,
                        subtitle: Contacts.issuesLabel,
                        uri: Contacts.issuesUri,
                      ),
                      SheetLink(
                        icon: Symbols.mail_rounded,
                        label: l10n.contactEmail,
                        subtitle: Contacts.developerEmail,
                        uri: Contacts.mailto(Contacts.developerEmail),
                      ),
                    ],
                  ),
                ),
              ),
              _SectionTitle(l10n.accountSectionSecurity),
              _Entry(
                icon: Symbols.key_rounded,
                label: l10n.accountChangePassword,
                onTap: () => context.push(Routes.accountChangePassword),
              ),
              _Entry(
                icon: Symbols.delete_rounded,
                label: l10n.accountDelete,
                color: scheme.error,
                showChevron: false,
                onTap: () => context.push(Routes.accountDelete),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                    textStyle: theme.textTheme.labelLarge?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  onPressed: () => unawaited(_confirmLogout(context, ref)),
                  icon: const Icon(Symbols.logout_rounded),
                  label: Text(l10n.logout),
                ),
              ),
              if (version != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    l10n.appVersion(version),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The card at the top: photo, name and customer code.
class _Header extends StatelessWidget {
  const _Header({required this.user, required this.customerCode});

  final UserData? user;
  final String? customerCode;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(color: scheme.surfaceContainer, borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            UserAvatar(user: user),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    [user?.firstName, user?.lastName].nonNulls.join(' '),
                    style: theme.textTheme.titleMedium?.copyWith(fontSize: 18),
                  ),
                  if (customerCode != null) ...[
                    const SizedBox(height: 4),
                    Text.rich(
                      TextSpan(
                        text: '${l10n.accountCustomerCode} ',
                        children: [
                          TextSpan(
                            text: customerCode,
                            style: TextStyle(fontWeight: FontWeight.w700, color: scheme.onSurface, letterSpacing: 1),
                          ),
                        ],
                      ),
                      style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 4),
      child: Text(title, style: theme.textTheme.titleSmall?.copyWith(color: theme.colorScheme.primary)),
    );
  }
}

class _Entry extends StatelessWidget {
  const _Entry({
    required this.icon,
    required this.label,
    required this.onTap,
    this.subtitle,
    this.trailing,
    this.color,
    this.showChevron = true,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final String? subtitle;

  /// Shown before the chevron, e.g. a state.
  final Widget? trailing;

  /// Sets a destructive entry apart.
  final Color? color;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      subtitle: subtitle == null ? null : Text(subtitle!),
      iconColor: color,
      textColor: color,
      trailing: trailing == null && !showChevron
          ? null
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ?trailing,
                if (trailing != null && showChevron) const SizedBox(width: 8),
                if (showChevron) const Icon(Symbols.chevron_right_rounded),
              ],
            ),
      onTap: onTap,
    );
  }
}
