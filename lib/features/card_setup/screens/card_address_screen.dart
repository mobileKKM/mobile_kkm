import 'package:ekp_api/ekp_api.dart';
import 'package:flutter/services.dart';
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
import 'package:mobile_kkm/features/auth/utils/validators.dart';
import 'package:mobile_kkm/features/auth/widgets/auth_page.dart';
import 'package:mobile_kkm/features/card_setup/services/card_setup_controller.dart';
import 'package:mobile_kkm/features/card_setup/widgets/step_bar.dart';
import 'package:mobile_kkm/features/card_setup/widgets/street_field.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

final _postcodePattern = RegExp(r'^\d{2}-\d{3}$');

/// Keeps a postcode in the form `99-999` while it is typed.
class PostcodeFormatter extends TextInputFormatter {
  const PostcodeFormatter();

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final kept = digits.length > 5 ? digits.substring(0, 5) : digits;
    final text = kept.length > 2 ? '${kept.substring(0, 2)}-${kept.substring(2)}' : kept;
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

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
                StreetField(
                  controller: _street,
                  town: _town,
                  label: l10n.addressStreet,
                  validator: (value) => validateRequired(l10n, value),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _building,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(labelText: l10n.addressBuilding),
                        validator: (value) => validateRequired(l10n, value),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _flat,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(labelText: l10n.addressFlat, helperText: l10n.fieldOptional),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _postcode,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.postalCode],
                        inputFormatters: const [PostcodeFormatter()],
                        decoration: InputDecoration(labelText: l10n.addressPostcode),
                        validator: (value) =>
                            validateRequired(l10n, value) ??
                            (_postcodePattern.hasMatch(value!.trim()) ? null : l10n.addressPostcodeInvalid),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _town,
                        textInputAction: TextInputAction.done,
                        textCapitalization: TextCapitalization.words,
                        autofillHints: const [AutofillHints.addressCity],
                        decoration: InputDecoration(labelText: l10n.addressTown),
                        validator: (value) => validateRequired(l10n, value),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
