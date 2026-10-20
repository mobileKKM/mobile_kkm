import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/theme/app_theme.dart';
import 'package:mobile_kkm/features/purchase/models/purchase_selection.dart';
import 'package:mobile_kkm/features/purchase/models/sales_rules.dart';
import 'package:mobile_kkm/features/purchase/providers/purchase_providers.dart';
import 'package:mobile_kkm/features/purchase/utils/purchase_format.dart';
import 'package:mobile_kkm/features/purchase/widgets/price_bar.dart';
import 'package:mobile_kkm/features/purchase/widgets/purchase_form_widgets.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

import '../../../support/sample_data.dart';

final en = lookupAppLocalizations(const Locale('en'));
final pl = lookupAppLocalizations(const Locale('pl'));
final privileged = SalesRules(TicketSalesConfiguration.fromJson(apiFixture('sales_config_privileged')));
final notPrivileged = SalesRules(TicketSalesConfiguration.fromJson(apiFixture('sales_config')));

Future<void> _pump(WidgetTester tester, Widget child) => tester.pumpWidget(
  MaterialApp(
    theme: AppTheme.light(),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(body: child),
  ),
);

String _note(AppLocalizations l10n, SalesRules rules, PurchaseSelection selection) =>
    zoneNoteText(l10n, rules, rules.notes(rules.reconcile(selection)).single);

void main() {
  setUpAll(initializeDateFormatting);

  group('zone notes read as the design', () {
    test('Strefa I and III', () {
      const selection = PurchaseSelection(kind: 2, zones: {0, 2});
      expect(
        _note(en, notPrivileged, selection),
        'Strefa I and III aren’t sold together. Add Strefa II to travel in both.',
      );
      expect(
        _note(pl, notPrivileged, selection),
        'Strefy I i III nie są sprzedawane razem. Dodaj Strefę II, aby jeździć w obu.',
      );
    });

    test('Aktywizujący outside its zones', () {
      const selection = PurchaseSelection(kind: 17, zones: {1});
      expect(_note(en, notPrivileged, selection), 'Aktywizujący is sold for Strefa I, I+II and I+II+III.');
      expect(_note(pl, notPrivileged, selection), 'Bilet Aktywizujący jest sprzedawany na Strefy I, I+II i I+II+III.');
    });

    test('the discount', () {
      const selection = PurchaseSelection(type: '1001', kind: 2);
      expect(_note(en, privileged, selection), 'The Karta Krakowska discount is for Strefa I only.');
      expect(_note(pl, privileged, selection), 'Zniżka Karty Krakowskiej obejmuje tylko Strefę I.');
    });
  });

  test('period and line labels', () {
    final periods = privileged.periodsFor('1001');
    expect(
      [for (final p in periods) periodLabel(en, p)],
      ['1 month', '2 months', '3 months', '6 months', 'Studencki Roczny'],
    );
    expect(
      [for (final p in periods) periodLabel(pl, p)],
      ['1 miesiąc', '2 miesiące', '3 miesiące', '6 miesięcy', 'Studencki Roczny'],
    );
    expect(periodLabel(en, const SalesPeriodOption(value: 7, unit: 3)), '7 days');
    expect(
      [
        for (final o in privileged.lineChoices('1001', {0})) lineOptionLabel(pl, o),
      ],
      ['Wszystkie linie', '1 linia'],
    );
  });

  test('the start range', () {
    final bounds = StartBounds(
      initial: DateTime(2026, 10, 17),
      first: DateTime(2026, 10, 16),
      last: DateTime(2026, 11, 15),
    );
    expect(startRangeLabel(en, 'en', bounds), 'Any day from Oct 16 to Nov 15');
    expect(startDayLabel('en', DateTime(2026, 10, 17)), 'Sat, Oct 17, 2026');
    expect(startDayLabel('pl', DateTime(2026, 10, 17)), 'sob., 17 paź 2026');
    expect(startRangeLabel(pl, 'pl', bounds), 'Dowolny dzień od 16 paź do 15 lis');
    final extending = StartBounds(
      initial: DateTime(2026, 11, 1),
      first: DateTime(2026, 11, 1),
      last: DateTime(2026, 12, 1),
      extending: true,
    );
    expect(startRangeLabel(en, 'en', extending), 'From Nov 1, the day after your ticket ends, to Dec 1');
  });

  group('price bar', () {
    testWidgets('a hint, and Continue off until priced', (tester) async {
      await _pump(tester, PriceBar(price: const PriceIdle(), hint: 'Choose a fare', onContinue: () {}));
      expect(find.text('Choose a fare'), findsOneWidget);
      expect(tester.widget<FilledButton>(find.byType(FilledButton)).onPressed, isNull);
    });

    testWidgets('the price in Polish format, Continue on', (tester) async {
      var continued = false;
      final calculation = TicketCalculation.fromJson(apiFixture('tickets_calculate'));
      final choice = TicketChoice(
        validFrom: DateTime(2025, 10, 28),
        ticketNumberOfLineCode: 3,
        ticketKindCode: 2,
        ticketPeriodCode: 1,
        lines: const [],
      );
      await _pump(
        tester,
        PriceBar(price: PricePriced(calculation, choice), hint: '', onContinue: () => continued = true),
      );
      expect(find.text('Price'), findsOneWidget);
      expect(find.text('99,00\u00a0zł'), findsOneWidget);
      await tester.tap(find.text('Continue'));
      expect(continued, isTrue);
    });

    testWidgets('a refusal above the row: field errors, else the message', (tester) async {
      await _pump(
        tester,
        PriceBar(
          price: const PriceRefused(fieldErrors: true, message: 'x'),
          hint: 'h',
          onContinue: () {},
        ),
      );
      expect(find.text('Please choose the fare and type correctly.'), findsOneWidget);
      expect(tester.widget<FilledButton>(find.byType(FilledButton)).onPressed, isNull);

      await _pump(
        tester,
        PriceBar(
          price: const PriceRefused(message: 'Bilet może być kupiony'),
          hint: 'h',
          onContinue: () {},
        ),
      );
      expect(find.text('Bilet może być kupiony'), findsOneWidget);
    });

    testWidgets('calculating', (tester) async {
      await _pump(tester, PriceBar(price: const PriceCalculating(), hint: '', onContinue: () {}));
      expect(find.text('Calculating…'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Calculating… fades to the price, and a new price replaces it in place', (tester) async {
      final calculation = TicketCalculation.fromJson(apiFixture('tickets_calculate'));
      final choice = TicketChoice(
        validFrom: DateTime(2025, 10, 28),
        ticketNumberOfLineCode: 3,
        ticketKindCode: 2,
        ticketPeriodCode: 1,
        lines: const [],
      );
      await _pump(tester, PriceBar(price: const PriceCalculating(), hint: '', onContinue: () {}));
      await _pump(tester, PriceBar(price: PricePriced(calculation, choice), hint: '', onContinue: () {}));
      // Half way through both are there, one fading out, the other in.
      await tester.pump(const Duration(milliseconds: 75));
      expect(find.text('Calculating…'), findsOneWidget);
      expect(find.text('99,00\u00a0zł'), findsOneWidget);
      await tester.pump(PriceBar.fadeDuration);
      expect(find.text('Calculating…'), findsNothing);

      final dearer = PricePriced(calculation.copyWith(price: 120), choice);
      await _pump(tester, PriceBar(price: dearer, hint: '', onContinue: () {}));
      await tester.pump(const Duration(milliseconds: 75));
      expect(find.text('99,00\u00a0zł'), findsOneWidget);
      expect(find.text('120,00\u00a0zł'), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.text('99,00\u00a0zł'), findsNothing);
    });
  });

  testWidgets('a disabled tile does not react; a selected one has a check', (tester) async {
    var taps = 0;
    await _pump(
      tester,
      ChoiceTileGrid(
        children: [
          ChoiceTile(label: 'Normalny', selected: true, onTap: () => taps++),
          ChoiceTile(label: 'Ulgowy', selected: false, onTap: () => taps++),
          ChoiceTile(label: 'Aktywizujący', selected: false, enabled: false, onTap: () => taps++),
        ],
      ),
    );
    await tester.tap(find.text('Aktywizujący'));
    expect(taps, 0);
    await tester.tap(find.text('Ulgowy'));
    expect(taps, 1);
    expect(
      tester.getSemantics(find.byType(ChoiceTile).first),
      matchesSemantics(
        label: 'Normalny',
        isButton: true,
        isSelected: true,
        hasSelectedState: true,
        isEnabled: true,
        hasEnabledState: true,
        isInMutuallyExclusiveGroup: true,
        hasTapAction: true,
        hasFocusAction: true,
        isFocusable: true,
      ),
    );
  });
}
