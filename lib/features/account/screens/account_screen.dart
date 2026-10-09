import 'dart:async';

import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/core/providers/platform_providers.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/core/theme/app_theme.dart';
import 'package:mobile_kkm/core/widgets/icon_tile.dart';
import 'package:mobile_kkm/core/widgets/row_group.dart';
import 'package:mobile_kkm/core/widgets/skeleton_box.dart';
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
        title: Text(l10n.logoutConfirmTitle, textAlign: TextAlign.center),
        content: Text(l10n.logoutConfirmBody),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(l10n.cancel)),
          FilledButton(
            style: AppTheme.dialogAction,
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.logoutConfirmAction),
          ),
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
    final colors = AppColors.of(context);
    final userData = ref.watch(userDataProvider);
    final data = userData.value;
    final resident = data?.mkkmData?.hasInhabitantPrivilege;
    final version = ref.watch(appVersionProvider).value;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navAccount)),
      body: SafeArea(
        top: false,
        bottom: false,
        // A column, not a lazy list: it is short, and every entry stays findable.
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
              _Header(
                user: data?.userData,
                customerCode: data?.mkkmData?.customerCode,
                loading: data == null && userData.isLoading,
              ),
              RowGroup(
                title: l10n.accountSectionProfile,
                children: [
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
                      true => StatusChip(
                        l10n.cityCardActive,
                        icon: Symbols.check_circle_rounded,
                        background: colors.successContainer,
                        foreground: colors.onSuccessContainer,
                        compact: true,
                      ),
                      false => StatusChip(
                        l10n.cityCardInactive,
                        icon: Symbols.remove_circle_rounded,
                        background: scheme.surfaceContainerHighest,
                        foreground: scheme.onSurfaceVariant,
                        compact: true,
                      ),
                      null => null,
                    },
                    onTap: () => context.push(Routes.cityCard),
                  ),
                ],
              ),
              RowGroup(
                title: l10n.accountSectionHelp,
                children: [
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
                            external: true,
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
                ],
              ),
              RowGroup(
                title: l10n.accountSectionSecurity,
                children: [
                  _Entry(
                    icon: Symbols.key_rounded,
                    label: l10n.accountChangePassword,
                    onTap: () => context.push(Routes.accountChangePassword),
                  ),
                  _Entry(
                    icon: Symbols.delete_rounded,
                    label: l10n.accountDelete,
                    danger: true,
                    onTap: () => context.push(Routes.accountDelete),
                  ),
                ],
              ),
              OutlinedButton.icon(
                onPressed: () => unawaited(_confirmLogout(context, ref)),
                icon: const Icon(Symbols.logout_rounded),
                label: Text(l10n.logout),
              ),
              if (version != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    // The app's own version, and the official client's that it speaks to the server as.
                    l10n.appVersion(version, EkpDefaults.clientVersion),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 13,
                      height: 18 / 13,
                      color: scheme.onSurfaceVariant,
                    ),
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
  const _Header({required this.user, required this.customerCode, required this.loading});

  final UserData? user;
  final String? customerCode;

  /// Nothing stored yet and the first answer still on its way.
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: scheme.surfaceContainerLow, borderRadius: BorderRadius.circular(28)),
      child: Row(
        children: [
          UserAvatar(user: user, size: 72),
          const SizedBox(width: 16),
          Expanded(
            child: loading
                ? const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [SkeletonBox(width: 170, height: 14), SkeletonBox(width: 120, height: 14)],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      Text([user?.firstName, user?.lastName].nonNulls.join(' '), style: theme.textTheme.titleLarge),
                      if (customerCode != null)
                        Text.rich(
                          TextSpan(
                            text: '${l10n.accountCustomerCode} ',
                            children: [
                              TextSpan(
                                text: customerCode,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: scheme.onSurface,
                                  letterSpacing: 1,
                                  fontFeatures: const [FontFeature.tabularFigures()],
                                ),
                              ),
                            ],
                          ),
                          style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                        ),
                    ],
                  ),
          ),
        ],
      ),
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
    this.danger = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final String? subtitle;

  /// Shown before the chevron, e.g. a state.
  final Widget? trailing;

  /// Sets the one destructive entry apart; it also leads nowhere to come
  /// back from, so it has no chevron.
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return GroupRow(
      leading: danger
          ? IconTile(icon, background: scheme.errorContainer, foreground: scheme.onErrorContainer)
          : IconTile(icon),
      label: label,
      labelColor: danger ? scheme.error : null,
      subtitle: subtitle,
      trailing: trailing,
      showChevron: !danger,
      onTap: onTap,
    );
  }
}
