import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/widgets/app_status_banner.dart';
import 'package:mobile_kkm/features/account/providers/user_data_provider.dart';
import 'package:mobile_kkm/features/home/widgets/pinned_ticket_card.dart';
import 'package:mobile_kkm/features/home/widgets/quick_actions.dart';
import 'package:mobile_kkm/features/home/widgets/subscription_cta.dart';
import 'package:mobile_kkm/features/tickets/services/ticket_sync.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// The dashboard: greeting, the pinned ticket, shortcuts and, for Karta
/// Krakowska holders and 5+1 subscribers, the way into the 5+1 programme.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final user = ref.watch(userDataProvider).value;
    final firstName = user?.userData?.firstName;
    // As in the official client: 5+1 is offered to Karta Krakowska holders and
    // to anyone with a running subscription. The client also requires an
    // attached mKKM card; here that will be settled by the onboarding, before
    // the user gets this far. Unknown counts as no, so the row does not appear
    // and vanish again while the data loads.
    final mkkm = user?.mkkmData;
    final has5p1Access = mkkm?.hasInhabitantPrivilege == true || mkkm?.hasActiveSubscription == true;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: ref.read(ticketSyncProvider.notifier).refresh,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
            children: [
              const AppStatusBanner(padding: EdgeInsets.only(bottom: 16)),
              Text(
                firstName == null || firstName.isEmpty ? l10n.homeGreetingAnonymous : l10n.homeGreeting(firstName),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              const PinnedTicketCard(),
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
