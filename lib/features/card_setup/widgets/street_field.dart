import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';

/// The street of an address: typed freely, with the server's streets of
/// Kraków offered under it once typing stops.
///
/// The official client only lets a street be picked from that list, which
/// knows Kraków alone; here it is help, not a rule.
class StreetField extends ConsumerStatefulWidget {
  const StreetField({super.key, required this.controller, required this.town, required this.label, this.validator});

  final TextEditingController controller;

  /// The address's town: other towns get no suggestions.
  final TextEditingController town;
  final String label;
  final FormFieldValidator<String>? validator;

  @override
  ConsumerState<StreetField> createState() => _StreetFieldState();
}

class _StreetFieldState extends ConsumerState<StreetField> {
  /// The `cityId` of Kraków in `account/street-autocomplete`.
  static const _krakow = 15;
  static const _pause = Duration(milliseconds: 500);
  static const _shown = 4;

  Timer? _debounce;
  List<String> _streets = const [];

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  bool get _inKrakow {
    final town = widget.town.text.trim().toLowerCase();
    return town.isEmpty || town == 'kraków' || town == 'krakow';
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    final query = value.trim();
    if (query.length < 3 || !_inKrakow) {
      if (_streets.isNotEmpty) {
        setState(() => _streets = const []);
      }
      return;
    }
    _debounce = Timer(_pause, () => unawaited(_search(query)));
  }

  Future<void> _search(String query) async {
    try {
      final reply = await ref.read(ekpClientProvider).account.streetAutocomplete(_krakow, query);
      // Typed on in the meantime: the next answer is the one that counts.
      if (!mounted || widget.controller.text.trim() != query) {
        return;
      }
      setState(() => _streets = reply.streets.take(_shown).toList());
    } catch (_) {
      // Only a help: the street can be typed out.
    }
  }

  void _pick(String street) {
    widget.controller.text = street;
    setState(() => _streets = const []);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 4,
      children: [
        TextFormField(
          controller: widget.controller,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          autofillHints: const [AutofillHints.streetAddressLine1],
          decoration: InputDecoration(labelText: widget.label),
          validator: widget.validator,
          onChanged: _onChanged,
        ),
        if (_streets.isNotEmpty)
          Material(
            color: scheme.surfaceContainerHigh,
            elevation: 2,
            borderRadius: BorderRadius.circular(16),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final street in _streets)
                    InkWell(
                      onTap: () => _pick(street),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(minHeight: 48),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Icon(Symbols.location_on_rounded, size: 20, color: scheme.onSurfaceVariant),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  street,
                                  style: theme.textTheme.bodyLarge?.copyWith(fontSize: 15, height: 20 / 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
