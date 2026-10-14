import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/features/auth/utils/validators.dart';
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

/// The fields of a home address: street, building and flat, postcode and
/// town. All but the flat are required; what is missing is said by the form
/// around them, when it is validated.
class AddressFields extends StatelessWidget {
  const AddressFields({
    super.key,
    required this.street,
    required this.building,
    required this.flat,
    required this.postcode,
    required this.town,
  });

  final TextEditingController street;
  final TextEditingController building;
  final TextEditingController flat;
  final TextEditingController postcode;
  final TextEditingController town;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 20,
      children: [
        StreetField(
          controller: street,
          town: town,
          label: l10n.addressStreet,
          validator: (value) => validateRequired(l10n, value),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            Expanded(
              child: TextFormField(
                controller: building,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: l10n.addressBuilding),
                validator: (value) => validateRequired(l10n, value),
              ),
            ),
            Expanded(
              child: TextFormField(
                controller: flat,
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
                controller: postcode,
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
                controller: town,
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
    );
  }
}
