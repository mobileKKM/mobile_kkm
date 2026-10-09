import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/core/widgets/app_status_banner.dart';
import 'package:mobile_kkm/core/widgets/icon_tile.dart';
import 'package:mobile_kkm/core/widgets/row_group.dart';
import 'package:mobile_kkm/features/account/providers/user_data_provider.dart';
import 'package:mobile_kkm/features/account/widgets/user_avatar.dart';
import 'package:mobile_kkm/features/home/widgets/pinned_ticket_card.dart';
import 'package:mobile_kkm/features/home/widgets/quick_actions.dart';
import 'package:mobile_kkm/features/home/widgets/subscription_cta.dart';
import 'package:mobile_kkm/features/tickets/providers/tickets_providers.dart';
import 'package:mobile_kkm/features/tickets/services/ticket_sync.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// The dashboard: greeting, the pinned ticket, shortcuts and, for Karta
/// Krakowska holders and 5+1 subscribers, the way into the 5+1 programme.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final user = ref.watch(userDataProvider).value;
    final firstName = user?.userData?.firstName;
    // As in the official client: 5+1 is offered to Karta Krakowska holders and
    // to anyone with a running subscription. The client also requires an
    // attached mKKM card; here that will be settled by the onboarding, before
    // the user gets this far. Unknown counts as no, so the row does not appear
    // and vanish again while the data loads.
    final mkkm = user?.mkkmData;
    final has5p1Access = mkkm?.hasInhabitantPrivilege == true || mkkm?.hasActiveSubscription == true;
    final customerCode = mkkm?.customerCode;
    final unpaid = ref.watch(pendingPaymentCountProvider);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: ref.read(ticketSyncProvider.notifier).refresh,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              const AppStatusBanner(padding: EdgeInsets.only(top: 4, bottom: 8)),
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 8, 4, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 6,
                        children: [
                          Text(
                            firstName == null || firstName.isEmpty
                                ? l10n.homeGreetingAnonymous
                                : l10n.homeGreeting(firstName),
                            style: theme.textTheme.headlineMedium,
                          ),
                          if (customerCode != null)
                            Text(
                              l10n.homeCustomerCode(customerCode),
                              style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    UserAvatar(user: user?.userData),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const PinnedTicketCard(),
              if (unpaid > 0) ...[
                const SizedBox(height: 16),
                RowGroup(
                  children: [
                    GroupRow(
                      minHeight: 64,
                      leading: IconTile(
                        Symbols.payments_rounded,
                        size: 40,
                        background: scheme.tertiaryContainer,
                        foreground: scheme.onTertiaryContainer,
                      ),
                      label: l10n.homeTicketsAwaitingPayment(unpaid),
                      onTap: () => context.go(Routes.tickets),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 16),
              const QuickActions(),
              if (has5p1Access) ...[const SizedBox(height: 16), const SubscriptionCta()],
            ],
          ),
        ),
      ),
    );
  }
}
