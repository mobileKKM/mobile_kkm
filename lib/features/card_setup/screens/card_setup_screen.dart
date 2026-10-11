import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/api/error_messages.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/core/widgets/bullet_card.dart';
import 'package:mobile_kkm/core/widgets/lead_header.dart';
import 'package:mobile_kkm/core/widgets/message_banner.dart';
import 'package:mobile_kkm/core/widgets/submit_button.dart';
import 'package:mobile_kkm/features/account/providers/user_data_provider.dart';
import 'package:mobile_kkm/features/auth/widgets/auth_page.dart';
import 'package:mobile_kkm/features/auth/widgets/sign_out_dialog.dart';
import 'package:mobile_kkm/features/card_setup/models/card_gate.dart';
import 'package:mobile_kkm/features/card_setup/providers/card_gate_provider.dart';
import 'package:mobile_kkm/features/card_setup/services/card_setup_controller.dart';
import 'package:mobile_kkm/features/card_setup/widgets/mkkm_card.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// All a signed-in user sees until their account has an attached mKKM card:
/// why one is needed and the way to it, the card that was detached, and
/// the card once it is there. The only other way out is to sign out.
class CardSetupScreen extends ConsumerStatefulWidget {
  const CardSetupScreen({super.key});

  @override
  ConsumerState<CardSetupScreen> createState() => _CardSetupScreenState();
}

class _CardSetupScreenState extends ConsumerState<CardSetupScreen> {
  bool _attaching = false;
  String? _error;

  Future<void> _reattach() async {
    final l10n = AppLocalizations.of(context);
    setState(() {
      _attaching = true;
      _error = null;
    });
    String? error;
    try {
      await ref.read(cardSetupProvider.notifier).reattach();
    } catch (failure) {
      error = describeError(l10n, failure);
    }
    if (mounted) {
      setState(() {
        _attaching = false;
        _error = error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final gate = ref.watch(cardGateProvider);
    final stage = ref.watch(cardSetupProvider.select((state) => state.stage));
    final data = ref.watch(userDataProvider).value;
    final user = data?.userData;
    final signOut = TextButton(
      style: TextButton.styleFrom(minimumSize: const Size.fromHeight(48)),
      onPressed: () => unawaited(confirmSignOut(context, ref)),
      child: Text(l10n.logout),
    );

    if (stage == CardSetupStage.ready) {
      return AuthPage(
        showAppBar: false,
        centered: true,
        bottom: FilledButton.icon(
          onPressed: ref.read(cardSetupProvider.notifier).finish,
          icon: const Icon(Symbols.home_rounded),
          label: Text(l10n.goHome),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            MkkmCard(user: user, status: MkkmCardStatus.active, customerCode: data?.mkkmData?.customerCode),
            LeadHeader(centered: true, title: l10n.cardReadyTitle, body: l10n.cardReadyHint, titleSize: 24),
          ],
        ),
      );
    }

    switch (gate) {
      case CardGate.detached:
        return AuthPage(
          showAppBar: false,
          centered: true,
          bottom: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SubmitButton(
                label: l10n.cardReattach,
                icon: Symbols.add_card_rounded,
                loading: _attaching || stage == CardSetupStage.waiting,
                loadingLabel: l10n.cardReattaching,
                onPressed: _reattach,
              ),
              signOut,
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
              MkkmCard(user: user, status: MkkmCardStatus.detached, customerCode: data?.mkkmData?.customerCode),
              LeadHeader(title: l10n.cardDetachedTitle, body: l10n.cardDetachedHint, titleSize: 26),
              if (_error != null) MessageBanner(_error!),
            ],
          ),
        );
      case CardGate.setUp:
        final firstName = user?.firstName;
        return AuthPage(
          showAppBar: false,
          bottom: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FilledButton.icon(
                onPressed: () => context.go(Routes.cardSetupAddress),
                icon: const Icon(Symbols.add_card_rounded),
                label: Text(l10n.cardSetupCreate),
              ),
              signOut,
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
              LeadHeader(
                icon: Symbols.add_card_rounded,
                title: l10n.cardSetupTitle,
                body: firstName == null || firstName.isEmpty
                    ? l10n.cardSetupWelcomeAnonymous
                    : l10n.cardSetupWelcome(firstName),
                titleSize: 26,
              ),
              BulletCard(
                items: [
                  BulletItem(
                    icon: Symbols.confirmation_number_rounded,
                    title: l10n.cardSetupBenefitTicketsTitle,
                    body: l10n.cardSetupBenefitTicketsBody,
                  ),
                  BulletItem(
                    icon: Symbols.smartphone_rounded,
                    title: l10n.cardSetupBenefitPhoneTitle,
                    body: l10n.cardSetupBenefitPhoneBody,
                  ),
                  BulletItem(
                    icon: Symbols.timer_rounded,
                    title: l10n.cardSetupBenefitTimeTitle,
                    body: l10n.cardSetupBenefitTimeBody,
                  ),
                ],
              ),
            ],
          ),
        );
      // The router is about to move on.
      case CardGate.checking || CardGate.settling || CardGate.open:
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
  }
}
