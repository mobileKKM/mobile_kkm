import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/api/error_messages.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/core/widgets/form_card.dart';
import 'package:mobile_kkm/core/widgets/lead_header.dart';
import 'package:mobile_kkm/core/widgets/message_banner.dart';
import 'package:mobile_kkm/features/account/providers/user_data_provider.dart';
import 'package:mobile_kkm/features/account/widgets/address_fields.dart';
import 'package:mobile_kkm/features/auth/widgets/auth_page.dart';
import 'package:mobile_kkm/features/card_setup/services/card_setup_controller.dart';
import 'package:mobile_kkm/features/card_setup/widgets/step_bar.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// Step 1 of the card set-up: the address the card is made for. It goes to
/// the server with the card request itself, after step 2.
class CardAddressScreen extends ConsumerStatefulWidget {
  const CardAddressScreen({super.key});

  @override
  ConsumerState<CardAddressScreen> createState() => _CardAddressScreenState();
}

class _CardAddressScreenState extends ConsumerState<CardAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _street;
  late final TextEditingController _building;
  late final TextEditingController _flat;
  late final TextEditingController _postcode;
  late final TextEditingController _town;

  @override
  void initState() {
    super.initState();
    // What was typed on an earlier visit, else what the account has.
    final address =
        ref.read(cardSetupProvider).address ?? ref.read(userDataProvider).value?.userData?.registeredAddress;
    _street = TextEditingController(text: address?.street);
    _building = TextEditingController(text: address?.buildingNumber);
    _flat = TextEditingController(text: address?.apartmentNumber);
    _postcode = TextEditingController(text: address?.postalCode);
    _town = TextEditingController(text: address?.city);
  }

  @override
  void dispose() {
    for (final controller in _required) {
      controller.dispose();
    }
    _flat.dispose();
    super.dispose();
  }

  List<TextEditingController> get _required => [_street, _building, _postcode, _town];

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final flat = _flat.text.trim();
    ref
        .read(cardSetupProvider.notifier)
        .setAddress(
          Address(
            city: _town.text.trim(),
            postalCode: _postcode.text.trim(),
            street: _street.text.trim(),
            buildingNumber: _building.text.trim(),
            apartmentNumber: flat.isEmpty ? null : flat,
          ),
        );
    context.go(Routes.cardSetupPhoto);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final refusal = ref.watch(cardSetupProvider.select((state) => state.refusal));
    return AuthPage(
      title: l10n.cardTitle,
      // Off only while there is nothing to check: what is missing is said
      // on the tap, not while typing.
      bottom: ListenableBuilder(
        listenable: Listenable.merge(_required),
        builder: (context, _) => FilledButton.icon(
          onPressed: _required.every((controller) => controller.text.trim().isEmpty) ? null : _submit,
          icon: const Icon(Symbols.arrow_forward_rounded),
          label: Text(l10n.cardSetupContinue),
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            StepBar(step: 1, name: l10n.cardSetupStepAddress),
            LeadHeader(title: l10n.cardSetupAddressTitle, body: l10n.cardSetupAddressHint, titleSize: 24),
            if (refusal != null) MessageBanner(describeError(l10n, refusal)),
            FormCard(
              children: [
                AddressFields(street: _street, building: _building, flat: _flat, postcode: _postcode, town: _town),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
